Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E185C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E861A2176B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgE3J6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgE3J5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC16C08C5C9;
        Sat, 30 May 2020 02:57:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEw-0002pr-Tb; Sat, 30 May 2020 11:57:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 889B81C0093;
        Sat, 30 May 2020 11:57:18 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:18 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Clarify irq_{enter,exit}_rcu()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529213321.359433429@infradead.org>
References: <20200529213321.359433429@infradead.org>
MIME-Version: 1.0
Message-ID: <159083263842.17951.2162910976893497225.tip-bot2@tip-bot2>
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

Commit-ID:     b614345f52bcde8299a53132f5e48a9eb5a1f320
Gitweb:        https://git.kernel.org/tip/b614345f52bcde8299a53132f5e48a9eb5a1f320
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 23:27:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:10 +02:00

x86/entry: Clarify irq_{enter,exit}_rcu()

Because:

  irq_enter_rcu() includes lockdep_hardirq_enter()
  irq_exit_rcu() does *NOT* include lockdep_hardirq_exit()

Which resulted in two 'stray' lockdep_hardirq_exit() calls in
idtentry.h, and me spending a long time trying to find the matching
enter calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200529213321.359433429@infradead.org

---
 arch/x86/include/asm/idtentry.h |  2 --
 kernel/softirq.c                | 19 +++++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d214a30..f8e2737 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -206,7 +206,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
-	lockdep_hardirq_exit();						\
 	instrumentation_end();						\
 	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
@@ -249,7 +248,6 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_on_irqstack_cond(__##func, regs, regs);			\
 	irq_exit_rcu();							\
-	lockdep_hardirq_exit();						\
 	instrumentation_end();						\
 	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
diff --git a/kernel/softirq.c b/kernel/softirq.c
index beb8e3a..a3eb6eb 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -404,12 +404,7 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
-/**
- * irq_exit_rcu() - Exit an interrupt context without updating RCU
- *
- * Also processes softirqs if needed and possible.
- */
-void irq_exit_rcu(void)
+static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
 	local_irq_disable();
@@ -425,6 +420,18 @@ void irq_exit_rcu(void)
 }
 
 /**
+ * irq_exit_rcu() - Exit an interrupt context without updating RCU
+ *
+ * Also processes softirqs if needed and possible.
+ */
+void irq_exit_rcu(void)
+{
+	__irq_exit_rcu();
+	 /* must be last! */
+	lockdep_hardirq_exit();
+}
+
+/**
  * irq_exit - Exit an interrupt context, update RCU and lockdep
  *
  * Also processes softirqs if needed and possible.
