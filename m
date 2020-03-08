Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25BEC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC23206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgCHKOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:14:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCHKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:14:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAsx5-0004nb-6z; Sun, 08 Mar 2020 11:14:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 16ECE1C2212;
        Sun,  8 Mar 2020 11:14:30 +0100 (CET)
Date:   Sun, 08 Mar 2020 10:14:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add return value to check_irq_resend()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306130623.775200917@linutronix.de>
References: <20200306130623.775200917@linutronix.de>
MIME-Version: 1.0
Message-ID: <158366246979.28353.6874083740904221262.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1f85b1f5e1f5541272abedc19ba7b6c5b564c228
Gitweb:        https://git.kernel.org/tip/1f85b1f5e1f5541272abedc19ba7b6c5b564c228
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 06 Mar 2020 14:03:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Mar 2020 11:06:41 +01:00

genirq: Add return value to check_irq_resend()

In preparation for an interrupt injection interface which can be used
safely by error injection mechanisms. e.g. PCI-E/ AER, add a return value
to check_irq_resend() so errors can be propagated to the caller.

Split out the software resend code so the ugly #ifdef in check_irq_resend()
goes away and the whole thing becomes readable.

Fix up the caller in debugfs. The caller in irq_startup() does not care
about the return value as this is unconditionally invoked for all
interrupts and the resend is best effort anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20200306130623.775200917@linutronix.de

---
 kernel/irq/debugfs.c   |  3 +-
 kernel/irq/internals.h |  2 +-
 kernel/irq/resend.c    | 83 ++++++++++++++++++++++++-----------------
 3 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index d44c8fd..0c60779 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -218,8 +218,7 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 			err = -EINVAL;
 		} else {
 			desc->istate |= IRQS_PENDING;
-			check_irq_resend(desc);
-			err = 0;
+			err = check_irq_resend(desc);
 		}
 
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5be382f..8980859 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -108,7 +108,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
-void check_irq_resend(struct irq_desc *desc);
+int check_irq_resend(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 5064b13..a21fc4e 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -47,6 +47,43 @@ static void resend_irqs(unsigned long arg)
 /* Tasklet to handle resend: */
 static DECLARE_TASKLET(resend_tasklet, resend_irqs, 0);
 
+static int irq_sw_resend(struct irq_desc *desc)
+{
+	unsigned int irq = irq_desc_get_irq(desc);
+
+	/*
+	 * Validate whether this interrupt can be safely injected from
+	 * non interrupt context
+	 */
+	if (handle_enforce_irqctx(&desc->irq_data))
+		return -EINVAL;
+
+	/*
+	 * If the interrupt is running in the thread context of the parent
+	 * irq we need to be careful, because we cannot trigger it
+	 * directly.
+	 */
+	if (irq_settings_is_nested_thread(desc)) {
+		/*
+		 * If the parent_irq is valid, we retrigger the parent,
+		 * otherwise we do nothing.
+		 */
+		if (!desc->parent_irq)
+			return -EINVAL;
+		irq = desc->parent_irq;
+	}
+
+	/* Set it pending and activate the softirq: */
+	set_bit(irq, irqs_resend);
+	tasklet_schedule(&resend_tasklet);
+	return 0;
+}
+
+#else
+static int irq_sw_resend(struct irq_desc *desc)
+{
+	return -EINVAL;
+}
 #endif
 
 /*
@@ -54,50 +91,28 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs, 0);
  *
  * Is called with interrupts disabled and desc->lock held.
  */
-void check_irq_resend(struct irq_desc *desc)
+int check_irq_resend(struct irq_desc *desc)
 {
 	/*
-	 * We do not resend level type interrupts. Level type
-	 * interrupts are resent by hardware when they are still
-	 * active. Clear the pending bit so suspend/resume does not
-	 * get confused.
+	 * We do not resend level type interrupts. Level type interrupts
+	 * are resent by hardware when they are still active. Clear the
+	 * pending bit so suspend/resume does not get confused.
 	 */
 	if (irq_settings_is_level(desc)) {
 		desc->istate &= ~IRQS_PENDING;
-		return;
+		return -EINVAL;
 	}
+
 	if (desc->istate & IRQS_REPLAY)
-		return;
+		return -EBUSY;
+
 	if (desc->istate & IRQS_PENDING) {
 		desc->istate &= ~IRQS_PENDING;
 		desc->istate |= IRQS_REPLAY;
 
-		if ((!desc->irq_data.chip->irq_retrigger ||
-		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data)) &&
-		    !handle_enforce_irqctx(&desc->irq_data)) {
-#ifdef CONFIG_HARDIRQS_SW_RESEND
-			unsigned int irq = irq_desc_get_irq(desc);
-
-			/*
-			 * If the interrupt is running in the thread
-			 * context of the parent irq we need to be
-			 * careful, because we cannot trigger it
-			 * directly.
-			 */
-			if (irq_settings_is_nested_thread(desc)) {
-				/*
-				 * If the parent_irq is valid, we
-				 * retrigger the parent, otherwise we
-				 * do nothing.
-				 */
-				if (!desc->parent_irq)
-					return;
-				irq = desc->parent_irq;
-			}
-			/* Set it pending and activate the softirq: */
-			set_bit(irq, irqs_resend);
-			tasklet_schedule(&resend_tasklet);
-#endif
-		}
+		if (!desc->irq_data.chip->irq_retrigger ||
+		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+		    return irq_sw_resend(desc);
 	}
+	return 0;
 }
