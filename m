Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D710C2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGJO5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:57:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgGJO5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:57:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49E111FB;
        Fri, 10 Jul 2020 07:57:22 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 496E93F8F8;
        Fri, 10 Jul 2020 07:57:21 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: [RFC PATCH] irqchip/gic: Implement irq_chip->irq_retrigger()
Date:   Fri, 10 Jul 2020 15:56:42 +0100
Message-Id: <20200710145642.28978-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While digging around IRQCHIP_EOI_IF_HANDLED and irq/resend.c, it has come
to my attention that the IRQ resend situation seems a bit precarious for
the GIC(s). Below is a (somewhat structured) dump of my notes/thoughts
about that.

IRQCHIP_EOI_IF_HANDLED
======================

If the irqchip doesn't have this flag set, we may issue an irq_eoi()
despite not having handled the IRQ in the following cases:

o !irq_may_run()
  - IRQ may be in progress (handle_irq_event() ongoing)
  - IRQ is an armed wakeup source (also sets it pending)

o !action or IRQ disabled; in this case it is set as pending.

irq_resend()
============

For the above cases where the IRQ is marked as pending, it means that when
we'll go through check_irq_resend() (e.g. when we re-enable the IRQ) we
will end up in resend_irqs() which goes through the flow handler again, IOW
will issue *another* EOI on the same IRQ.

Now, this is all done via a tasklet, so AFAICT cannot happen in irq
context (as defined by in_interrupt() - it can happen at the tail of
handling an IRQ if it wasn't nesting).

GIC woes
========

The TL;DR for IRQ handling on the GIC is that we have 3 steps:
o Acknowledgement (Ack)
o priority drop (PD)
o deactivation (D)

The GIC also has an "eoimode" knob that says whether PD and D are split, IOW:
o eoimode=0: irq_eoi() does PD + D
o eoimode=1: irq_eoi() does D

Regardless of the mode, it is paramount that any PD is
o issued on the same CPU that Ack'd the IRQ
o issued in reverse order of the Acks

IHI0069D, 4.1.1 Physical CPU interface, Priority drop
"""
A priority drop must be performed by the same PE that activated the
interrupt.

[...]

For each CPU interface, the GIC architecture requires the order of the
valid writes to ICC_EOIR0_EL1 and ICC_EOIR1_EL1 to be the exact reverse of
the order of the reads from ICC_IAR0_EL1 and ICC_IAR1_EL1
"""

IHI0069D, 8.2.9 ICC_EOIR0_EL1, Interrupt Controller End Of Interrupt Register 0
"""
A write to this register must correspond to the most recent valid read by
this PE from an Interrupt Acknowledge Register, and must correspond to the
INTID that was read from ICC_IAR0_EL1, otherwise the system behavior is
UNPREDICTABLE.
"""

For eoimode=1, the PD is hidden from genirq and is contained within the GIC
driver. This means that issuing another irq_eoi() will only be re-issuing a
D, which I think the GIC can live with (even if issued from a different CPU).

For eoimode=0, it is more troubling, as we break the aforementioned
restrictions. That said, IIUC this cannot cause e.g. a bogus running
priority reduction due to the tasklet context mentioned above (running
priority ought to be idle priority).

Linux hosts will almost always use eoimode=1, so that leaves us with
guests running with eoimode=0, and I don't know how common it is (if at all
possible) for those to use pm / wakeup IRQs. I suppose that is a reason
why this hasn't cropped up before, that or I miserably misunderstood the
whole thing.

In any case, the virtual interface follows the same restrictions wrt
PD ordering:

IHI0069D 8.3.7 ICV_EOIR0_EL1, Interrupt Controller Virtual End Of Interrupt Register 0
"""
A write to this register must correspond to the most recent valid read by
this vPE from a Virtual Interrupt Acknowledge Register, and must correspond
to the INTID that was read from ICV_IAR0_EL1, otherwise the system behavior
is UNPREDICTABLE.
"""

Change
======

One way to ensure we only get one PD per interrupt activation and maintain
the expected ordering is to add the IRQCHIP_EOI_IF_HANDLED flag to all
irq-gic chips, but that only really works for eoimode=1; for eoimode=0 that
would mean leaving the flow handler without having issued a PD at all.

At the same time, this whole IRQS_PENDING & resend thing feels like
something we can handle in hardware: we can leverage
irq_chip.irq_retrigger() and use this to mark the interrupt as pending in
the GIC itself, in which case we *don't* want to have
IRQCHIP_EOI_IF_HANDLED (as the retrigger will lead to another ack+eoi
pair).

Implement irq_chip.irq_retrigger() for both GICs.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 drivers/irqchip/irq-gic.c    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cc46bc2d634b..c025e8b51464 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1207,6 +1207,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #define gic_smp_init()		do { } while(0)
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
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
index 00de05abd3c3..33ce025868d0 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -355,6 +355,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
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

