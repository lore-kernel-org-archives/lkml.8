Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EACC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B14021D7E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971480;
	bh=kaG7HV+v6Jnj36rrvZ1NTf3ijrYzyJj4T+3p2tJeCcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UAkt7ChgiXpNm2rOe3qOUL2W5fkbsTtPIK2Y7YVnJ+Gx0o3NWwqU5Q+15WXyFJZsV
	 1plbnCBqKUfS11s6OOzZYQSQJ36fCKiPge9+XbjlhXmOoykC1Tomo3oclPQp5ABAl0
	 Ixc0Wkvg2QxBgfgCwvehKgGCaK5EW2gcGmpIDVEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgIAOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgIAOnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:37 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E636206EB;
        Tue,  1 Sep 2020 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971416;
        bh=kaG7HV+v6Jnj36rrvZ1NTf3ijrYzyJj4T+3p2tJeCcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvP227x3M7Uj6arESPQIvGmx6/yhHetTOyqupG0TBpVTahI7ALTTg1yOY0hPwDZL8
         LINb5mauaj6AN1we5YI1N2YfJF0isDgKf9GLNEVeqXhYVyrhpNwQJ8t8OnBFJvziUv
         Ta1EmNp16Ic4VlA5h00xIib8gw8bA8N46s7n1+Z8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7VW-008IQP-Ju; Tue, 01 Sep 2020 15:43:34 +0100
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
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3 06/16] irqchip/gic-v3: Configure SGIs as standard interrupts
Date:   Tue,  1 Sep 2020 15:43:14 +0100
Message-Id: <20200901144324.1071694-7-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
References: <20200901144324.1071694-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the way we deal with GICv3 SGIs by turning them into proper
IRQs, and calling into the arch code to register the interrupt range
instead of a callback.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 86 ++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f7c99a302d01..717064588299 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -36,6 +36,8 @@
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 
+#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -383,7 +385,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 {
 	u32 reg;
 
-	if (d->hwirq >= 8192) /* PPI/SPI only */
+	if (d->hwirq >= 8192) /* SGI/PPI/SPI only */
 		return -EINVAL;
 
 	switch (which) {
@@ -583,6 +585,9 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
+	if (get_intid_range(d) == SGI_RANGE)
+		return -EINVAL;
+
 	if (vcpu)
 		irqd_set_forwarded_to_vcpu(d);
 	else
@@ -657,38 +662,14 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if ((irqnr >= 1020 && irqnr <= 1023))
 		return;
 
-	/* Treat anything but SGIs in a uniform way */
-	if (likely(irqnr > 15)) {
-		int err;
-
-		if (static_branch_likely(&supports_deactivate_key))
-			gic_write_eoir(irqnr);
-		else
-			isb();
-
-		err = handle_domain_irq(gic_data.domain, irqnr, regs);
-		if (err) {
-			WARN_ONCE(true, "Unexpected interrupt received!\n");
-			gic_deactivate_unhandled(irqnr);
-		}
-		return;
-	}
-	if (irqnr < 16) {
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_write_eoir(irqnr);
-		if (static_branch_likely(&supports_deactivate_key))
-			gic_write_dir(irqnr);
-#ifdef CONFIG_SMP
-		/*
-		 * Unlike GICv2, we don't need an smp_rmb() here.
-		 * The control dependency from gic_read_iar to
-		 * the ISB in gic_write_eoir is enough to ensure
-		 * that any shared data read by handle_IPI will
-		 * be read after the ACK.
-		 */
-		handle_IPI(irqnr, regs);
-#else
-		WARN_ONCE(true, "Unexpected SGI received!\n");
-#endif
+	else
+		isb();
+
+	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
+		WARN_ONCE(true, "Unexpected interrupt received!\n");
+		gic_deactivate_unhandled(irqnr);
 	}
 }
 
@@ -1136,11 +1117,11 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	gic_write_sgi1r(val);
 }
 
-static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
 
-	if (WARN_ON(irq >= 16))
+	if (WARN_ON(d->hwirq >= 16))
 		return;
 
 	/*
@@ -1154,7 +1135,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
-		gic_send_sgi(cluster_id, tlist, irq);
+		gic_send_sgi(cluster_id, tlist, d->hwirq);
 	}
 
 	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
@@ -1163,10 +1144,24 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 static void __init gic_smp_init(void)
 {
-	set_smp_cross_call(gic_raise_softirq);
+	struct irq_fwspec sgi_fwspec = {
+		.fwnode		= gic_data.fwnode,
+		.param_count	= 1,
+	};
+	int base_sgi;
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
 				  "irqchip/arm/gicv3:starting",
 				  gic_starting_cpu, NULL);
+
+	/* Register all 8 non-secure SGIs */
+	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
+					   NUMA_NO_NODE, &sgi_fwspec,
+					   false, NULL);
+	if (WARN_ON(base_sgi <= 0))
+		return;
+
+	set_smp_ipi_range(base_sgi, 8);
 }
 
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
@@ -1215,6 +1210,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #else
 #define gic_set_affinity	NULL
+#define gic_ipi_send_mask	NULL
 #define gic_smp_init()		do { } while(0)
 #endif
 
@@ -1257,6 +1253,7 @@ static struct irq_chip gic_chip = {
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
+	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1274,6 +1271,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
+	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1289,6 +1287,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 
 	switch (__get_intid_range(hw)) {
 	case SGI_RANGE:
+		irq_set_percpu_devid(irq);
+		irq_domain_set_info(d, irq, hw, chip, d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+		break;
+
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
@@ -1318,13 +1322,17 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
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
@@ -1656,9 +1664,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_rdist_properties();
 
-	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
+	gic_smp_init();
 	gic_cpu_pm_init();
 
 	if (gic_dist_supports_lpis()) {
-- 
2.27.0

