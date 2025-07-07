package com.example;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/devops-dashboard")
public class DevOpsServlet extends HttpServlet {

    private final String[] devOpsTips = {
            "Infrastructure as Code: Treat your servers like cattle, not pets!",
            "Automate everything - if you do it twice, automate it!",
            "Monitoring without alerting is like watching a silent movie.",
            "Small, frequent deployments > big bang releases!",
            "CI/CD pipeline should be your product's heartbeat 💓",
            "Git commit messages should tell a story, not just 'fixed bug'",
            "Blue-green deployments: Because downtime is so last decade",
            "Chaos engineering: Break things on purpose before they break in production!",
            "Documentation is the silent hero of DevOps",
            "Your staging environment should mirror production exactly",
            "Shift left on security - bake it in from the start!",
            "Observability > Monitoring - understand why, not just what",
            "Serverless doesn't mean 'operations-less'",
            "Kubernetes: Because sometimes you need to orchestrate your orchestrator",
            "MTTR (Mean Time To Repair) is more important than MTBF (Mean Time Between Failures)",
            "🎉 WEBHOOK AUTOMATION TEST: This tip was added to test automatic deployment!"};

    private final String[] devOpsEmojis =
            {"🚀", "🔧", "⚡", "🔁", "📊", "🔍", "🛠️", "💡", "🤖", "🔒"};

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Get system info
        Runtime runtime = Runtime.getRuntime();
        long freeMemory = runtime.freeMemory() / (1024 * 1024);
        long totalMemory = runtime.totalMemory() / (1024 * 1024);
        long maxMemory = runtime.maxMemory() / (1024 * 1024);
        int availableProcessors = runtime.availableProcessors();

        // Get current time
        String time =
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Random selections
        Random random = new Random();
        String randomTip = devOpsTips[random.nextInt(devOpsTips.length)];
        String randomEmoji = devOpsEmojis[random.nextInt(devOpsEmojis.length)];

        // Build the response
        response.setContentType("text/html");
        response.getWriter().println("<html><head><title>DevOps Dashboard</title>");
        response.getWriter().println("<style>");
        response.getWriter().println(
                "body {font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f0f2f5;}");
        response.getWriter()
                .println(".container {max-width: 800px; margin: 20px auto; padding: 20px;}");
        response.getWriter().println(
                ".dashboard {background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);}");
        response.getWriter().println(
                ".header {color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 15px; margin-bottom: 20px;}");
        response.getWriter().println(".name-highlight {color: #e74c3c; font-weight: bold;}");
        response.getWriter().println(
                ".sys-info {background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px;}");
        response.getWriter().println(
                ".tip-box {background: #e8f4fc; padding: 15px; border-left: 4px solid #3498db; margin: 20px 0;}");
        response.getWriter().println(
                ".footer {margin-top: 20px; font-size: 0.9em; color: #7f8c8d; text-align: center;}");
        response.getWriter().println("</style>");
        response.getWriter().println("</head><body>");
        response.getWriter().println("<div class='container'>");
        response.getWriter().println("<div class='dashboard'>");
        response.getWriter().println("<h1 class='header'>" + randomEmoji
                + " Welcome to <span class='name-highlight'>Nilesh Patil</span>'s DevOps World!</h1>");

        response.getWriter().println("<div class='sys-info'>");
        response.getWriter().println("<h2>⏱️ System Snapshot</h2>");
        response.getWriter().println("<p><strong>Current Time:</strong> " + time + "</p>");
        response.getWriter().println("<p><strong>JVM Memory:</strong> " + freeMemory + "MB free of "
                + totalMemory + "MB (Max: " + maxMemory + "MB)</p>");
        response.getWriter().println(
                "<p><strong>Available Processors:</strong> " + availableProcessors + "</p>");
        response.getWriter().println("</div>");

        response.getWriter().println("<div class='tip-box'>");
        response.getWriter().println("<h2>💡 DevOps Tip of the Moment</h2>");
        response.getWriter().println("<p><em>\"" + randomTip + "\"</em></p>");
        response.getWriter().println("</div>");

        response.getWriter().println("<div class='footer'>");
        response.getWriter().println("<p>Refresh the page for a new tip and emoji!</p>");
        response.getWriter()
                .println("<p>Total DevOps Tips in rotation: " + devOpsTips.length + "</p>");
        response.getWriter().println("</div>");

        response.getWriter().println("</div>"); // close dashboard
        response.getWriter().println("</div>"); // close container
        response.getWriter().println("</body></html>");
    }
}
