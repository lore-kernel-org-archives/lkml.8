Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E2C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593028718;
	bh=XXi8edY9x3wr+Y2/yPhKhdQW4BKXddtnZDL77VlPayc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z7umf5oYKWCtqincxY9VyM9DimDbAUERmZF3oz7E83xE7m6LSgmvdXD52ISTon2wx
	 7iFRrZaRE3eVtsd13YDmYCrS515jIKAPmK2enXwya7fqihYJ+KACvG4aXmjiQQ65ZH
	 2H0bLyh3Rm4jmEK+xu8oGtTZbWtFfM4qhWAPGeEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406312AbgFXT6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406286AbgFXT6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:58:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F10920899;
        Wed, 24 Jun 2020 19:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593028704;
        bh=XXi8edY9x3wr+Y2/yPhKhdQW4BKXddtnZDL77VlPayc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGLSqnB3UEi7yjfnGJO2DWssKlt5IgSmleLUoc9c1Qc5mqQWOU37oZfvdmWjlCgJ4
         b0cdMIdn30C2gpoemXvXi4jS1z8cqs/RklOmtI7D/d3a85lsUPfKu/p4HuibRnqueo
         +a8EjYjL2OXY0iPDKmx0zxc0m50yO8UeW9VgzBR4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joBXK-006ABu-9s; Wed, 24 Jun 2020 20:58:22 +0100
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
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: [PATCH v2 09/17] irqchip/gic: Configure SGIs as standard interrupts
Date:   Wed, 24 Jun 2020 20:58:03 +0100
Message-Id: <20200624195811.435857-10-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624195811.435857-1-maz@kernel.org>
References: <20200624195811.435857-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the way we deal with GIC SGIs by turning them into proper
IRQs, and calling into the arch code to register the interrupt range
instead of a callback.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 101 +++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 801a5a5004d6..86699761e19f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -335,31 +335,22 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
-		if (likely(irqnr > 15 && irqnr < 1020)) {
-			if (static_branch_likely(&supports_deactivate_key))
-				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			isb();
-			handle_domain_irq(gic->domain, irqnr, regs);
-			continue;
-		}
-		if (irqnr < 16) {
+		if (unlikely(irqnr >= 1020))
+			break;
+
+		if (static_branch_likely(&supports_deactivate_key))
 			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			if (static_branch_likely(&supports_deactivate_key))
-				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
-#ifdef CONFIG_SMP
-			/*
-			 * Ensure any shared data written by the CPU sending
-			 * the IPI is read after we've read the ACK register
-			 * on the GIC.
-			 *
-			 * Pairs with the write barrier in gic_raise_softirq
-			 */
+		isb();
+
+		/*
+		 * Ensure any shared data written by the CPU sending the IPI
+		 * is read after we've read the ACK register on the GIC.
+		 *
+		 * Pairs with the write barrier in gic_ipi_send_mask
+		 */
+		if (irqnr <= 15)
 			smp_rmb();
-			handle_IPI(irqnr, regs);
-#endif
-			continue;
-		}
-		break;
+		handle_domain_irq(gic->domain, irqnr, regs);
 	} while (1);
 }
 
@@ -793,14 +784,14 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
 	unsigned long flags, map = 0;
 
 	if (unlikely(nr_cpu_ids == 1)) {
 		/* Only one CPU? let's do a self-IPI... */
-		writel_relaxed(2 << 24 | irq,
+		writel_relaxed(2 << 24 | d->hwirq,
 			       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 		return;
 	}
@@ -818,7 +809,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	dmb(ishst);
 
 	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel_relaxed(map << 16 | d->hwirq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
 	gic_unlock_irqrestore(flags);
 }
@@ -831,14 +822,28 @@ static int gic_starting_cpu(unsigned int cpu)
 
 static __init void gic_smp_init(void)
 {
-	set_smp_cross_call(gic_raise_softirq);
+	struct irq_fwspec sgi_fwspec = {
+		.fwnode		= gic_data[0].domain->fwnode,
+		.param_count	= 1,
+	};
+	int base_sgi;
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
 				  "irqchip/arm/gic:starting",
 				  gic_starting_cpu, NULL);
+
+	base_sgi = __irq_domain_alloc_irqs(gic_data[0].domain, -1, 8,
+					   NUMA_NO_NODE, &sgi_fwspec,
+					   false, NULL);
+	if (WARN_ON(base_sgi <= 0))
+		return;
+
+	set_smp_ipi_range(base_sgi, 8);
 }
 #else
 #define gic_smp_init()		do { } while(0)
 #define gic_set_affinity	NULL
+#define gic_ipi_send_mask	NULL
 #endif
 
 #ifdef CONFIG_BL_SWITCHER
@@ -985,15 +990,24 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct gic_chip_data *gic = d->host_data;
 
-	if (hw < 32) {
+	switch (hw) {
+	case 0 ... 15:
+		irq_set_percpu_devid(irq);
+		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+		break;
+	case 16 ... 31:
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-	} else {
+		break;
+	default:
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		break;
 	}
 	return 0;
 }
@@ -1007,19 +1021,26 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
+	if (fwspec->param_count == 1 && fwspec->param[0] < 16) {
+		*hwirq = fwspec->param[0];
+		*type = IRQ_TYPE_EDGE_RISING;
+		return 0;
+	}
+
 	if (is_of_node(fwspec->fwnode)) {
 		if (fwspec->param_count < 3)
 			return -EINVAL;
 
-		/* Get the interrupt number and add 16 to skip over SGIs */
-		*hwirq = fwspec->param[1] + 16;
-
-		/*
-		 * For SPIs, we need to add 16 more to get the GIC irq
-		 * ID number
-		 */
-		if (!fwspec->param[0])
-			*hwirq += 16;
+		switch (fwspec->param[0]) {
+		case 0:			/* SPI */
+			*hwirq = fwspec->param[1] + 32;
+			break;
+		case 1:			/* PPI */
+			*hwirq = fwspec->param[1] + 16;
+			break;
+		default:
+			return -EINVAL;
+		}
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 
@@ -1088,8 +1109,10 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
 	}
 
-	if (gic == &gic_data[0])
+	if (gic == &gic_data[0]) {
 		gic->chip.irq_set_affinity = gic_set_affinity;
+		gic->chip.ipi_send_mask = gic_ipi_send_mask;
+	}
 }
 
 static int gic_init_bases(struct gic_chip_data *gic,
-- 
2.27.0

