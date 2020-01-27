Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC41DC33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC8824686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgA1AGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:06:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47607 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgA1AGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:06:44 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwEOm-00033x-1R; Tue, 28 Jan 2020 01:06:33 +0100
Date:   Mon, 27 Jan 2020 23:49:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
Message-ID: <158016896589.31887.14545084921211172429.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-01-28

up to:  43ee74487bd2: Merge tag 'irqchip-5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core


The interrupt departement provides:

 - A mechanism to shield isolated tasks from managed interrupts:

   The affinity of managed interrupts is completely controlled by the
   kernel and user space has no influence on them. The reason is that
   the automatically assigned affinity correlates to the multi-queue
   CPU handling of block devices.

   If the generated affinity mask spaws both housekeeping and isolated CPUs
   the interrupt could be routed to an isolated CPU which would then be
   disturbed by I/O submitted by a housekeeping CPU.

   The new mechamism ensures that as long as one housekeeping CPU is online
   in the assigned affinity mask the interrupt is routed to a housekeeping
   CPU.

   If there is no online housekeeping CPU in the affinity mask, then the
   interrupt is routed to an isolated CPU to keep the device queue intact,
   but unless the isolated CPU submits I/O by itself these interrupts are
   not raised.

 - A small addon to the device tree irqdomain core code to avoid
   duplication in irq chip drivers

 - Conversion of the SiFive PLIC to hierarchical domains

 - The usual pile of new irq chip drivers: SiFive GPIO, Aspeed SCI, NXP
   INTMUX, Meson A1 GPIO

 - The first cut of support for the new ARM GICv4.1

 - The usual pile of fixes and improvements in core and driver code

Thanks,

	tglx

------------------>
Eddie James (2):
      dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
      irqchip: Add Aspeed SCU interrupt controller

Hyunki Koo (1):
      irqchip: Define EXYNOS_IRQ_COMBINER

Joakim Zhang (2):
      dt-bindings: interrupt-controller: Add binding for NXP INTMUX interrupt multiplexer
      irqchip: Add NXP INTMUX interrupt multiplexer support

John Garry (1):
      irqchip/mbigen: Set driver .suppress_bind_attrs to avoid remove problems

Jules Irenge (2):
      genirq: Add missing __releases() sparse annotation
      genirq: Add missing __must_hold() sparse annotation

Kevin Hao (1):
      irqdomain: Fix a memory leak in irq_domain_push_irq()

Luca Ceresoli (1):
      genirq: Show irq name in non-oneshot error message

Marc Zyngier (14):
      irqchip/gic-v3-its: Fix get_vlpi_map() breakage with doorbells
      irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
      irqchip/gic-v3: Add GICv4.1 VPEID size discovery
      irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation
      irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP
      irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is set
      irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP
      irqchip/gic-v4.1: Plumb skeletal VPE irqchip
      irqchip/gic-v4.1: Add mask/unmask doorbell callbacks
      irqchip/gic-v4.1: Add VPE residency callback
      irqchip/gic-v4.1: Add VPE eviction callback
      irqchip/gic-v4.1: Add VPE INVALL callback
      irqchip/gic-v4.1: Suppress per-VLPI doorbell
      irqchip/gic-v4.1: Allow direct invalidation of VLPIs

Ming Lei (1):
      genirq, sched/isolation: Isolate from handling managed interrupts

Qianggui Song (3):
      dt-bindings: interrupt-controller: New binding for Meson-A1 SoCs
      irqchip/meson-gpio: Rework meson irqchip driver to support meson-A1 SoCs
      irqchip/meson-gpio: Add support for meson a1 SoCs

Yash Shah (5):
      genirq: Introduce irq_domain_translate_onecell
      irqchip/nvic: Use irq_domain_translate_onecell instead of custom func
      irqchip/sifive-plic: Support irq domain hierarchy
      gpio/sifive: Add DT documentation for SiFive GPIO
      gpio/sifive: Add GPIO driver for SiFive SoCs


 Documentation/admin-guide/kernel-parameters.txt    |  26 +-
 .../devicetree/bindings/gpio/sifive,gpio.yaml      |  68 ++
 .../amlogic,meson-gpio-intc.txt                    |   1 +
 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt |  23 +
 .../bindings/interrupt-controller/fsl,intmux.yaml  |  68 ++
 MAINTAINERS                                        |   8 +
 arch/arm/include/asm/arch_gicv3.h                  |   2 +
 arch/arm/mach-exynos/Kconfig                       |   1 +
 arch/arm64/include/asm/arch_gicv3.h                |   1 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sifive.c                         | 252 ++++++++
 drivers/irqchip/Kconfig                            |  14 +
 drivers/irqchip/Makefile                           |   5 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                | 239 +++++++
 drivers/irqchip/irq-gic-v3-its.c                   | 698 +++++++++++++++++++--
 drivers/irqchip/irq-gic-v3.c                       |  24 +-
 drivers/irqchip/irq-imx-intmux.c                   | 309 +++++++++
 drivers/irqchip/irq-mbigen.c                       |   1 +
 drivers/irqchip/irq-meson-gpio.c                   | 137 +++-
 drivers/irqchip/irq-nvic.c                         |  15 +-
 drivers/irqchip/irq-sifive-plic.c                  |  30 +-
 .../interrupt-controller/aspeed-scu-ic.h           |  23 +
 include/linux/irqchip/arm-gic-v3.h                 |  59 +-
 include/linux/irqchip/arm-gic-v4.h                 |  23 +-
 include/linux/irqdomain.h                          |   5 +
 include/linux/sched/isolation.h                    |   1 +
 kernel/irq/cpuhotplug.c                            |  21 +-
 kernel/irq/irqdesc.c                               |   1 +
 kernel/irq/irqdomain.c                             |  18 +
 kernel/irq/manage.c                                |  45 +-
 kernel/irq/spurious.c                              |   1 +
 kernel/sched/isolation.c                           |   6 +
 33 files changed, 2024 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
 create mode 100644 drivers/gpio/gpio-sifive.c
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 drivers/irqchip/irq-imx-intmux.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..765e4274ba71 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1933,9 +1933,31 @@
 			  <cpu number> begins at 0 and the maximum value is
 			  "number of CPUs in system - 1".
 
-			The format of <cpu-list> is described above.
-
+			managed_irq
+
+			  Isolate from being targeted by managed interrupts
+			  which have an interrupt mask containing isolated
+			  CPUs. The affinity of managed interrupts is
+			  handled by the kernel and cannot be changed via
+			  the /proc/irq/* interfaces.
+
+			  This isolation is best effort and only effective
+			  if the automatically assigned interrupt mask of a
+			  device queue contains isolated and housekeeping
+			  CPUs. If housekeeping CPUs are online then such
+			  interrupts are directed to the housekeeping CPU
+			  so that IO submitted on the housekeeping CPU
+			  cannot disturb the isolated CPU.
+
+			  If a queue's affinity mask contains only isolated
+			  CPUs then this parameter has no effect on the
+			  interrupt routing decision, though interrupts are
+			  only delivered when tasks running on those
+			  isolated CPUs submit IO. IO submitted on
+			  housekeeping CPUs has no influence on those
+			  queues.
 
+			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]
 
diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
new file mode 100644
index 000000000000..418e8381e07c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sifive,gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive GPIO controller
+
+maintainers:
+  - Yash Shah <yash.shah@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-gpio
+      - const: sifive,gpio0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt mapping one per GPIO. Maximum 16 GPIOs.
+    minItems: 1
+    maxItems: 16
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - clocks
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/sifive-fu540-prci.h>
+      gpio@10060000 {
+        compatible = "sifive,fu540-c000-gpio", "sifive,gpio0";
+        interrupt-parent = <&plic>;
+        interrupts = <7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22>;
+        reg = <0x0 0x10060000 0x0 0x1000>;
+        clocks = <&tlclk PRCI_CLK_TLCLK>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+      };
+
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 684bb1cd75ec..23b18b92c558 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -17,6 +17,7 @@ Required properties:
     "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
     "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
+    "amlogic,meson-a1-gpio-intc" for A1 SoCs (A113L)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
new file mode 100644
index 000000000000..251ed44171db
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
@@ -0,0 +1,23 @@
+Aspeed AST25XX and AST26XX SCU Interrupt Controller
+
+Required Properties:
+ - #interrupt-cells		: must be 1
+ - compatible			: must be "aspeed,ast2500-scu-ic",
+				  "aspeed,ast2600-scu-ic0" or
+				  "aspeed,ast2600-scu-ic1"
+ - interrupts			: interrupt from the parent controller
+ - interrupt-controller		: indicates that the controller receives and
+				  fires new interrupts for child busses
+
+Example:
+
+    syscon@1e6e2000 {
+        ranges = <0 0x1e6e2000 0x1a8>;
+
+        scu_ic: interrupt-controller@18 {
+            #interrupt-cells = <1>;
+            compatible = "aspeed,ast2500-scu-ic";
+            interrupts = <21>;
+            interrupt-controller;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
new file mode 100644
index 000000000000..43c6effbb5bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale INTMUX interrupt multiplexer
+
+maintainers:
+  - Joakim Zhang <qiangqing.zhang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx-intmux
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+    description: |
+      Should contain the parent interrupt lines (up to 8) used to multiplex
+      the input interrupts.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      The 1st cell is hw interrupt number, the 2nd cell is channel index.
+
+  clocks:
+    description: ipg clock.
+
+  clock-names:
+    const: ipg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@37400000 {
+        compatible = "fsl,imx-intmux";
+        reg = <0x37400000 0x1000>;
+        interrupts = <0 16 4>,
+                     <0 17 4>,
+                     <0 18 4>,
+                     <0 19 4>,
+                     <0 20 4>,
+                     <0 21 4>,
+                     <0 22 4>,
+                     <0 23 4>;
+        interrupt-controller;
+        interrupt-parent = <&gic>;
+        #interrupt-cells = <2>;
+        clocks = <&clk>;
+        clock-names = "ipg";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..4535780c81e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2694,6 +2694,14 @@ S:	Maintained
 F:	drivers/pinctrl/aspeed/
 F:	Documentation/devicetree/bindings/pinctrl/aspeed,*
 
+ASPEED SCU INTERRUPT CONTROLLER DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+F:	drivers/irqchip/irq-aspeed-scu-ic.c
+F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org
diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index fa50bb04f580..b5752f0e8936 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -327,6 +328,7 @@ static inline u64 __gic_readq_nonatomic(const volatile void __iomem *addr)
 /*
  * GITS_VPROPBASER - hi and lo bits may be accessed independently.
  */
+#define gits_read_vpropbaser(c)		__gic_readq_nonatomic(c)
 #define gits_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
 
 /*
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4ef56571145b..6e7f10c8098a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -12,6 +12,7 @@ menuconfig ARCH_EXYNOS
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
+	select EXYNOS_IRQ_COMBINER
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_ASV
 	select EXYNOS_CHIPID
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 89e4c8b79349..4750fc8030c3 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -141,6 +141,7 @@ static inline u32 gic_read_rpr(void)
 #define gicr_read_pendbaser(c)		readq_relaxed(c)
 
 #define gits_write_vpropbaser(v, c)	writeq_relaxed(v, c)
+#define gits_read_vpropbaser(c)		readq_relaxed(c)
 
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 6ab25fe1c423..809dd54a2e82 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -479,6 +479,15 @@ config GPIO_SAMA5D2_PIOBU
 	  The difference from regular GPIOs is that they
 	  maintain their value during backup/self-refresh.
 
+config GPIO_SIFIVE
+	bool "SiFive GPIO support"
+	depends on OF_GPIO && IRQ_DOMAIN_HIERARCHY
+	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
+	select REGMAP_MMIO
+	help
+	  Say yes here to support the GPIO device on SiFive SoCs.
+
 config GPIO_SIOX
 	tristate "SIOX GPIO support"
 	depends on SIOX
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 34eb8b2b12dd..11eeeebbde0d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_ARCH_SA1100)		+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+= gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
 obj-$(CONFIG_GPIO_SCH)			+= gpio-sch.o
+obj-$(CONFIG_GPIO_SIFIVE)		+= gpio-sifive.o
 obj-$(CONFIG_GPIO_SIOX)			+= gpio-siox.o
 obj-$(CONFIG_GPIO_SODAVILLE)		+= gpio-sodaville.o
 obj-$(CONFIG_GPIO_SPEAR_SPICS)		+= gpio-spear-spics.o
diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
new file mode 100644
index 000000000000..147a1bd04515
--- /dev/null
+++ b/drivers/gpio/gpio-sifive.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 SiFive
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/of_irq.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/regmap.h>
+
+#define SIFIVE_GPIO_INPUT_VAL	0x00
+#define SIFIVE_GPIO_INPUT_EN	0x04
+#define SIFIVE_GPIO_OUTPUT_EN	0x08
+#define SIFIVE_GPIO_OUTPUT_VAL	0x0C
+#define SIFIVE_GPIO_RISE_IE	0x18
+#define SIFIVE_GPIO_RISE_IP	0x1C
+#define SIFIVE_GPIO_FALL_IE	0x20
+#define SIFIVE_GPIO_FALL_IP	0x24
+#define SIFIVE_GPIO_HIGH_IE	0x28
+#define SIFIVE_GPIO_HIGH_IP	0x2C
+#define SIFIVE_GPIO_LOW_IE	0x30
+#define SIFIVE_GPIO_LOW_IP	0x34
+#define SIFIVE_GPIO_OUTPUT_XOR	0x40
+
+#define SIFIVE_GPIO_MAX		32
+#define SIFIVE_GPIO_IRQ_OFFSET	7
+
+struct sifive_gpio {
+	void __iomem		*base;
+	struct gpio_chip	gc;
+	struct regmap		*regs;
+	u32			irq_state;
+	unsigned int		trigger[SIFIVE_GPIO_MAX];
+	unsigned int		irq_parent[SIFIVE_GPIO_MAX];
+};
+
+static void sifive_gpio_set_ie(struct sifive_gpio *chip, unsigned int offset)
+{
+	unsigned long flags;
+	unsigned int trigger;
+
+	spin_lock_irqsave(&chip->gc.bgpio_lock, flags);
+	trigger = (chip->irq_state & BIT(offset)) ? chip->trigger[offset] : 0;
+	regmap_update_bits(chip->regs, SIFIVE_GPIO_RISE_IE, BIT(offset),
+			   (trigger & IRQ_TYPE_EDGE_RISING) ? BIT(offset) : 0);
+	regmap_update_bits(chip->regs, SIFIVE_GPIO_FALL_IE, BIT(offset),
+			   (trigger & IRQ_TYPE_EDGE_FALLING) ? BIT(offset) : 0);
+	regmap_update_bits(chip->regs, SIFIVE_GPIO_HIGH_IE, BIT(offset),
+			   (trigger & IRQ_TYPE_LEVEL_HIGH) ? BIT(offset) : 0);
+	regmap_update_bits(chip->regs, SIFIVE_GPIO_LOW_IE, BIT(offset),
+			   (trigger & IRQ_TYPE_LEVEL_LOW) ? BIT(offset) : 0);
+	spin_unlock_irqrestore(&chip->gc.bgpio_lock, flags);
+}
+
+static int sifive_gpio_irq_set_type(struct irq_data *d, unsigned int trigger)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct sifive_gpio *chip = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(d);
+
+	if (offset < 0 || offset >= gc->ngpio)
+		return -EINVAL;
+
+	chip->trigger[offset] = trigger;
+	sifive_gpio_set_ie(chip, offset);
+	return 0;
+}
+
+static void sifive_gpio_irq_enable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct sifive_gpio *chip = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(d) % SIFIVE_GPIO_MAX;
+	u32 bit = BIT(offset);
+	unsigned long flags;
+
+	irq_chip_enable_parent(d);
+
+	/* Switch to input */
+	gc->direction_input(gc, offset);
+
+	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	/* Clear any sticky pending interrupts */
+	regmap_write(chip->regs, SIFIVE_GPIO_RISE_IP, bit);
+	regmap_write(chip->regs, SIFIVE_GPIO_FALL_IP, bit);
+	regmap_write(chip->regs, SIFIVE_GPIO_HIGH_IP, bit);
+	regmap_write(chip->regs, SIFIVE_GPIO_LOW_IP, bit);
+	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+
+	/* Enable interrupts */
+	assign_bit(offset, (unsigned long *)&chip->irq_state, 1);
+	sifive_gpio_set_ie(chip, offset);
+}
+
+static void sifive_gpio_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct sifive_gpio *chip = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(d) % SIFIVE_GPIO_MAX;
+
+	assign_bit(offset, (unsigned long *)&chip->irq_state, 0);
+	sifive_gpio_set_ie(chip, offset);
+	irq_chip_disable_parent(d);
+}
+
+static void sifive_gpio_irq_eoi(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct sifive_gpio *chip = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(d) % SIFIVE_GPIO_MAX;
+	u32 bit = BIT(offset);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	/* Clear all pending interrupts */
+	regmap_write(chip->regs, SIFIVE_GPIO_RISE_IP, bit);
+	regmap_write(chip->regs, SIFIVE_GPIO_FALL_IP, bit);
+	regmap_write(chip->regs, SIFIVE_GPIO_HIGH_IP, bit);
+	regmap_write(chip->regs, SIFIVE_GPIO_LOW_IP, bit);
+	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+
+	irq_chip_eoi_parent(d);
+}
+
+static struct irq_chip sifive_gpio_irqchip = {
+	.name		= "sifive-gpio",
+	.irq_set_type	= sifive_gpio_irq_set_type,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_enable	= sifive_gpio_irq_enable,
+	.irq_disable	= sifive_gpio_irq_disable,
+	.irq_eoi	= sifive_gpio_irq_eoi,
+};
+
+static int sifive_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
+					     unsigned int child,
+					     unsigned int child_type,
+					     unsigned int *parent,
+					     unsigned int *parent_type)
+{
+	*parent_type = IRQ_TYPE_NONE;
+	*parent = child + SIFIVE_GPIO_IRQ_OFFSET;
+	return 0;
+}
+
+static const struct regmap_config sifive_gpio_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.disable_locking = true,
+};
+
+static int sifive_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *irq_parent;
+	struct irq_domain *parent;
+	struct gpio_irq_chip *girq;
+	struct sifive_gpio *chip;
+	int ret, ngpio;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(chip->base)) {
+		dev_err(dev, "failed to allocate device memory\n");
+		return PTR_ERR(chip->base);
+	}
+
+	chip->regs = devm_regmap_init_mmio(dev, chip->base,
+					   &sifive_gpio_regmap_config);
+	if (IS_ERR(chip->regs))
+		return PTR_ERR(chip->regs);
+
+	ngpio = of_irq_count(node);
+	if (ngpio >= SIFIVE_GPIO_MAX) {
+		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
+			SIFIVE_GPIO_MAX);
+		return -ENXIO;
+	}
+
+	irq_parent = of_irq_find_parent(node);
+	if (!irq_parent) {
+		dev_err(dev, "no IRQ parent node\n");
+		return -ENODEV;
+	}
+	parent = irq_find_host(irq_parent);
+	if (!parent) {
+		dev_err(dev, "no IRQ parent domain\n");
+		return -ENODEV;
+	}
+
+	ret = bgpio_init(&chip->gc, dev, 4,
+			 chip->base + SIFIVE_GPIO_INPUT_VAL,
+			 chip->base + SIFIVE_GPIO_OUTPUT_VAL,
+			 NULL,
+			 chip->base + SIFIVE_GPIO_OUTPUT_EN,
+			 chip->base + SIFIVE_GPIO_INPUT_EN,
+			 0);
+	if (ret) {
+		dev_err(dev, "unable to init generic GPIO\n");
+		return ret;
+	}
+
+	/* Disable all GPIO interrupts before enabling parent interrupts */
+	regmap_write(chip->regs, SIFIVE_GPIO_RISE_IE, 0);
+	regmap_write(chip->regs, SIFIVE_GPIO_FALL_IE, 0);
+	regmap_write(chip->regs, SIFIVE_GPIO_HIGH_IE, 0);
+	regmap_write(chip->regs, SIFIVE_GPIO_LOW_IE, 0);
+	chip->irq_state = 0;
+
+	chip->gc.base = -1;
+	chip->gc.ngpio = ngpio;
+	chip->gc.label = dev_name(dev);
+	chip->gc.parent = dev;
+	chip->gc.owner = THIS_MODULE;
+	girq = &chip->gc.irq;
+	girq->chip = &sifive_gpio_irqchip;
+	girq->fwnode = of_node_to_fwnode(node);
+	girq->parent_domain = parent;
+	girq->child_to_parent_hwirq = sifive_gpio_child_to_parent_hwirq;
+	girq->handler = handle_bad_irq;
+	girq->default_type = IRQ_TYPE_NONE;
+
+	platform_set_drvdata(pdev, chip);
+	return gpiochip_add_data(&chip->gc, chip);
+}
+
+static const struct of_device_id sifive_gpio_match[] = {
+	{ .compatible = "sifive,gpio0" },
+	{ .compatible = "sifive,fu540-c000-gpio" },
+	{ },
+};
+
+static struct platform_driver sifive_gpio_driver = {
+	.probe		= sifive_gpio_probe,
+	.driver = {
+		.name	= "sifive_gpio",
+		.of_match_table = of_match_ptr(sifive_gpio_match),
+	},
+};
+builtin_platform_driver(sifive_gpio_driver)
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 697e6a8ccaae..1006c694d9fb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -457,6 +457,12 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config IMX_INTMUX
+	def_bool y if ARCH_MXC
+	select IRQ_DOMAIN
+	help
+	  Support for the i.MX INTMUX interrupt multiplexer.
+
 config LS1X_IRQ
 	bool "Loongson-1 Interrupt Controller"
 	depends on MACH_LOONGSON32
@@ -490,6 +496,7 @@ config TI_SCI_INTA_IRQCHIP
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
 	help
 	   This enables support for the PLIC chip found in SiFive (and
 	   potentially other) RISC-V systems.  The PLIC controls devices
@@ -499,4 +506,11 @@ config SIFIVE_PLIC
 
 	   If you don't know what to do here, say Y.
 
+config EXYNOS_IRQ_COMBINER
+	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
+	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
+	help
+	  Say yes here to add support for the IRQ combiner devices embedded
+	  in Samsung Exynos chips.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..eae0d78cbf22 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
-obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
@@ -87,7 +87,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
-obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
+obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
@@ -100,6 +100,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
+obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
new file mode 100644
index 000000000000..c90a3346b985
--- /dev/null
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
+ * Copyright 2019 IBM Corporation
+ *
+ * Eddie James <eajames@linux.ibm.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+
+#define ASPEED_SCU_IC_REG		0x018
+#define ASPEED_SCU_IC_SHIFT		0
+#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
+#define ASPEED_SCU_IC_NUM_IRQS		7
+#define ASPEED_SCU_IC_STATUS_SHIFT	16
+
+#define ASPEED_AST2600_SCU_IC0_REG	0x560
+#define ASPEED_AST2600_SCU_IC0_SHIFT	0
+#define ASPEED_AST2600_SCU_IC0_ENABLE	\
+	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
+#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
+
+#define ASPEED_AST2600_SCU_IC1_REG	0x570
+#define ASPEED_AST2600_SCU_IC1_SHIFT	4
+#define ASPEED_AST2600_SCU_IC1_ENABLE	\
+	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
+#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
+
+struct aspeed_scu_ic {
+	unsigned long irq_enable;
+	unsigned long irq_shift;
+	unsigned int num_irqs;
+	unsigned int reg;
+	struct regmap *scu;
+	struct irq_domain *irq_domain;
+};
+
+static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
+{
+	unsigned int irq;
+	unsigned int sts;
+	unsigned long bit;
+	unsigned long enabled;
+	unsigned long max;
+	unsigned long status;
+	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+
+	chained_irq_enter(chip, desc);
+
+	/*
+	 * The SCU IC has just one register to control its operation and read
+	 * status. The interrupt enable bits occupy the lower 16 bits of the
+	 * register, while the interrupt status bits occupy the upper 16 bits.
+	 * The status bit for a given interrupt is always 16 bits shifted from
+	 * the enable bit for the same interrupt.
+	 * Therefore, perform the IRQ operations in the enable bit space by
+	 * shifting the status down to get the mapping and then back up to
+	 * clear the bit.
+	 */
+	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
+	enabled = sts & scu_ic->irq_enable;
+	status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
+
+	bit = scu_ic->irq_shift;
+	max = scu_ic->num_irqs + bit;
+
+	for_each_set_bit_from(bit, &status, max) {
+		irq = irq_find_mapping(scu_ic->irq_domain,
+				       bit - scu_ic->irq_shift);
+		generic_handle_irq(irq);
+
+		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
+				   BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_scu_ic_irq_mask(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
+	unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
+		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+
+	/*
+	 * Status bits are cleared by writing 1. In order to prevent the mask
+	 * operation from clearing the status bits, they should be under the
+	 * mask and written with 0.
+	 */
+	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+}
+
+static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
+	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
+	unsigned int mask = bit |
+		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+
+	/*
+	 * Status bits are cleared by writing 1. In order to prevent the unmask
+	 * operation from clearing the status bits, they should be under the
+	 * mask and written with 0.
+	 */
+	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+}
+
+static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
+					  const struct cpumask *dest,
+					  bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip aspeed_scu_ic_chip = {
+	.name			= "aspeed-scu-ic",
+	.irq_mask		= aspeed_scu_ic_irq_mask,
+	.irq_unmask		= aspeed_scu_ic_irq_unmask,
+	.irq_set_affinity	= aspeed_scu_ic_irq_set_affinity,
+};
+
+static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_scu_ic_domain_ops = {
+	.map = aspeed_scu_ic_map,
+};
+
+static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
+					struct device_node *node)
+{
+	int irq;
+	int rc = 0;
+
+	if (!node->parent) {
+		rc = -ENODEV;
+		goto err;
+	}
+
+	scu_ic->scu = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(scu_ic->scu)) {
+		rc = PTR_ERR(scu_ic->scu);
+		goto err;
+	}
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq < 0) {
+		rc = irq;
+		goto err;
+	}
+
+	scu_ic->irq_domain = irq_domain_add_linear(node, scu_ic->num_irqs,
+						   &aspeed_scu_ic_domain_ops,
+						   scu_ic);
+	if (!scu_ic->irq_domain) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
+					 scu_ic);
+
+	return 0;
+
+err:
+	kfree(scu_ic);
+
+	return rc;
+}
+
+static int __init aspeed_scu_ic_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_SCU_IC_ENABLE;
+	scu_ic->irq_shift = ASPEED_SCU_IC_SHIFT;
+	scu_ic->num_irqs = ASPEED_SCU_IC_NUM_IRQS;
+	scu_ic->reg = ASPEED_SCU_IC_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+static int __init aspeed_ast2600_scu_ic0_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC0_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC0_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC0_NUM_IRQS;
+	scu_ic->reg = ASPEED_AST2600_SCU_IC0_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC1_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC1_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC1_NUM_IRQS;
+	scu_ic->reg = ASPEED_AST2600_SCU_IC1_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
+		aspeed_ast2600_scu_ic0_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
+		aspeed_ast2600_scu_ic1_of_init);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e05673bcd52b..f71758632f8d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -106,6 +106,7 @@ struct its_node {
 	u64			typer;
 	u64			cbaser_save;
 	u32			ctlr_save;
+	u32			mpidr;
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
@@ -116,12 +117,22 @@ struct its_node {
 };
 
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
+#define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
 #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
 
 #define ITS_ITT_ALIGN		SZ_256
 
 /* The maximum number of VPEID bits supported by VLPI commands */
-#define ITS_MAX_VPEID_BITS	(16)
+#define ITS_MAX_VPEID_BITS						\
+	({								\
+		int nvpeid = 16;					\
+		if (gic_rdists->has_rvpeid &&				\
+		    gic_rdists->gicd_typer2 & GICD_TYPER2_VIL)		\
+			nvpeid = 1 + (gic_rdists->gicd_typer2 &		\
+				      GICD_TYPER2_VID);			\
+									\
+		nvpeid;							\
+	})
 #define ITS_MAX_VPEID		(1 << (ITS_MAX_VPEID_BITS))
 
 /* Convert page order to size in bytes */
@@ -216,11 +227,27 @@ static struct its_vlpi_map *dev_event_to_vlpi_map(struct its_device *its_dev,
 	return &its_dev->event_map.vlpi_maps[event];
 }
 
-static struct its_collection *irq_to_col(struct irq_data *d)
+static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
+{
+	if (irqd_is_forwarded_to_vcpu(d)) {
+		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+		u32 event = its_get_event_id(d);
+
+		return dev_event_to_vlpi_map(its_dev, event);
+	}
+
+	return NULL;
+}
+
+static int irq_to_cpuid(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_vlpi_map *map = get_vlpi_map(d);
 
-	return dev_event_to_col(its_dev, its_get_event_id(d));
+	if (map)
+		return map->vpe->col_idx;
+
+	return its_dev->event_map.col_map[its_get_event_id(d)];
 }
 
 static struct its_collection *valid_col(struct its_collection *col)
@@ -322,6 +349,10 @@ struct its_cmd_desc {
 			u16 seq_num;
 			u16 its_list;
 		} its_vmovp_cmd;
+
+		struct {
+			struct its_vpe *vpe;
+		} its_invdb_cmd;
 	};
 };
 
@@ -438,6 +469,38 @@ static void its_encode_vpt_size(struct its_cmd_block *cmd, u8 vpt_size)
 	its_mask_encode(&cmd->raw_cmd[3], vpt_size, 4, 0);
 }
 
+static void its_encode_vconf_addr(struct its_cmd_block *cmd, u64 vconf_pa)
+{
+	its_mask_encode(&cmd->raw_cmd[0], vconf_pa >> 16, 51, 16);
+}
+
+static void its_encode_alloc(struct its_cmd_block *cmd, bool alloc)
+{
+	its_mask_encode(&cmd->raw_cmd[0], alloc, 8, 8);
+}
+
+static void its_encode_ptz(struct its_cmd_block *cmd, bool ptz)
+{
+	its_mask_encode(&cmd->raw_cmd[0], ptz, 9, 9);
+}
+
+static void its_encode_vmapp_default_db(struct its_cmd_block *cmd,
+					u32 vpe_db_lpi)
+{
+	its_mask_encode(&cmd->raw_cmd[1], vpe_db_lpi, 31, 0);
+}
+
+static void its_encode_vmovp_default_db(struct its_cmd_block *cmd,
+					u32 vpe_db_lpi)
+{
+	its_mask_encode(&cmd->raw_cmd[3], vpe_db_lpi, 31, 0);
+}
+
+static void its_encode_db(struct its_cmd_block *cmd, bool db)
+{
+	its_mask_encode(&cmd->raw_cmd[2], db, 63, 63);
+}
+
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
@@ -621,19 +684,45 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 					   struct its_cmd_block *cmd,
 					   struct its_cmd_desc *desc)
 {
-	unsigned long vpt_addr;
+	unsigned long vpt_addr, vconf_addr;
 	u64 target;
-
-	vpt_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
-	target = desc->its_vmapp_cmd.col->target_address + its->vlpi_redist_offset;
+	bool alloc;
 
 	its_encode_cmd(cmd, GITS_CMD_VMAPP);
 	its_encode_vpeid(cmd, desc->its_vmapp_cmd.vpe->vpe_id);
 	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
+
+	if (!desc->its_vmapp_cmd.valid) {
+		if (is_v4_1(its)) {
+			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
+			its_encode_alloc(cmd, alloc);
+		}
+
+		goto out;
+	}
+
+	vpt_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
+	target = desc->its_vmapp_cmd.col->target_address + its->vlpi_redist_offset;
+
 	its_encode_target(cmd, target);
 	its_encode_vpt_addr(cmd, vpt_addr);
 	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
 
+	if (!is_v4_1(its))
+		goto out;
+
+	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
+
+	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
+
+	its_encode_alloc(cmd, alloc);
+
+	/* We can only signal PTZ when alloc==1. Why do we have two bits? */
+	its_encode_ptz(cmd, alloc);
+	its_encode_vconf_addr(cmd, vconf_addr);
+	its_encode_vmapp_default_db(cmd, desc->its_vmapp_cmd.vpe->vpe_db_lpi);
+
+out:
 	its_fixup_cmd(cmd);
 
 	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
@@ -645,7 +734,7 @@ static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmapti_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmapti_cmd.db_enabled)
 		db = desc->its_vmapti_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -668,7 +757,7 @@ static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmovi_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmovi_cmd.db_enabled)
 		db = desc->its_vmovi_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -698,6 +787,11 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 	its_encode_vpeid(cmd, desc->its_vmovp_cmd.vpe->vpe_id);
 	its_encode_target(cmd, target);
 
+	if (is_v4_1(its)) {
+		its_encode_db(cmd, true);
+		its_encode_vmovp_default_db(cmd, desc->its_vmovp_cmd.vpe->vpe_db_lpi);
+	}
+
 	its_fixup_cmd(cmd);
 
 	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
@@ -757,6 +851,21 @@ static struct its_vpe *its_build_vclear_cmd(struct its_node *its,
 	return valid_vpe(its, map->vpe);
 }
 
+static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
+					   struct its_cmd_block *cmd,
+					   struct its_cmd_desc *desc)
+{
+	if (WARN_ON(!is_v4_1(its)))
+		return NULL;
+
+	its_encode_cmd(cmd, GITS_CMD_INVDB);
+	its_encode_vpeid(cmd, desc->its_invdb_cmd.vpe->vpe_id);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, desc->its_invdb_cmd.vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -1165,20 +1274,17 @@ static void its_send_vclear(struct its_device *dev, u32 event_id)
 	its_send_single_vcommand(dev->its, its_build_vclear_cmd, &desc);
 }
 
-/*
- * irqchip functions - assumes MSI, mostly.
- */
-static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
+static void its_send_invdb(struct its_node *its, struct its_vpe *vpe)
 {
-	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	u32 event = its_get_event_id(d);
-
-	if (!irqd_is_forwarded_to_vcpu(d))
-		return NULL;
+	struct its_cmd_desc desc;
 
-	return dev_event_to_vlpi_map(its_dev, event);
+	desc.its_invdb_cmd.vpe = vpe;
+	its_send_single_vcommand(its, its_build_invdb_cmd, &desc);
 }
 
+/*
+ * irqchip functions - assumes MSI, mostly.
+ */
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
 	struct its_vlpi_map *map = get_vlpi_map(d);
@@ -1221,13 +1327,25 @@ static void wait_for_syncr(void __iomem *rdbase)
 
 static void direct_lpi_inv(struct irq_data *d)
 {
-	struct its_collection *col;
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	void __iomem *rdbase;
+	u64 val;
+
+	if (map) {
+		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+
+		WARN_ON(!is_v4_1(its_dev->its));
+
+		val  = GICR_INVLPIR_V;
+		val |= FIELD_PREP(GICR_INVLPIR_VPEID, map->vpe->vpe_id);
+		val |= FIELD_PREP(GICR_INVLPIR_INTID, map->vintid);
+	} else {
+		val = d->hwirq;
+	}
 
 	/* Target the redistributor this LPI is currently routed to */
-	col = irq_to_col(d);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, col->col_id)->rd_base;
-	gic_write_lpir(d->hwirq, rdbase + GICR_INVLPIR);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, irq_to_cpuid(d))->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
 
 	wait_for_syncr(rdbase);
 }
@@ -1237,7 +1355,8 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
 	lpi_write_config(d, clr, set);
-	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
+	if (gic_rdists->has_direct_lpi &&
+	    (is_v4_1(its_dev->its) || !irqd_is_forwarded_to_vcpu(d)))
 		direct_lpi_inv(d);
 	else if (!irqd_is_forwarded_to_vcpu(d))
 		its_send_inv(its_dev, its_get_event_id(d));
@@ -1251,6 +1370,13 @@ static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
 	u32 event = its_get_event_id(d);
 	struct its_vlpi_map *map;
 
+	/*
+	 * GICv4.1 does away with the per-LPI nonsense, nothing to do
+	 * here.
+	 */
+	if (is_v4_1(its_dev->its))
+		return;
+
 	map = dev_event_to_vlpi_map(its_dev, event);
 
 	if (map->db_enabled == enable)
@@ -2090,6 +2216,65 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	return indirect;
 }
 
+static u32 compute_common_aff(u64 val)
+{
+	u32 aff, clpiaff;
+
+	aff = FIELD_GET(GICR_TYPER_AFFINITY, val);
+	clpiaff = FIELD_GET(GICR_TYPER_COMMON_LPI_AFF, val);
+
+	return aff & ~(GENMASK(31, 0) >> (clpiaff * 8));
+}
+
+static u32 compute_its_aff(struct its_node *its)
+{
+	u64 val;
+	u32 svpet;
+
+	/*
+	 * Reencode the ITS SVPET and MPIDR as a GICR_TYPER, and compute
+	 * the resulting affinity. We then use that to see if this match
+	 * our own affinity.
+	 */
+	svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
+	val  = FIELD_PREP(GICR_TYPER_COMMON_LPI_AFF, svpet);
+	val |= FIELD_PREP(GICR_TYPER_AFFINITY, its->mpidr);
+	return compute_common_aff(val);
+}
+
+static struct its_node *find_sibling_its(struct its_node *cur_its)
+{
+	struct its_node *its;
+	u32 aff;
+
+	if (!FIELD_GET(GITS_TYPER_SVPET, cur_its->typer))
+		return NULL;
+
+	aff = compute_its_aff(cur_its);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		u64 baser;
+
+		if (!is_v4_1(its) || its == cur_its)
+			continue;
+
+		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
+			continue;
+
+		if (aff != compute_its_aff(its))
+			continue;
+
+		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
+		baser = its->tables[2].val;
+		if (!(baser & GITS_BASER_VALID))
+			continue;
+
+		return its;
+	}
+
+	return NULL;
+}
+
 static void its_free_tables(struct its_node *its)
 {
 	int i;
@@ -2132,6 +2317,17 @@ static int its_alloc_tables(struct its_node *its)
 			break;
 
 		case GITS_BASER_TYPE_VCPU:
+			if (is_v4_1(its)) {
+				struct its_node *sibling;
+
+				WARN_ON(i != 2);
+				if ((sibling = find_sibling_its(its))) {
+					*baser = sibling->tables[2];
+					its_write_baser(its, baser, baser->val);
+					continue;
+				}
+			}
+
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
 							    ITS_MAX_VPEID_BITS);
@@ -2153,6 +2349,220 @@ static int its_alloc_tables(struct its_node *its)
 	return 0;
 }
 
+static u64 inherit_vpe_l1_table_from_its(void)
+{
+	struct its_node *its;
+	u64 val;
+	u32 aff;
+
+	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+	aff = compute_common_aff(val);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		u64 baser, addr;
+
+		if (!is_v4_1(its))
+			continue;
+
+		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
+			continue;
+
+		if (aff != compute_its_aff(its))
+			continue;
+
+		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
+		baser = its->tables[2].val;
+		if (!(baser & GITS_BASER_VALID))
+			continue;
+
+		/* We have a winner! */
+		val  = GICR_VPROPBASER_4_1_VALID;
+		if (baser & GITS_BASER_INDIRECT)
+			val |= GICR_VPROPBASER_4_1_INDIRECT;
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE,
+				  FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser));
+		switch (FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser)) {
+		case GIC_PAGE_SIZE_64K:
+			addr = GITS_BASER_ADDR_48_to_52(baser);
+			break;
+		default:
+			addr = baser & GENMASK_ULL(47, 12);
+			break;
+		}
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, addr >> 12);
+		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
+				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
+		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
+				  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
+
+		return val;
+	}
+
+	return 0;
+}
+
+static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
+{
+	u32 aff;
+	u64 val;
+	int cpu;
+
+	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+	aff = compute_common_aff(val);
+
+	for_each_possible_cpu(cpu) {
+		void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
+		u32 tmp;
+
+		if (!base || cpu == smp_processor_id())
+			continue;
+
+		val = gic_read_typer(base + GICR_TYPER);
+		tmp = compute_common_aff(val);
+		if (tmp != aff)
+			continue;
+
+		/*
+		 * At this point, we have a victim. This particular CPU
+		 * has already booted, and has an affinity that matches
+		 * ours wrt CommonLPIAff. Let's use its own VPROPBASER.
+		 * Make sure we don't write the Z bit in that case.
+		 */
+		val = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+		val &= ~GICR_VPROPBASER_4_1_Z;
+
+		*mask = gic_data_rdist_cpu(cpu)->vpe_table_mask;
+
+		return val;
+	}
+
+	return 0;
+}
+
+static int allocate_vpe_l1_table(void)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val, gpsz, npg, pa;
+	unsigned int psz = SZ_64K;
+	unsigned int np, epp, esz;
+	struct page *page;
+
+	if (!gic_rdists->has_rvpeid)
+		return 0;
+
+	/*
+	 * if VPENDBASER.Valid is set, disable any previously programmed
+	 * VPE by setting PendingLast while clearing Valid. This has the
+	 * effect of making sure no doorbell will be generated and we can
+	 * then safely clear VPROPBASER.Valid.
+	 */
+	if (gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
+		gits_write_vpendbaser(GICR_VPENDBASER_PendingLast,
+				      vlpi_base + GICR_VPENDBASER);
+
+	/*
+	 * If we can inherit the configuration from another RD, let's do
+	 * so. Otherwise, we have to go through the allocation process. We
+	 * assume that all RDs have the exact same requirements, as
+	 * nothing will work otherwise.
+	 */
+	val = inherit_vpe_l1_table_from_rd(&gic_data_rdist()->vpe_table_mask);
+	if (val & GICR_VPROPBASER_4_1_VALID)
+		goto out;
+
+	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_KERNEL);
+	if (!gic_data_rdist()->vpe_table_mask)
+		return -ENOMEM;
+
+	val = inherit_vpe_l1_table_from_its();
+	if (val & GICR_VPROPBASER_4_1_VALID)
+		goto out;
+
+	/* First probe the page size */
+	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
+	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	val = gits_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
+	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
+	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
+
+	switch (gpsz) {
+	default:
+		gpsz = GIC_PAGE_SIZE_4K;
+		/* fall through */
+	case GIC_PAGE_SIZE_4K:
+		psz = SZ_4K;
+		break;
+	case GIC_PAGE_SIZE_16K:
+		psz = SZ_16K;
+		break;
+	case GIC_PAGE_SIZE_64K:
+		psz = SZ_64K;
+		break;
+	}
+
+	/*
+	 * Start populating the register from scratch, including RO fields
+	 * (which we want to print in debug cases...)
+	 */
+	val = 0;
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, gpsz);
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ENTRY_SIZE, esz);
+
+	/* How many entries per GIC page? */
+	esz++;
+	epp = psz / (esz * SZ_8);
+
+	/*
+	 * If we need more than just a single L1 page, flag the table
+	 * as indirect and compute the number of required L1 pages.
+	 */
+	if (epp < ITS_MAX_VPEID) {
+		int nl2;
+
+		val |= GICR_VPROPBASER_4_1_INDIRECT;
+
+		/* Number of L2 pages required to cover the VPEID space */
+		nl2 = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
+
+		/* Number of L1 pages to point to the L2 pages */
+		npg = DIV_ROUND_UP(nl2 * SZ_8, psz);
+	} else {
+		npg = 1;
+	}
+
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg);
+
+	/* Right, that's the number of CPU pages we need for L1 */
+	np = DIV_ROUND_UP(npg * psz, PAGE_SIZE);
+
+	pr_debug("np = %d, npg = %lld, psz = %d, epp = %d, esz = %d\n",
+		 np, npg, psz, epp, esz);
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(np * PAGE_SIZE));
+	if (!page)
+		return -ENOMEM;
+
+	gic_data_rdist()->vpe_l1_page = page;
+	pa = virt_to_phys(page_address(page));
+	WARN_ON(!IS_ALIGNED(pa, psz));
+
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, pa >> 12);
+	val |= GICR_VPROPBASER_RaWb;
+	val |= GICR_VPROPBASER_InnerShareable;
+	val |= GICR_VPROPBASER_4_1_Z;
+	val |= GICR_VPROPBASER_4_1_VALID;
+
+out:
+	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	cpumask_set_cpu(smp_processor_id(), gic_data_rdist()->vpe_table_mask);
+
+	pr_debug("CPU%d: VPROPBASER = %llx %*pbl\n",
+		 smp_processor_id(), val,
+		 cpumask_pr_args(gic_data_rdist()->vpe_table_mask));
+
+	return 0;
+}
+
 static int its_alloc_collections(struct its_node *its)
 {
 	int i;
@@ -2244,7 +2654,7 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
-static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 {
 	u32 count = 1000000;	/* 1s! */
 	bool clean;
@@ -2252,6 +2662,8 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 
 	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 	val &= ~GICR_VPENDBASER_Valid;
+	val &= ~clr;
+	val |= set;
 	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 
 	do {
@@ -2264,6 +2676,11 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 		}
 	} while (!clean && count);
 
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
+		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
+		val |= GICR_VPENDBASER_PendingLast;
+	}
+
 	return val;
 }
 
@@ -2352,7 +2769,7 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
-	if (gic_rdists->has_vlpis) {
+	if (gic_rdists->has_vlpis && !gic_rdists->has_rvpeid) {
 		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 
 		/*
@@ -2372,10 +2789,20 @@ static void its_cpu_init_lpis(void)
 		 * ancient programming gets left in and has possibility of
 		 * corrupting memory.
 		 */
-		val = its_clear_vpend_valid(vlpi_base);
+		val = its_clear_vpend_valid(vlpi_base, 0, 0);
 		WARN_ON(val & GICR_VPENDBASER_Dirty);
 	}
 
+	if (allocate_vpe_l1_table()) {
+		/*
+		 * If the allocation has failed, we're in massive trouble.
+		 * Disable direct injection, and pray that no VM was
+		 * already running...
+		 */
+		gic_rdists->has_rvpeid = false;
+		gic_rdists->has_vlpis = false;
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
@@ -2859,7 +3286,7 @@ static const struct irq_domain_ops its_domain_ops = {
 /*
  * This is insane.
  *
- * If a GICv4 doesn't implement Direct LPIs (which is extremely
+ * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
  * likely), the only way to perform an invalidate is to use a fake
  * device to issue an INV command, implying that the LPI has first
  * been mapped to some event on that device. Since this is not exactly
@@ -2867,9 +3294,20 @@ static const struct irq_domain_ops its_domain_ops = {
  * only issue an UNMAP if we're short on available slots.
  *
  * Broken by design(tm).
+ *
+ * GICv4.1, on the other hand, mandates that we're able to invalidate
+ * by writing to a MMIO register. It doesn't implement the whole of
+ * DirectLPI, but that's good enough. And most of the time, we don't
+ * even have to invalidate anything, as the redistributor can be told
+ * whether to generate a doorbell or not (we thus leave it enabled,
+ * always).
  */
 static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already unmapped? */
 	if (vpe->vpe_proxy_event == -1)
 		return;
@@ -2892,6 +3330,10 @@ static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (!gic_rdists->has_direct_lpi) {
 		unsigned long flags;
 
@@ -2903,6 +3345,10 @@ static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_map_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already mapped? */
 	if (vpe->vpe_proxy_event != -1)
 		return;
@@ -2925,6 +3371,10 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 	unsigned long flags;
 	struct its_collection *target_col;
 
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (gic_rdists->has_direct_lpi) {
 		void __iomem *rdbase;
 
@@ -2951,7 +3401,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int cpu = cpumask_first(mask_val);
+	int from, cpu = cpumask_first(mask_val);
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -2959,14 +3409,24 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * into the proxy device, we need to move the doorbell
 	 * interrupt to its new location.
 	 */
-	if (vpe->col_idx != cpu) {
-		int from = vpe->col_idx;
+	if (vpe->col_idx == cpu)
+		goto out;
 
-		vpe->col_idx = cpu;
-		its_send_vmovp(vpe);
-		its_vpe_db_proxy_move(vpe, from, cpu);
-	}
+	from = vpe->col_idx;
+	vpe->col_idx = cpu;
 
+	/*
+	 * GICv4.1 allows us to skip VMOVP if moving to a cpu whose RD
+	 * is sharing its VPE table with the current one.
+	 */
+	if (gic_data_rdist_cpu(cpu)->vpe_table_mask &&
+	    cpumask_test_cpu(from, gic_data_rdist_cpu(cpu)->vpe_table_mask))
+		goto out;
+
+	its_send_vmovp(vpe);
+	its_vpe_db_proxy_move(vpe, from, cpu);
+
+out:
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK_DONE;
@@ -3009,16 +3469,10 @@ static void its_vpe_deschedule(struct its_vpe *vpe)
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 	u64 val;
 
-	val = its_clear_vpend_valid(vlpi_base);
+	val = its_clear_vpend_valid(vlpi_base, 0, 0);
 
-	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
-		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
-		vpe->idai = false;
-		vpe->pending_last = true;
-	} else {
-		vpe->idai = !!(val & GICR_VPENDBASER_IDAI);
-		vpe->pending_last = !!(val & GICR_VPENDBASER_PendingLast);
-	}
+	vpe->idai = !!(val & GICR_VPENDBASER_IDAI);
+	vpe->pending_last = !!(val & GICR_VPENDBASER_PendingLast);
 }
 
 static void its_vpe_invall(struct its_vpe *vpe)
@@ -3151,6 +3605,139 @@ static struct irq_chip its_vpe_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
 };
 
+static struct its_node *find_4_1_its(void)
+{
+	static struct its_node *its = NULL;
+
+	if (!its) {
+		list_for_each_entry(its, &its_nodes, entry) {
+			if (is_v4_1(its))
+				return its;
+		}
+
+		/* Oops? */
+		its = NULL;
+	}
+
+	return its;
+}
+
+static void its_vpe_4_1_send_inv(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_node *its;
+
+	/*
+	 * GICv4.1 wants doorbells to be invalidated using the
+	 * INVDB command in order to be broadcast to all RDs. Send
+	 * it to the first valid ITS, and let the HW do its magic.
+	 */
+	its = find_4_1_its();
+	if (its)
+		its_send_invdb(its, vpe);
+}
+
+static void its_vpe_4_1_mask_irq(struct irq_data *d)
+{
+	lpi_write_config(d->parent_data, LPI_PROP_ENABLED, 0);
+	its_vpe_4_1_send_inv(d);
+}
+
+static void its_vpe_4_1_unmask_irq(struct irq_data *d)
+{
+	lpi_write_config(d->parent_data, 0, LPI_PROP_ENABLED);
+	its_vpe_4_1_send_inv(d);
+}
+
+static void its_vpe_4_1_schedule(struct its_vpe *vpe,
+				 struct its_cmd_info *info)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val = 0;
+
+	/* Schedule the VPE */
+	val |= GICR_VPENDBASER_Valid;
+	val |= info->g0en ? GICR_VPENDBASER_4_1_VGRP0EN : 0;
+	val |= info->g1en ? GICR_VPENDBASER_4_1_VGRP1EN : 0;
+	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
+
+	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+}
+
+static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
+				   struct its_cmd_info *info)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val;
+
+	if (info->req_db) {
+		/*
+		 * vPE is going to block: make the vPE non-resident with
+		 * PendingLast clear and DB set. The GIC guarantees that if
+		 * we read-back PendingLast clear, then a doorbell will be
+		 * delivered when an interrupt comes.
+		 */
+		val = its_clear_vpend_valid(vlpi_base,
+					    GICR_VPENDBASER_PendingLast,
+					    GICR_VPENDBASER_4_1_DB);
+		vpe->pending_last = !!(val & GICR_VPENDBASER_PendingLast);
+	} else {
+		/*
+		 * We're not blocking, so just make the vPE non-resident
+		 * with PendingLast set, indicating that we'll be back.
+		 */
+		val = its_clear_vpend_valid(vlpi_base,
+					    0,
+					    GICR_VPENDBASER_PendingLast);
+		vpe->pending_last = true;
+	}
+}
+
+static void its_vpe_4_1_invall(struct its_vpe *vpe)
+{
+	void __iomem *rdbase;
+	u64 val;
+
+	val  = GICR_INVALLR_V;
+	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
+
+	/* Target the redistributor this vPE is currently known on */
+	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVALLR);
+}
+
+static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_cmd_info *info = vcpu_info;
+
+	switch (info->cmd_type) {
+	case SCHEDULE_VPE:
+		its_vpe_4_1_schedule(vpe, info);
+		return 0;
+
+	case DESCHEDULE_VPE:
+		its_vpe_4_1_deschedule(vpe, info);
+		return 0;
+
+	case INVALL_VPE:
+		its_vpe_4_1_invall(vpe);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct irq_chip its_vpe_4_1_irq_chip = {
+	.name			= "GICv4.1-vpe",
+	.irq_mask		= its_vpe_4_1_mask_irq,
+	.irq_unmask		= its_vpe_4_1_unmask_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= its_vpe_set_affinity,
+	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
+};
+
 static int its_vpe_id_alloc(void)
 {
 	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
@@ -3186,7 +3773,10 @@ static int its_vpe_init(struct its_vpe *vpe)
 
 	vpe->vpe_id = vpe_id;
 	vpe->vpt_page = vpt_page;
-	vpe->vpe_proxy_event = -1;
+	if (gic_rdists->has_rvpeid)
+		atomic_set(&vpe->vmapp_count, 0);
+	else
+		vpe->vpe_proxy_event = -1;
 
 	return 0;
 }
@@ -3228,6 +3818,7 @@ static void its_vpe_irq_domain_free(struct irq_domain *domain,
 static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				    unsigned int nr_irqs, void *args)
 {
+	struct irq_chip *irqchip = &its_vpe_irq_chip;
 	struct its_vm *vm = args;
 	unsigned long *bitmap;
 	struct page *vprop_page;
@@ -3255,6 +3846,9 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	vm->nr_db_lpis = nr_ids;
 	vm->vprop_page = vprop_page;
 
+	if (gic_rdists->has_rvpeid)
+		irqchip = &its_vpe_4_1_irq_chip;
+
 	for (i = 0; i < nr_irqs; i++) {
 		vm->vpes[i]->vpe_db_lpi = base + i;
 		err = its_vpe_init(vm->vpes[i]);
@@ -3265,7 +3859,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		if (err)
 			break;
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
-					      &its_vpe_irq_chip, vm->vpes[i]);
+					      irqchip, vm->vpes[i]);
 		set_bit(i, bitmap);
 	}
 
@@ -3778,6 +4372,14 @@ static int __init its_probe_one(struct resource *res,
 		} else {
 			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
 		}
+
+		if (is_v4_1(its)) {
+			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, typer);
+			its->mpidr = readl_relaxed(its_base + GITS_MPIDR);
+
+			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
+				&res->start, its->mpidr, svpet);
+		}
 	}
 
 	its->numa_node = numa_node;
@@ -4138,6 +4740,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	bool has_v4 = false;
 	int err;
 
+	gic_rdists = rdists;
+
 	its_parent = parent_domain;
 	of_node = to_of_node(handle);
 	if (of_node)
@@ -4150,8 +4754,6 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		return -ENXIO;
 	}
 
-	gic_rdists = rdists;
-
 	err = allocate_lpi_tables();
 	if (err)
 		return err;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d6218012097b..286f98222878 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -858,8 +858,21 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 					 void __iomem *ptr)
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
+
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
-	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
+
+	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
+	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
+	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
+					   gic_data.rdists.has_rvpeid);
+
+	/* Detect non-sensical configurations */
+	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
+		gic_data.rdists.has_direct_lpi = false;
+		gic_data.rdists.has_vlpis = false;
+		gic_data.rdists.has_rvpeid = false;
+	}
+
 	gic_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_data.ppi_nr);
 
 	return 1;
@@ -872,9 +885,10 @@ static void gic_update_rdist_properties(void)
 	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
 		gic_data.ppi_nr = 0;
 	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
-	pr_info("%sVLPI support, %sdirect LPI support\n",
+	pr_info("%sVLPI support, %sdirect LPI support, %sRVPEID support\n",
 		!gic_data.rdists.has_vlpis ? "no " : "",
-		!gic_data.rdists.has_direct_lpi ? "no " : "");
+		!gic_data.rdists.has_direct_lpi ? "no " : "",
+		!gic_data.rdists.has_rvpeid ? "no " : "");
 }
 
 /* Check whether it's single security state view */
@@ -1562,10 +1576,14 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
 	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
+
+	gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + GICD_TYPER2);
+
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
+	gic_data.rdists.has_rvpeid = true;
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
 
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
new file mode 100644
index 000000000000..c27577c81126
--- /dev/null
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2017 NXP
+
+/*                     INTMUX Block Diagram
+ *
+ *                               ________________
+ * interrupt source #  0  +---->|                |
+ *                        |     |                |
+ * interrupt source #  1  +++-->|                |
+ *            ...         | |   |   channel # 0  |--------->interrupt out # 0
+ *            ...         | |   |                |
+ *            ...         | |   |                |
+ * interrupt source # X-1 +++-->|________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                        | | | |                |
+ *                        | +-->|                |
+ *                        | | | |   channel # 1  |--------->interrupt out # 1
+ *                        | | +>|                |
+ *                        | | | |                |
+ *                        | | | |________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |       ...
+ *                        | | |       ...
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                          | | |                |
+ *                          +-->|                |
+ *                            | |   channel # N  |--------->interrupt out # N
+ *                            +>|                |
+ *                              |                |
+ *                              |________________|
+ *
+ *
+ * N: Interrupt Channel Instance Number (N=7)
+ * X: Interrupt Source Number for each channel (X=32)
+ *
+ * The INTMUX interrupt multiplexer has 8 channels, each channel receives 32
+ * interrupt sources and generates 1 interrupt output.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+
+#define CHANIER(n)	(0x10 + (0x40 * n))
+#define CHANIPR(n)	(0x20 + (0x40 * n))
+
+#define CHAN_MAX_NUM		0x8
+
+struct intmux_irqchip_data {
+	int			chanidx;
+	int			irq;
+	struct irq_domain	*domain;
+};
+
+struct intmux_data {
+	raw_spinlock_t			lock;
+	void __iomem			*regs;
+	struct clk			*ipg_clk;
+	int				channum;
+	struct intmux_irqchip_data	irqchip_data[];
+};
+
+static void imx_intmux_irq_mask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg = data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* disable the interrupt source of this channel */
+	val &= ~BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void imx_intmux_irq_unmask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg = data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* enable the interrupt source of this channel */
+	val |= BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static struct irq_chip imx_intmux_irq_chip = {
+	.name		= "intmux",
+	.irq_mask	= imx_intmux_irq_mask,
+	.irq_unmask	= imx_intmux_irq_unmask,
+};
+
+static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, h->host_data);
+	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static int imx_intmux_irq_xlate(struct irq_domain *d, struct device_node *node,
+				const u32 *intspec, unsigned int intsize,
+				unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct intmux_irqchip_data *irqchip_data = d->host_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+
+	/*
+	 * two cells needed in interrupt specifier:
+	 * the 1st cell: hw interrupt number
+	 * the 2nd cell: channel index
+	 */
+	if (WARN_ON(intsize != 2))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[1] >= data->channum))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
+static int imx_intmux_irq_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				 enum irq_domain_bus_token bus_token)
+{
+	struct intmux_irqchip_data *irqchip_data = d->host_data;
+
+	/* Not for us */
+	if (fwspec->fwnode != d->fwnode)
+		return false;
+
+	return irqchip_data->chanidx == fwspec->param[1];
+}
+
+static const struct irq_domain_ops imx_intmux_domain_ops = {
+	.map		= imx_intmux_irq_map,
+	.xlate		= imx_intmux_irq_xlate,
+	.select		= imx_intmux_irq_select,
+};
+
+static void imx_intmux_irq_handler(struct irq_desc *desc)
+{
+	struct intmux_irqchip_data *irqchip_data = irq_desc_get_handler_data(desc);
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long irqstat;
+	int pos, virq;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	/* read the interrupt source pending status of this channel */
+	irqstat = readl_relaxed(data->regs + CHANIPR(idx));
+
+	for_each_set_bit(pos, &irqstat, 32) {
+		virq = irq_find_mapping(irqchip_data->domain, pos);
+		if (virq)
+			generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int imx_intmux_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct irq_domain *domain;
+	struct intmux_data *data;
+	int channum;
+	int i, ret;
+
+	channum = platform_irq_count(pdev);
+	if (channum == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (channum > CHAN_MAX_NUM) {
+		dev_err(&pdev->dev, "supports up to %d multiplex channels\n",
+			CHAN_MAX_NUM);
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data) +
+			    channum * sizeof(data->irqchip_data[0]), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize reg\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(data->ipg_clk)) {
+		ret = PTR_ERR(data->ipg_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	data->channum = channum;
+	raw_spin_lock_init(&data->lock);
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < channum; i++) {
+		data->irqchip_data[i].chanidx = i;
+
+		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
+		if (data->irqchip_data[i].irq <= 0) {
+			ret = -EINVAL;
+			dev_err(&pdev->dev, "failed to get irq\n");
+			goto out;
+		}
+
+		domain = irq_domain_add_linear(np, 32, &imx_intmux_domain_ops,
+					       &data->irqchip_data[i]);
+		if (!domain) {
+			ret = -ENOMEM;
+			dev_err(&pdev->dev, "failed to create IRQ domain\n");
+			goto out;
+		}
+		data->irqchip_data[i].domain = domain;
+
+		/* disable all interrupt sources of this channel firstly */
+		writel_relaxed(0, data->regs + CHANIER(i));
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 imx_intmux_irq_handler,
+						 &data->irqchip_data[i]);
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+out:
+	clk_disable_unprepare(data->ipg_clk);
+	return ret;
+}
+
+static int imx_intmux_remove(struct platform_device *pdev)
+{
+	struct intmux_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < data->channum; i++) {
+		/* disable all interrupt sources of this channel */
+		writel_relaxed(0, data->regs + CHANIER(i));
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 NULL, NULL);
+
+		irq_domain_remove(data->irqchip_data[i].domain);
+	}
+
+	clk_disable_unprepare(data->ipg_clk);
+
+	return 0;
+}
+
+static const struct of_device_id imx_intmux_id[] = {
+	{ .compatible = "fsl,imx-intmux", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver imx_intmux_driver = {
+	.driver = {
+		.name = "imx-intmux",
+		.of_match_table = imx_intmux_id,
+	},
+	.probe = imx_intmux_probe,
+	.remove = imx_intmux_remove,
+};
+builtin_platform_driver(imx_intmux_driver);
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 3f09f658e8e2..6b566bba263b 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -374,6 +374,7 @@ static struct platform_driver mbigen_platform_driver = {
 		.name		= "Hisilicon MBIGEN-V2",
 		.of_match_table	= mbigen_of_match,
 		.acpi_match_table = ACPI_PTR(mbigen_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe			= mbigen_device_probe,
 };
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 829084b568fa..ccc7f823911b 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -24,50 +24,101 @@
 #define REG_PIN_47_SEL	0x08
 #define REG_FILTER_SEL	0x0c
 
+/* use for A1 like chips */
+#define REG_PIN_A1_SEL	0x04
+
 /*
  * Note: The S905X3 datasheet reports that BOTH_EDGE is controlled by
  * bits 24 to 31. Tests on the actual HW show that these bits are
  * stuck at 0. Bits 8 to 15 are responsive and have the expected
  * effect.
  */
-#define REG_EDGE_POL_EDGE(x)	BIT(x)
-#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
-#define REG_BOTH_EDGE(x)	BIT(8 + (x))
-#define REG_EDGE_POL_MASK(x)    (	\
-		REG_EDGE_POL_EDGE(x) |	\
-		REG_EDGE_POL_LOW(x)  |	\
-		REG_BOTH_EDGE(x))
+#define REG_EDGE_POL_EDGE(params, x)	BIT((params)->edge_single_offset + (x))
+#define REG_EDGE_POL_LOW(params, x)	BIT((params)->pol_low_offset + (x))
+#define REG_BOTH_EDGE(params, x)	BIT((params)->edge_both_offset + (x))
+#define REG_EDGE_POL_MASK(params, x)    (	\
+		REG_EDGE_POL_EDGE(params, x) |	\
+		REG_EDGE_POL_LOW(params, x)  |	\
+		REG_BOTH_EDGE(params, x))
 #define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
 #define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
 
+struct meson_gpio_irq_controller;
+static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				    unsigned int channel, unsigned long hwirq);
+static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl);
+static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				      unsigned int channel,
+				      unsigned long hwirq);
+static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl);
+
+struct irq_ctl_ops {
+	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
+				 unsigned int channel, unsigned long hwirq);
+	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
+};
+
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
 	bool support_edge_both;
+	unsigned int edge_both_offset;
+	unsigned int edge_single_offset;
+	unsigned int pol_low_offset;
+	unsigned int pin_sel_mask;
+	struct irq_ctl_ops ops;
 };
 
+#define INIT_MESON_COMMON(irqs, init, sel)			\
+	.nr_hwirq = irqs,					\
+	.ops = {						\
+		.gpio_irq_init = init,				\
+		.gpio_irq_sel_pin = sel,			\
+	},
+
+#define INIT_MESON8_COMMON_DATA(irqs)				\
+	INIT_MESON_COMMON(irqs, meson_gpio_irq_init_dummy,	\
+			  meson8_gpio_irq_sel_pin)		\
+	.edge_single_offset = 0,				\
+	.pol_low_offset = 16,					\
+	.pin_sel_mask = 0xff,					\
+
+#define INIT_MESON_A1_COMMON_DATA(irqs)				\
+	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
+			  meson_a1_gpio_irq_sel_pin)		\
+	.support_edge_both = true,				\
+	.edge_both_offset = 16,					\
+	.edge_single_offset = 8,				\
+	.pol_low_offset = 0,					\
+	.pin_sel_mask = 0x7f,					\
+
 static const struct meson_gpio_irq_params meson8_params = {
-	.nr_hwirq = 134,
+	INIT_MESON8_COMMON_DATA(134)
 };
 
 static const struct meson_gpio_irq_params meson8b_params = {
-	.nr_hwirq = 119,
+	INIT_MESON8_COMMON_DATA(119)
 };
 
 static const struct meson_gpio_irq_params gxbb_params = {
-	.nr_hwirq = 133,
+	INIT_MESON8_COMMON_DATA(133)
 };
 
 static const struct meson_gpio_irq_params gxl_params = {
-	.nr_hwirq = 110,
+	INIT_MESON8_COMMON_DATA(110)
 };
 
 static const struct meson_gpio_irq_params axg_params = {
-	.nr_hwirq = 100,
+	INIT_MESON8_COMMON_DATA(100)
 };
 
 static const struct meson_gpio_irq_params sm1_params = {
-	.nr_hwirq = 100,
+	INIT_MESON8_COMMON_DATA(100)
 	.support_edge_both = true,
+	.edge_both_offset = 8,
+};
+
+static const struct meson_gpio_irq_params a1_params = {
+	INIT_MESON_A1_COMMON_DATA(62)
 };
 
 static const struct of_device_id meson_irq_gpio_matches[] = {
@@ -78,6 +129,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
+	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
 	{ }
 };
 
@@ -100,9 +152,43 @@ static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
 	writel_relaxed(tmp, ctl->base + reg);
 }
 
-static unsigned int meson_gpio_irq_channel_to_reg(unsigned int channel)
+static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
+{
+}
+
+static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				    unsigned int channel, unsigned long hwirq)
+{
+	unsigned int reg_offset;
+	unsigned int bit_offset;
+
+	reg_offset = (channel < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
+	bit_offset = REG_PIN_SEL_SHIFT(channel);
+
+	meson_gpio_irq_update_bits(ctl, reg_offset,
+				   ctl->params->pin_sel_mask << bit_offset,
+				   hwirq << bit_offset);
+}
+
+static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				      unsigned int channel,
+				      unsigned long hwirq)
 {
-	return (channel < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
+	unsigned int reg_offset;
+	unsigned int bit_offset;
+
+	bit_offset = ((channel % 2) == 0) ? 0 : 16;
+	reg_offset = REG_PIN_A1_SEL + ((channel / 2) << 2);
+
+	meson_gpio_irq_update_bits(ctl, reg_offset,
+				   ctl->params->pin_sel_mask << bit_offset,
+				   hwirq << bit_offset);
+}
+
+/* For a1 or later chips like a1 there is a switch to enable/disable irq */
+static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl)
+{
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL, BIT(31), BIT(31));
 }
 
 static int
@@ -110,7 +196,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 			       unsigned long  hwirq,
 			       u32 **channel_hwirq)
 {
-	unsigned int reg, idx;
+	unsigned int idx;
 
 	spin_lock(&ctl->lock);
 
@@ -129,10 +215,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	 * Setup the mux of the channel to route the signal of the pad
 	 * to the appropriate input of the GIC
 	 */
-	reg = meson_gpio_irq_channel_to_reg(idx);
-	meson_gpio_irq_update_bits(ctl, reg,
-				   0xff << REG_PIN_SEL_SHIFT(idx),
-				   hwirq << REG_PIN_SEL_SHIFT(idx));
+	ctl->params->ops.gpio_irq_sel_pin(ctl, idx, hwirq);
 
 	/*
 	 * Get the hwirq number assigned to this channel through
@@ -173,7 +256,9 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 {
 	u32 val = 0;
 	unsigned int idx;
+	const struct meson_gpio_irq_params *params;
 
+	params = ctl->params;
 	idx = meson_gpio_irq_get_channel_idx(ctl, channel_hwirq);
 
 	/*
@@ -190,22 +275,22 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 	 * precedence over the other edge/polarity settings
 	 */
 	if (type == IRQ_TYPE_EDGE_BOTH) {
-		if (!ctl->params->support_edge_both)
+		if (!params->support_edge_both)
 			return -EINVAL;
 
-		val |= REG_BOTH_EDGE(idx);
+		val |= REG_BOTH_EDGE(params, idx);
 	} else {
 		if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
-			val |= REG_EDGE_POL_EDGE(idx);
+			val |= REG_EDGE_POL_EDGE(params, idx);
 
 		if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
-			val |= REG_EDGE_POL_LOW(idx);
+			val |= REG_EDGE_POL_LOW(params, idx);
 	}
 
 	spin_lock(&ctl->lock);
 
 	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
-				   REG_EDGE_POL_MASK(idx), val);
+				   REG_EDGE_POL_MASK(params, idx), val);
 
 	spin_unlock(&ctl->lock);
 
@@ -371,6 +456,8 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
 		return ret;
 	}
 
+	ctl->params->ops.gpio_irq_init(ctl);
+
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index a166d30deea2..f747e2209ea9 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -45,17 +45,6 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 	handle_IRQ(irq, regs);
 }
 
-static int nvic_irq_domain_translate(struct irq_domain *d,
-				     struct irq_fwspec *fwspec,
-				     unsigned long *hwirq, unsigned int *type)
-{
-	if (WARN_ON(fwspec->param_count < 1))
-		return -EINVAL;
-	*hwirq = fwspec->param[0];
-	*type = IRQ_TYPE_NONE;
-	return 0;
-}
-
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
@@ -64,7 +53,7 @@ static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type = IRQ_TYPE_NONE;
 	struct irq_fwspec *fwspec = arg;
 
-	ret = nvic_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -75,7 +64,7 @@ static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops nvic_irq_domain_ops = {
-	.translate = nvic_irq_domain_translate,
+	.translate = irq_domain_translate_onecell,
 	.alloc = nvic_irq_domain_alloc,
 	.free = irq_domain_free_irqs_top,
 };
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 0aca5807a119..aa4af886e43a 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -154,15 +154,37 @@ static struct irq_chip plic_chip = {
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &plic_chip, handle_fasteoi_irq);
-	irq_set_chip_data(irq, NULL);
+	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
+			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
 	return 0;
 }
 
+static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = plic_irqdomain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct irq_domain_ops plic_irqdomain_ops = {
-	.map		= plic_irqdomain_map,
-	.xlate		= irq_domain_xlate_onecell,
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= plic_irq_domain_alloc,
+	.free		= irq_domain_free_irqs_top,
 };
 
 static struct irq_domain *plic_irqdomain;
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
new file mode 100644
index 000000000000..f315d5a7f5ee
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+
+#define ASPEED_SCU_IC_VGA_CURSOR_CHANGE			0
+#define ASPEED_SCU_IC_VGA_SCRATCH_REG_CHANGE		1
+
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI	2
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_HI_TO_LO	3
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_LO_TO_HI	4
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_HI_TO_LO	5
+#define ASPEED_AST2500_SCU_IC_ISSUE_MSI			6
+
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI	2
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_HI_TO_LO	3
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_LO_TO_HI	4
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_HI_TO_LO	5
+
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
+
+#endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index de991d6633a5..f0b8ca766e7d 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -13,6 +13,7 @@
 #define GICD_CTLR			0x0000
 #define GICD_TYPER			0x0004
 #define GICD_IIDR			0x0008
+#define GICD_TYPER2			0x000C
 #define GICD_STATUSR			0x0010
 #define GICD_SETSPI_NSR			0x0040
 #define GICD_CLRSPI_NSR			0x0048
@@ -89,6 +90,9 @@
 #define GICD_TYPER_ESPIS(typer)						\
 	(((typer) & GICD_TYPER_ESPI) ? GICD_TYPER_SPIS((typer) >> 27) : 0)
 
+#define GICD_TYPER2_VIL			(1U << 7)
+#define GICD_TYPER2_VID			GENMASK(4, 0)
+
 #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
 #define GICD_IROUTER_SPI_MODE_ANY	(1U << 31)
 
@@ -98,6 +102,11 @@
 
 #define GIC_V3_DIST_SIZE		0x10000
 
+#define GIC_PAGE_SIZE_4K		0ULL
+#define GIC_PAGE_SIZE_16K		1ULL
+#define GIC_PAGE_SIZE_64K		2ULL
+#define GIC_PAGE_SIZE_MASK		3ULL
+
 /*
  * Re-Distributor registers, offsets from RD_base
  */
@@ -234,6 +243,16 @@
 #define GICR_TYPER_VLPIS		(1U << 1)
 #define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
+#define GICR_TYPER_RVPEID		(1U << 7)
+#define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
+#define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
+
+#define GICR_INVLPIR_INTID		GENMASK_ULL(31, 0)
+#define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
+#define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
+
+#define GICR_INVALLR_VPEID		GICR_INVLPIR_VPEID
+#define GICR_INVALLR_V			GICR_INVLPIR_V
 
 #define GIC_V3_REDIST_SIZE		0x20000
 
@@ -272,6 +291,18 @@
 #define GICR_VPROPBASER_RaWaWt	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWaWt)
 #define GICR_VPROPBASER_RaWaWb	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWaWb)
 
+/*
+ * GICv4.1 VPROPBASER reinvention. A subtle mix between the old
+ * VPROPBASER and ITS_BASER. Just not quite any of the two.
+ */
+#define GICR_VPROPBASER_4_1_VALID	(1ULL << 63)
+#define GICR_VPROPBASER_4_1_ENTRY_SIZE	GENMASK_ULL(61, 59)
+#define GICR_VPROPBASER_4_1_INDIRECT	(1ULL << 55)
+#define GICR_VPROPBASER_4_1_PAGE_SIZE	GENMASK_ULL(54, 53)
+#define GICR_VPROPBASER_4_1_Z		(1ULL << 52)
+#define GICR_VPROPBASER_4_1_ADDR	GENMASK_ULL(51, 12)
+#define GICR_VPROPBASER_4_1_SIZE	GENMASK_ULL(6, 0)
+
 #define GICR_VPENDBASER			0x0078
 
 #define GICR_VPENDBASER_SHAREABILITY_SHIFT		(10)
@@ -303,12 +334,22 @@
 #define GICR_VPENDBASER_IDAI		(1ULL << 62)
 #define GICR_VPENDBASER_Valid		(1ULL << 63)
 
+/*
+ * GICv4.1 VPENDBASER, used for VPE residency. On top of these fields,
+ * also use the above Valid, PendingLast and Dirty.
+ */
+#define GICR_VPENDBASER_4_1_DB		(1ULL << 62)
+#define GICR_VPENDBASER_4_1_VGRP0EN	(1ULL << 59)
+#define GICR_VPENDBASER_4_1_VGRP1EN	(1ULL << 58)
+#define GICR_VPENDBASER_4_1_VPEID	GENMASK_ULL(15, 0)
+
 /*
  * ITS registers, offsets from ITS_base
  */
 #define GITS_CTLR			0x0000
 #define GITS_IIDR			0x0004
 #define GITS_TYPER			0x0008
+#define GITS_MPIDR			0x0018
 #define GITS_CBASER			0x0080
 #define GITS_CWRITER			0x0088
 #define GITS_CREADR			0x0090
@@ -342,6 +383,8 @@
 #define GITS_TYPER_HCC_SHIFT		24
 #define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
 #define GITS_TYPER_VMOVP		(1ULL << 37)
+#define GITS_TYPER_VMAPP		(1ULL << 40)
+#define GITS_TYPER_SVPET		GENMASK_ULL(42, 41)
 
 #define GITS_IIDR_REV_SHIFT		12
 #define GITS_IIDR_REV_MASK		(0xf << GITS_IIDR_REV_SHIFT)
@@ -412,10 +455,11 @@
 #define GITS_BASER_InnerShareable					\
 	GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
 #define GITS_BASER_PAGE_SIZE_SHIFT	(8)
-#define GITS_BASER_PAGE_SIZE_4K		(0ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_16K	(1ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_64K	(2ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_MASK	(3ULL << GITS_BASER_PAGE_SIZE_SHIFT)
+#define __GITS_BASER_PSZ(sz)		(GIC_PAGE_SIZE_ ## sz << GITS_BASER_PAGE_SIZE_SHIFT)
+#define GITS_BASER_PAGE_SIZE_4K		__GITS_BASER_PSZ(4K)
+#define GITS_BASER_PAGE_SIZE_16K	__GITS_BASER_PSZ(16K)
+#define GITS_BASER_PAGE_SIZE_64K	__GITS_BASER_PSZ(64K)
+#define GITS_BASER_PAGE_SIZE_MASK	__GITS_BASER_PSZ(MASK)
 #define GITS_BASER_PAGES_MAX		256
 #define GITS_BASER_PAGES_SHIFT		(0)
 #define GITS_BASER_NR_PAGES(r)		(((r) & 0xff) + 1)
@@ -456,8 +500,9 @@
 #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
 #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
 #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
-/* VMOVP is the odd one, as it doesn't have a physical counterpart */
+/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
 #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
+#define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
 
 /*
  * ITS error numbers
@@ -607,14 +652,18 @@ struct rdists {
 	struct {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
+		struct page	*vpe_l1_page;
 		phys_addr_t	phys_base;
 		bool		lpi_enabled;
+		cpumask_t	*vpe_table_mask;
 	} __percpu		*rdist;
 	phys_addr_t		prop_table_pa;
 	void			*prop_table_va;
 	u64			flags;
 	u32			gicd_typer;
+	u32			gicd_typer2;
 	bool			has_vlpis;
+	bool			has_rvpeid;
 	bool			has_direct_lpi;
 };
 
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 5dbcfc65f21e..d9c34968467a 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -39,8 +39,20 @@ struct its_vpe {
 	irq_hw_number_t		vpe_db_lpi;
 	/* VPE resident */
 	bool			resident;
-	/* VPE proxy mapping */
-	int			vpe_proxy_event;
+	union {
+		/* GICv4.0 implementations */
+		struct {
+			/* VPE proxy mapping */
+			int	vpe_proxy_event;
+			/* Implementation Defined Area Invalid */
+			bool	idai;
+		};
+		/* GICv4.1 implementations */
+		struct {
+			atomic_t vmapp_count;
+		};
+	};
+
 	/*
 	 * This collection ID is used to indirect the target
 	 * redistributor for this VPE. The ID itself isn't involved in
@@ -49,8 +61,6 @@ struct its_vpe {
 	u16			col_idx;
 	/* Unique (system-wide) VPE identifier */
 	u16			vpe_id;
-	/* Implementation Defined Area Invalid */
-	bool			idai;
 	/* Pending VLPIs on schedule out? */
 	bool			pending_last;
 };
@@ -90,6 +100,11 @@ struct its_cmd_info {
 	union {
 		struct its_vlpi_map	*map;
 		u8			config;
+		bool			req_db;
+		struct {
+			bool		g0en;
+			bool		g1en;
+		};
 	};
 };
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 3c340dbc5a1f..698749f42ced 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -427,6 +427,11 @@ int irq_domain_translate_twocell(struct irq_domain *d,
 				 unsigned long *out_hwirq,
 				 unsigned int *out_type);
 
+int irq_domain_translate_onecell(struct irq_domain *d,
+				 struct irq_fwspec *fwspec,
+				 unsigned long *out_hwirq,
+				 unsigned int *out_type);
+
 /* IPI functions */
 int irq_reserve_ipi(struct irq_domain *domain, const struct cpumask *dest);
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 6c8512d3be88..0fbcbacd1b29 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -13,6 +13,7 @@ enum hk_flags {
 	HK_FLAG_TICK		= (1 << 4),
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
+	HK_FLAG_MANAGED_IRQ	= (1 << 7),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 6c7ca2e983a5..02236b13b359 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/ratelimit.h>
 #include <linux/irq.h>
+#include <linux/sched/isolation.h>
 
 #include "internals.h"
 
@@ -171,6 +172,20 @@ void irq_migrate_all_off_this_cpu(void)
 	}
 }
 
+static bool hk_should_isolate(struct irq_data *data, unsigned int cpu)
+{
+	const struct cpumask *hk_mask;
+
+	if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
+		return false;
+
+	hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+	if (cpumask_subset(irq_data_get_effective_affinity_mask(data), hk_mask))
+		return false;
+
+	return cpumask_test_cpu(cpu, hk_mask);
+}
+
 static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
@@ -188,9 +203,11 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 	/*
 	 * If the interrupt can only be directed to a single target
 	 * CPU then it is already assigned to a CPU in the affinity
-	 * mask. No point in trying to move it around.
+	 * mask. No point in trying to move it around unless the
+	 * isolation mechanism requests to move it to an upcoming
+	 * housekeeping CPU.
 	 */
-	if (!irqd_is_single_target(data))
+	if (!irqd_is_single_target(data) || hk_should_isolate(data, cpu))
 		irq_set_affinity_locked(data, affinity, false);
 }
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5b8fdd659e54..98a5f10d1900 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -891,6 +891,7 @@ __irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
 }
 
 void __irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags, bool bus)
+	__releases(&desc->lock)
 {
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	if (bus)
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dd822fd8a7d5..7527e5ef6fe5 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -986,6 +986,23 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 };
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
+/**
+ * irq_domain_translate_onecell() - Generic translate for direct one cell
+ * bindings
+ */
+int irq_domain_translate_onecell(struct irq_domain *d,
+				 struct irq_fwspec *fwspec,
+				 unsigned long *out_hwirq,
+				 unsigned int *out_type)
+{
+	if (WARN_ON(fwspec->param_count < 1))
+		return -EINVAL;
+	*out_hwirq = fwspec->param[0];
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_domain_translate_onecell);
+
 /**
  * irq_domain_translate_twocell() - Generic translate for direct two cell
  * bindings
@@ -1459,6 +1476,7 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	if (rv) {
 		/* Restore the original irq_data. */
 		*root_irq_data = *child_irq_data;
+		kfree(child_irq_data);
 		goto error;
 	}
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..818b2802d3e7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/task.h>
+#include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
 
@@ -217,7 +218,45 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	ret = chip->irq_set_affinity(data, mask, force);
+	/*
+	 * If this is a managed interrupt and housekeeping is enabled on
+	 * it check whether the requested affinity mask intersects with
+	 * a housekeeping CPU. If so, then remove the isolated CPUs from
+	 * the mask and just keep the housekeeping CPU(s). This prevents
+	 * the affinity setter from routing the interrupt to an isolated
+	 * CPU to avoid that I/O submitted from a housekeeping CPU causes
+	 * interrupts on an isolated one.
+	 *
+	 * If the masks do not intersect or include online CPU(s) then
+	 * keep the requested mask. The isolated target CPUs are only
+	 * receiving interrupts when the I/O operation was submitted
+	 * directly from them.
+	 *
+	 * If all housekeeping CPUs in the affinity mask are offline, the
+	 * interrupt will be migrated by the CPU hotplug code once a
+	 * housekeeping CPU which belongs to the affinity mask comes
+	 * online.
+	 */
+	if (irqd_affinity_is_managed(data) &&
+	    housekeeping_enabled(HK_FLAG_MANAGED_IRQ)) {
+		const struct cpumask *hk_mask, *prog_mask;
+
+		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
+		static struct cpumask tmp_mask;
+
+		hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+
+		raw_spin_lock(&tmp_mask_lock);
+		cpumask_and(&tmp_mask, mask, hk_mask);
+		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
+			prog_mask = mask;
+		else
+			prog_mask = &tmp_mask;
+		ret = chip->irq_set_affinity(data, prog_mask, force);
+		raw_spin_unlock(&tmp_mask_lock);
+	} else {
+		ret = chip->irq_set_affinity(data, mask, force);
+	}
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
@@ -1500,8 +1539,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 * has. The type flags are unreliable as the
 		 * underlying chip implementation can override them.
 		 */
-		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for irq %d\n",
-		       irq);
+		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for %s (irq %d)\n",
+		       new->name, irq);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 2ed97a7c9b2a..f865e5f4d382 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -34,6 +34,7 @@ static atomic_t irq_poll_active;
  * true and let the handler run.
  */
 bool irq_wait_for_poll(struct irq_desc *desc)
+	__must_hold(&desc->lock)
 {
 	if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
 		      "irq poll in progress on cpu %d for irq %d\n",
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 9fcb2a695a41..008d6ac2342b 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -163,6 +163,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "managed_irq,", 12)) {
+			str += 12;
+			flags |= HK_FLAG_MANAGED_IRQ;
+			continue;
+		}
+
 		pr_warn("isolcpus: Error, unknown flag\n");
 		return 0;
 	}

