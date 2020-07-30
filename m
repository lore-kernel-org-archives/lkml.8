Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6CC22CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgG3RFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:05:23 -0400
Received: from foss.arm.com ([217.140.110.172]:42694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3RFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:05:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6DF30E;
        Thu, 30 Jul 2020 10:05:20 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AE253F66E;
        Thu, 30 Jul 2020 10:05:19 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: [PATCH v2 1/2] irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
Date:   Thu, 30 Jul 2020 18:03:20 +0100
Message-Id: <20200730170321.31228-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730170321.31228-1-valentin.schneider@arm.com>
References: <20200730170321.31228-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While digging around IRQCHIP_EOI_IF_HANDLED and irq/resend.c, it has come
to my attention that the IRQ resend situation seems a bit precarious for
the GIC(s).

When marking an IRQ with IRQS_PENDING, handle_fasteoi_irq() will bail out
and issue an irq_eoi(). Should the IRQ in question be re-enabled,
check_irq_resend() will trigger a SW resend, which will go through the flow
handler again and issue *another* irq_eoi() on the *same* IRQ
activation. This is something the GIC spec clearly describes as a bad idea:
any EOI must match a previous ACK.

Implement irq_chip.irq_retrigger() for the GIC chips by setting the GIC
pending bit of the relevant IRQ. After being called by check_irq_resend(),
this will eventually trigger a *new* interrupt which we will handle as usual.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 drivers/irqchip/irq-gic.c    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cc46bc2d634b..0fbcbf55ec48 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1207,6 +1207,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #define gic_smp_init()		do { } while(0)
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 #ifdef CONFIG_CPU_PM
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
@@ -1242,6 +1247,7 @@ static struct irq_chip gic_chip = {
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
@@ -1258,6 +1264,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 00de05abd3c3..e2b4cae88bce 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -355,6 +355,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -425,6 +430,7 @@ static const struct irq_chip gic_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
-- 
2.27.0

