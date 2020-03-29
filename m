Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8CEC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E1C2076A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgC2SoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgC2SnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32072145D;
        Sun, 29 Mar 2020 18:43:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIcty-002G1C-KV; Sun, 29 Mar 2020 14:43:18 -0400
Message-Id: <20200329184318.517382511@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 21/21] tracing: Add documentation on set_ftrace_notrace_pid and
 set_event_notrace_pid
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Update the tracing documentation to reflect the new files in the tracing
directory.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 00621731bf27..3b5614b1d1a5 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -263,6 +263,20 @@ of ftrace. Here is a list of some of the key files:
 	traced by the function tracer as well. This option will also
 	cause PIDs of tasks that exit to be removed from the file.
 
+  set_ftrace_notrace_pid:
+
+        Have the function tracer ignore threads whose PID are listed in
+        this file.
+
+        If the "function-fork" option is set, then when a task whose
+	PID is listed in this file forks, the child's PID will
+	automatically be added to this file, and the child will not be
+	traced by the function tracer as well. This option will also
+	cause PIDs of tasks that exit to be removed from the file.
+
+        If a PID is in both this file and "set_ftrace_pid", then this
+        file takes precedence, and the thread will not be traced.
+
   set_event_pid:
 
 	Have the events only trace a task with a PID listed in this file.
@@ -274,6 +288,19 @@ of ftrace. Here is a list of some of the key files:
 	cause the PIDs of tasks to be removed from this file when the task
 	exits.
 
+  set_event_notrace_pid:
+
+	Have the events not trace a task with a PID listed in this file.
+	Note, sched_switch and sched_wakeup will trace threads not listed
+	in this file, even if a thread's PID is in the file if the
+        sched_switch or sched_wakeup events also trace a thread that should
+        be traced.
+
+	To have the PIDs of children of tasks with their PID in this file
+	added on fork, enable the "event-fork" option. That option will also
+	cause the PIDs of tasks to be removed from this file when the task
+	exits.
+
   set_graph_function:
 
 	Functions listed in this file will cause the function graph
@@ -1183,6 +1210,8 @@ Here are the available options:
 	tasks fork. Also, when tasks with PIDs in set_event_pid exit,
 	their PIDs will be removed from the file.
 
+        This affects PIDs listed in set_event_notrace_pid as well.
+
   function-trace
 	The latency tracers will enable function tracing
 	if this option is enabled (default it is). When
@@ -1197,6 +1226,8 @@ Here are the available options:
 	set_ftrace_pid exit, their PIDs will be removed from the
 	file.
 
+        This affects PIDs in set_ftrace_notrace_pid as well.
+
   display-graph
 	When set, the latency tracers (irqsoff, wakeup, etc) will
 	use function graph tracing instead of function tracing.
-- 
2.25.1


