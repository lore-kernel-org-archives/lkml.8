Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C31207F7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFBMI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgFBMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:08:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5D5C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:08:54 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jg5iu-0004cV-EQ; Tue, 02 Jun 2020 14:08:52 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id ED681100F18;
        Tue,  2 Jun 2020 14:08:51 +0200 (CEST)
Date:   Tue, 02 Jun 2020 12:08:10 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v5.8
References: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
Message-ID: <159109969095.14228.4958990874220284812.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-06-02

up to:  809eb4e9bf9d: dt-bindings: timer: Add renesas,em-sti bindings


The truly boring timer and clocksource updates for 5.8:

 - Not a single new clocksource or clockevent driver!
 
 - Device tree updates for various chips
 - Fixes and improvements and cleanups all over the place

Thanks,

	tglx

------------------>
Anson Huang (1):
      clocksource/drivers/imx-tpm: Add support for ARM64

Christophe JAILLET (2):
      clocksource/drivers/davinci: Avoid trailing '\n' hidden in pr_fmt()
      clocksource: davinci: axe a pointless __GFP_NOFAIL

Colin Ian King (1):
      clocksource/drivers/timer-ti-dm: Fix spelling mistake "detectt" -> "detect"

Dejin Zheng (2):
      clocksource/drivers/arc_timer: Remove duplicate error message
      drivers/clocksource/arm_arch_timer: Remove duplicate error message

Geert Uytterhoeven (1):
      dt-bindings: timer: Add renesas,em-sti bindings

Jason Yan (1):
      clocksource/drivers/atmel-st: Remove useless 'status'

Johan Hovold (1):
      clocksource/drivers/rda: drop redundant Kconfig dependency

Lokesh Vutla (2):
      ARM: dts: Add 32KHz clock as default clock source
      clocksource/drivers/timer-ti-dm: Do one override clock parent in prepare()

Michael Ellerman (1):
      clocksource/drivers/timer-microchip-pit64b: Select CONFIG_TIMER_OF

Paul Burton (1):
      clocksource: mips-gic-timer: Register as sched_clock

Rob Herring (1):
      clocksource/drivers/versatile: Allow CONFIG_CLKSRC_VERSATILE to be disabled

Saravana Kannan (1):
      clocksource/drivers/timer-versatile: Clear OF_POPULATED flag

Serge Semin (6):
      dt-bindings: rtc: Convert snps,dw-apb-timer to DT schema
      dt-bindings: timer: Move snps,dw-apb-timer DT schema from rtc
      clocksource: dw_apb_timer: Make CPU-affiliation being optional
      clocksource: dw_apb_timer: Affiliate of-based timer with any CPU
      clocksource: dw_apb_timer_of: Fix missing clockevent timers
      clocksource: mips-gic-timer: Mark GIC timer as unstable if ref clock changes

Tony Lindgren (6):
      clocksource/drivers/timer-ti-32k: Add support for initializing directly
      clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
      clocksource/drivers/timer-ti-dm: Fix warning for set but not used
      clocksource/drivers/timer-ti-32k: Add support for initializing directly
      clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
      clocksource/drivers/timer-ti-dm: Fix warning for set but not used


 Documentation/devicetree/bindings/rtc/dw-apb.txt   |  32 -
 .../devicetree/bindings/timer/renesas,em-sti.yaml  |  46 ++
 .../bindings/timer/snps,dw-apb-timer.yaml          |  88 +++
 arch/arm/boot/dts/am335x-guardian.dts              |   1 +
 arch/arm/boot/dts/am3517-evm.dts                   |   1 +
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   1 +
 drivers/clocksource/Kconfig                        |   8 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/arc_timer.c                    |   4 +-
 drivers/clocksource/arm_arch_timer.c               |   4 +-
 drivers/clocksource/dw_apb_timer.c                 |   5 +-
 drivers/clocksource/dw_apb_timer_of.c              |   8 +-
 drivers/clocksource/mips-gic-timer.c               |  50 +-
 drivers/clocksource/timer-atmel-st.c               |   3 +-
 drivers/clocksource/timer-davinci.c                |  24 +-
 drivers/clocksource/timer-imx-tpm.c                |   8 +-
 drivers/clocksource/timer-ti-32k.c                 |  48 +-
 drivers/clocksource/timer-ti-dm-systimer.c         | 727 +++++++++++++++++++++
 drivers/clocksource/timer-ti-dm.c                  |   4 +-
 drivers/clocksource/timer-versatile.c              |   3 +
 21 files changed, 992 insertions(+), 75 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/dw-apb.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
 create mode 100644 drivers/clocksource/timer-ti-dm-systimer.c

diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
deleted file mode 100644
index c703d51abb6c..000000000000
--- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* Designware APB timer
-
-Required properties:
-- compatible: One of:
- 	"snps,dw-apb-timer"
-	"snps,dw-apb-timer-sp" <DEPRECATED>
-	"snps,dw-apb-timer-osc" <DEPRECATED>
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: IRQ line for the timer.
-- either clocks+clock-names or clock-frequency properties
-
-Optional properties:
-- clocks	: list of clock specifiers, corresponding to entries in
-		  the clock-names property;
-- clock-names	: should contain "timer" and "pclk" entries, matching entries
-		  in the clocks property.
-- clock-frequency: The frequency in HZ of the timer.
-- clock-freq: For backwards compatibility with picoxcell
-
-If using the clock specifiers, the pclk clock is optional, as not all
-systems may use one.
-
-
-Example:
-	timer@ffe00000 {
-		compatible = "snps,dw-apb-timer";
-		interrupts = <0 170 4>;
-		reg = <0xffe00000 0x1000>;
-		clocks = <&timer_clk>, <&timer_pclk>;
-		clock-names = "timer", "pclk";
-	};
diff --git a/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml b/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
new file mode 100644
index 000000000000..233d74d5402c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/renesas,em-sti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas EMMA Mobile System Timer
+
+maintainers:
+  - Magnus Damm <magnus.damm@gmail.com>
+
+properties:
+  compatible:
+    const: renesas,em-sti
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    timer@e0180000 {
+            compatible = "renesas,em-sti";
+            reg = <0xe0180000 0x54>;
+            interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&sti_sclk>;
+            clock-names = "sclk";
+    };
diff --git a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
new file mode 100644
index 000000000000..5d300efdf0ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/snps,dw-apb-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare APB Timer
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: snps,dw-apb-timer
+      - enum:
+          - snps,dw-apb-timer-sp
+          - snps,dw-apb-timer-osc
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+       - description: Timer ticks reference clock source
+       - description: APB interface clock source
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: timer
+      - const: pclk
+
+  clock-frequency: true
+
+  clock-freq:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: |
+      Has the same meaning as the 'clock-frequency' property - timer clock
+      frequency in HZ, but is defined only for the backwards compatibility
+      with the picoxcell platform.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+oneOf:
+  - required:
+      - clocks
+      - clock-names
+  - required:
+      - clock-frequency
+  - required:
+      - clock-freq
+
+examples:
+  - |
+    timer@ffe00000 {
+      compatible = "snps,dw-apb-timer";
+      interrupts = <0 170 4>;
+      reg = <0xffe00000 0x1000>;
+      clocks = <&timer_clk>, <&timer_pclk>;
+      clock-names = "timer", "pclk";
+    };
+  - |
+    timer@ffe00000 {
+      compatible = "snps,dw-apb-timer";
+      interrupts = <0 170 4>;
+      reg = <0xffe00000 0x1000>;
+      clocks = <&timer_clk>;
+      clock-names = "timer";
+    };
+  - |
+    timer@ffe00000 {
+      compatible = "snps,dw-apb-timer";
+      interrupts = <0 170 4>;
+      reg = <0xffe00000 0x1000>;
+      clock-frequency = <25000000>;
+    };
+...
diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 81e0f63e94d3..0ebe9e2c150e 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -105,6 +105,7 @@
 		ti,timers = <&timer7>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dmtimer7_pins>;
+		ti,clock-source = <0x01>;
 	};
 
 	vmmcsd_fixed: regulator-3v3 {
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index a1fd3e63e86e..92466b9eb6ba 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -156,6 +156,7 @@
 		pinctrl-0 = <&pwm_pins>;
 		ti,timers = <&timer11>;
 		#pwm-cells = <3>;
+		ti,clock-source = <0x01>;
 	};
 
 	/* HS USB Host PHY on PORT 1 */
diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
index f7b82ced4080..381f0e82bb70 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -65,6 +65,7 @@
 		pinctrl-0 = <&pwm_pins>;
 		ti,timers = <&timer10>;
 		#pwm-cells = <3>;
+		ti,clock-source = <0x01>;
 	};
 
 };
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 409a758c99f1..ecc45862b4f3 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -150,6 +150,7 @@
 		compatible = "ti,omap-dmtimer-pwm";
 		ti,timers = <&timer11>;
 		#pwm-cells = <3>;
+		ti,clock-source = <0x01>;
 	};
 
 	hsusb2_phy: hsusb2_phy {
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f2142e6bbea3..91418381fcd4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -120,7 +120,6 @@ config OWL_TIMER
 
 config RDA_TIMER
 	bool "RDA timer driver" if COMPILE_TEST
-	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
 	select TIMER_OF
 	help
@@ -562,16 +561,16 @@ config CLKSRC_VERSATILE
 	bool "ARM Versatile (Express) reference platforms clock source" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
 	select TIMER_OF
-	default y if MFD_VEXPRESS_SYSREG
+	default y if (ARCH_VEXPRESS || ARCH_VERSATILE) && ARM
 	help
 	  This option enables clock source based on free running
 	  counter available in the "System Registers" block of
-	  ARM Versatile, RealView and Versatile Express reference
-	  platforms.
+	  ARM Versatile and Versatile Express reference platforms.
 
 config CLKSRC_MIPS_GIC
 	bool
 	depends on MIPS_GIC
+	select CLOCKSOURCE_WATCHDOG
 	select TIMER_OF
 
 config CLKSRC_TANGO_XTAL
@@ -709,6 +708,7 @@ config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
 	  based system. It supports the oneshot, the periodic
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 641ba5383ab5..bdda1a2e4097 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
+obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm-systimer.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index b29b5a75333e..de93dd1a8c7b 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -334,10 +334,8 @@ static int __init arc_clockevent_setup(struct device_node *node)
 	}
 
 	ret = arc_get_timer_clk(node);
-	if (ret) {
-		pr_err("clockevent: missing clk\n");
+	if (ret)
 		return ret;
-	}
 
 	/* Needs apriori irq_set_percpu_devid() done in intc map function */
 	ret = request_percpu_irq(arc_timer_irq, timer_irq_handler,
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2204a444e801..ecf7b7db2d05 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1588,10 +1588,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
 	ret = acpi_gtdt_init(table, &platform_timer_count);
-	if (ret) {
-		pr_err("Failed to init GTDT table.\n");
+	if (ret)
 		return ret;
-	}
 
 	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
 		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index b207a77b0831..f5f24a95ee82 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -222,7 +222,8 @@ static int apbt_next_event(unsigned long delta,
 /**
  * dw_apb_clockevent_init() - use an APB timer as a clock_event_device
  *
- * @cpu:	The CPU the events will be targeted at.
+ * @cpu:	The CPU the events will be targeted at or -1 if CPU affiliation
+ *		isn't required.
  * @name:	The name used for the timer and the IRQ for it.
  * @rating:	The rating to give the timer.
  * @base:	I/O base for the timer registers.
@@ -257,7 +258,7 @@ dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
 	dw_ced->ced.max_delta_ticks = 0x7fffffff;
 	dw_ced->ced.min_delta_ns = clockevent_delta2ns(5000, &dw_ced->ced);
 	dw_ced->ced.min_delta_ticks = 5000;
-	dw_ced->ced.cpumask = cpumask_of(cpu);
+	dw_ced->ced.cpumask = cpu < 0 ? cpu_possible_mask : cpumask_of(cpu);
 	dw_ced->ced.features = CLOCK_EVT_FEAT_PERIODIC |
 				CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
 	dw_ced->ced.set_state_shutdown = apbt_shutdown;
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 8c28b127759f..ab3ddebe8344 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -73,7 +73,7 @@ static void __init add_clockevent(struct device_node *event_timer)
 
 	timer_get_base_and_rate(event_timer, &iobase, &rate);
 
-	ced = dw_apb_clockevent_init(0, event_timer->name, 300, iobase, irq,
+	ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
 				     rate);
 	if (!ced)
 		panic("Unable to initialise clockevent device");
@@ -147,10 +147,6 @@ static int num_called;
 static int __init dw_apb_timer_init(struct device_node *timer)
 {
 	switch (num_called) {
-	case 0:
-		pr_debug("%s: found clockevent timer\n", __func__);
-		add_clockevent(timer);
-		break;
 	case 1:
 		pr_debug("%s: found clocksource timer\n", __func__);
 		add_clocksource(timer);
@@ -161,6 +157,8 @@ static int __init dw_apb_timer_init(struct device_node *timer)
 #endif
 		break;
 	default:
+		pr_debug("%s: found clockevent timer\n", __func__);
+		add_clockevent(timer);
 		break;
 	}
 
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 8b5f8ae723cb..be4175f415ba 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
+#include <linux/sched_clock.h>
 #include <linux/smp.h>
 #include <linux/time.h>
 #include <asm/mips-cps.h>
@@ -23,14 +24,14 @@
 static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
 static int gic_timer_irq;
 static unsigned int gic_frequency;
+static bool __read_mostly gic_clock_unstable;
 
-static u64 notrace gic_read_count(void)
+static void gic_clocksource_unstable(char *reason);
+
+static u64 notrace gic_read_count_2x32(void)
 {
 	unsigned int hi, hi2, lo;
 
-	if (mips_cm_is64)
-		return read_gic_counter();
-
 	do {
 		hi = read_gic_counter_32h();
 		lo = read_gic_counter_32l();
@@ -40,6 +41,19 @@ static u64 notrace gic_read_count(void)
 	return (((u64) hi) << 32) + lo;
 }
 
+static u64 notrace gic_read_count_64(void)
+{
+	return read_gic_counter();
+}
+
+static u64 notrace gic_read_count(void)
+{
+	if (mips_cm_is64)
+		return gic_read_count_64();
+
+	return gic_read_count_2x32();
+}
+
 static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 {
 	int cpu = cpumask_first(evt->cpumask);
@@ -114,8 +128,10 @@ static int gic_clk_notifier(struct notifier_block *nb, unsigned long action,
 {
 	struct clk_notifier_data *cnd = data;
 
-	if (action == POST_RATE_CHANGE)
+	if (action == POST_RATE_CHANGE) {
+		gic_clocksource_unstable("ref clock rate change");
 		on_each_cpu(gic_update_frequency, (void *)cnd->new_rate, 1);
+	}
 
 	return NOTIFY_OK;
 }
@@ -161,6 +177,18 @@ static struct clocksource gic_clocksource = {
 	.vdso_clock_mode	= VDSO_CLOCKMODE_GIC,
 };
 
+static void gic_clocksource_unstable(char *reason)
+{
+	if (gic_clock_unstable)
+		return;
+
+	gic_clock_unstable = true;
+
+	pr_info("GIC timer is unstable due to %s\n", reason);
+
+	clocksource_mark_unstable(&gic_clocksource);
+}
+
 static int __init __gic_clocksource_init(void)
 {
 	unsigned int count_width;
@@ -228,6 +256,18 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	/* And finally start the counter */
 	clear_gic_config(GIC_CONFIG_COUNTSTOP);
 
+	/*
+	 * It's safe to use the MIPS GIC timer as a sched clock source only if
+	 * its ticks are stable, which is true on either the platforms with
+	 * stable CPU frequency or on the platforms with CM3 and CPU frequency
+	 * change performed by the CPC core clocks divider.
+	 */
+	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
+		sched_clock_register(mips_cm_is64 ?
+				     gic_read_count_64 : gic_read_count_2x32,
+				     64, gic_frequency);
+	}
+
 	return 0;
 }
 TIMER_OF_DECLARE(mips_gic_timer, "mti,gic-timer",
diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index ab0aabfae5f0..73e8aee445da 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -139,7 +139,6 @@ static int
 clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 {
 	u32		alm;
-	int		status = 0;
 	unsigned int	val;
 
 	BUG_ON(delta < 2);
@@ -163,7 +162,7 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 	alm += delta;
 	regmap_write(regmap_st, AT91_ST_RTAR, alm);
 
-	return status;
+	return 0;
 }
 
 static struct clock_event_device clkevt = {
diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index e421946a91c5..bb4eee31ae08 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -18,7 +18,7 @@
 #include <clocksource/timer-davinci.h>
 
 #undef pr_fmt
-#define pr_fmt(fmt) "%s: " fmt "\n", __func__
+#define pr_fmt(fmt) "%s: " fmt, __func__
 
 #define DAVINCI_TIMER_REG_TIM12			0x10
 #define DAVINCI_TIMER_REG_TIM34			0x14
@@ -250,31 +250,29 @@ int __init davinci_timer_register(struct clk *clk,
 
 	rv = clk_prepare_enable(clk);
 	if (rv) {
-		pr_err("Unable to prepare and enable the timer clock");
+		pr_err("Unable to prepare and enable the timer clock\n");
 		return rv;
 	}
 
 	if (!request_mem_region(timer_cfg->reg.start,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
-		pr_err("Unable to request memory region");
+		pr_err("Unable to request memory region\n");
 		return -EBUSY;
 	}
 
 	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
-		pr_err("Unable to map the register range");
+		pr_err("Unable to map the register range\n");
 		return -ENOMEM;
 	}
 
 	davinci_timer_init(base);
 	tick_rate = clk_get_rate(clk);
 
-	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL | __GFP_NOFAIL);
-	if (!clockevent) {
-		pr_err("Error allocating memory for clockevent data");
+	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
+	if (!clockevent)
 		return -ENOMEM;
-	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -298,7 +296,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 davinci_timer_irq_timer, IRQF_TIMER,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
-		pr_err("Unable to request the clockevent interrupt");
+		pr_err("Unable to request the clockevent interrupt\n");
 		return rv;
 	}
 
@@ -325,7 +323,7 @@ int __init davinci_timer_register(struct clk *clk,
 
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
-		pr_err("Unable to register clocksource");
+		pr_err("Unable to register clocksource\n");
 		return rv;
 	}
 
@@ -343,20 +341,20 @@ static int __init of_davinci_timer_register(struct device_node *np)
 
 	rv = of_address_to_resource(np, 0, &timer_cfg.reg);
 	if (rv) {
-		pr_err("Unable to get the register range for timer");
+		pr_err("Unable to get the register range for timer\n");
 		return rv;
 	}
 
 	rv = of_irq_to_resource_table(np, timer_cfg.irq,
 				      DAVINCI_TIMER_NUM_IRQS);
 	if (rv != DAVINCI_TIMER_NUM_IRQS) {
-		pr_err("Unable to get the interrupts for timer");
+		pr_err("Unable to get the interrupts for timer\n");
 		return rv;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Unable to get the timer clock");
+		pr_err("Unable to get the timer clock\n");
 		return PTR_ERR(clk);
 	}
 
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 6334a35fdc2f..2cdc077a39f5 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -61,17 +61,19 @@ static inline void tpm_irq_acknowledge(void)
 	writel(TPM_STATUS_CH0F, timer_base + TPM_STATUS);
 }
 
-static struct delay_timer tpm_delay_timer;
-
 static inline unsigned long tpm_read_counter(void)
 {
 	return readl(timer_base + TPM_CNT);
 }
 
+#if defined(CONFIG_ARM)
+static struct delay_timer tpm_delay_timer;
+
 static unsigned long tpm_read_current_timer(void)
 {
 	return tpm_read_counter();
 }
+#endif
 
 static u64 notrace tpm_read_sched_clock(void)
 {
@@ -144,9 +146,11 @@ static struct timer_of to_tpm = {
 
 static int __init tpm_clocksource_init(void)
 {
+#if defined(CONFIG_ARM)
 	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
 	tpm_delay_timer.freq = timer_of_rate(&to_tpm) >> 3;
 	register_current_timer_delay(&tpm_delay_timer);
+#endif
 
 	sched_clock_register(tpm_read_sched_clock, counter_width,
 			     timer_of_rate(&to_tpm) >> 3);
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index abd5f158d6e2..ae12bbf3d68c 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -24,6 +24,7 @@
  * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/sched_clock.h>
@@ -76,6 +77,49 @@ static u64 notrace omap_32k_read_sched_clock(void)
 	return ti_32k_read_cycles(&ti_32k_timer.cs);
 }
 
+static void __init ti_32k_timer_enable_clock(struct device_node *np,
+					     const char *name)
+{
+	struct clk *clock;
+	int error;
+
+	clock = of_clk_get_by_name(np->parent, name);
+	if (IS_ERR(clock)) {
+		/* Only some SoCs have a separate interface clock */
+		if (PTR_ERR(clock) == -EINVAL && !strncmp("ick", name, 3))
+			return;
+
+		pr_warn("%s: could not get clock %s %li\n",
+			__func__, name, PTR_ERR(clock));
+		return;
+	}
+
+	error = clk_prepare_enable(clock);
+	if (error) {
+		pr_warn("%s: could not enable %s: %i\n",
+			__func__, name, error);
+		return;
+	}
+}
+
+static void __init ti_32k_timer_module_init(struct device_node *np,
+					    void __iomem *base)
+{
+	void __iomem *sysc = base + 4;
+
+	if (!of_device_is_compatible(np->parent, "ti,sysc"))
+		return;
+
+	ti_32k_timer_enable_clock(np, "fck");
+	ti_32k_timer_enable_clock(np, "ick");
+
+	/*
+	 * Force idle module as wkup domain is active with MPU.
+	 * No need to tag the module disabled for ti-sysc probe.
+	 */
+	writel_relaxed(0, sysc);
+}
+
 static int __init ti_32k_timer_init(struct device_node *np)
 {
 	int ret;
@@ -90,6 +134,7 @@ static int __init ti_32k_timer_init(struct device_node *np)
 		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 
 	ti_32k_timer.counter = ti_32k_timer.base;
+	ti_32k_timer_module_init(np, ti_32k_timer.base);
 
 	/*
 	 * 32k sync Counter IP register offsets vary between the highlander
@@ -104,6 +149,8 @@ static int __init ti_32k_timer_init(struct device_node *np)
 	else
 		ti_32k_timer.counter += OMAP2_32KSYNCNT_CR_OFF_LOW;
 
+	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
+
 	ret = clocksource_register_hz(&ti_32k_timer.cs, 32768);
 	if (ret) {
 		pr_err("32k_counter: can't register clocksource\n");
@@ -111,7 +158,6 @@ static int __init ti_32k_timer_init(struct device_node *np)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
-	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
 }
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
new file mode 100644
index 000000000000..6fd1f219a512
--- /dev/null
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -0,0 +1,727 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <linux/clk/clk-conf.h>
+
+#include <clocksource/timer-ti-dm.h>
+#include <dt-bindings/bus/ti-sysc.h>
+
+/* For type1, set SYSC_OMAP2_CLOCKACTIVITY for fck off on idle, l4 clock on */
+#define DMTIMER_TYPE1_ENABLE	((1 << 9) | (SYSC_IDLE_SMART << 3) | \
+				 SYSC_OMAP2_ENAWAKEUP | SYSC_OMAP2_AUTOIDLE)
+
+#define DMTIMER_TYPE2_ENABLE	(SYSC_IDLE_SMART_WKUP << 2)
+#define DMTIMER_RESET_WAIT	100000
+
+#define DMTIMER_INST_DONT_CARE	~0U
+
+static int counter_32k;
+static u32 clocksource;
+static u32 clockevent;
+
+/*
+ * Subset of the timer registers we use. Note that the register offsets
+ * depend on the timer revision detected.
+ */
+struct dmtimer_systimer {
+	void __iomem *base;
+	u8 sysc;
+	u8 irq_stat;
+	u8 irq_ena;
+	u8 pend;
+	u8 load;
+	u8 counter;
+	u8 ctrl;
+	u8 wakeup;
+	u8 ifctrl;
+	unsigned long rate;
+};
+
+struct dmtimer_clockevent {
+	struct clock_event_device dev;
+	struct dmtimer_systimer t;
+	u32 period;
+};
+
+struct dmtimer_clocksource {
+	struct clocksource dev;
+	struct dmtimer_systimer t;
+	unsigned int loadval;
+};
+
+/* Assumes v1 ip if bits [31:16] are zero */
+static bool dmtimer_systimer_revision1(struct dmtimer_systimer *t)
+{
+	u32 tidr = readl_relaxed(t->base);
+
+	return !(tidr >> 16);
+}
+
+static int __init dmtimer_systimer_type1_reset(struct dmtimer_systimer *t)
+{
+	void __iomem *syss = t->base + OMAP_TIMER_V1_SYS_STAT_OFFSET;
+	int ret;
+	u32 l;
+
+	writel_relaxed(BIT(1) | BIT(2), t->base + t->ifctrl);
+	ret = readl_poll_timeout_atomic(syss, l, l & BIT(0), 100,
+					DMTIMER_RESET_WAIT);
+
+	return ret;
+}
+
+/* Note we must use io_base instead of func_base for type2 OCP regs */
+static int __init dmtimer_systimer_type2_reset(struct dmtimer_systimer *t)
+{
+	void __iomem *sysc = t->base + t->sysc;
+	u32 l;
+
+	l = readl_relaxed(sysc);
+	l |= BIT(0);
+	writel_relaxed(l, sysc);
+
+	return readl_poll_timeout_atomic(sysc, l, !(l & BIT(0)), 100,
+					 DMTIMER_RESET_WAIT);
+}
+
+static int __init dmtimer_systimer_reset(struct dmtimer_systimer *t)
+{
+	int ret;
+
+	if (dmtimer_systimer_revision1(t))
+		ret = dmtimer_systimer_type1_reset(t);
+	else
+		ret = dmtimer_systimer_type2_reset(t);
+	if (ret < 0) {
+		pr_err("%s failed with %i\n", __func__, ret);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id counter_match_table[] = {
+	{ .compatible = "ti,omap-counter32k" },
+	{ /* Sentinel */ },
+};
+
+/*
+ * Check if the SoC als has a usable working 32 KiHz counter. The 32 KiHz
+ * counter is handled by timer-ti-32k, but we need to detect it as it
+ * affects the preferred dmtimer system timer configuration. There is
+ * typically no use for a dmtimer clocksource if the 32 KiHz counter is
+ * present, except on am437x as described below.
+ */
+static void __init dmtimer_systimer_check_counter32k(void)
+{
+	struct device_node *np;
+
+	if (counter_32k)
+		return;
+
+	np = of_find_matching_node(NULL, counter_match_table);
+	if (!np) {
+		counter_32k = -ENODEV;
+
+		return;
+	}
+
+	if (of_device_is_available(np))
+		counter_32k = 1;
+	else
+		counter_32k = -ENODEV;
+
+	of_node_put(np);
+}
+
+static const struct of_device_id dmtimer_match_table[] = {
+	{ .compatible = "ti,omap2420-timer", },
+	{ .compatible = "ti,omap3430-timer", },
+	{ .compatible = "ti,omap4430-timer", },
+	{ .compatible = "ti,omap5430-timer", },
+	{ .compatible = "ti,am335x-timer", },
+	{ .compatible = "ti,am335x-timer-1ms", },
+	{ .compatible = "ti,dm814-timer", },
+	{ .compatible = "ti,dm816-timer", },
+	{ /* Sentinel */ },
+};
+
+/*
+ * Checks that system timers are configured to not reset and idle during
+ * the generic timer-ti-dm device driver probe. And that the system timer
+ * source clocks are properly configured. Also, let's not hog any DSP and
+ * PWM capable timers unnecessarily as system timers.
+ */
+static bool __init dmtimer_is_preferred(struct device_node *np)
+{
+	if (!of_device_is_available(np))
+		return false;
+
+	if (!of_property_read_bool(np->parent,
+				   "ti,no-reset-on-init"))
+		return false;
+
+	if (!of_property_read_bool(np->parent, "ti,no-idle"))
+		return false;
+
+	/* Secure gptimer12 is always clocked with a fixed source */
+	if (!of_property_read_bool(np, "ti,timer-secure")) {
+		if (!of_property_read_bool(np, "assigned-clocks"))
+			return false;
+
+		if (!of_property_read_bool(np, "assigned-clock-parents"))
+			return false;
+	}
+
+	if (of_property_read_bool(np, "ti,timer-dsp"))
+		return false;
+
+	if (of_property_read_bool(np, "ti,timer-pwm"))
+		return false;
+
+	return true;
+}
+
+/*
+ * Finds the first available usable always-on timer, and assigns it to either
+ * clockevent or clocksource depending if the counter_32k is available on the
+ * SoC or not.
+ *
+ * Some omap3 boards with unreliable oscillator must not use the counter_32k
+ * or dmtimer1 with 32 KiHz source. Additionally, the boards with unreliable
+ * oscillator should really set counter_32k as disabled, and delete dmtimer1
+ * ti,always-on property, but let's not count on it. For these quirky cases,
+ * we prefer using the always-on secure dmtimer12 with the internal 32 KiHz
+ * clock as the clocksource, and any available dmtimer as clockevent.
+ *
+ * For am437x, we are using am335x style dmtimer clocksource. It is unclear
+ * if this quirk handling is really needed, but let's change it separately
+ * based on testing as it might cause side effects.
+ */
+static void __init dmtimer_systimer_assign_alwon(void)
+{
+	struct device_node *np;
+	u32 pa = 0;
+	bool quirk_unreliable_oscillator = false;
+
+	/* Quirk unreliable 32 KiHz oscillator with incomplete dts */
+	if (of_machine_is_compatible("ti,omap3-beagle") ||
+	    of_machine_is_compatible("timll,omap3-devkit8000")) {
+		quirk_unreliable_oscillator = true;
+		counter_32k = -ENODEV;
+	}
+
+	/* Quirk am437x using am335x style dmtimer clocksource */
+	if (of_machine_is_compatible("ti,am43"))
+		counter_32k = -ENODEV;
+
+	for_each_matching_node(np, dmtimer_match_table) {
+		if (!dmtimer_is_preferred(np))
+			continue;
+
+		if (of_property_read_bool(np, "ti,timer-alwon")) {
+			const __be32 *addr;
+
+			addr = of_get_address(np, 0, NULL, NULL);
+			pa = of_translate_address(np, addr);
+			if (pa) {
+				/* Quirky omap3 boards must use dmtimer12 */
+				if (quirk_unreliable_oscillator &&
+				    pa == 0x48318000)
+					continue;
+
+				of_node_put(np);
+				break;
+			}
+		}
+	}
+
+	/* Usually no need for dmtimer clocksource if we have counter32 */
+	if (counter_32k >= 0) {
+		clockevent = pa;
+		clocksource = 0;
+	} else {
+		clocksource = pa;
+		clockevent = DMTIMER_INST_DONT_CARE;
+	}
+}
+
+/* Finds the first usable dmtimer, used for the don't care case */
+static u32 __init dmtimer_systimer_find_first_available(void)
+{
+	struct device_node *np;
+	const __be32 *addr;
+	u32 pa = 0;
+
+	for_each_matching_node(np, dmtimer_match_table) {
+		if (!dmtimer_is_preferred(np))
+			continue;
+
+		addr = of_get_address(np, 0, NULL, NULL);
+		pa = of_translate_address(np, addr);
+		if (pa) {
+			if (pa == clocksource || pa == clockevent) {
+				pa = 0;
+				continue;
+			}
+
+			of_node_put(np);
+			break;
+		}
+	}
+
+	return pa;
+}
+
+/* Selects the best clocksource and clockevent to use */
+static void __init dmtimer_systimer_select_best(void)
+{
+	dmtimer_systimer_check_counter32k();
+	dmtimer_systimer_assign_alwon();
+
+	if (clockevent == DMTIMER_INST_DONT_CARE)
+		clockevent = dmtimer_systimer_find_first_available();
+
+	pr_debug("%s: counter_32k: %i clocksource: %08x clockevent: %08x\n",
+		 __func__, counter_32k, clocksource, clockevent);
+}
+
+/* Interface clocks are only available on some SoCs variants */
+static int __init dmtimer_systimer_init_clock(struct device_node *np,
+					      const char *name,
+					      unsigned long *rate)
+{
+	struct clk *clock;
+	unsigned long r;
+	int error;
+
+	clock = of_clk_get_by_name(np, name);
+	if ((PTR_ERR(clock) == -EINVAL) && !strncmp(name, "ick", 3))
+		return 0;
+	else if (IS_ERR(clock))
+		return PTR_ERR(clock);
+
+	error = clk_prepare_enable(clock);
+	if (error)
+		return error;
+
+	r = clk_get_rate(clock);
+	if (!r)
+		return -ENODEV;
+
+	*rate = r;
+
+	return 0;
+}
+
+static void dmtimer_systimer_enable(struct dmtimer_systimer *t)
+{
+	u32 val;
+
+	if (dmtimer_systimer_revision1(t))
+		val = DMTIMER_TYPE1_ENABLE;
+	else
+		val = DMTIMER_TYPE2_ENABLE;
+
+	writel_relaxed(val, t->base + t->sysc);
+}
+
+static void dmtimer_systimer_disable(struct dmtimer_systimer *t)
+{
+	writel_relaxed(0, t->base + t->sysc);
+}
+
+static int __init dmtimer_systimer_setup(struct device_node *np,
+					 struct dmtimer_systimer *t)
+{
+	unsigned long rate;
+	u8 regbase;
+	int error;
+
+	if (!of_device_is_compatible(np->parent, "ti,sysc"))
+		return -EINVAL;
+
+	t->base = of_iomap(np, 0);
+	if (!t->base)
+		return -ENXIO;
+
+	/*
+	 * Enable optional assigned-clock-parents configured at the timer
+	 * node level. For regular device drivers, this is done automatically
+	 * by bus related code such as platform_drv_probe().
+	 */
+	error = of_clk_set_defaults(np, false);
+	if (error < 0)
+		pr_err("%s: clock source init failed: %i\n", __func__, error);
+
+	/* For ti-sysc, we have timer clocks at the parent module level */
+	error = dmtimer_systimer_init_clock(np->parent, "fck", &rate);
+	if (error)
+		goto err_unmap;
+
+	t->rate = rate;
+
+	error = dmtimer_systimer_init_clock(np->parent, "ick", &rate);
+	if (error)
+		goto err_unmap;
+
+	if (dmtimer_systimer_revision1(t)) {
+		t->irq_stat = OMAP_TIMER_V1_STAT_OFFSET;
+		t->irq_ena = OMAP_TIMER_V1_INT_EN_OFFSET;
+		t->pend = _OMAP_TIMER_WRITE_PEND_OFFSET;
+		regbase = 0;
+	} else {
+		t->irq_stat = OMAP_TIMER_V2_IRQSTATUS;
+		t->irq_ena = OMAP_TIMER_V2_IRQENABLE_SET;
+		regbase = OMAP_TIMER_V2_FUNC_OFFSET;
+		t->pend = regbase + _OMAP_TIMER_WRITE_PEND_OFFSET;
+	}
+
+	t->sysc = OMAP_TIMER_OCP_CFG_OFFSET;
+	t->load = regbase + _OMAP_TIMER_LOAD_OFFSET;
+	t->counter = regbase + _OMAP_TIMER_COUNTER_OFFSET;
+	t->ctrl = regbase + _OMAP_TIMER_CTRL_OFFSET;
+	t->wakeup = regbase + _OMAP_TIMER_WAKEUP_EN_OFFSET;
+	t->ifctrl = regbase + _OMAP_TIMER_IF_CTRL_OFFSET;
+
+	dmtimer_systimer_enable(t);
+	dmtimer_systimer_reset(t);
+	pr_debug("dmtimer rev %08x sysc %08x\n", readl_relaxed(t->base),
+		 readl_relaxed(t->base + t->sysc));
+
+	return 0;
+
+err_unmap:
+	iounmap(t->base);
+
+	return error;
+}
+
+/* Clockevent */
+static struct dmtimer_clockevent *
+to_dmtimer_clockevent(struct clock_event_device *clockevent)
+{
+	return container_of(clockevent, struct dmtimer_clockevent, dev);
+}
+
+static irqreturn_t dmtimer_clockevent_interrupt(int irq, void *data)
+{
+	struct dmtimer_clockevent *clkevt = data;
+	struct dmtimer_systimer *t = &clkevt->t;
+
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->irq_stat);
+	clkevt->dev.event_handler(&clkevt->dev);
+
+	return IRQ_HANDLED;
+}
+
+static int dmtimer_set_next_event(unsigned long cycles,
+				  struct clock_event_device *evt)
+{
+	struct dmtimer_clockevent *clkevt = to_dmtimer_clockevent(evt);
+	struct dmtimer_systimer *t = &clkevt->t;
+	void __iomem *pend = t->base + t->pend;
+
+	writel_relaxed(0xffffffff - cycles, t->base + t->counter);
+	while (readl_relaxed(pend) & WP_TCRR)
+		cpu_relax();
+
+	writel_relaxed(OMAP_TIMER_CTRL_ST, t->base + t->ctrl);
+	while (readl_relaxed(pend) & WP_TCLR)
+		cpu_relax();
+
+	return 0;
+}
+
+static int dmtimer_clockevent_shutdown(struct clock_event_device *evt)
+{
+	struct dmtimer_clockevent *clkevt = to_dmtimer_clockevent(evt);
+	struct dmtimer_systimer *t = &clkevt->t;
+	void __iomem *ctrl = t->base + t->ctrl;
+	u32 l;
+
+	l = readl_relaxed(ctrl);
+	if (l & OMAP_TIMER_CTRL_ST) {
+		l &= ~BIT(0);
+		writel_relaxed(l, ctrl);
+		/* Flush posted write */
+		l = readl_relaxed(ctrl);
+		/*  Wait for functional clock period x 3.5 */
+		udelay(3500000 / t->rate + 1);
+	}
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->irq_stat);
+
+	return 0;
+}
+
+static int dmtimer_set_periodic(struct clock_event_device *evt)
+{
+	struct dmtimer_clockevent *clkevt = to_dmtimer_clockevent(evt);
+	struct dmtimer_systimer *t = &clkevt->t;
+	void __iomem *pend = t->base + t->pend;
+
+	dmtimer_clockevent_shutdown(evt);
+
+	/* Looks like we need to first set the load value separately */
+	writel_relaxed(clkevt->period, t->base + t->load);
+	while (readl_relaxed(pend) & WP_TLDR)
+		cpu_relax();
+
+	writel_relaxed(clkevt->period, t->base + t->counter);
+	while (readl_relaxed(pend) & WP_TCRR)
+		cpu_relax();
+
+	writel_relaxed(OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
+		       t->base + t->ctrl);
+	while (readl_relaxed(pend) & WP_TCLR)
+		cpu_relax();
+
+	return 0;
+}
+
+static void omap_clockevent_idle(struct clock_event_device *evt)
+{
+	struct dmtimer_clockevent *clkevt = to_dmtimer_clockevent(evt);
+	struct dmtimer_systimer *t = &clkevt->t;
+
+	dmtimer_systimer_disable(t);
+}
+
+static void omap_clockevent_unidle(struct clock_event_device *evt)
+{
+	struct dmtimer_clockevent *clkevt = to_dmtimer_clockevent(evt);
+	struct dmtimer_systimer *t = &clkevt->t;
+
+	dmtimer_systimer_enable(t);
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->irq_ena);
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
+}
+
+static int __init dmtimer_clockevent_init(struct device_node *np)
+{
+	struct dmtimer_clockevent *clkevt;
+	struct clock_event_device *dev;
+	struct dmtimer_systimer *t;
+	int error;
+
+	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
+	if (!clkevt)
+		return -ENOMEM;
+
+	t = &clkevt->t;
+	dev = &clkevt->dev;
+
+	/*
+	 * We mostly use cpuidle_coupled with ARM local timers for runtime,
+	 * so there's probably no use for CLOCK_EVT_FEAT_DYNIRQ here.
+	 */
+	dev->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	dev->rating = 300;
+	dev->set_next_event = dmtimer_set_next_event;
+	dev->set_state_shutdown = dmtimer_clockevent_shutdown;
+	dev->set_state_periodic = dmtimer_set_periodic;
+	dev->set_state_oneshot = dmtimer_clockevent_shutdown;
+	dev->tick_resume = dmtimer_clockevent_shutdown;
+	dev->cpumask = cpu_possible_mask;
+
+	dev->irq = irq_of_parse_and_map(np, 0);
+	if (!dev->irq) {
+		error = -ENXIO;
+		goto err_out_free;
+	}
+
+	error = dmtimer_systimer_setup(np, &clkevt->t);
+	if (error)
+		goto err_out_free;
+
+	clkevt->period = 0xffffffff - DIV_ROUND_CLOSEST(t->rate, HZ);
+
+	/*
+	 * For clock-event timers we never read the timer counter and
+	 * so we are not impacted by errata i103 and i767. Therefore,
+	 * we can safely ignore this errata for clock-event timers.
+	 */
+	writel_relaxed(OMAP_TIMER_CTRL_POSTED, t->base + t->ifctrl);
+
+	error = request_irq(dev->irq, dmtimer_clockevent_interrupt,
+			    IRQF_TIMER, "clockevent", clkevt);
+	if (error)
+		goto err_out_unmap;
+
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->irq_ena);
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
+
+	pr_info("TI gptimer clockevent: %s%lu Hz at %pOF\n",
+		of_find_property(np, "ti,timer-alwon", NULL) ?
+		"always-on " : "", t->rate, np->parent);
+
+	clockevents_config_and_register(dev, t->rate,
+					3, /* Timer internal resynch latency */
+					0xffffffff);
+
+	if (of_device_is_compatible(np, "ti,am33xx") ||
+	    of_device_is_compatible(np, "ti,am43")) {
+		dev->suspend = omap_clockevent_idle;
+		dev->resume = omap_clockevent_unidle;
+	}
+
+	return 0;
+
+err_out_unmap:
+	iounmap(t->base);
+
+err_out_free:
+	kfree(clkevt);
+
+	return error;
+}
+
+/* Clocksource */
+static struct dmtimer_clocksource *
+to_dmtimer_clocksource(struct clocksource *cs)
+{
+	return container_of(cs, struct dmtimer_clocksource, dev);
+}
+
+static u64 dmtimer_clocksource_read_cycles(struct clocksource *cs)
+{
+	struct dmtimer_clocksource *clksrc = to_dmtimer_clocksource(cs);
+	struct dmtimer_systimer *t = &clksrc->t;
+
+	return (u64)readl_relaxed(t->base + t->counter);
+}
+
+static void __iomem *dmtimer_sched_clock_counter;
+
+static u64 notrace dmtimer_read_sched_clock(void)
+{
+	return readl_relaxed(dmtimer_sched_clock_counter);
+}
+
+static void dmtimer_clocksource_suspend(struct clocksource *cs)
+{
+	struct dmtimer_clocksource *clksrc = to_dmtimer_clocksource(cs);
+	struct dmtimer_systimer *t = &clksrc->t;
+
+	clksrc->loadval = readl_relaxed(t->base + t->counter);
+	dmtimer_systimer_disable(t);
+}
+
+static void dmtimer_clocksource_resume(struct clocksource *cs)
+{
+	struct dmtimer_clocksource *clksrc = to_dmtimer_clocksource(cs);
+	struct dmtimer_systimer *t = &clksrc->t;
+
+	dmtimer_systimer_enable(t);
+	writel_relaxed(clksrc->loadval, t->base + t->counter);
+	writel_relaxed(OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR,
+		       t->base + t->ctrl);
+}
+
+static int __init dmtimer_clocksource_init(struct device_node *np)
+{
+	struct dmtimer_clocksource *clksrc;
+	struct dmtimer_systimer *t;
+	struct clocksource *dev;
+	int error;
+
+	clksrc = kzalloc(sizeof(*clksrc), GFP_KERNEL);
+	if (!clksrc)
+		return -ENOMEM;
+
+	dev = &clksrc->dev;
+	t = &clksrc->t;
+
+	error = dmtimer_systimer_setup(np, t);
+	if (error)
+		goto err_out_free;
+
+	dev->name = "dmtimer";
+	dev->rating = 300;
+	dev->read = dmtimer_clocksource_read_cycles;
+	dev->mask = CLOCKSOURCE_MASK(32);
+	dev->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	if (of_device_is_compatible(np, "ti,am33xx") ||
+	    of_device_is_compatible(np, "ti,am43")) {
+		dev->suspend = dmtimer_clocksource_suspend;
+		dev->resume = dmtimer_clocksource_resume;
+	}
+
+	writel_relaxed(0, t->base + t->counter);
+	writel_relaxed(OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR,
+		       t->base + t->ctrl);
+
+	pr_info("TI gptimer clocksource: %s%pOF\n",
+		of_find_property(np, "ti,timer-alwon", NULL) ?
+		"always-on " : "", np->parent);
+
+	if (!dmtimer_sched_clock_counter) {
+		dmtimer_sched_clock_counter = t->base + t->counter;
+		sched_clock_register(dmtimer_read_sched_clock, 32, t->rate);
+	}
+
+	if (clocksource_register_hz(dev, t->rate))
+		pr_err("Could not register clocksource %pOF\n", np);
+
+	return 0;
+
+err_out_free:
+	kfree(clksrc);
+
+	return -ENODEV;
+}
+
+/*
+ * To detect between a clocksource and clockevent, we assume the device tree
+ * has no interrupts configured for a clocksource timer.
+ */
+static int __init dmtimer_systimer_init(struct device_node *np)
+{
+	const __be32 *addr;
+	u32 pa;
+
+	/* One time init for the preferred timer configuration */
+	if (!clocksource && !clockevent)
+		dmtimer_systimer_select_best();
+
+	if (!clocksource && !clockevent) {
+		pr_err("%s: unable to detect system timers, update dtb?\n",
+		       __func__);
+
+		return -EINVAL;
+	}
+
+	addr = of_get_address(np, 0, NULL, NULL);
+	pa = of_translate_address(np, addr);
+	if (!pa)
+		return -EINVAL;
+
+	if (counter_32k <= 0 && clocksource == pa)
+		return dmtimer_clocksource_init(np);
+
+	if (clockevent == pa)
+		return dmtimer_clockevent_init(np);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(systimer_omap2, "ti,omap2420-timer", dmtimer_systimer_init);
+TIMER_OF_DECLARE(systimer_omap3, "ti,omap3430-timer", dmtimer_systimer_init);
+TIMER_OF_DECLARE(systimer_omap4, "ti,omap4430-timer", dmtimer_systimer_init);
+TIMER_OF_DECLARE(systimer_omap5, "ti,omap5430-timer", dmtimer_systimer_init);
+TIMER_OF_DECLARE(systimer_am33x, "ti,am335x-timer", dmtimer_systimer_init);
+TIMER_OF_DECLARE(systimer_am3ms, "ti,am335x-timer-1ms", dmtimer_systimer_init);
+TIMER_OF_DECLARE(systimer_dm814, "ti,dm814-timer", dmtimer_systimer_init);
+TIMER_OF_DECLARE(systimer_dm816, "ti,dm816-timer", dmtimer_systimer_init);
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 2531eab3d6d7..60aff087947a 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -258,9 +258,7 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	__omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);
 
-	rc = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
-
-	return rc;
+	return 0;
 }
 
 static inline u32 omap_dm_timer_reserved_systimer(int id)
diff --git a/drivers/clocksource/timer-versatile.c b/drivers/clocksource/timer-versatile.c
index e4ebb656d005..f5d017b31afa 100644
--- a/drivers/clocksource/timer-versatile.c
+++ b/drivers/clocksource/timer-versatile.c
@@ -6,6 +6,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/sched_clock.h>
 
@@ -22,6 +23,8 @@ static int __init versatile_sched_clock_init(struct device_node *node)
 {
 	void __iomem *base = of_iomap(node, 0);
 
+	of_node_clear_flag(node, OF_POPULATED);
+
 	if (!base)
 		return -ENXIO;
 

