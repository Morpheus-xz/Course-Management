<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Management</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #1b2735, #090a0f);
            font-family: 'Inter', system-ui, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #eaeaea;
        }

        .wrapper {
            width: 1100px;
            display: grid;
            grid-template-columns: 380px 1fr;
            gap: 30px;
            padding: 30px;
        }

        .card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(16px);
            border-radius: 18px;
            padding: 28px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.6);
        }

        .card h2 {
            font-size: 22px;
            margin-bottom: 20px;
            text-align: center;
            letter-spacing: 0.5px;
        }

        label {
            font-size: 13px;
            opacity: 0.8;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 6px 0 18px;
            background: rgba(255,255,255,0.15);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 14px;
        }

        input::placeholder {
            color: rgba(255,255,255,0.5);
        }

        input:focus {
            outline: none;
            background: rgba(255,255,255,0.22);
        }

        button {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            color: white;
            background: linear-gradient(135deg, #6a85ff, #8fd3f4);
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(106,133,255,0.5);
        }

        .table-card h2 {
            text-align: left;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 18px;
        }

        th {
            text-align: left;
            padding: 14px;
            font-size: 13px;
            text-transform: uppercase;
            opacity: 0.7;
            border-bottom: 1px solid rgba(255,255,255,0.15);
        }

        td {
            padding: 14px;
            font-size: 14px;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }

        tr:hover td {
            background: rgba(255,255,255,0.06);
        }

        .action a {
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            margin-right: 12px;
        }

        .edit {
            color: #8fd3f4;
        }

        .delete {
            color: #ff6b6b;
        }

        .action a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="wrapper">

    <!-- LEFT: COURSE FORM -->
    <div class="card">
        <h2>📚 Course Entry</h2>

        <form action="${course.id == 0 ? '/courses/add' : '/courses/update'}" method="post">
            <input type="hidden" name="id" value="${course.id}">

            <label>Course Code</label>
            <input type="text"
                   name="courseCode"
                   value="${course.courseCode}"
                   placeholder="CS101"
                   required>

            <label>Course Name</label>
            <input type="text"
                   name="courseName"
                   value="${course.courseName}"
                   placeholder="Data Structures"
                   required>

            <button type="submit">
                ${course.id == 0 ? 'Add Course' : 'Update Course'}
            </button>
        </form>
    </div>

    <!-- RIGHT: COURSE TABLE -->
    <div class="card table-card">
        <h2>📋 Available Courses</h2>

        <table>
            <tr>
                <th>ID</th>
                <th>Course Code</th>
                <th>Course Name</th>
                <th>Actions</th>
            </tr>

            <%
                java.util.List<com.example.demo.model.Course> list =
                        (java.util.List<com.example.demo.model.Course>) request.getAttribute("courses");

                if (list != null) {
                    for (com.example.demo.model.Course c : list) {
            %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getCourseCode() %></td>
                <td><%= c.getCourseName() %></td>
                <td class="action">
                    <a class="edit" href="/courses/edit/<%= c.getId() %>">Edit</a>
                    <a class="delete"
                       href="/courses/delete/<%= c.getId() %>"
                       onclick="return confirm('Delete this course?');">
                        Delete
                    </a>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>

</div>

</body>
</html>
