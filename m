Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B042078B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEPAKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727838AbgEPAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE3C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:40 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkP3-00022L-Pw; Sat, 16 May 2020 02:10:09 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4E953100605;
        Sat, 16 May 2020 02:10:09 +0200 (CEST)
Message-Id: <20200515235124.577025789@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:45:49 +0200
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V6 02/37] tracing/hwlat: Split ftrace_nmi_enter/exit()
References: <20200515234547.710474468@linutronix.de>
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

The hardware latency tracer calls into timekeeping and ends up in
various instrumentable functions which is problematic vs. the kprobe
handling especially the text poke machinery. It's invoked from
nmi_enter/exit(), i.e. non-instrumentable code.

Split it into two parts:

 1) NMI counter, only invoked on nmi_enter() and noinstr safe

 2) NMI timestamping, to be invoked from instrumentable code

Move it into the rcu is watching regions of nmi_enter/exit() even
if there is no actual RCU dependency right now but there is also
no point in having it early.

The actual split of nmi_enter/exit() is done in a separate step.

Requested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/ftrace_irq.h |   31 +++++++++++++++++++------------
 include/linux/hardirq.h    |    5 +++--
 kernel/trace/trace_hwlat.c |   19 ++++++++++++-------
 3 files changed, 34 insertions(+), 21 deletions(-)

--- a/include/linux/ftrace_irq.h
+++ b/include/linux/ftrace_irq.h
@@ -4,23 +4,30 @@
 
 #ifdef CONFIG_HWLAT_TRACER
 extern bool trace_hwlat_callback_enabled;
-extern void trace_hwlat_callback(bool enter);
-#endif
+extern void trace_hwlat_count_nmi(void);
+extern void trace_hwlat_timestamp(bool enter);
 
-static inline void ftrace_nmi_enter(void)
+static __always_inline void ftrace_count_nmi(void)
 {
-#ifdef CONFIG_HWLAT_TRACER
-	if (trace_hwlat_callback_enabled)
-		trace_hwlat_callback(true);
-#endif
+	if (unlikely(trace_hwlat_callback_enabled))
+		trace_hwlat_count_nmi();
 }
 
-static inline void ftrace_nmi_exit(void)
+static __always_inline void ftrace_nmi_handler_enter(void)
 {
-#ifdef CONFIG_HWLAT_TRACER
-	if (trace_hwlat_callback_enabled)
-		trace_hwlat_callback(false);
-#endif
+	if (unlikely(trace_hwlat_callback_enabled))
+		trace_hwlat_timestamp(true);
 }
 
+static __always_inline void ftrace_nmi_handler_exit(void)
+{
+	if (unlikely(trace_hwlat_callback_enabled))
+		trace_hwlat_timestamp(false);
+}
+#else /* CONFIG_HWLAT_TRACER */
+static inline void ftrace_count_nmi(void) {}
+static inline void ftrace_nmi_handler_enter(void) {}
+static inline void ftrace_nmi_handler_exit(void) {}
+#endif
+
 #endif /* _LINUX_FTRACE_IRQ_H */
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -82,20 +82,21 @@ extern void irq_exit(void);
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
-		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
+		ftrace_count_nmi();				\
+		ftrace_nmi_handler_enter();			\
 	} while (0)
 
 #define nmi_exit()						\
 	do {							\
+		ftrace_nmi_handler_exit();			\
 		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
 		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
 		arch_nmi_exit();				\
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -132,21 +132,26 @@ static void trace_hwlat_sample(struct hw
 }
 
 /*
+ * Count NMIs in nmi_enter(). Does not take timestamps
+ * because the timestamping callchain cannot be invoked
+ * from noinstr sections.
+ */
+noinstr void trace_hwlat_count_nmi(void)
+{
+	if (smp_processor_id() == nmi_cpu)
+		nmi_count++;
+}
+
+/*
  * Timestamping uses ktime_get_mono_fast(), the NMI safe access to
  * CLOCK_MONOTONIC.
  */
-void trace_hwlat_callback(bool enter)
+void trace_hwlat_timestamp(bool enter)
 {
-	if (smp_processor_id() != nmi_cpu)
-		return;
-
 	if (enter)
 		nmi_ts_start = ktime_get_mono_fast_ns();
 	else
 		nmi_total_ts += ktime_get_mono_fast_ns() - nmi_ts_start;
-
-	if (enter)
-		nmi_count++;
 }
 
 /**

