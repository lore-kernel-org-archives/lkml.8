Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B5C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18365208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgEUUbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgEUUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:31:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1019C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:31:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqX-0000Ga-P6; Thu, 21 May 2020 22:31:17 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1D25E100606;
        Thu, 21 May 2020 22:31:17 +0200 (CEST)
Message-Id: <20200521202117.089709607@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:16 +0200
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
Subject: [patch V9 03/39] rcu: Provide rcu_irq_exit_check_preempt()
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

Provide a debug check which can be invoked from exception return to kernel
mode before an attempt is made to schedule. Warn if RCU is not ready for
this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: New patch
---
 include/linux/rcutiny.h |    1 +
 include/linux/rcutree.h |    6 ++++++
 kernel/rcu/tree.c       |   18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -72,6 +72,7 @@ static inline void rcu_irq_exit_irqson(v
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_preempt(void) { }
+static inline void rcu_irq_exit_check_preempt(void) { }
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -51,6 +51,12 @@ void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
 
+#ifdef CONFIG_PROVE_RCU
+void rcu_irq_exit_check_preempt(void);
+#else
+static inline void rcu_irq_exit_check_preempt(void) { }
+#endif
+
 void exit_rcu(void);
 
 void rcu_scheduler_starting(void);
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -765,6 +765,24 @@ void rcu_irq_exit_preempt(void)
 			 "RCU in extended quiescent state!");
 }
 
+#ifdef CONFIG_PROVE_RCU
+/**
+ * rcu_irq_exit_check_preempt - Validate that scheduling is possible
+ */
+void rcu_irq_exit_check_preempt(void)
+{
+	lockdep_assert_irqs_disabled();
+
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
+			 "RCU dynticks_nesting counter underflow/zero!");
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
+			 DYNTICK_IRQ_NONIDLE,
+			 "Bad RCU  dynticks_nmi_nesting counter\n");
+	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+			 "RCU in extended quiescent state!");
+}
+#endif /* #ifdef CONFIG_PROVE_RCU */
+
 /*
  * Wrapper for rcu_irq_exit() where interrupts are enabled.
  *

