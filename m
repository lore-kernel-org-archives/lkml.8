Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAEFC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B87C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971979;
	bh=9yLINjPSos82hFGzf/cR8Ml9M2B8nrGP/wY7LDOCtxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S97g8TpTN7MFv/zAn5bsl5mTHyXbXcBBReBbq1aJWg+ZQLKEaJktV8Vk5rb7yd3gh
	 F9+38UhQZ01JFIehqUrVCCrPC3Sv1v1gQlszqwfDMeGptpXDu4ZF80+UDJRzR6P5+J
	 JEav6YAlQ30488Ph/4kE0hd9tS4rKFCJfOmnvlF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgIAOw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgIAOuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46ADE208CA;
        Tue,  1 Sep 2020 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971854;
        bh=9yLINjPSos82hFGzf/cR8Ml9M2B8nrGP/wY7LDOCtxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLtw61eU4UbQ9YrG3a6k6KHIJW/Ccwh4ci8VhZlpiLsXS28X7QiRoyHIv1+DY2ySG
         8AYdqfUghadI7GJX6YGHHhe9TBoA8/jjilDWnriFFLDKFCsoxWfn6J5/85dYpkMUnM
         r8rfWRwpwinwRRIN6diz1h5UPT/N/dBvXvSzxj2g=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7Vb-008IQP-ND; Tue, 01 Sep 2020 15:43:39 +0100
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
Subject: [PATCH v3 12/16] irqchip/armada-370-xp: Configure IPIs as standard interrupts
Date:   Tue,  1 Sep 2020 15:43:20 +0100
Message-Id: <20200901144324.1071694-13-maz@kernel.org>
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

To introduce IPIs as standard interrupts to the Armada 370-XP
driver, let's allocate a completely separate irqdomain and
irqchip combo that lives parallel to the "standard" one.

This effectively should be modelled as a chained interrupt
controller, but the code is in such a state that it is
pretty hard to shoehorn, as it would require the rewrite
of the MSI layer as well.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-armada-370-xp.c | 262 +++++++++++++++++++---------
 1 file changed, 178 insertions(+), 84 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index c9bdc5221b82..d7eb2e93db8f 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -310,7 +310,134 @@ static inline int armada_370_xp_msi_init(struct device_node *node,
 }
 #endif
 
+static void armada_xp_mpic_perf_init(void)
+{
+	unsigned long cpuid = cpu_logical_map(smp_processor_id());
+
+	/* Enable Performance Counter Overflow interrupts */
+	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
+	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
+}
+
 #ifdef CONFIG_SMP
+static struct irq_domain *ipi_domain;
+
+static void armada_370_xp_ipi_mask(struct irq_data *d)
+{
+	u32 reg;
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg &= ~BIT(d->hwirq);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+}
+
+static void armada_370_xp_ipi_unmask(struct irq_data *d)
+{
+	u32 reg;
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg |= BIT(d->hwirq);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+}
+
+static void armada_370_xp_ipi_send_mask(struct irq_data *d,
+					const struct cpumask *mask)
+{
+	unsigned long map = 0;
+	int cpu;
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= 1 << cpu_logical_map(cpu);
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
+	/* submit softirq */
+	writel((map << 8) | d->hwirq, main_int_base +
+		ARMADA_370_XP_SW_TRIG_INT_OFFS);
+}
+
+static void armada_370_xp_ipi_eoi(struct irq_data *d)
+{
+	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+}
+
+static struct irq_chip ipi_irqchip = {
+	.name		= "IPI",
+	.irq_mask	= armada_370_xp_ipi_mask,
+	.irq_unmask	= armada_370_xp_ipi_unmask,
+	.irq_eoi	= armada_370_xp_ipi_eoi,
+	.ipi_send_mask	= armada_370_xp_ipi_send_mask,
+};
+
+static int armada_370_xp_ipi_alloc(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
+				    d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void armada_370_xp_ipi_free(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops ipi_domain_ops = {
+	.alloc	= armada_370_xp_ipi_alloc,
+	.free	= armada_370_xp_ipi_free,
+};
+
+static void ipi_resume(void)
+{
+	int i;
+
+	for (i = 0; i < IPI_DOORBELL_END; i++) {
+		int irq;
+
+		irq = irq_find_mapping(ipi_domain, i);
+		if (irq <= 0)
+			continue;
+		if (irq_percpu_is_enabled(irq)) {
+			struct irq_data *d;
+			d = irq_domain_get_irq_data(ipi_domain, irq);
+			armada_370_xp_ipi_unmask(d);
+		}
+	}
+}
+
+static __init void armada_xp_ipi_init(struct device_node *node)
+{
+	int base_ipi;
+
+	ipi_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+					      IPI_DOORBELL_END,
+					      &ipi_domain_ops, NULL);
+	if (WARN_ON(!ipi_domain))
+		return;
+
+	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
+	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, IPI_DOORBELL_END,
+					   NUMA_NO_NODE, NULL, false, NULL);
+	if (WARN_ON(!base_ipi))
+		return;
+
+	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
+}
+
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 static int armada_xp_set_affinity(struct irq_data *d,
@@ -334,43 +461,6 @@ static int armada_xp_set_affinity(struct irq_data *d,
 
 	return IRQ_SET_MASK_OK;
 }
-#endif
-
-static struct irq_chip armada_370_xp_irq_chip = {
-	.name		= "MPIC",
-	.irq_mask       = armada_370_xp_irq_mask,
-	.irq_mask_ack   = armada_370_xp_irq_mask,
-	.irq_unmask     = armada_370_xp_irq_unmask,
-#ifdef CONFIG_SMP
-	.irq_set_affinity = armada_xp_set_affinity,
-#endif
-	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
-};
-
-static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
-				      unsigned int virq, irq_hw_number_t hw)
-{
-	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	if (!is_percpu_irq(hw))
-		writel(hw, per_cpu_int_base +
-			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-	else
-		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
-	irq_set_status_flags(virq, IRQ_LEVEL);
-
-	if (is_percpu_irq(hw)) {
-		irq_set_percpu_devid(virq);
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_percpu_devid_irq);
-	} else {
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_level_irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
-	}
-	irq_set_probe(virq);
-
-	return 0;
-}
 
 static void armada_xp_mpic_smp_cpu_init(void)
 {
@@ -383,48 +473,16 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	for (i = 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
 
+	/* Disable all IPIs */
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
 	/* Clear pending IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
-	/* Enable first 8 IPIs */
-	writel(IPI_DOORBELL_MASK, per_cpu_int_base +
-		ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-
 	/* Unmask IPI interrupt */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
-static void armada_xp_mpic_perf_init(void)
-{
-	unsigned long cpuid = cpu_logical_map(smp_processor_id());
-
-	/* Enable Performance Counter Overflow interrupts */
-	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
-	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
-}
-
-#ifdef CONFIG_SMP
-static void armada_mpic_send_doorbell(const struct cpumask *mask,
-				      unsigned int irq)
-{
-	int cpu;
-	unsigned long map = 0;
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= 1 << cpu_logical_map(cpu);
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before issuing the IPI.
-	 */
-	dsb();
-
-	/* submit softirq */
-	writel((map << 8) | irq, main_int_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS);
-}
-
 static void armada_xp_mpic_reenable_percpu(void)
 {
 	unsigned int irq;
@@ -445,6 +503,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 
 		armada_370_xp_irq_unmask(data);
 	}
+
+	ipi_resume();
 }
 
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
@@ -462,7 +522,46 @@ static int mpic_cascaded_starting_cpu(unsigned int cpu)
 	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
 	return 0;
 }
+#else
+static void armada_xp_mpic_smp_cpu_init(void) {}
+static void ipi_resume(void) {}
+#endif
+
+static struct irq_chip armada_370_xp_irq_chip = {
+	.name		= "MPIC",
+	.irq_mask       = armada_370_xp_irq_mask,
+	.irq_mask_ack   = armada_370_xp_irq_mask,
+	.irq_unmask     = armada_370_xp_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = armada_xp_set_affinity,
 #endif
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
+				      unsigned int virq, irq_hw_number_t hw)
+{
+	armada_370_xp_irq_mask(irq_get_irq_data(virq));
+	if (!is_percpu_irq(hw))
+		writel(hw, per_cpu_int_base +
+			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	else
+		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+	irq_set_status_flags(virq, IRQ_LEVEL);
+
+	if (is_percpu_irq(hw)) {
+		irq_set_percpu_devid(virq);
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_percpu_devid_irq);
+	} else {
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_level_irq);
+		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
+	}
+	irq_set_probe(virq);
+
+	return 0;
+}
 
 static const struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.map = armada_370_xp_mpic_irq_map,
@@ -562,22 +661,15 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 		/* IPI Handling */
 		if (irqnr == 0) {
-			u32 ipimask, ipinr;
+			unsigned long ipimask;
+			int ipi;
 
 			ipimask = readl_relaxed(per_cpu_int_base +
 						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
 				& IPI_DOORBELL_MASK;
 
-			writel(~ipimask, per_cpu_int_base +
-				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
-
-			/* Handle all pending doorbells */
-			for (ipinr = IPI_DOORBELL_START;
-			     ipinr < IPI_DOORBELL_END; ipinr++) {
-				if (ipimask & (0x1 << ipinr))
-					handle_IPI(ipinr, regs);
-			}
-			continue;
+			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
+				handle_domain_irq(ipi_domain, ipi, regs);
 		}
 #endif
 
@@ -636,6 +728,8 @@ static void armada_370_xp_mpic_resume(void)
 		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
+	ipi_resume();
 }
 
 static struct syscore_ops armada_370_xp_mpic_syscore_ops = {
@@ -691,7 +785,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		irq_set_default_host(armada_370_xp_mpic_domain);
 		set_handle_irq(armada_370_xp_handle_irq);
 #ifdef CONFIG_SMP
-		set_smp_cross_call(armada_mpic_send_doorbell);
+		armada_xp_ipi_init(node);
 		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 					  "irqchip/armada/ipi:starting",
 					  armada_xp_mpic_starting_cpu, NULL);
-- 
2.27.0

