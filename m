Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E398C10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B5120838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCHKOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:14:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56470 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgCHKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:14:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAsx5-0004nt-PN; Sun, 08 Mar 2020 11:14:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E4D841C2214;
        Sun,  8 Mar 2020 11:14:30 +0100 (CET)
Date:   Sun, 08 Mar 2020 10:14:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add protection against unsafe usage of
 generic_handle_irq()
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306130623.590923677@linutronix.de>
References: <20200306130623.590923677@linutronix.de>
MIME-Version: 1.0
Message-ID: <158366247058.28353.956469590360925581.tip-bot2@tip-bot2>
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

Commit-ID:     c16816acd08697b02a53f56f8936497a9f6f6e7a
Gitweb:        https://git.kernel.org/tip/c16816acd08697b02a53f56f8936497a9f6f6e7a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 06 Mar 2020 14:03:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Mar 2020 11:06:40 +01:00

genirq: Add protection against unsafe usage of generic_handle_irq()

In general calling generic_handle_irq() with interrupts disabled from non
interrupt context is harmless. For some interrupt controllers like the x86
trainwrecks this is outright dangerous as it might corrupt state if an
interrupt affinity change is pending.

Add infrastructure which allows to mark interrupts as unsafe and catch such
usage in generic_handle_irq().

Reported-by: sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20200306130623.590923677@linutronix.de

---
 include/linux/irq.h    | 13 +++++++++++++
 kernel/irq/internals.h |  8 ++++++++
 kernel/irq/irqdesc.c   |  6 ++++++
 kernel/irq/resend.c    |  5 +++--
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3ed5a05..9315fbb 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -211,6 +211,8 @@ struct irq_data {
  * IRQD_CAN_RESERVE		- Can use reservation mode
  * IRQD_MSI_NOMASK_QUIRK	- Non-maskable MSI quirk for affinity change
  *				  required
+ * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only invoked
+ *				  from actual interrupt context.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -234,6 +236,7 @@ enum {
 	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 	IRQD_CAN_RESERVE		= (1 << 26),
 	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
+	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -303,6 +306,16 @@ static inline bool irqd_is_single_target(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_SINGLE_TARGET;
 }
 
+static inline void irqd_set_handle_enforce_irqctx(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_HANDLE_ENFORCE_IRQCTX;
+}
+
+static inline bool irqd_is_handle_enforce_irqctx(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_HANDLE_ENFORCE_IRQCTX;
+}
+
 static inline bool irqd_is_wakeup_set(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index c9d8eb7..5be382f 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -425,6 +425,10 @@ static inline struct cpumask *irq_desc_get_pending_mask(struct irq_desc *desc)
 {
 	return desc->pending_mask;
 }
+static inline bool handle_enforce_irqctx(struct irq_data *data)
+{
+	return irqd_is_handle_enforce_irqctx(data);
+}
 bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
 #else /* CONFIG_GENERIC_PENDING_IRQ */
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
@@ -451,6 +455,10 @@ static inline bool irq_fixup_move_pending(struct irq_desc *desc, bool fclear)
 {
 	return false;
 }
+static inline bool handle_enforce_irqctx(struct irq_data *data)
+{
+	return false;
+}
 #endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 98a5f10..1a77236 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -638,9 +638,15 @@ void irq_init_desc(unsigned int irq)
 int generic_handle_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_data *data;
 
 	if (!desc)
 		return -EINVAL;
+
+	data = irq_desc_get_irq_data(desc);
+	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
+		return -EPERM;
+
 	generic_handle_irq_desc(desc);
 	return 0;
 }
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 98c04ca..5064b13 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -72,8 +72,9 @@ void check_irq_resend(struct irq_desc *desc)
 		desc->istate &= ~IRQS_PENDING;
 		desc->istate |= IRQS_REPLAY;
 
-		if (!desc->irq_data.chip->irq_retrigger ||
-		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data)) {
+		if ((!desc->irq_data.chip->irq_retrigger ||
+		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data)) &&
+		    !handle_enforce_irqctx(&desc->irq_data)) {
 #ifdef CONFIG_HARDIRQS_SW_RESEND
 			unsigned int irq = irq_desc_get_irq(desc);
 
