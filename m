Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75534C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3F720FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgE0IMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgE0IML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFBC061A0F;
        Wed, 27 May 2020 01:12:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAX-0002hY-3G; Wed, 27 May 2020 10:12:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E7A2E1C0837;
        Wed, 27 May 2020 10:12:01 +0200 (CEST)
Date:   Wed, 27 May 2020 08:12:01 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] rcu: Provide rcu_irq_exit_check_preempt()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.089709607@linutronix.de>
References: <20200521202117.089709607@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056712180.17951.11617155731989917506.tip-bot2@tip-bot2>
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

Commit-ID:     07325d4a90d2d84de45cc07b134fd0f023dbb971
Gitweb:        https://git.kernel.org/tip/07325d4a90d2d84de45cc07b134fd0f023dbb971
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:05:11 +02:00

rcu: Provide rcu_irq_exit_check_preempt()

Provide a debug check which can be invoked from exception return to kernel
mode before an attempt is made to schedule. Warn if RCU is not ready for
this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.089709607@linutronix.de
---
 include/linux/rcutiny.h |  1 +
 include/linux/rcutree.h |  6 ++++++
 kernel/rcu/tree.c       | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index c869fb2..8512cae 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -72,6 +72,7 @@ static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_preempt(void) { }
+static inline void rcu_irq_exit_check_preempt(void) { }
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 9366fa4..d5cc9d6 100644
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
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b7f8c49..d8e9dbb 100644
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
