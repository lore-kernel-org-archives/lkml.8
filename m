Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F0F2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgE0IMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgE0IMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68218C03E97C;
        Wed, 27 May 2020 01:12:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAV-0002f0-RM; Wed, 27 May 2020 10:12:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D85C61C0823;
        Wed, 27 May 2020 10:11:58 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:58 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] genirq: Provide irq_enter/exit_rcu()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.567023613@linutronix.de>
References: <20200521202117.567023613@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711874.17951.11195495403173853743.tip-bot2@tip-bot2>
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

Commit-ID:     a59262f6413b82992626754b46383a615bfac152
Gitweb:        https://git.kernel.org/tip/a59262f6413b82992626754b46383a615bfac152
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

genirq: Provide irq_enter/exit_rcu()

irq_enter()/exit() currently include RCU handling. To properly separate the RCU
handling code, provide variants which contain only the non-RCU related
functionality.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.567023613@linutronix.de
---
 include/linux/hardirq.h | 13 +++++++++++--
 kernel/softirq.c        | 35 +++++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 29b862a..3dc9102 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -40,7 +40,11 @@ static __always_inline void rcu_irq_enter_check_tick(void)
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
@@ -55,7 +59,12 @@ extern void irq_enter(void);
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
diff --git a/kernel/softirq.c b/kernel/softirq.c
index a47c6dd..beb8e3a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -339,12 +339,11 @@ asmlinkage __visible void do_softirq(void)
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
