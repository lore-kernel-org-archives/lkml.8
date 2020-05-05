Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CD3C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3E520838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgEEOOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729351AbgEEOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC48CC061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:18 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKY-0000lj-2m; Tue, 05 May 2020 16:13:54 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 936F7FFC8D;
        Tue,  5 May 2020 16:13:53 +0200 (CEST)
Message-Id: <20200505134101.248881738@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:34 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [patch V4 part 1 32/36] sh/ftrace: Move arch_ftrace_nmi_{enter,exit}
 into nmi exception
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

SuperH is the last remaining user of arch_ftrace_nmi_{enter,exit}(),
remove it from the generic code and into the SuperH code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 Documentation/trace/ftrace-design.rst |    8 --------
 arch/sh/Kconfig                       |    1 -
 arch/sh/kernel/traps.c                |   12 ++++++++++++
 include/linux/ftrace_irq.h            |   11 -----------
 kernel/trace/Kconfig                  |   10 ----------
 5 files changed, 12 insertions(+), 30 deletions(-)

--- a/Documentation/trace/ftrace-design.rst
+++ b/Documentation/trace/ftrace-design.rst
@@ -229,14 +229,6 @@ Adding support for it is easy: just defi
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
@@ -22,12 +13,10 @@ static inline void ftrace_nmi_enter(void
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

