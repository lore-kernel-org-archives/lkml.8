Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D988FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B782120747
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TcQRfXSH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pHmz6Opz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGEPrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgGEPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:47:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0AC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 08:47:54 -0700 (PDT)
Date:   Sun, 05 Jul 2020 15:46:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593964070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yePEeuwfeQwyPE9DPiLvsCsITDdUl0/9T68w9GikjMI=;
        b=TcQRfXSHNSYtfwFLc7zrH4piBN6to54KMslRlvmf73FamjIAvzJa01ZbCoRK4A+rEhpXPY
        I7lOcsaAoO77w9eveJtOXZW9aOfVSzA0n8xEN3QFAoCc17mLyEYHLtIhu8X3Ox23iiPBoC
        HDGoBLs/5FEtA5aSRzxDmeR42SAGygOqMhLwPndGsDAxFNZWaXliFHG43U0ZbHxXJ6/hup
        04ul0m44T4eAGYk7c3IeS5b45MBgm8lY2z/+ZY+Wx+7ZAFo9YKz93Ci1L8QxSQqqUf8IIZ
        pvZeAmqW0F+Kd3Rygepkatt8fhjN1ZoQtFTPzIe159dRJgIQ1CdflrskjVNLSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593964070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yePEeuwfeQwyPE9DPiLvsCsITDdUl0/9T68w9GikjMI=;
        b=pHmz6Opz9nzV1P2PvACTuR+mOVrfYPABwyHQG2MFk/0o8D/naOrs987U/ZEe3KQwT7nWPW
        DyZ84ZWkjF+rS9AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.8-rc4
References: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
Message-ID: <159396401536.28963.14025922176028941347.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-07-05

up to:  98817a84ff1c: Merge tag 'irqchip-fixes-5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of interrupt chip driver fixes:

 - Ensure the atomicity of affinity updates in the GIC driver.

 - Don't try to sleep in atomic context when waiting for the GICv4.1 to
   respond. Use polling instead.

 - Typo fixes in Kconfig and warnings.

Thanks,

	tglx

------------------>
Jiaxun Yang (1):
      irqchip/loongson-pci-msi: Fix a typo in Kconfig

Marc Zyngier (1):
      irqchip/gic: Atomically update affinity

Palmer Dabbelt (1):
      irqchip/riscv-intc: Fix a typo in a pr_warn()

Zenghui Yu (1):
      irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in atomic


 drivers/irqchip/Kconfig          |  2 +-
 drivers/irqchip/irq-gic-v3-its.c |  8 ++++----
 drivers/irqchip/irq-gic.c        | 14 +++-----------
 drivers/irqchip/irq-riscv-intc.c |  2 +-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 29fead208cad..216b3b8392b5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -563,7 +563,7 @@ config LOONGSON_PCH_PIC
 	  Support for the Loongson PCH PIC Controller.
 
 config LOONGSON_PCH_MSI
-	bool "Loongson PCH PIC Controller"
+	bool "Loongson PCH MSI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
 	depends on PCI
 	default MACH_LOONGSON64
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd685f521c77..6a5a87fc4601 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3797,10 +3797,10 @@ static void its_wait_vpt_parse_complete(void)
 	if (!gic_rdists->has_vpend_valid_dirty)
 		return;
 
-	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
-						val,
-						!(val & GICR_VPENDBASER_Dirty),
-						10, 500));
+	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
+						       val,
+						       !(val & GICR_VPENDBASER_Dirty),
+						       10, 500));
 }
 
 static void its_vpe_schedule(struct its_vpe *vpe)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 00de05abd3c3..c17fabd6741e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -329,10 +329,8 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
-	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
-	u32 val, mask, bit;
-	unsigned long flags;
+	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	unsigned int cpu;
 
 	if (!force)
 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
@@ -342,13 +340,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	gic_lock_irqsave(flags);
-	mask = 0xff << shift;
-	bit = gic_cpu_map[cpu] << shift;
-	val = readl_relaxed(reg) & ~mask;
-	writel_relaxed(val | bit, reg);
-	gic_unlock_irqrestore(flags);
-
+	writeb_relaxed(gic_cpu_map[cpu], reg);
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK_DONE;
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index a6f97fa6ff69..8017f6d32d52 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -99,7 +99,7 @@ static int __init riscv_intc_init(struct device_node *node,
 
 	hartid = riscv_of_parent_hartid(node);
 	if (hartid < 0) {
-		pr_warn("unable to fine hart id for %pOF\n", node);
+		pr_warn("unable to find hart id for %pOF\n", node);
 		return 0;
 	}
 

