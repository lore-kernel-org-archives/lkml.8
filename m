Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D3CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45A9207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905117;
	bh=IPC/7tQVD57PFeb8X6j+jJhzgj26niEWfPYqC+ar0N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DQknGSYf/s2cgsxTNIDb7cF9CNa0+eA5IR3DzW/An1nG/SwAFRxwj4Jw4k+7lfidz
	 ngRbSy6SuhdQKw5l/AD8cQ+1y3A3DZ2NGpju8mh0UXZCiQ/dZVxfTXvaTdOA12KzNe
	 WU+YH5qF+Z0DJ2oSF/Oibrh9JOcd2ceCpo5NMMBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgESQSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbgESQS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:18:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C256A20829;
        Tue, 19 May 2020 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905105;
        bh=IPC/7tQVD57PFeb8X6j+jJhzgj26niEWfPYqC+ar0N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrFQyvBPy/yZdxoLQdZzqSE3+ajeHkRdXPE4BJ2AS55XXXVpMowurXEkz7FixSaRp
         TXwyXxxCNU8ysISDQrH9Xwl4sVCgzArPH8SiotJRwOcd7ccxWU0KjWr+GlZoLxRWE4
         T7Kq8gkVDon3H8aGb+Oy+f8JfCDDKm+K86qaeyWQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb4wi-00Decy-6h; Tue, 19 May 2020 17:18:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: [PATCH 07/11] irqchip/gic: Refactor SMP configuration
Date:   Tue, 19 May 2020 17:17:51 +0100
Message-Id: <20200519161755.209565-8-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519161755.209565-1-maz@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to change quite a lot of the SMP support code,
let's start by moving it around so that it minimizes the amount
of #ifdefery.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 92 ++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30ab623343d3..e289810e794c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -325,36 +325,6 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
-			    bool force)
-{
-	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
-	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
-	u32 val, mask, bit;
-	unsigned long flags;
-
-	if (!force)
-		cpu = cpumask_any_and(mask_val, cpu_online_mask);
-	else
-		cpu = cpumask_first(mask_val);
-
-	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
-		return -EINVAL;
-
-	gic_lock_irqsave(flags);
-	mask = 0xff << shift;
-	bit = gic_cpu_map[cpu] << shift;
-	val = readl_relaxed(reg) & ~mask;
-	writel_relaxed(val | bit, reg);
-	gic_unlock_irqrestore(flags);
-
-	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-
-	return IRQ_SET_MASK_OK_DONE;
-}
-#endif
-
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -803,6 +773,34 @@ static int gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
+static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+			    bool force)
+{
+	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
+	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
+	u32 val, mask, bit;
+	unsigned long flags;
+
+	if (!force)
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	gic_lock_irqsave(flags);
+	mask = 0xff << shift;
+	bit = gic_cpu_map[cpu] << shift;
+	val = readl_relaxed(reg) & ~mask;
+	writel_relaxed(val | bit, reg);
+	gic_unlock_irqrestore(flags);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
 static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
@@ -832,6 +830,23 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 	gic_unlock_irqrestore(flags);
 }
+
+static int gic_starting_cpu(unsigned int cpu)
+{
+	gic_cpu_init(&gic_data[0]);
+	return 0;
+}
+
+static __init void gic_smp_init(void)
+{
+	set_smp_cross_call(gic_raise_softirq);
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
+				  "irqchip/arm/gic:starting",
+				  gic_starting_cpu, NULL);
+}
+#else
+#define gic_smp_init()		do { } while(0)
+#define gic_set_affinity	NULL
 #endif
 
 #ifdef CONFIG_BL_SWITCHER
@@ -1036,12 +1051,6 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 	return -EINVAL;
 }
 
-static int gic_starting_cpu(unsigned int cpu)
-{
-	gic_cpu_init(&gic_data[0]);
-	return 0;
-}
-
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
@@ -1088,10 +1097,8 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
 	}
 
-#ifdef CONFIG_SMP
 	if (gic == &gic_data[0])
 		gic->chip.irq_set_affinity = gic_set_affinity;
-#endif
 }
 
 static int gic_init_bases(struct gic_chip_data *gic,
@@ -1208,12 +1215,7 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 		 */
 		for (i = 0; i < NR_GIC_CPU_IF; i++)
 			gic_cpu_map[i] = 0xff;
-#ifdef CONFIG_SMP
-		set_smp_cross_call(gic_raise_softirq);
-#endif
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
-					  "irqchip/arm/gic:starting",
-					  gic_starting_cpu, NULL);
+
 		set_handle_irq(gic_handle_irq);
 		if (static_branch_likely(&supports_deactivate_key))
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
@@ -1230,6 +1232,8 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 	ret = gic_init_bases(gic, handle);
 	if (ret)
 		kfree(name);
+	else if (gic == &gic_data[0])
+		gic_smp_init();
 
 	return ret;
 }
-- 
2.26.2

