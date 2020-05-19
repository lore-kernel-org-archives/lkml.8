Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185AA2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgESTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgESTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:53:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8CC08C5C0;
        Tue, 19 May 2020 12:53:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hz-0007rb-GG; Tue, 19 May 2020 21:52:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 160791C047E;
        Tue, 19 May 2020 21:52:35 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] sh/ftrace: Move arch_ftrace_nmi_{enter,exit} into nmi
 exception
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134101.248881738@linutronix.de>
References: <20200505134101.248881738@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795499.17951.5925531045899996305.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     178ba00c354eb15cec6806a812771e60a5ae3ea1
Gitweb:        https://git.kernel.org/tip/178ba00c354eb15cec6806a812771e60a5ae3ea1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2020 22:26:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:18 +02:00

sh/ftrace: Move arch_ftrace_nmi_{enter,exit} into nmi exception

SuperH is the last remaining user of arch_ftrace_nmi_{enter,exit}(),
remove it from the generic code and into the SuperH code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: https://lkml.kernel.org/r/20200505134101.248881738@linutronix.de


---
 Documentation/trace/ftrace-design.rst |  8 --------
 arch/sh/Kconfig                       |  1 -
 arch/sh/kernel/traps.c                | 12 ++++++++++++
 include/linux/ftrace_irq.h            | 11 -----------
 kernel/trace/Kconfig                  | 10 ----------
 5 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/Documentation/trace/ftrace-design.rst b/Documentation/trace/ftrace-design.rst
index a8e22e0..6893399 100644
--- a/Documentation/trace/ftrace-design.rst
+++ b/Documentation/trace/ftrace-design.rst
@@ -229,14 +229,6 @@ Adding support for it is easy: just define the macro in asm/ftrace.h and
 pass the return address pointer as the 'retp' argument to
 ftrace_push_return_trace().
 
-HAVE_FTRACE_NMI_ENTER
----------------------
-
-If you can't trace NMI functions, then skip this option.
-
-<details to be filled>
-
-
 HAVE_SYSCALL_TRACEPOINTS
 ------------------------
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b4f0e37..97656d2 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -71,7 +71,6 @@ config SUPERH32
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_FTRACE_NMI_ENTER if DYNAMIC_FTRACE
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_ARCH_KGDB
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 63cf17b..2130381 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -170,11 +170,21 @@ BUILD_TRAP_HANDLER(bug)
 	force_sig(SIGTRAP);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern void arch_ftrace_nmi_enter(void);
+extern void arch_ftrace_nmi_exit(void);
+#else
+static inline void arch_ftrace_nmi_enter(void) { }
+static inline void arch_ftrace_nmi_exit(void) { }
+#endif
+
 BUILD_TRAP_HANDLER(nmi)
 {
 	unsigned int cpu = smp_processor_id();
 	TRAP_HANDLER_DECL;
 
+	arch_ftrace_nmi_enter();
+
 	nmi_enter();
 	nmi_count(cpu)++;
 
@@ -190,4 +200,6 @@ BUILD_TRAP_HANDLER(nmi)
 	}
 
 	nmi_exit();
+
+	arch_ftrace_nmi_exit();
 }
diff --git a/include/linux/ftrace_irq.h b/include/linux/ftrace_irq.h
index ccda97d..0abd9a1 100644
--- a/include/linux/ftrace_irq.h
+++ b/include/linux/ftrace_irq.h
@@ -2,15 +2,6 @@
 #ifndef _LINUX_FTRACE_IRQ_H
 #define _LINUX_FTRACE_IRQ_H
 
-
-#ifdef CONFIG_FTRACE_NMI_ENTER
-extern void arch_ftrace_nmi_enter(void);
-extern void arch_ftrace_nmi_exit(void);
-#else
-static inline void arch_ftrace_nmi_enter(void) { }
-static inline void arch_ftrace_nmi_exit(void) { }
-#endif
-
 #ifdef CONFIG_HWLAT_TRACER
 extern bool trace_hwlat_callback_enabled;
 extern void trace_hwlat_callback(bool enter);
@@ -22,12 +13,10 @@ static inline void ftrace_nmi_enter(void)
 	if (trace_hwlat_callback_enabled)
 		trace_hwlat_callback(true);
 #endif
-	arch_ftrace_nmi_enter();
 }
 
 static inline void ftrace_nmi_exit(void)
 {
-	arch_ftrace_nmi_exit();
 #ifdef CONFIG_HWLAT_TRACER
 	if (trace_hwlat_callback_enabled)
 		trace_hwlat_callback(false);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 1e9a8f9..24876fa 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -10,11 +10,6 @@ config USER_STACKTRACE_SUPPORT
 config NOP_TRACER
 	bool
 
-config HAVE_FTRACE_NMI_ENTER
-	bool
-	help
-	  See Documentation/trace/ftrace-design.rst
-
 config HAVE_FUNCTION_TRACER
 	bool
 	help
@@ -72,11 +67,6 @@ config RING_BUFFER
 	select TRACE_CLOCK
 	select IRQ_WORK
 
-config FTRACE_NMI_ENTER
-       bool
-       depends on HAVE_FTRACE_NMI_ENTER
-       default y
-
 config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
