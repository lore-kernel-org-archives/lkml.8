Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2971EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0B4206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971922;
	bh=pEbuGAOy8T4+ZTB6IMqS/f9G9nYR6hAUaaScf8PYFvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zbiS5wj1sBtPVhD5SnFK8iiV5tVFaS2EChl4jYuwXziW0LagdWCdAtpqwb3uc135A
	 zYliFzY89ra/Vj8Hr/isWzZvB4CDg5vQZoaLxcjKm3Ua4b3GzL+tdGvvMIBALbU9a3
	 HBZHYETkRATv2MLHNqzlmeWtIvcFly22v5i+L85o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgIAOv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgIAOvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:51:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0686D21527;
        Tue,  1 Sep 2020 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971860;
        bh=pEbuGAOy8T4+ZTB6IMqS/f9G9nYR6hAUaaScf8PYFvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dj0jMd+MuyeHEu3YLlw+3p5da3pYZNaO3I3ZeOlrWbyOomw5IDCTnyRQxhnrLajFa
         PbFg86KpyusxfqhCjwepozKadEBRZyiTmx7aC9bHT9A+v1TW8zzGTywLxeyMy+NaMN
         +zY6ayzmWLt9ggaqAlG2T30ymlwzn3HTMgo9BTZo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7Va-008IQP-Sz; Tue, 01 Sep 2020 15:43:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: [PATCH v3 11/16] irqchip/hip04: Configure IPIs as standard interrupts
Date:   Tue,  1 Sep 2020 15:43:19 +0100
Message-Id: <20200901144324.1071694-12-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
References: <20200901144324.1071694-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to switch the hip04 driver to provide standard interrupts
for IPIs, rework the way interrupts are allocated, making sure
the irqdomain covers the SGIs as well as the rest of the interrupt
range.

The driver is otherwise so old-school that it creates all interrupts
upfront (duh!), so there is hardly anything else to change, apart
from communicating the IPIs to the arch code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-hip04.c | 89 +++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 130caa1c9d93..9b73dcfaf48d 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -171,6 +171,29 @@ static int hip04_irq_set_affinity(struct irq_data *d,
 
 	return IRQ_SET_MASK_OK;
 }
+
+static void hip04_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	int cpu;
+	unsigned long flags, map = 0;
+
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= hip04_cpu_map[cpu];
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before they observe us issuing the IPI.
+	 */
+	dmb(ishst);
+
+	/* this always happens on GIC0 */
+	writel_relaxed(map << 8 | d->hwirq, hip04_data.dist_base + GIC_DIST_SOFTINT);
+
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+}
 #endif
 
 static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
@@ -182,19 +205,9 @@ static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
-		if (likely(irqnr > 15 && irqnr <= HIP04_MAX_IRQS)) {
+		if (irqnr <= HIP04_MAX_IRQS)
 			handle_domain_irq(hip04_data.domain, irqnr, regs);
-			continue;
-		}
-		if (irqnr < 16) {
-			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-#ifdef CONFIG_SMP
-			handle_IPI(irqnr, regs);
-#endif
-			continue;
-		}
-		break;
-	} while (1);
+	} while (irqnr > HIP04_MAX_IRQS);
 }
 
 static struct irq_chip hip04_irq_chip = {
@@ -205,6 +218,7 @@ static struct irq_chip hip04_irq_chip = {
 	.irq_set_type		= hip04_irq_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= hip04_irq_set_affinity,
+	.ipi_send_mask		= hip04_ipi_send_mask,
 #endif
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
@@ -279,39 +293,17 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 	writel_relaxed(1, base + GIC_CPU_CTRL);
 }
 
-#ifdef CONFIG_SMP
-static void hip04_raise_softirq(const struct cpumask *mask, unsigned int irq)
-{
-	int cpu;
-	unsigned long flags, map = 0;
-
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= hip04_cpu_map[cpu];
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before they observe us issuing the IPI.
-	 */
-	dmb(ishst);
-
-	/* this always happens on GIC0 */
-	writel_relaxed(map << 8 | irq, hip04_data.dist_base + GIC_DIST_SOFTINT);
-
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-#endif
-
 static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
-	if (hw < 32) {
+	if (hw < 16) {
+		irq_set_percpu_devid(irq);
+		irq_set_chip_and_handler(irq, &hip04_irq_chip,
+					 handle_percpu_devid_fasteoi_ipi);
+	} else if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_percpu_devid_irq);
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	} else {
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_fasteoi_irq);
@@ -328,10 +320,13 @@ static int hip04_irq_domain_xlate(struct irq_domain *d,
 				  unsigned long *out_hwirq,
 				  unsigned int *out_type)
 {
-	unsigned long ret = 0;
-
 	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
+	if (intsize == 1 && intspec[0] < 16) {
+		*out_hwirq = intspec[0];
+		*out_type = IRQ_TYPE_EDGE_RISING;
+		return 0;
+	}
 	if (intsize < 3)
 		return -EINVAL;
 
@@ -344,7 +339,7 @@ static int hip04_irq_domain_xlate(struct irq_domain *d,
 
 	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
 
-	return ret;
+	return 0;
 }
 
 static int hip04_irq_starting_cpu(unsigned int cpu)
@@ -361,7 +356,6 @@ static const struct irq_domain_ops hip04_irq_domain_ops = {
 static int __init
 hip04_of_init(struct device_node *node, struct device_node *parent)
 {
-	irq_hw_number_t hwirq_base = 16;
 	int nr_irqs, irq_base, i;
 
 	if (WARN_ON(!node))
@@ -390,24 +384,21 @@ hip04_of_init(struct device_node *node, struct device_node *parent)
 		nr_irqs = HIP04_MAX_IRQS;
 	hip04_data.nr_irqs = nr_irqs;
 
-	nr_irqs -= hwirq_base; /* calculate # of irqs to allocate */
-
-	irq_base = irq_alloc_descs(-1, hwirq_base, nr_irqs, numa_node_id());
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, numa_node_id());
 	if (irq_base < 0) {
 		pr_err("failed to allocate IRQ numbers\n");
 		return -EINVAL;
 	}
 
 	hip04_data.domain = irq_domain_add_legacy(node, nr_irqs, irq_base,
-						  hwirq_base,
+						  0,
 						  &hip04_irq_domain_ops,
 						  &hip04_data);
-
 	if (WARN_ON(!hip04_data.domain))
 		return -EINVAL;
 
 #ifdef CONFIG_SMP
-	set_smp_cross_call(hip04_raise_softirq);
+	set_smp_ipi_range(irq_base, 16);
 #endif
 	set_handle_irq(hip04_handle_irq);
 
-- 
2.27.0

