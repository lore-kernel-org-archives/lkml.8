Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D01BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA78208FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgE3J6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgE3J5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17032C03E969;
        Sat, 30 May 2020 02:57:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEw-0002pY-EO; Sat, 30 May 2020 11:57:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 13E4E1C032F;
        Sat, 30 May 2020 11:57:18 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:17 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Rename trace_hardirqs_off_prepare()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529213321.415774872@infradead.org>
References: <20200529213321.415774872@infradead.org>
MIME-Version: 1.0
Message-ID: <159083263791.17951.6423790450916631090.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     029149180d1d6e05e81e7db0d46c00960ab2e84f
Gitweb:        https://git.kernel.org/tip/029149180d1d6e05e81e7db0d46c00960ab2e84f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 23:27:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:11 +02:00

x86/entry: Rename trace_hardirqs_off_prepare()

The typical pattern for trace_hardirqs_off_prepare() is:

  ENTRY
    lockdep_hardirqs_off(); // because hardware
    ... do entry magic
    instrumentation_begin();
    trace_hardirqs_off_prepare();
    ... do actual work
    trace_hardirqs_on_prepare();
    lockdep_hardirqs_on_prepare();
    instrumentation_end();
    ... do exit magic
    lockdep_hardirqs_on();

which shows that it's named wrong, rename it to
trace_hardirqs_off_finish(), as it concludes the hardirq_off transition.

Also, given that the above is the only correct order, make the traditional
all-in-one trace_hardirqs_off() follow suit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200529213321.415774872@infradead.org

---
 arch/x86/entry/common.c         |  6 +++---
 arch/x86/kernel/cpu/mce/core.c  |  2 +-
 arch/x86/kernel/nmi.c           |  2 +-
 arch/x86/kernel/traps.c         |  4 ++--
 include/linux/irqflags.h        |  4 ++--
 kernel/trace/trace_preemptirq.c | 10 +++++-----
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 17a9a5a..aea6b4f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -65,7 +65,7 @@ static noinstr void enter_from_user_mode(void)
 
 	instrumentation_begin();
 	CT_WARN_ON(state != CONTEXT_USER);
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
 #else
@@ -73,7 +73,7 @@ static __always_inline void enter_from_user_mode(void)
 {
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
 #endif
@@ -569,7 +569,7 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
 		instrumentation_begin();
-		trace_hardirqs_off_prepare();
+		trace_hardirqs_off_finish();
 		instrumentation_end();
 
 		return true;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index be49926..b9cb381 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1922,7 +1922,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 * that out because it's an indirect call. Annotate it.
 	 */
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	machine_check_vector(regs);
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 52a708e..4a43934 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -334,7 +334,7 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6f887be..79af913 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -634,7 +634,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	} else {
 		nmi_enter();
 		instrumentation_begin();
-		trace_hardirqs_off_prepare();
+		trace_hardirqs_off_finish();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		if (regs->flags & X86_EFLAGS_IF)
@@ -833,7 +833,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 {
 	nmi_enter();
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 
 	/*
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d7f7e43..6384d28 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -32,7 +32,7 @@
 
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on_prepare(void);
-  extern void trace_hardirqs_off_prepare(void);
+  extern void trace_hardirqs_off_finish(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
 # define lockdep_hardirq_context(p)	((p)->hardirq_context)
@@ -101,7 +101,7 @@ do {						\
 
 #else
 # define trace_hardirqs_on_prepare()		do { } while (0)
-# define trace_hardirqs_off_prepare()		do { } while (0)
+# define trace_hardirqs_off_finish()		do { } while (0)
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
 # define lockdep_hardirq_context(p)	0
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index fb0691b..f10073e 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -58,7 +58,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on);
  * and lockdep uses a staged approach which splits the lockdep hardirq
  * tracking into a RCU on and a RCU off section.
  */
-void trace_hardirqs_off_prepare(void)
+void trace_hardirqs_off_finish(void)
 {
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
@@ -68,19 +68,19 @@ void trace_hardirqs_off_prepare(void)
 	}
 
 }
-EXPORT_SYMBOL(trace_hardirqs_off_prepare);
-NOKPROBE_SYMBOL(trace_hardirqs_off_prepare);
+EXPORT_SYMBOL(trace_hardirqs_off_finish);
+NOKPROBE_SYMBOL(trace_hardirqs_off_finish);
 
 void trace_hardirqs_off(void)
 {
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
 		if (!in_nmi())
 			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
 	}
-
-	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);
