Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5CC2D0F0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31FD20936
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgC2Sn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgC2SnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672C920B1F;
        Sun, 29 Mar 2020 18:43:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIctx-002FwY-Aw; Sun, 29 Mar 2020 14:43:17 -0400
Message-Id: <20200329184317.221824368@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 12/21] tracing: Do not disable tracing when reading the trace file
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When opening the "trace" file, it is no longer necessary to disable tracing.

Note, a new option is created called "pause-on-trace", when set, will cause
the trace file to emulate its original behavior.

Link: http://lkml.kernel.org/r/20200317213416.903351225@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 6 ++++++
 kernel/trace/trace.c           | 9 ++++++---
 kernel/trace/trace.h           | 1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 99a0890e20ec..c33950a35d65 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1125,6 +1125,12 @@ Here are the available options:
 	the trace displays additional information about the
 	latency, as described in "Latency trace format".
 
+  pause-on-trace
+	When set, opening the trace file for read, will pause
+	writing to the ring buffer (as if tracing_on was set to zero).
+	This simulates the original behavior of the trace file.
+	When the file is closed, tracing will be enabled again.
+
   record-cmd
 	When any event or tracer is enabled, a hook is enabled
 	in the sched_switch trace point to fill comm cache
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47889123be7f..650fa81fffe8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4273,8 +4273,11 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (trace_clocks[tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
 
-	/* stop the trace while dumping if we are not opening "snapshot" */
-	if (!iter->snapshot)
+	/*
+	 * If pause-on-trace is enabled, then stop the trace while
+	 * dumping, unless this is the "snapshot" file
+	 */
+	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER_PAUSE_ON_TRACE))
 		tracing_stop_tr(tr);
 
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
@@ -4371,7 +4374,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 	if (iter->trace && iter->trace->close)
 		iter->trace->close(iter);
 
-	if (!iter->snapshot)
+	if (!iter->snapshot && tr->stop_count)
 		/* reenable tracing if it was previously enabled */
 		tracing_start_tr(tr);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c61e1b1c85a6..f37e05135986 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1302,6 +1302,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(IRQ_INFO,		"irq-info"),		\
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
+		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-- 
2.25.1


