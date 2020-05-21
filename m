Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B238020874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEUUcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbgEUUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10317C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:03 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqd-0000M6-Ti; Thu, 21 May 2020 22:31:24 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 576F8100CA6;
        Thu, 21 May 2020 22:31:23 +0200 (CEST)
Message-Id: <20200521202117.567023613@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [patch V9 08/39] genirq: Provide irq_enter/exit_rcu()
References: <20200521200513.656533920@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

irq_enter()/exit() include the RCU handling. To properly separate the RCU
handling provide variants which contain only the non-RCU related
functionality.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/hardirq.h |   13 +++++++++++--
 kernel/softirq.c        |   35 +++++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 10 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -52,7 +52,11 @@ static __always_inline void rcu_irq_ente
 /*
  * Enter irq context (on NO_HZ, update jiffies):
  */
-extern void irq_enter(void);
+void irq_enter(void);
+/*
+ * Like irq_enter(), but RCU is already watching.
+ */
+void irq_enter_rcu(void);
 
 /*
  * Exit irq context without processing softirqs:
@@ -67,7 +71,12 @@ extern void irq_enter(void);
 /*
  * Exit irq context and process softirqs if needed:
  */
-extern void irq_exit(void);
+void irq_exit(void);
+
+/*
+ * Like irq_exit(), but return with RCU watching.
+ */
+void irq_exit_rcu(void);
 
 #ifndef arch_nmi_enter
 #define arch_nmi_enter()	do { } while (0)
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -339,12 +339,11 @@ asmlinkage __visible void do_softirq(voi
 	local_irq_restore(flags);
 }
 
-/*
- * Enter an interrupt context.
+/**
+ * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
-void irq_enter(void)
+void irq_enter_rcu(void)
 {
-	rcu_irq_enter();
 	if (is_idle_task(current) && !in_interrupt()) {
 		/*
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
@@ -354,10 +353,18 @@ void irq_enter(void)
 		tick_irq_enter();
 		_local_bh_enable();
 	}
-
 	__irq_enter();
 }
 
+/**
+ * irq_enter - Enter an interrupt context including RCU update
+ */
+void irq_enter(void)
+{
+	rcu_irq_enter();
+	irq_enter_rcu();
+}
+
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
@@ -397,10 +404,12 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
-/*
- * Exit an interrupt context. Process softirqs if needed and possible:
+/**
+ * irq_exit_rcu() - Exit an interrupt context without updating RCU
+ *
+ * Also processes softirqs if needed and possible.
  */
-void irq_exit(void)
+void irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
 	local_irq_disable();
@@ -413,6 +422,16 @@ void irq_exit(void)
 		invoke_softirq();
 
 	tick_irq_exit();
+}
+
+/**
+ * irq_exit - Exit an interrupt context, update RCU and lockdep
+ *
+ * Also processes softirqs if needed and possible.
+ */
+void irq_exit(void)
+{
+	irq_exit_rcu();
 	rcu_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();

