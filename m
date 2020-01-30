Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA03AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A6321734
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgA3OsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbgA3OsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7FE24685;
        Thu, 30 Jan 2020 14:48:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB77-001CSQ-1j; Thu, 30 Jan 2020 09:48:13 -0500
Message-Id: <20200130144812.928328487@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:48:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 18/21] tracing: Move all function tracing configs together
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The features that depend on the function tracer were spread out through the
tracing menu, pull them together as it is easier to manage.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 142 +++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 4484e783f68d..32fcbc00753b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -172,6 +172,77 @@ config FUNCTION_GRAPH_TRACER
 	  the return value. This is done by setting the current return
 	  address on the current task structure into a stack of calls.
 
+config DYNAMIC_FTRACE
+	bool "enable/disable function tracing dynamically"
+	depends on FUNCTION_TRACER
+	depends on HAVE_DYNAMIC_FTRACE
+	default y
+	help
+	  This option will modify all the calls to function tracing
+	  dynamically (will patch them out of the binary image and
+	  replace them with a No-Op instruction) on boot up. During
+	  compile time, a table is made of all the locations that ftrace
+	  can function trace, and this table is linked into the kernel
+	  image. When this is enabled, functions can be individually
+	  enabled, and the functions not enabled will not affect
+	  performance of the system.
+
+	  See the files in /sys/kernel/debug/tracing:
+	    available_filter_functions
+	    set_ftrace_filter
+	    set_ftrace_notrace
+
+	  This way a CONFIG_FUNCTION_TRACER kernel is slightly larger, but
+	  otherwise has native performance as long as no tracing is active.
+
+config DYNAMIC_FTRACE_WITH_REGS
+	def_bool y
+	depends on DYNAMIC_FTRACE
+	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
+
+config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	def_bool y
+	depends on DYNAMIC_FTRACE
+	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+
+config FUNCTION_PROFILER
+	bool "Kernel function profiler"
+	depends on FUNCTION_TRACER
+	default n
+	help
+	  This option enables the kernel function profiler. A file is created
+	  in debugfs called function_profile_enabled which defaults to zero.
+	  When a 1 is echoed into this file profiling begins, and when a
+	  zero is entered, profiling stops. A "functions" file is created in
+	  the trace_stat directory; this file shows the list of functions that
+	  have been hit and their counters.
+
+	  If in doubt, say N.
+
+config STACK_TRACER
+	bool "Trace max stack"
+	depends on HAVE_FUNCTION_TRACER
+	select FUNCTION_TRACER
+	select STACKTRACE
+	select KALLSYMS
+	help
+	  This special tracer records the maximum stack footprint of the
+	  kernel and displays it in /sys/kernel/debug/tracing/stack_trace.
+
+	  This tracer works by hooking into every function call that the
+	  kernel executes, and keeping a maximum stack depth value and
+	  stack-trace saved.  If this is configured with DYNAMIC_FTRACE
+	  then it will not have any overhead while the stack tracer
+	  is disabled.
+
+	  To enable the stack tracer on bootup, pass in 'stacktrace'
+	  on the kernel command line.
+
+	  The stack tracer can also be enabled or disabled via the
+	  sysctl kernel.stack_tracer_enabled
+
+	  Say N if unsure.
+
 config TRACE_PREEMPT_TOGGLE
 	bool
 	help
@@ -410,30 +481,6 @@ config BRANCH_TRACER
 
 	  Say N if unsure.
 
-config STACK_TRACER
-	bool "Trace max stack"
-	depends on HAVE_FUNCTION_TRACER
-	select FUNCTION_TRACER
-	select STACKTRACE
-	select KALLSYMS
-	help
-	  This special tracer records the maximum stack footprint of the
-	  kernel and displays it in /sys/kernel/debug/tracing/stack_trace.
-
-	  This tracer works by hooking into every function call that the
-	  kernel executes, and keeping a maximum stack depth value and
-	  stack-trace saved.  If this is configured with DYNAMIC_FTRACE
-	  then it will not have any overhead while the stack tracer
-	  is disabled.
-
-	  To enable the stack tracer on bootup, pass in 'stacktrace'
-	  on the kernel command line.
-
-	  The stack tracer can also be enabled or disabled via the
-	  sysctl kernel.stack_tracer_enabled
-
-	  Say N if unsure.
-
 config BLK_DEV_IO_TRACE
 	bool "Support for tracing block IO actions"
 	depends on SYSFS
@@ -531,53 +578,6 @@ config DYNAMIC_EVENTS
 config PROBE_EVENTS
 	def_bool n
 
-config DYNAMIC_FTRACE
-	bool "enable/disable function tracing dynamically"
-	depends on FUNCTION_TRACER
-	depends on HAVE_DYNAMIC_FTRACE
-	default y
-	help
-	  This option will modify all the calls to function tracing
-	  dynamically (will patch them out of the binary image and
-	  replace them with a No-Op instruction) on boot up. During
-	  compile time, a table is made of all the locations that ftrace
-	  can function trace, and this table is linked into the kernel
-	  image. When this is enabled, functions can be individually
-	  enabled, and the functions not enabled will not affect
-	  performance of the system.
-
-	  See the files in /sys/kernel/debug/tracing:
-	    available_filter_functions
-	    set_ftrace_filter
-	    set_ftrace_notrace
-
-	  This way a CONFIG_FUNCTION_TRACER kernel is slightly larger, but
-	  otherwise has native performance as long as no tracing is active.
-
-config DYNAMIC_FTRACE_WITH_REGS
-	def_bool y
-	depends on DYNAMIC_FTRACE
-	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
-
-config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	def_bool y
-	depends on DYNAMIC_FTRACE
-	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-
-config FUNCTION_PROFILER
-	bool "Kernel function profiler"
-	depends on FUNCTION_TRACER
-	default n
-	help
-	  This option enables the kernel function profiler. A file is created
-	  in debugfs called function_profile_enabled which defaults to zero.
-	  When a 1 is echoed into this file profiling begins, and when a
-	  zero is entered, profiling stops. A "functions" file is created in
-	  the trace_stat directory; this file shows the list of functions that
-	  have been hit and their counters.
-
-	  If in doubt, say N.
-
 config BPF_KPROBE_OVERRIDE
 	bool "Enable BPF programs to override a kprobed function"
 	depends on BPF_EVENTS
-- 
2.24.1


