Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0786CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D291A2465B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgA3Osd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:48:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbgA3OsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86CA224694;
        Thu, 30 Jan 2020 14:48:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB77-001CTt-Ff; Thu, 30 Jan 2020 09:48:13 -0500
Message-Id: <20200130144813.363630935@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:48:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 21/21] tracing: Move tracing selftests to bottom of menu
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Move all the tracing selftest configs to the bottom of the tracing menu.
There's no reason for them to be interspersed throughout.

Also, move the bootconfig menu to the top.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 168 +++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 2014056682f5..91e885194dbc 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -141,6 +141,15 @@ menuconfig FTRACE
 
 if FTRACE
 
+config BOOTTIME_TRACING
+	bool "Boot-time Tracing support"
+	depends on BOOT_CONFIG && TRACING
+	default y
+	help
+	  Enable developer to setup ftrace subsystem via supplemental
+	  kernel cmdline at boot time for debugging (tracing) driver
+	  initialization and boot process.
+
 config FUNCTION_TRACER
 	bool "Kernel Function Tracer"
 	depends on HAVE_FUNCTION_TRACER
@@ -605,41 +614,6 @@ config FTRACE_MCOUNT_RECORD
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_FTRACE_MCOUNT_RECORD
 
-config FTRACE_SELFTEST
-	bool
-
-config FTRACE_STARTUP_TEST
-	bool "Perform a startup test on ftrace"
-	depends on GENERIC_TRACER
-	select FTRACE_SELFTEST
-	help
-	  This option performs a series of startup tests on ftrace. On bootup
-	  a series of tests are made to verify that the tracer is
-	  functioning properly. It will do tests on all the configured
-	  tracers of ftrace.
-
-config EVENT_TRACE_STARTUP_TEST
-	bool "Run selftest on trace events"
-	depends on FTRACE_STARTUP_TEST
-	default y
-	help
-	  This option performs a test on all trace events in the system.
-	  It basically just enables each event and runs some code that
-	  will trigger events (not necessarily the event it enables)
-	  This may take some time run as there are a lot of events.
-
-config EVENT_TRACE_TEST_SYSCALLS
-	bool "Run selftest on syscall events"
-	depends on EVENT_TRACE_STARTUP_TEST
-	help
-	 This option will also enable testing every syscall event.
-	 It only enables the event and disables it and runs various loads
-	 with the event enabled. This adds a bit more time for kernel boot
-	 up since it runs this on every system call defined.
-
-	 TBD - enable a way to actually call the syscalls as we test their
-	       events
-
 config TRACING_MAP
 	bool
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
@@ -726,6 +700,81 @@ config RING_BUFFER_BENCHMARK
 
 	  If unsure, say N.
 
+config TRACE_EVAL_MAP_FILE
+       bool "Show eval mappings for trace events"
+       depends on TRACING
+       help
+	The "print fmt" of the trace events will show the enum/sizeof names
+	instead of their values. This can cause problems for user space tools
+	that use this string to parse the raw data as user space does not know
+	how to convert the string to its value.
+
+	To fix this, there's a special macro in the kernel that can be used
+	to convert an enum/sizeof into its value. If this macro is used, then
+	the print fmt strings will be converted to their values.
+
+	If something does not get converted properly, this option can be
+	used to show what enums/sizeof the kernel tried to convert.
+
+	This option is for debugging the conversions. A file is created
+	in the tracing directory called "eval_map" that will show the
+	names matched with their values and what trace event system they
+	belong too.
+
+	Normally, the mapping of the strings to values will be freed after
+	boot up or module load. With this option, they will not be freed, as
+	they are needed for the "eval_map" file. Enabling this option will
+	increase the memory footprint of the running kernel.
+
+	If unsure, say N.
+
+config GCOV_PROFILE_FTRACE
+	bool "Enable GCOV profiling on ftrace subsystem"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling on ftrace subsystem for checking
+	  which functions/lines are tested.
+
+	  If unsure, say N.
+
+	  Note that on a kernel compiled with this config, ftrace will
+	  run significantly slower.
+
+config FTRACE_SELFTEST
+	bool
+
+config FTRACE_STARTUP_TEST
+	bool "Perform a startup test on ftrace"
+	depends on GENERIC_TRACER
+	select FTRACE_SELFTEST
+	help
+	  This option performs a series of startup tests on ftrace. On bootup
+	  a series of tests are made to verify that the tracer is
+	  functioning properly. It will do tests on all the configured
+	  tracers of ftrace.
+
+config EVENT_TRACE_STARTUP_TEST
+	bool "Run selftest on trace events"
+	depends on FTRACE_STARTUP_TEST
+	default y
+	help
+	  This option performs a test on all trace events in the system.
+	  It basically just enables each event and runs some code that
+	  will trigger events (not necessarily the event it enables)
+	  This may take some time run as there are a lot of events.
+
+config EVENT_TRACE_TEST_SYSCALLS
+	bool "Run selftest on syscall events"
+	depends on EVENT_TRACE_STARTUP_TEST
+	help
+	 This option will also enable testing every syscall event.
+	 It only enables the event and disables it and runs various loads
+	 with the event enabled. This adds a bit more time for kernel boot
+	 up since it runs this on every system call defined.
+
+	 TBD - enable a way to actually call the syscalls as we test their
+	       events
+
 config RING_BUFFER_STARTUP_TEST
        bool "Ring buffer startup self test"
        depends on RING_BUFFER
@@ -799,55 +848,6 @@ config KPROBE_EVENT_GEN_TEST
 
 	  If unsure, say N.
 
-config TRACE_EVAL_MAP_FILE
-       bool "Show eval mappings for trace events"
-       depends on TRACING
-       help
-	The "print fmt" of the trace events will show the enum/sizeof names
-	instead of their values. This can cause problems for user space tools
-	that use this string to parse the raw data as user space does not know
-	how to convert the string to its value.
-
-	To fix this, there's a special macro in the kernel that can be used
-	to convert an enum/sizeof into its value. If this macro is used, then
-	the print fmt strings will be converted to their values.
-
-	If something does not get converted properly, this option can be
-	used to show what enums/sizeof the kernel tried to convert.
-
-	This option is for debugging the conversions. A file is created
-	in the tracing directory called "eval_map" that will show the
-	names matched with their values and what trace event system they
-	belong too.
-
-	Normally, the mapping of the strings to values will be freed after
-	boot up or module load. With this option, they will not be freed, as
-	they are needed for the "eval_map" file. Enabling this option will
-	increase the memory footprint of the running kernel.
-
-	If unsure, say N.
-
-config GCOV_PROFILE_FTRACE
-	bool "Enable GCOV profiling on ftrace subsystem"
-	depends on GCOV_KERNEL
-	help
-	  Enable GCOV profiling on ftrace subsystem for checking
-	  which functions/lines are tested.
-
-	  If unsure, say N.
-
-	  Note that on a kernel compiled with this config, ftrace will
-	  run significantly slower.
-
-config BOOTTIME_TRACING
-	bool "Boot-time Tracing support"
-	depends on BOOT_CONFIG && TRACING
-	default y
-	help
-	  Enable developer to setup ftrace subsystem via supplemental
-	  kernel cmdline at boot time for debugging (tracing) driver
-	  initialization and boot process.
-
 endif # FTRACE
 
 endif # TRACING_SUPPORT
-- 
2.24.1


