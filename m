Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC039C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF92206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkmfCzCE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nTfcJGm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgHDIaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:30:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgHDIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:30:10 -0400
Date:   Tue, 04 Aug 2020 08:21:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596529801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6Je2cysxJdc+C3FAYtyIc+I7UHRTmtZIML0qIj9Pgrg=;
        b=TkmfCzCE6lCgkzNZrmALwl7E5/Y5l4I8hE5UB9JnP8XcojrnazSxZTXkJVdRIP60Nvz+cu
        nbUpLUx1xwDr4n2ww4Jj9EzYYc52CbOVb7MrtOKNKk7Dcu7DUHgOmiDN4onkN5ljBPitYI
        MhZiw0jsQYH+E4cVU6pIi+XkY5ke8ymfVX30KkAiUwRQmUS9odh+/ybsp0wDqwDBXMYjPU
        WaTWl4H2zx+89sCWYb98SUGvYz9W65Z4oRsht38iW1Iy8nwjJ8+AtY4DrNKokFWqMdH578
        Bln1ynNvNhj7QTAFyhwIH02wZzGEZJRl0xC6rQMoPqU1rPHXi44uGyi+cYqAGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596529801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6Je2cysxJdc+C3FAYtyIc+I7UHRTmtZIML0qIj9Pgrg=;
        b=nTfcJGm7T35GdlJ1A3hX/vj8fNlT5CoTw5hIerDOm2IJVkw4zemYL+1ey+O8GjeZ6CI77y
        Sdgl5v012KF3adBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [GIT pull] irq/core for v5.9
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
Message-ID: <159652931460.11821.10453621811208035324.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-08-04

up to:  3d5128c1deb5: Merge tag 'irqchip-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

The usual boring updates from the interrupt subsystem:

 - Infrastructure to allow building irqchip drivers as modules
 
 - Consolidation of irqchip ACPI probing

 - Removal of the EOI-preflow interrupt handler which was required for
   SPARC support and became obsolete after SPARC was converted to
   use sparse interrupts.

 - Cleanups, fixes and improvements all over the place

Thanks,

	tglx

P.S.: This time there is really no new driver. Just the minimal updates to
      existing drivers to support newer chip variants.

------------------>
Alexandre Torgue (1):
      irqchip/stm32-exti: Map direct event to irq parent

Bartosz Golaszewski (1):
      irqchip/irq-mtk-sysirq: Replace spinlock with raw_spinlock

Claudiu Beznea (1):
      irqchip/atmel-aic5: Add support for sam9x60 rtt fixup

Fabien Dessenne (1):
      irqchip/stm32-exti: Use the hwspin_lock_timeout_in_atomic() API

Florian Fainelli (5):
      dt-bindings: interrupt-controller: Document Broadcom STB HIF L2
      dt-bindings: interrupt-controller: Document UPG auxiliary L2
      irqchip/brcmstb-l2: Match UPG_AUX_AON_INTR2 compatible
      irqchip/irq-bcm7038-l1: Allow building on ARM 32-bit
      irqchip/irq-bcm7038-l1: Guard uses of cpu_logical_map

Gustavo A. R. Silva (1):
      irqchip/imx-intmux: Use struct_size() helper in devm_kzalloc()

Huacai Chen (4):
      dt-bindings: interrupt-controller: Update Loongson HTVEC description
      irqchip/loongson-liointc: Fix misuse of gc->mask_cache
      irqchip/loongson-htvec: Support 8 groups of HT vectors
      irqchip/loongson-pch-pic: Fix the misused irq flow handler

Joakim Zhang (1):
      irqchip/imx-intmux: Implement intmux runtime power management

John Stultz (3):
      irqdomain: Export irq_domain_update_bus_token
      genirq: Export irq_chip_retrigger_hierarchy and irq_chip_set_vcpu_affinity_parent
      irqchip/qcom-pdc: Allow QCOM_PDC to be loadable as a permanent module

Justin Chen (2):
      irqchip/bcm7120-l2: Set controller as wake-up source
      irqchip/brcmstb-l2: Set controller as wake-up source

Kamal Dasu (1):
      irqchip/brcmstb-l2: Match HIF_SPI_INTR2 compatible

Linus Walleij (2):
      irqchip/vic: Drop cascaded intialization call
      irqchip/vic: Cut down the external API

Marc Zyngier (1):
      irqchip: Fix IRQCHIP_PLATFORM_DRIVER_* compilation by including module.h

Masahiro Yamada (1):
      irqchip/ativic32: Constify irq_domain_ops

Oscar Carter (3):
      drivers/acpi: Add new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
      drivers/irqchip: Use new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
      drivers/acpi: Remove function cast

Randy Dunlap (1):
      irqchip: irq-bcm2836.h: drop a duplicated word

Saravana Kannan (4):
      irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros
      irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER helper macros
      irqchip/mtk-sysirq: Convert to a platform driver
      irqchip/mtk-cirq: Convert to a platform driver

Tiezhu Yang (10):
      irqchip/ti-sci-inta: Remove dead code in ti_sci_inta_set_type()
      irqchip/ti-sci-inta: Fix return value about devm_ioremap_resource()
      irqchip/ti-sci-inta: Fix typo about MODULE_AUTHOR
      irqchip/loongson-htpic: Remove redundant kfree operation
      irqchip/loongson-htpic: Remove unneeded select of I8259
      irqchip/loongson-htvec: Fix potential resource leak
      irqchip/loongson-htvec: Check return value of irq_domain_translate_onecell()
      irqchip/loongson-pch-pic: Check return value of irq_domain_translate_twocell()
      irqchip/loongson-pch-msi: Remove unneeded variable
      irqchip/loongson-liointc: Fix potential dead lock

Valentin Schneider (2):
      sparc64: Deselect IRQ_PREFLOW_FASTEOI
      genirq: Remove preflow handler support

Wei Yongjun (2):
      irqchip/mips-gic: Make local symbols static
      irqchip/imx-intmux: Fix irqdata regs save in imx_intmux_runtime_suspend()

Zenghui Yu (4):
      genirq/irqdomain: Remove redundant NULL pointer check on fwnode
      irqchip/gic-v3: Remove unused register definition
      irqchip/gic-v4.1: Ensure accessing the correct RD when writing INVALLR
      irqchip/gic-v4.1: Use GFP_ATOMIC flag in allocate_vpe_l1_table()


 .../bindings/interrupt-controller/brcm,l2-intc.txt |   5 +-
 .../interrupt-controller/loongson,htvec.yaml       |   4 +-
 arch/sparc/Kconfig                                 |   1 -
 drivers/irqchip/Kconfig                            |   3 +-
 drivers/irqchip/irq-ativic32.c                     |   2 +-
 drivers/irqchip/irq-atmel-aic5.c                   |   8 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |  11 ++
 drivers/irqchip/irq-bcm7120-l2.c                   |   8 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |   5 +
 drivers/irqchip/irq-gic-v3-its.c                   |  14 +-
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-gic.c                          |   2 +-
 drivers/irqchip/irq-imx-intmux.c                   |  70 ++++++++-
 drivers/irqchip/irq-loongson-htpic.c               |   6 +-
 drivers/irqchip/irq-loongson-htvec.c               |  32 ++--
 drivers/irqchip/irq-loongson-liointc.c             |  11 +-
 drivers/irqchip/irq-loongson-pch-msi.c             |   7 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  30 ++--
 drivers/irqchip/irq-mips-gic.c                     |  10 +-
 drivers/irqchip/irq-mtk-cirq.c                     |   4 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |  12 +-
 drivers/irqchip/irq-stm32-exti.c                   | 166 +++++++++++----------
 drivers/irqchip/irq-ti-sci-inta.c                  |   6 +-
 drivers/irqchip/irq-vic.c                          |  26 +---
 drivers/irqchip/irqchip.c                          |  29 ++++
 drivers/irqchip/qcom-pdc.c                         |   8 +-
 include/linux/acpi.h                               |  23 ++-
 include/linux/irqchip.h                            |  29 +++-
 include/linux/irqchip/arm-gic-v3.h                 |   4 -
 include/linux/irqchip/arm-vic.h                    |  11 --
 include/linux/irqchip/irq-bcm2836.h                |   2 +-
 include/linux/irqdesc.h                            |  15 --
 include/linux/irqhandler.h                         |   1 -
 kernel/irq/Kconfig                                 |   4 -
 kernel/irq/chip.c                                  |  16 +-
 kernel/irq/irqdomain.c                             |   3 +-
 36 files changed, 346 insertions(+), 244 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
index d514ec060a4a..021cf822395c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
@@ -2,7 +2,10 @@ Broadcom Generic Level 2 Interrupt Controller
 
 Required properties:
 
-- compatible: should be "brcm,l2-intc" for latched interrupt controllers
+- compatible: should be one of:
+	      "brcm,hif-spi-l2-intc" or
+	      "brcm,upg-aux-aon-l2-intc" or
+	      "brcm,l2-intc" for latched interrupt controllers
               should be "brcm,bcm7271-l2-intc" for level interrupt controllers
 - reg: specifies the base physical address and size of the registers
 - interrupt-controller: identifies the node as an interrupt controller
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
index e865cd8f96a9..87a74558204f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
@@ -22,8 +22,8 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 4
-    description: Four parent interrupts that receive chained interrupts.
+    maxItems: 8
+    description: Eight parent interrupts that receive chained interrupts.
 
   interrupt-controller: true
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5bf2dc163540..76f4078e7419 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -80,7 +80,6 @@ config SPARC64
 	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
-	select IRQ_PREFLOW_FASTEOI
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 29fead208cad..ee051571408a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -425,7 +425,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	bool "QCOM PDC"
+	tristate "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
@@ -541,7 +541,6 @@ config LOONGSON_HTPIC
 	default y
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
-	select I8259
 	help
 	  Support for the Loongson-3 HyperTransport PIC Controller.
 
diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
index 85cf6e0e0e52..476d6024aaf2 100644
--- a/drivers/irqchip/irq-ativic32.c
+++ b/drivers/irqchip/irq-ativic32.c
@@ -92,7 +92,7 @@ static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops ativic32_ops = {
+static const struct irq_domain_ops ativic32_ops = {
 	.map = ativic32_irq_domain_map,
 	.xlate = irq_domain_xlate_onecell
 };
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index fc1b3a9cdafc..fb4ad2aaa727 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -310,10 +310,16 @@ static void __init sama5d3_aic_irq_fixup(void)
 	aic_common_rtc_irq_fixup();
 }
 
+static void __init sam9x60_aic_irq_fixup(void)
+{
+	aic_common_rtc_irq_fixup();
+	aic_common_rtt_irq_fixup();
+}
+
 static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
-	{ .compatible = "microchip,sam9x60", .data = sama5d3_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x60", .data = sam9x60_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index fd7c537fb42a..9dc9bf8cdcc4 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -28,6 +28,9 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/syscore_ops.h>
+#ifdef CONFIG_ARM
+#include <asm/smp_plat.h>
+#endif
 
 #define IRQS_PER_WORD		32
 #define REG_BYTES_PER_IRQ_WORD	(sizeof(u32) * 4)
@@ -327,7 +330,11 @@ static int bcm7038_l1_suspend(void)
 	u32 val;
 
 	/* Wakeup interrupt should only come from the boot cpu */
+#ifdef CONFIG_SMP
 	boot_cpu = cpu_logical_map(0);
+#else
+	boot_cpu = 0;
+#endif
 
 	list_for_each_entry(intc, &bcm7038_l1_intcs_list, list) {
 		for (word = 0; word < intc->n_words; word++) {
@@ -347,7 +354,11 @@ static void bcm7038_l1_resume(void)
 	struct bcm7038_l1_chip *intc;
 	int boot_cpu, word;
 
+#ifdef CONFIG_SMP
 	boot_cpu = cpu_logical_map(0);
+#else
+	boot_cpu = 0;
+#endif
 
 	list_for_each_entry(intc, &bcm7038_l1_intcs_list, list) {
 		for (word = 0; word < intc->n_words; word++) {
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 586df3587be0..c7c9e976acbb 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -143,6 +143,9 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 
 	irq_set_chained_handler_and_data(parent_irq,
 					 bcm7120_l2_intc_irq_handle, l1_data);
+	if (data->can_wake)
+		enable_irq_wake(parent_irq);
+
 	return 0;
 }
 
@@ -247,6 +250,8 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	if (ret < 0)
 		goto out_free_l1_data;
 
+	data->can_wake = of_property_read_bool(dn, "brcm,irq-can-wake");
+
 	for (irq = 0; irq < data->num_parent_irqs; irq++) {
 		ret = bcm7120_l2_intc_init_one(dn, data, irq, valid_mask);
 		if (ret)
@@ -274,9 +279,6 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		goto out_free_domain;
 	}
 
-	if (of_property_read_bool(dn, "brcm,irq-can-wake"))
-		data->can_wake = true;
-
 	for (idx = 0; idx < data->n_words; idx++) {
 		irq = idx * IRQS_PER_WORD;
 		gc = irq_get_domain_generic_chip(data->domain, irq);
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 0298ede67e51..cdd6a42d4efa 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -254,6 +254,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		 */
 		data->gc->wake_enabled = 0xffffffff;
 		ct->chip.irq_set_wake = irq_gc_set_wake;
+		enable_irq_wake(parent_irq);
 	}
 
 	pr_info("registered L2 intc (%pOF, parent irq: %d)\n", np, parent_irq);
@@ -275,6 +276,10 @@ static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
 IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_edge_intc_of_init);
+IRQCHIP_DECLARE(brcmstb_hif_spi_l2_intc, "brcm,hif-spi-l2-intc",
+		brcmstb_l2_edge_intc_of_init);
+IRQCHIP_DECLARE(brcmstb_upg_aux_aon_l2_intc, "brcm,upg-aux-aon-l2-intc",
+		brcmstb_l2_edge_intc_of_init);
 
 static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
 	struct device_node *parent)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd685f521c77..6b238f9edef6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2814,7 +2814,7 @@ static int allocate_vpe_l1_table(void)
 	if (val & GICR_VPROPBASER_4_1_VALID)
 		goto out;
 
-	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_KERNEL);
+	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_ATOMIC);
 	if (!gic_data_rdist()->vpe_table_mask)
 		return -ENOMEM;
 
@@ -2881,7 +2881,7 @@ static int allocate_vpe_l1_table(void)
 
 	pr_debug("np = %d, npg = %lld, psz = %d, epp = %d, esz = %d\n",
 		 np, npg, psz, epp, esz);
-	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(np * PAGE_SIZE));
+	page = alloc_pages(GFP_ATOMIC | __GFP_ZERO, get_order(np * PAGE_SIZE));
 	if (!page)
 		return -ENOMEM;
 
@@ -4079,18 +4079,22 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
 static void its_vpe_4_1_invall(struct its_vpe *vpe)
 {
 	void __iomem *rdbase;
+	unsigned long flags;
 	u64 val;
+	int cpu;
 
 	val  = GICR_INVALLR_V;
 	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
 
 	/* Target the redistributor this vPE is currently known on */
-	raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
+	cpu = vpe_to_cpuid_lock(vpe, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
 	gic_write_lpir(val, rdbase + GICR_INVALLR);
 
 	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	vpe_to_cpuid_unlock(vpe, flags);
 }
 
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cc46bc2d634b..324f280ff606 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2116,7 +2116,7 @@ static void __init gic_acpi_setup_kvm_info(void)
 }
 
 static int __init
-gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
+gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 {
 	struct acpi_madt_generic_distributor *dist;
 	struct fwnode_handle *domain_handle;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 00de05abd3c3..71bd64884ae5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1592,7 +1592,7 @@ static void __init gic_acpi_setup_kvm_info(void)
 	gic_set_kvm_info(&gic_v2_kvm_info);
 }
 
-static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
+static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
 	struct acpi_madt_generic_distributor *dist;
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index c27577c81126..e35b7b09c3ab 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -53,6 +53,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
 
 #define CHANIER(n)	(0x10 + (0x40 * n))
 #define CHANIPR(n)	(0x20 + (0x40 * n))
@@ -60,6 +61,8 @@
 #define CHAN_MAX_NUM		0x8
 
 struct intmux_irqchip_data {
+	struct irq_chip		chip;
+	u32			saved_reg;
 	int			chanidx;
 	int			irq;
 	struct irq_domain	*domain;
@@ -120,8 +123,10 @@ static struct irq_chip imx_intmux_irq_chip = {
 static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
-	irq_set_chip_data(irq, h->host_data);
-	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
+	struct intmux_irqchip_data *data = h->host_data;
+
+	irq_set_chip_data(irq, data);
+	irq_set_chip_and_handler(irq, &data->chip, handle_level_irq);
 
 	return 0;
 }
@@ -210,8 +215,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data) +
-			    channum * sizeof(data->irqchip_data[0]), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, struct_size(data, irqchip_data, channum), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -232,6 +236,10 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	data->channum = channum;
 	raw_spin_lock_init(&data->lock);
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = clk_prepare_enable(data->ipg_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
@@ -239,6 +247,8 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < channum; i++) {
+		data->irqchip_data[i].chip = imx_intmux_irq_chip;
+		data->irqchip_data[i].chip.parent_device = &pdev->dev;
 		data->irqchip_data[i].chanidx = i;
 
 		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
@@ -267,6 +277,12 @@ static int imx_intmux_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	/*
+	 * Let pm_runtime_put() disable clock.
+	 * If CONFIG_PM is not enabled, the clock will stay powered.
+	 */
+	pm_runtime_put(&pdev->dev);
+
 	return 0;
 out:
 	clk_disable_unprepare(data->ipg_clk);
@@ -288,11 +304,56 @@ static int imx_intmux_remove(struct platform_device *pdev)
 		irq_domain_remove(data->irqchip_data[i].domain);
 	}
 
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int imx_intmux_runtime_suspend(struct device *dev)
+{
+	struct intmux_data *data = dev_get_drvdata(dev);
+	struct intmux_irqchip_data *irqchip_data;
+	int i;
+
+	for (i = 0; i < data->channum; i++) {
+		irqchip_data = &data->irqchip_data[i];
+		irqchip_data->saved_reg = readl_relaxed(data->regs + CHANIER(i));
+	}
+
 	clk_disable_unprepare(data->ipg_clk);
 
 	return 0;
 }
 
+static int imx_intmux_runtime_resume(struct device *dev)
+{
+	struct intmux_data *data = dev_get_drvdata(dev);
+	struct intmux_irqchip_data *irqchip_data;
+	int ret, i;
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < data->channum; i++) {
+		irqchip_data = &data->irqchip_data[i];
+		writel_relaxed(irqchip_data->saved_reg, data->regs + CHANIER(i));
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx_intmux_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx_intmux_runtime_suspend,
+			   imx_intmux_runtime_resume, NULL)
+};
+
 static const struct of_device_id imx_intmux_id[] = {
 	{ .compatible = "fsl,imx-intmux", },
 	{ /* sentinel */ },
@@ -302,6 +363,7 @@ static struct platform_driver imx_intmux_driver = {
 	.driver = {
 		.name = "imx-intmux",
 		.of_match_table = imx_intmux_id,
+		.pm = &imx_intmux_pm_ops,
 	},
 	.probe = imx_intmux_probe,
 	.remove = imx_intmux_remove,
diff --git a/drivers/irqchip/irq-loongson-htpic.c b/drivers/irqchip/irq-loongson-htpic.c
index dd018c22ea83..63f72803c8c4 100644
--- a/drivers/irqchip/irq-loongson-htpic.c
+++ b/drivers/irqchip/irq-loongson-htpic.c
@@ -93,10 +93,8 @@ int __init htpic_of_init(struct device_node *node, struct device_node *parent)
 	}
 
 	htpic = kzalloc(sizeof(*htpic), GFP_KERNEL);
-	if (!htpic) {
-		err = -ENOMEM;
-		goto out_free;
-	}
+	if (!htpic)
+		return -ENOMEM;
 
 	htpic->base = of_iomap(node, 0);
 	if (!htpic->base) {
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 1ece9337c78d..13e6016fe464 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -19,15 +19,14 @@
 
 /* Registers */
 #define HTVEC_EN_OFF		0x20
-#define HTVEC_MAX_PARENT_IRQ	4
+#define HTVEC_MAX_PARENT_IRQ	8
 
 #define VEC_COUNT_PER_REG	32
-#define VEC_REG_COUNT		4
-#define VEC_COUNT		(VEC_COUNT_PER_REG * VEC_REG_COUNT)
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
 
 struct htvec {
+	int			num_parents;
 	void __iomem		*base;
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
@@ -43,7 +42,7 @@ static void htvec_irq_dispatch(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	for (i = 0; i < VEC_REG_COUNT; i++) {
+	for (i = 0; i < priv->num_parents; i++) {
 		pending = readl(priv->base + 4 * i);
 		while (pending) {
 			int bit = __ffs(pending);
@@ -109,11 +108,14 @@ static struct irq_chip htvec_irq_chip = {
 static int htvec_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nr_irqs, void *arg)
 {
+	int ret;
 	unsigned long hwirq;
 	unsigned int type, i;
 	struct htvec *priv = domain->host_data;
 
-	irq_domain_translate_onecell(domain, arg, &hwirq, &type);
+	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i, &htvec_irq_chip,
@@ -147,7 +149,7 @@ static void htvec_reset(struct htvec *priv)
 	u32 idx;
 
 	/* Clear IRQ cause registers, mask all interrupts */
-	for (idx = 0; idx < VEC_REG_COUNT; idx++) {
+	for (idx = 0; idx < priv->num_parents; idx++) {
 		writel_relaxed(0x0, priv->base + HTVEC_EN_OFF + 4 * idx);
 		writel_relaxed(0xFFFFFFFF, priv->base);
 	}
@@ -157,7 +159,7 @@ static int htvec_of_init(struct device_node *node,
 				struct device_node *parent)
 {
 	struct htvec *priv;
-	int err, parent_irq[4], num_parents = 0, i;
+	int err, parent_irq[8], i;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -176,33 +178,35 @@ static int htvec_of_init(struct device_node *node,
 		if (parent_irq[i] <= 0)
 			break;
 
-		num_parents++;
+		priv->num_parents++;
 	}
 
-	if (!num_parents) {
+	if (!priv->num_parents) {
 		pr_err("Failed to get parent irqs\n");
 		err = -ENODEV;
 		goto iounmap_base;
 	}
 
 	priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
-						      VEC_COUNT,
-						      &htvec_domain_ops,
-						      priv);
+					(VEC_COUNT_PER_REG * priv->num_parents),
+					&htvec_domain_ops, priv);
 	if (!priv->htvec_domain) {
 		pr_err("Failed to create IRQ domain\n");
 		err = -ENOMEM;
-		goto iounmap_base;
+		goto irq_dispose;
 	}
 
 	htvec_reset(priv);
 
-	for (i = 0; i < num_parents; i++)
+	for (i = 0; i < priv->num_parents; i++)
 		irq_set_chained_handler_and_data(parent_irq[i],
 						 htvec_irq_dispatch, priv);
 
 	return 0;
 
+irq_dispose:
+	for (; i > 0; i--)
+		irq_dispose_mapping(parent_irq[i - 1]);
 iounmap_base:
 	iounmap(priv->base);
 free_priv:
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 63b61474a0cc..9ed1bc473663 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -60,7 +60,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	if (!pending) {
 		/* Always blame LPC IRQ if we have that bug */
 		if (handler->priv->has_lpc_irq_errata &&
-			(handler->parent_int_map & ~gc->mask_cache &
+			(handler->parent_int_map & gc->mask_cache &
 			BIT(LIOINTC_ERRATA_IRQ)))
 			pending = BIT(LIOINTC_ERRATA_IRQ);
 		else
@@ -114,6 +114,7 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
 		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	default:
+		irq_gc_unlock_irqrestore(gc, flags);
 		return -EINVAL;
 	}
 	irq_gc_unlock_irqrestore(gc, flags);
@@ -131,11 +132,11 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	irq_gc_lock_irqsave(gc, flags);
 	/* Disable all at first */
 	writel(0xffffffff, gc->reg_base + LIOINTC_REG_INTC_DISABLE);
-	/* Revert map cache */
+	/* Restore map cache */
 	for (i = 0; i < LIOINTC_CHIP_IRQ; i++)
 		writeb(priv->map_cache[i], gc->reg_base + i);
-	/* Revert mask cache */
-	writel(~gc->mask_cache, gc->reg_base + LIOINTC_REG_INTC_ENABLE);
+	/* Restore mask cache */
+	writel(gc->mask_cache, gc->reg_base + LIOINTC_REG_INTC_ENABLE);
 	irq_gc_unlock_irqrestore(gc, flags);
 }
 
@@ -243,7 +244,7 @@ int __init liointc_of_init(struct device_node *node,
 	ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
 	ct->chip.irq_set_type = liointc_set_type;
 
-	gc->mask_cache = 0xffffffff;
+	gc->mask_cache = 0;
 	priv->gc = gc;
 
 	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 50becd21008c..12aeeab43289 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -100,17 +100,12 @@ static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
 					unsigned int virq, int hwirq)
 {
 	struct irq_fwspec fwspec;
-	int ret;
 
 	fwspec.fwnode = domain->parent->fwnode;
 	fwspec.param_count = 1;
 	fwspec.param[0] = hwirq;
 
-	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
-	if (ret)
-		return ret;
-
-	return 0;
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 }
 
 static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 2a05b9305012..9bf6b9a5f734 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -64,15 +64,6 @@ static void pch_pic_bitclr(struct pch_pic *priv, int offset, int bit)
 	raw_spin_unlock(&priv->pic_lock);
 }
 
-static void pch_pic_eoi_irq(struct irq_data *d)
-{
-	u32 idx = PIC_REG_IDX(d->hwirq);
-	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
-
-	writel(BIT(PIC_REG_BIT(d->hwirq)),
-			priv->base + PCH_PIC_CLR + idx * 4);
-}
-
 static void pch_pic_mask_irq(struct irq_data *d)
 {
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
@@ -85,6 +76,9 @@ static void pch_pic_unmask_irq(struct irq_data *d)
 {
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
 
+	writel(BIT(PIC_REG_BIT(d->hwirq)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+
 	irq_chip_unmask_parent(d);
 	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
 }
@@ -124,7 +118,6 @@ static struct irq_chip pch_pic_irq_chip = {
 	.irq_mask		= pch_pic_mask_irq,
 	.irq_unmask		= pch_pic_unmask_irq,
 	.irq_ack		= irq_chip_ack_parent,
-	.irq_eoi		= pch_pic_eoi_irq,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_type		= pch_pic_set_type,
 };
@@ -135,22 +128,25 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 	int err;
 	unsigned int type;
 	unsigned long hwirq;
-	struct irq_fwspec fwspec;
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec parent_fwspec;
 	struct pch_pic *priv = domain->host_data;
 
-	irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	err = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	if (err)
+		return err;
 
-	fwspec.fwnode = domain->parent->fwnode;
-	fwspec.param_count = 1;
-	fwspec.param[0] = hwirq + priv->ht_vec_base;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 1;
+	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
 
-	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)
 		return err;
 
 	irq_domain_set_info(domain, virq, hwirq,
 			    &pch_pic_irq_chip, priv,
-			    handle_fasteoi_ack_irq, NULL, NULL);
+			    handle_level_irq, NULL, NULL);
 	irq_set_probe(virq);
 
 	return 0;
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d70507133c1d..aacfa012c082 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -46,7 +46,7 @@
 
 void __iomem *mips_gic_base;
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
@@ -617,8 +617,8 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
 	return ret;
 }
 
-void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
-			 unsigned int nr_irqs)
+static void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs)
 {
 	irq_hw_number_t base_hwirq;
 	struct irq_data *data;
@@ -631,8 +631,8 @@ void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
 	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
 
-int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
-			 enum irq_domain_bus_token bus_token)
+static int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
+				enum irq_domain_bus_token bus_token)
 {
 	bool is_ipi;
 
diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 69ba8ce3c178..62a61275aaa3 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -295,4 +295,6 @@ static int __init mtk_cirq_of_init(struct device_node *node,
 	return ret;
 }
 
-IRQCHIP_DECLARE(mtk_cirq, "mediatek,mtk-cirq", mtk_cirq_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_cirq)
+IRQCHIP_MATCH("mediatek,mtk-cirq", mtk_cirq_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(mtk_cirq)
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 73eae5966a40..7299c5ab4d10 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 
 struct mtk_sysirq_chip_data {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	u32 nr_intpol_bases;
 	void __iomem **intpol_bases;
 	u32 *intpol_words;
@@ -37,7 +37,7 @@ static int mtk_sysirq_set_type(struct irq_data *data, unsigned int type)
 	reg_index = chip_data->which_word[hwirq];
 	offset = hwirq & 0x1f;
 
-	spin_lock_irqsave(&chip_data->lock, flags);
+	raw_spin_lock_irqsave(&chip_data->lock, flags);
 	value = readl_relaxed(base + reg_index * 4);
 	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING) {
 		if (type == IRQ_TYPE_LEVEL_LOW)
@@ -53,7 +53,7 @@ static int mtk_sysirq_set_type(struct irq_data *data, unsigned int type)
 
 	data = data->parent_data;
 	ret = data->chip->irq_set_type(data, type);
-	spin_unlock_irqrestore(&chip_data->lock, flags);
+	raw_spin_unlock_irqrestore(&chip_data->lock, flags);
 	return ret;
 }
 
@@ -212,7 +212,7 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 		ret = -ENOMEM;
 		goto out_free_which_word;
 	}
-	spin_lock_init(&chip_data->lock);
+	raw_spin_lock_init(&chip_data->lock);
 
 	return 0;
 
@@ -231,4 +231,6 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 	kfree(chip_data);
 	return ret;
 }
-IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
+IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index faa8482c8246..03a36be757d8 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -25,7 +25,6 @@
 #define IRQS_PER_BANK 32
 
 #define HWSPNLCK_TIMEOUT	1000 /* usec */
-#define HWSPNLCK_RETRY_DELAY	100  /* usec */
 
 struct stm32_exti_bank {
 	u32 imr_ofst;
@@ -42,6 +41,7 @@ struct stm32_exti_bank {
 struct stm32_desc_irq {
 	u32 exti;
 	u32 irq_parent;
+	struct irq_chip *chip;
 };
 
 struct stm32_exti_drv_data {
@@ -166,27 +166,41 @@ static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
 	&stm32mp1_exti_b3,
 };
 
+static struct irq_chip stm32_exti_h_chip;
+static struct irq_chip stm32_exti_h_chip_direct;
+
 static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6 },
-	{ .exti = 1, .irq_parent = 7 },
-	{ .exti = 2, .irq_parent = 8 },
-	{ .exti = 3, .irq_parent = 9 },
-	{ .exti = 4, .irq_parent = 10 },
-	{ .exti = 5, .irq_parent = 23 },
-	{ .exti = 6, .irq_parent = 64 },
-	{ .exti = 7, .irq_parent = 65 },
-	{ .exti = 8, .irq_parent = 66 },
-	{ .exti = 9, .irq_parent = 67 },
-	{ .exti = 10, .irq_parent = 40 },
-	{ .exti = 11, .irq_parent = 42 },
-	{ .exti = 12, .irq_parent = 76 },
-	{ .exti = 13, .irq_parent = 77 },
-	{ .exti = 14, .irq_parent = 121 },
-	{ .exti = 15, .irq_parent = 127 },
-	{ .exti = 16, .irq_parent = 1 },
-	{ .exti = 65, .irq_parent = 144 },
-	{ .exti = 68, .irq_parent = 143 },
-	{ .exti = 73, .irq_parent = 129 },
+	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
+	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
+	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
+	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
+	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
+	{ .exti = 5, .irq_parent = 23, .chip = &stm32_exti_h_chip },
+	{ .exti = 6, .irq_parent = 64, .chip = &stm32_exti_h_chip },
+	{ .exti = 7, .irq_parent = 65, .chip = &stm32_exti_h_chip },
+	{ .exti = 8, .irq_parent = 66, .chip = &stm32_exti_h_chip },
+	{ .exti = 9, .irq_parent = 67, .chip = &stm32_exti_h_chip },
+	{ .exti = 10, .irq_parent = 40, .chip = &stm32_exti_h_chip },
+	{ .exti = 11, .irq_parent = 42, .chip = &stm32_exti_h_chip },
+	{ .exti = 12, .irq_parent = 76, .chip = &stm32_exti_h_chip },
+	{ .exti = 13, .irq_parent = 77, .chip = &stm32_exti_h_chip },
+	{ .exti = 14, .irq_parent = 121, .chip = &stm32_exti_h_chip },
+	{ .exti = 15, .irq_parent = 127, .chip = &stm32_exti_h_chip },
+	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
+	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 21, .irq_parent = 31, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 22, .irq_parent = 33, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 23, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 24, .irq_parent = 95, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 25, .irq_parent = 107, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 30, .irq_parent = 52, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 47, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 54, .irq_parent = 135, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 61, .irq_parent = 100, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 65, .irq_parent = 144, .chip = &stm32_exti_h_chip },
+	{ .exti = 68, .irq_parent = 143, .chip = &stm32_exti_h_chip },
+	{ .exti = 70, .irq_parent = 62, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 73, .irq_parent = 129, .chip = &stm32_exti_h_chip },
 };
 
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
@@ -196,22 +210,23 @@ static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
 };
 
-static int stm32_exti_to_irq(const struct stm32_exti_drv_data *drv_data,
-			     irq_hw_number_t hwirq)
+static const struct
+stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_data,
+				    irq_hw_number_t hwirq)
 {
-	const struct stm32_desc_irq *desc_irq;
+	const struct stm32_desc_irq *desc = NULL;
 	int i;
 
 	if (!drv_data->desc_irqs)
-		return -EINVAL;
+		return NULL;
 
 	for (i = 0; i < drv_data->irq_nr; i++) {
-		desc_irq = &drv_data->desc_irqs[i];
-		if (desc_irq->exti == hwirq)
-			return desc_irq->irq_parent;
+		desc = &drv_data->desc_irqs[i];
+		if (desc->exti == hwirq)
+			break;
 	}
 
-	return -EINVAL;
+	return desc;
 }
 
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
@@ -277,55 +292,24 @@ static int stm32_exti_set_type(struct irq_data *d,
 	return 0;
 }
 
-static int stm32_exti_hwspin_lock(struct stm32_exti_chip_data *chip_data)
-{
-	int ret, timeout = 0;
-
-	if (!chip_data->host_data->hwlock)
-		return 0;
-
-	/*
-	 * Use the x_raw API since we are under spin_lock protection.
-	 * Do not use the x_timeout API because we are under irq_disable
-	 * mode (see __setup_irq())
-	 */
-	do {
-		ret = hwspin_trylock_raw(chip_data->host_data->hwlock);
-		if (!ret)
-			return 0;
-
-		udelay(HWSPNLCK_RETRY_DELAY);
-		timeout += HWSPNLCK_RETRY_DELAY;
-	} while (timeout < HWSPNLCK_TIMEOUT);
-
-	if (ret == -EBUSY)
-		ret = -ETIMEDOUT;
-
-	if (ret)
-		pr_err("%s can't get hwspinlock (%d)\n", __func__, ret);
-
-	return ret;
-}
-
-static void stm32_exti_hwspin_unlock(struct stm32_exti_chip_data *chip_data)
-{
-	if (chip_data->host_data->hwlock)
-		hwspin_unlock_raw(chip_data->host_data->hwlock);
-}
-
 static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
 	u32 rtsr, ftsr;
 	int err;
 
 	irq_gc_lock(gc);
 
-	err = stm32_exti_hwspin_lock(chip_data);
-	if (err)
-		goto unlock;
+	if (hwlock) {
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		if (err) {
+			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
+			goto unlock;
+		}
+	}
 
 	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
 	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
@@ -338,7 +322,8 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
 unspinlock:
-	stm32_exti_hwspin_unlock(chip_data);
+	if (hwlock)
+		hwspin_unlock_in_atomic(hwlock);
 unlock:
 	irq_gc_unlock(gc);
 
@@ -504,15 +489,20 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 {
 	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
 	void __iomem *base = chip_data->host_data->base;
 	u32 rtsr, ftsr;
 	int err;
 
 	raw_spin_lock(&chip_data->rlock);
 
-	err = stm32_exti_hwspin_lock(chip_data);
-	if (err)
-		goto unlock;
+	if (hwlock) {
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		if (err) {
+			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
+			goto unlock;
+		}
+	}
 
 	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
 	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
@@ -525,7 +515,8 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
 
 unspinlock:
-	stm32_exti_hwspin_unlock(chip_data);
+	if (hwlock)
+		hwspin_unlock_in_atomic(hwlock);
 unlock:
 	raw_spin_unlock(&chip_data->rlock);
 
@@ -628,30 +619,47 @@ static struct irq_chip stm32_exti_h_chip = {
 	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
 };
 
+static struct irq_chip stm32_exti_h_chip_direct = {
+	.name			= "stm32-exti-h-direct",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= stm32_exti_h_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
+};
+
 static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 				     unsigned int virq,
 				     unsigned int nr_irqs, void *data)
 {
 	struct stm32_exti_host_data *host_data = dm->host_data;
 	struct stm32_exti_chip_data *chip_data;
+	const struct stm32_desc_irq *desc;
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
-	int p_irq, bank;
+	int bank;
 
 	hwirq = fwspec->param[0];
 	bank  = hwirq / IRQS_PER_BANK;
 	chip_data = &host_data->chips_data[bank];
 
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq,
-				      &stm32_exti_h_chip, chip_data);
 
-	p_irq = stm32_exti_to_irq(host_data->drv_data, hwirq);
-	if (p_irq >= 0) {
+	desc = stm32_exti_get_desc(host_data->drv_data, hwirq);
+	if (!desc)
+		return -EINVAL;
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, desc->chip,
+				      chip_data);
+	if (desc->irq_parent) {
 		p_fwspec.fwnode = dm->parent->fwnode;
 		p_fwspec.param_count = 3;
 		p_fwspec.param[0] = GIC_SPI;
-		p_fwspec.param[1] = p_irq;
+		p_fwspec.param[1] = desc->irq_parent;
 		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
 
 		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 7e3ebf6ed2cd..ea00d2e78ac3 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -433,8 +433,6 @@ static int ti_sci_inta_set_type(struct irq_data *data, unsigned int type)
 	default:
 		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static struct irq_chip ti_sci_inta_irq_chip = {
@@ -572,7 +570,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	inta->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(inta->base))
-		return -ENODEV;
+		return PTR_ERR(inta->base);
 
 	domain = irq_domain_add_linear(dev_of_node(dev),
 				       ti_sci_get_num_resources(inta->vint),
@@ -612,6 +610,6 @@ static struct platform_driver ti_sci_inta_irq_domain_driver = {
 };
 module_platform_driver(ti_sci_inta_irq_domain_driver);
 
-MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
+MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
 MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 3c87d925f74c..bc235db8a4c5 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -27,7 +27,10 @@
 
 #define VIC_IRQ_STATUS			0x00
 #define VIC_FIQ_STATUS			0x04
+#define VIC_RAW_STATUS			0x08
 #define VIC_INT_SELECT			0x0c	/* 1 = FIQ, 0 = IRQ */
+#define VIC_INT_ENABLE			0x10	/* 1 = enable, 0 = disable */
+#define VIC_INT_ENABLE_CLEAR		0x14
 #define VIC_INT_SOFT			0x18
 #define VIC_INT_SOFT_CLEAR		0x1c
 #define VIC_PROTECT			0x20
@@ -428,7 +431,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	vic_register(base, 0, irq_start, vic_sources, 0, node);
 }
 
-void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
+static void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
 			      u32 vic_sources, u32 resume_sources,
 			      struct device_node *node)
 {
@@ -481,27 +484,6 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 	__vic_init(base, 0, irq_start, vic_sources, resume_sources, NULL);
 }
 
-/**
- * vic_init_cascaded() - initialise a cascaded vectored interrupt controller
- * @base: iomem base address
- * @parent_irq: the parent IRQ we're cascaded off
- * @vic_sources: bitmask of interrupt sources to allow
- * @resume_sources: bitmask of interrupt sources to allow for resume
- *
- * This returns the base for the new interrupts or negative on error.
- */
-int __init vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
-			      u32 vic_sources, u32 resume_sources)
-{
-	struct vic_device *v;
-
-	v = &vic_devices[vic_id];
-	__vic_init(base, parent_irq, 0, vic_sources, resume_sources, NULL);
-	/* Return out acquired base */
-	return v->irq;
-}
-EXPORT_SYMBOL_GPL(vic_init_cascaded);
-
 #ifdef CONFIG_OF
 static int __init vic_of_init(struct device_node *node,
 			      struct device_node *parent)
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 2b35e68bea82..1bb0e36c2bf3 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -10,8 +10,10 @@
 
 #include <linux/acpi.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
+#include <linux/platform_device.h>
 
 /*
  * This special of_device_id is the sentinel at the end of the
@@ -29,3 +31,30 @@ void __init irqchip_init(void)
 	of_irq_init(__irqchip_of_table);
 	acpi_probe_device_table(irqchip);
 }
+
+int platform_irqchip_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *par_np = of_irq_find_parent(np);
+	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
+
+	if (!irq_init_cb)
+		return -EINVAL;
+
+	if (par_np == np)
+		par_np = NULL;
+
+	/*
+	 * If there's a parent interrupt controller and  none of the parent irq
+	 * domains have been registered, that means the parent interrupt
+	 * controller has not been initialized yet.  it's not time for this
+	 * interrupt controller to initialize. So, defer probe of this
+	 * interrupt controller. The actual initialization callback of this
+	 * interrupt controller can check for specific domains as necessary.
+	 */
+	if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
+		return -EPROBE_DEFER;
+
+	return irq_init_cb(np, par_np);
+}
+EXPORT_SYMBOL_GPL(platform_irqchip_probe);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 6ae9e1f0819d..c1c5dfad57cc 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,9 +11,11 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -430,4 +432,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
-IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
+IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
+IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d661cd0ee64d..1cda2d32e4c4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1143,16 +1143,27 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
-#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn)	\
+#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
+				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-		__used __section(__##table##_acpi_probe_table)		\
-		 = {							\
+		__used __section(__##table##_acpi_probe_table) = {	\
 			.id = table_id,					\
 			.type = subtable,				\
 			.subtable_valid = valid,			\
-			.probe_table = (acpi_tbl_table_handler)fn,	\
-			.driver_data = data, 				\
-		   }
+			.probe_table = fn,				\
+			.driver_data = data,				\
+		}
+
+#define ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(table, name, table_id,	\
+					  subtable, valid, data, fn)	\
+	static const struct acpi_probe_entry __acpi_probe_##name	\
+		__used __section(__##table##_acpi_probe_table) = {	\
+			.id = table_id,					\
+			.type = subtable,				\
+			.subtable_valid = valid,			\
+			.probe_subtbl = fn,				\
+			.driver_data = data,				\
+		}
 
 #define ACPI_PROBE_TABLE(name)		__##name##_acpi_probe_table
 #define ACPI_PROBE_TABLE_END(name)	__##name##_acpi_probe_table_end
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 950e4b2458f0..67351aac65ef 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -12,7 +12,9 @@
 #define _LINUX_IRQCHIP_H
 
 #include <linux/acpi.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 
 /*
  * This macro must be used by the different irqchip drivers to declare
@@ -26,6 +28,28 @@
  */
 #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
 
+extern int platform_irqchip_probe(struct platform_device *pdev);
+
+#define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
+static const struct of_device_id drv_name##_irqchip_match_table[] = {
+
+#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+	{},								\
+};									\
+MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
+static struct platform_driver drv_name##_driver = {		\
+	.probe  = platform_irqchip_probe,				\
+	.driver = {							\
+		.name = #drv_name,					\
+		.owner = THIS_MODULE,					\
+		.of_match_table = drv_name##_irqchip_match_table,	\
+		.suppress_bind_attrs = true,				\
+	},								\
+};									\
+builtin_platform_driver(drv_name##_driver)
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their version and their initialization function.
@@ -39,8 +63,9 @@
  * @fn: initialization function
  */
 #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
-	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
-				 subtable, validate, data, fn)
+	ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(irqchip, name,		\
+					  ACPI_SIG_MADT, subtable,	\
+					  validate, data, fn)
 
 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 6c36b6cc3edf..f6d092fdb93d 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -19,7 +19,6 @@
 #define GICD_CLRSPI_NSR			0x0048
 #define GICD_SETSPI_SR			0x0050
 #define GICD_CLRSPI_SR			0x0058
-#define GICD_SEIR			0x0068
 #define GICD_IGROUPR			0x0080
 #define GICD_ISENABLER			0x0100
 #define GICD_ICENABLER			0x0180
@@ -119,14 +118,11 @@
 #define GICR_WAKER			0x0014
 #define GICR_SETLPIR			0x0040
 #define GICR_CLRLPIR			0x0048
-#define GICR_SEIR			GICD_SEIR
 #define GICR_PROPBASER			0x0070
 #define GICR_PENDBASER			0x0078
 #define GICR_INVLPIR			0x00A0
 #define GICR_INVALLR			0x00B0
 #define GICR_SYNCR			0x00C0
-#define GICR_MOVLPIR			0x0100
-#define GICR_MOVALLR			0x0110
 #define GICR_IDREGS			GICD_IDREGS
 #define GICR_PIDR2			GICD_PIDR2
 
diff --git a/include/linux/irqchip/arm-vic.h b/include/linux/irqchip/arm-vic.h
index a158b97242c7..f2b11d1df23d 100644
--- a/include/linux/irqchip/arm-vic.h
+++ b/include/linux/irqchip/arm-vic.h
@@ -9,17 +9,6 @@
 
 #include <linux/types.h>
 
-#define VIC_RAW_STATUS			0x08
-#define VIC_INT_ENABLE			0x10	/* 1 = enable, 0 = disable */
-#define VIC_INT_ENABLE_CLEAR		0x14
-
-struct device_node;
-struct pt_regs;
-
-void __vic_init(void __iomem *base, int parent_irq, int irq_start,
-		u32 vic_sources, u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
-int vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
-		      u32 vic_sources, u32 resume_sources);
 
 #endif
diff --git a/include/linux/irqchip/irq-bcm2836.h b/include/linux/irqchip/irq-bcm2836.h
index f224d6f9e550..ac5719d8f56b 100644
--- a/include/linux/irqchip/irq-bcm2836.h
+++ b/include/linux/irqchip/irq-bcm2836.h
@@ -30,7 +30,7 @@
  */
 #define LOCAL_MAILBOX_INT_CONTROL0	0x050
 /*
- * The CPU's interrupt status register.  Bits are defined by the the
+ * The CPU's interrupt status register.  Bits are defined by the
  * LOCAL_IRQ_* bits below.
  */
 #define LOCAL_IRQ_PENDING0		0x060
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 8f2820c5e69e..5745491303e0 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -22,7 +22,6 @@ struct pt_regs;
  * @irq_common_data:	per irq and chip data passed down to chip functions
  * @kstat_irqs:		irq stats per cpu
  * @handle_irq:		highlevel irq-events handler
- * @preflow_handler:	handler called before the flow handler (currently used by sparc)
  * @action:		the irq action chain
  * @status_use_accessors: status information
  * @core_internal_state__do_not_mess_with_it: core internal status information
@@ -58,9 +57,6 @@ struct irq_desc {
 	struct irq_data		irq_data;
 	unsigned int __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-	irq_preflow_handler_t	preflow_handler;
-#endif
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
 	unsigned int		core_internal_state__do_not_mess_with_it;
@@ -268,15 +264,4 @@ irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 	}
 }
 
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-static inline void
-__irq_set_preflow_handler(unsigned int irq, irq_preflow_handler_t handler)
-{
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	desc->preflow_handler = handler;
-}
-#endif
-
 #endif
diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index 1e6f4e7123d6..c30f454a9518 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -10,6 +10,5 @@
 struct irq_desc;
 struct irq_data;
 typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
-typedef	void (*irq_preflow_handler_t)(struct irq_data *data);
 
 #endif
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 20512252ecc9..10a5aff4eecc 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -51,10 +51,6 @@ config GENERIC_IRQ_INJECTION
 config HARDIRQS_SW_RESEND
        bool
 
-# Preflow handler support for fasteoi (sparc64)
-config IRQ_PREFLOW_FASTEOI
-       bool
-
 # Edge style eoi based handler (cell)
 config IRQ_EDGE_EOI_HANDLER
        bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 41e7e37a0928..857f5f4c8098 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -656,16 +656,6 @@ void handle_level_irq(struct irq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);
 
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-static inline void preflow_handler(struct irq_desc *desc)
-{
-	if (desc->preflow_handler)
-		desc->preflow_handler(&desc->irq_data);
-}
-#else
-static inline void preflow_handler(struct irq_desc *desc) { }
-#endif
-
 static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 {
 	if (!(desc->istate & IRQS_ONESHOT)) {
@@ -721,7 +711,6 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
@@ -1231,7 +1220,6 @@ void handle_fasteoi_ack_irq(struct irq_desc *desc)
 	/* Start handling the irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
@@ -1281,7 +1269,6 @@ void handle_fasteoi_mask_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
@@ -1478,6 +1465,7 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_chip_retrigger_hierarchy);
 
 /**
  * irq_chip_set_vcpu_affinity_parent - Set vcpu affinity on the parent interrupt
@@ -1492,7 +1480,7 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
 
 	return -ENOSYS;
 }
-
+EXPORT_SYMBOL_GPL(irq_chip_set_vcpu_affinity_parent);
 /**
  * irq_chip_set_wake_parent - Set/reset wake-up on the parent interrupt
  * @data:	Pointer to interrupt specific data
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a4c2c915511d..76cd7ebd1178 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -142,7 +142,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 	if (!domain)
 		return NULL;
 
-	if (fwnode && is_fwnode_irqchip(fwnode)) {
+	if (is_fwnode_irqchip(fwnode)) {
 		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
 
 		switch (fwid->type) {
@@ -281,6 +281,7 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
 
 	mutex_unlock(&irq_domain_mutex);
 }
+EXPORT_SYMBOL_GPL(irq_domain_update_bus_token);
 
 /**
  * irq_domain_add_simple() - Register an irq_domain and optionally map a range of irqs

