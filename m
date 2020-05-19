Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A95FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A0D2081A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589906010;
	bh=/FqRthJBIes2psHuDe3nUlSS/Kp1i2t1BfVeTp/GH7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZ8VVPRjx9OaoVr5nMhMiNSyxa3OagO5Mqj/VgLyOZKqaUv6E2J1IClEPkuW7Mtv7
	 rjMJEMCWgYAKatzEXSmt4oezu8eJBmSCUlHrtxKf4o4+H3qGkxoXhTZ3L/jdB5uAq9
	 LaBBbR6wpNaaJi6yJ0gG4RQZMaR9YRCRfjQSReWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgESQd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbgESQdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:33:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F54020709;
        Tue, 19 May 2020 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589906000;
        bh=/FqRthJBIes2psHuDe3nUlSS/Kp1i2t1BfVeTp/GH7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Uwquxo25efjMmJU3Z0QRaCaZLPCXTnsqwx55uZ+m6BpFQT2Z7gXwqsf1IiP6sGq4
         bBqRVOOOQ6avs/NlXDRR9l5hYZYyoRX+6atBA9icjj2DQc+5RAZ2uVBOXI9a8OC0fd
         9v7hXy9Na4vK/Nllfzp2r0PuGbhEqrcqNMQG/lXw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb4wj-00Decy-RA; Tue, 19 May 2020 17:18:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: [PATCH 10/11] irqchip/bcm2836: Configure mailbox interrupts as standard interrupts
Date:   Tue, 19 May 2020 17:17:54 +0100
Message-Id: <20200519161755.209565-11-maz@kernel.org>
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

In order to switch the bcm2836 driver to privide standard interrupts
for IPIs, it first needs to stop lying about the way things work.

The mailbox interrupt is actually a multiplexer, with enough
bits to store 32 pending interrupts per CPU. So let's turn it
into a chained irqchip.

Once this is done, we can instanciate the corresponding IPIs,
and pass them to the architecture code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-bcm2836.c | 151 ++++++++++++++++++++++++++++------
 1 file changed, 125 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 2038693f074c..85df6ddad9be 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -10,6 +10,7 @@
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-bcm2836.h>
 
 #include <asm/exception.h>
@@ -89,12 +90,24 @@ static struct irq_chip bcm2836_arm_irqchip_gpu = {
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_gpu_irq,
 };
 
+static void bcm2836_arm_irqchip_dummy_op(struct irq_data *d)
+{
+}
+
+static struct irq_chip bcm2836_arm_irqchip_dummy = {
+	.name		= "bcm2836-dummy",
+	.irq_eoi	= bcm2836_arm_irqchip_dummy_op,
+};
+
 static int bcm2836_map(struct irq_domain *d, unsigned int irq,
 		       irq_hw_number_t hw)
 {
 	struct irq_chip *chip;
 
 	switch (hw) {
+	case LOCAL_IRQ_MAILBOX0:
+		chip = &bcm2836_arm_irqchip_dummy;
+		break;
 	case LOCAL_IRQ_CNTPSIRQ:
 	case LOCAL_IRQ_CNTPNSIRQ:
 	case LOCAL_IRQ_CNTHPIRQ:
@@ -127,17 +140,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 	u32 stat;
 
 	stat = readl_relaxed(intc.base + LOCAL_IRQ_PENDING0 + 4 * cpu);
-	if (stat & BIT(LOCAL_IRQ_MAILBOX0)) {
-#ifdef CONFIG_SMP
-		void __iomem *mailbox0 = (intc.base +
-					  LOCAL_MAILBOX0_CLR0 + 16 * cpu);
-		u32 mbox_val = readl(mailbox0);
-		u32 ipi = ffs(mbox_val) - 1;
-
-		writel(1 << ipi, mailbox0);
-		handle_IPI(ipi, regs);
-#endif
-	} else if (stat) {
+	if (stat) {
 		u32 hwirq = ffs(stat) - 1;
 
 		handle_domain_irq(intc.domain, hwirq, regs);
@@ -145,8 +148,35 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
-					 unsigned int ipi)
+static struct irq_domain *ipi_domain;
+
+static void bcm2836_arm_irqchip_handle_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int cpu = smp_processor_id();
+	u32 mbox_val;
+
+	chained_irq_enter(chip, desc);
+
+	mbox_val = readl_relaxed(intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
+	if (mbox_val) {
+		int hwirq = ffs(mbox_val) - 1;
+		generic_handle_irq(irq_find_mapping(ipi_domain, hwirq));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void bcm2836_arm_irqchip_ipi_eoi(struct irq_data *d)
+{
+	int cpu = smp_processor_id();
+
+	writel_relaxed(BIT(d->hwirq),
+		       intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
+}
+
+static void bcm2836_arm_irqchip_ipi_send_mask(struct irq_data *d,
+					      const struct cpumask *mask)
 {
 	int cpu;
 	void __iomem *mailbox0_base = intc.base + LOCAL_MAILBOX0_SET0;
@@ -157,11 +187,45 @@ static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
 	 */
 	smp_wmb();
 
-	for_each_cpu(cpu, mask)	{
-		writel(1 << ipi, mailbox0_base + 16 * cpu);
+	for_each_cpu(cpu, mask)
+		writel_relaxed(BIT(d->hwirq), mailbox0_base + 16 * cpu);
+}
+
+static struct irq_chip bcm2836_arm_irqchip_ipi = {
+	.name		= "IPI",
+	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
+	.ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
+};
+
+static int bcm2836_arm_irqchip_ipi_alloc(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &bcm2836_arm_irqchip_ipi,
+				    d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
 	}
+
+	return 0;
 }
 
+static void bcm2836_arm_irqchip_ipi_free(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops ipi_domain_ops = {
+	.alloc	= bcm2836_arm_irqchip_ipi_alloc,
+	.free	= bcm2836_arm_irqchip_ipi_free,
+};
+
 static int bcm2836_cpu_starting(unsigned int cpu)
 {
 	bcm2836_arm_irqchip_unmask_per_cpu_irq(LOCAL_MAILBOX_INT_CONTROL0, 0,
@@ -175,25 +239,58 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 					     cpu);
 	return 0;
 }
-#endif
 
-static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
-	.xlate = irq_domain_xlate_onetwocell,
-	.map = bcm2836_map,
-};
+#define BITS_PER_MBOX	32
 
-static void
-bcm2836_arm_irqchip_smp_init(void)
+static void bcm2836_arm_irqchip_smp_init(void)
 {
-#ifdef CONFIG_SMP
+	struct irq_fwspec ipi_fwspec = {
+		.fwnode		= intc.domain->fwnode,
+		.param_count	= 1,
+		.param		= {
+			[0]	= LOCAL_IRQ_MAILBOX0,
+		},
+	};
+	int base_ipi, mux_irq;
+
+	mux_irq = irq_create_fwspec_mapping(&ipi_fwspec);
+	if (WARN_ON(mux_irq <= 0))
+		return;
+
+	ipi_domain = irq_domain_create_linear(intc.domain->fwnode,
+					      BITS_PER_MBOX, &ipi_domain_ops,
+					      NULL);
+	if (WARN_ON(!ipi_domain))
+		return;
+
+	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
+	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
+
+	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, BITS_PER_MBOX,
+					   NUMA_NO_NODE, NULL,
+					   false, NULL);
+
+	if (WARN_ON(!base_ipi))
+		return;
+
+	set_smp_ipi_range(base_ipi, BITS_PER_MBOX);
+
+	irq_set_chained_handler_and_data(mux_irq,
+					 bcm2836_arm_irqchip_handle_ipi, NULL);
+
 	/* Unmask IPIs to the boot CPU. */
 	cpuhp_setup_state(CPUHP_AP_IRQ_BCM2836_STARTING,
 			  "irqchip/bcm2836:starting", bcm2836_cpu_starting,
 			  bcm2836_cpu_dying);
-
-	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
-#endif
 }
+#else
+#define bcm2836_arm_irqchip_smp_init()	do { } while(0)
+#endif
+
+static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
+	.xlate = irq_domain_xlate_onetwocell,
+	.map = bcm2836_map,
+};
 
 /*
  * The LOCAL_IRQ_CNT* timer firings are based off of the external
@@ -232,6 +329,8 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
 	if (!intc.domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
+	irq_domain_update_bus_token(intc.domain, DOMAIN_BUS_WIRED);
+
 	bcm2836_arm_irqchip_smp_init();
 
 	set_handle_irq(bcm2836_arm_irqchip_handle_irq);
-- 
2.26.2

