Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20CFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DD02068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFBMIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFBMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:08:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:08:54 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jg5it-0004cU-Kj; Tue, 02 Jun 2020 14:08:52 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id AF234100D32;
        Tue,  2 Jun 2020 14:08:50 +0200 (CEST)
Date:   Tue, 02 Jun 2020 12:08:09 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v5.8
Message-ID: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
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

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-06-02

up to:  d77aeb5d403d: irqchip: Fix "Loongson HyperTransport Vector support" driver build on all non-MIPS platforms

The generic interrupt departement provides:

  - Cleanup of the irq_domain API
  - Overhaul of the interrupt chip simulator
  - The usual pile of new interrupt chip drivers
  - Cleanups, improvements and fixes all over the place

Thanks,

	tglx

------------------>
Andy Shevchenko (3):
      irqdomain: Make __irq_domain_add() less OF-dependent
      irqdomain: Get rid of special treatment for ACPI in __irq_domain_add()
      irqdomain: Allow software nodes for IRQ domain creation

Anup Patel (3):
      irqchip/sifive-plic: Set default irq affinity in plic_irqdomain_map()
      irqchip/sifive-plic: Setup cpuhp once after boot CPU handler is present
      irqchip/sifive-plic: Improve boot prints for multiple PLIC instances

Bartosz Golaszewski (2):
      irqdomain: Make irq_domain_reset_irq_data() available to  non-hierarchical users
      genirq/irq_sim: Simplify the API

Dan Carpenter (1):
      iio: dummy_evgen: Fix use after free on error in iio_dummy_evgen_create()

Ingo Molnar (1):
      irqchip: Fix "Loongson HyperTransport Vector support" driver build on all non-MIPS platforms

Ingo Rohloff (1):
      irqchip/gic-v3: Fix missing "__init" for gic_smp_init()

Jiaxun Yang (6):
      irqchip: Add Loongson HyperTransport Vector support
      dt-bindings: interrupt-controller: Add Loongson HTVEC
      irqchip: Add Loongson PCH PIC controller
      dt-bindings: interrupt-controller: Add Loongson PCH PIC
      irqchip: Add Loongson PCH MSI controller
      dt-bindings: interrupt-controller: Add Loongson PCH MSI

Marc Zyngier (2):
      irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
      irqchip/gic-v3-its: Balance initial LPI affinity across CPUs

Marek Vasut (1):
      genirq: Check irq_data_get_irq_chip() return value before use

Shaokun Zhang (1):
      platform-msi: Fix typos in comment

Valentin Schneider (1):
      irqchip/gic-v2, v3: Drop extra IRQ_NOAUTOEN setting for (E)PPIs

Wesley W. Terpstra (1):
      irqchip/sifive-plic: Remove incorrect requirement about number of irq contexts


 .../interrupt-controller/loongson,htvec.yaml       |  57 +++++
 .../interrupt-controller/loongson,pch-msi.yaml     |  62 +++++
 .../interrupt-controller/loongson,pch-pic.yaml     |  56 +++++
 drivers/base/platform-msi.c                        |   2 +-
 drivers/gpio/gpio-mockup.c                         |  53 +++-
 drivers/iio/dummy/iio_dummy_evgen.c                |  31 ++-
 drivers/irqchip/Kconfig                            |  27 +++
 drivers/irqchip/Makefile                           |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   | 170 ++++++++++---
 drivers/irqchip/irq-gic-v3.c                       |   3 +-
 drivers/irqchip/irq-gic.c                          |   1 -
 drivers/irqchip/irq-loongson-htvec.c               | 214 +++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c             | 255 ++++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-pic.c             | 243 +++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c                  |  23 +-
 include/linux/irq_sim.h                            |  33 +--
 include/linux/irqdomain.h                          |   2 +-
 kernel/irq/Kconfig                                 |   1 +
 kernel/irq/irq_sim.c                               | 267 +++++++++++++--------
 kernel/irq/irqdomain.c                             |  53 ++--
 kernel/irq/manage.c                                |   4 +
 21 files changed, 1340 insertions(+), 220 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
 create mode 100644 drivers/irqchip/irq-loongson-htvec.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-msi.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-pic.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
new file mode 100644
index 000000000000..e865cd8f96a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,htvec.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson-3 HyperTransport Interrupt Vector Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description:
+  This interrupt controller is found in the Loongson-3 family of chips for
+  receiving vectorized interrupts from PCH's interrupt controller.
+
+properties:
+  compatible:
+    const: loongson,htvec-1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+    description: Four parent interrupts that receive chained interrupts.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    htvec: interrupt-controller@fb000080 {
+      compatible = "loongson,htvec-1.0";
+      reg = <0xfb000080 0x40>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interrupt-parent = <&liointc>;
+      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+                    <25 IRQ_TYPE_LEVEL_HIGH>,
+                    <26 IRQ_TYPE_LEVEL_HIGH>,
+                    <27 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
new file mode 100644
index 000000000000..1a5ebbdd219a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,pch-msi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson PCH MSI Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description:
+  This interrupt controller is found in the Loongson LS7A family of PCH for
+  transforming interrupts from PCIe MSI into HyperTransport vectorized
+  interrupts.
+
+properties:
+  compatible:
+    const: loongson,pch-msi-1.0
+
+  reg:
+    maxItems: 1
+
+  loongson,msi-base-vec:
+    description:
+      u32 value of the base of parent HyperTransport vector allocated
+      to PCH MSI.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+        maximum: 255
+
+  loongson,msi-num-vecs:
+    description:
+      u32 value of the number of parent HyperTransport vectors allocated
+      to PCH MSI.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 1
+        maximum: 256
+
+  msi-controller: true
+
+required:
+  - compatible
+  - reg
+  - msi-controller
+  - loongson,msi-base-vec
+  - loongson,msi-num-vecs
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    msi: msi-controller@2ff00000 {
+      compatible = "loongson,pch-msi-1.0";
+      reg = <0x2ff00000 0x4>;
+      msi-controller;
+      loongson,msi-base-vec = <64>;
+      loongson,msi-num-vecs = <64>;
+      interrupt-parent = <&htvec>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
new file mode 100644
index 000000000000..274adea13f33
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,pch-pic.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson PCH PIC Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description:
+  This interrupt controller is found in the Loongson LS7A family of PCH for
+  transforming interrupts from on-chip devices into HyperTransport vectorized
+  interrupts.
+
+properties:
+  compatible:
+    const: loongson,pch-pic-1.0
+
+  reg:
+    maxItems: 1
+
+  loongson,pic-base-vec:
+    description:
+      u32 value of the base of parent HyperTransport vector allocated
+      to PCH PIC.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+        maximum: 192
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - loongson,pic-base-vec
+  - interrupt-controller
+  - '#interrupt-cells'
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pic: interrupt-controller@10000000 {
+      compatible = "loongson,pch-pic-1.0";
+      reg = <0x10000000 0x400>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      loongson,pic-base-vec = <64>;
+      interrupt-parent = <&htvec>;
+    };
+...
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8da314b81eab..c4a17e5edf8b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -387,7 +387,7 @@ void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
  *
  * @domain:	The platform-msi domain
  * @virq:	The base irq from which to perform the allocate operation
- * @nvec:	How many interrupts to free from @virq
+ * @nr_irqs:	How many interrupts to free from @virq
  *
  * Return 0 on success, or an error code on failure. Must be called
  * with irq_domain_mutex held (which can only be done as part of a
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 3eb94f3740d1..bc345185db26 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -48,7 +49,7 @@ struct gpio_mockup_line_status {
 struct gpio_mockup_chip {
 	struct gpio_chip gc;
 	struct gpio_mockup_line_status *lines;
-	struct irq_sim irqsim;
+	struct irq_domain *irq_sim_domain;
 	struct dentry *dbg_dir;
 	struct mutex lock;
 };
@@ -144,14 +145,12 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 				  unsigned int offset, int value)
 {
+	int curr, irq, irq_type, ret = 0;
 	struct gpio_desc *desc;
 	struct gpio_chip *gc;
-	struct irq_sim *sim;
-	int curr, irq, irq_type;
 
 	gc = &chip->gc;
 	desc = &gc->gpiodev->descs[offset];
-	sim = &chip->irqsim;
 
 	mutex_lock(&chip->lock);
 
@@ -161,14 +160,28 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 		if (curr == value)
 			goto out;
 
-		irq = irq_sim_irqnum(sim, offset);
+		irq = irq_find_mapping(chip->irq_sim_domain, offset);
+		if (!irq)
+			/*
+			 * This is fine - it just means, nobody is listening
+			 * for interrupts on this line, otherwise
+			 * irq_create_mapping() would have been called from
+			 * the to_irq() callback.
+			 */
+			goto set_value;
+
 		irq_type = irq_get_trigger_type(irq);
 
 		if ((value == 1 && (irq_type & IRQ_TYPE_EDGE_RISING)) ||
-		    (value == 0 && (irq_type & IRQ_TYPE_EDGE_FALLING)))
-			irq_sim_fire(sim, offset);
+		    (value == 0 && (irq_type & IRQ_TYPE_EDGE_FALLING))) {
+			ret = irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING,
+						    true);
+			if (ret)
+				goto out;
+		}
 	}
 
+set_value:
 	/* Change the value unless we're actively driving the line. */
 	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
 	    !test_bit(FLAG_IS_OUT, &desc->flags))
@@ -177,7 +190,7 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 out:
 	chip->lines[offset].pull = value;
 	mutex_unlock(&chip->lock);
-	return 0;
+	return ret;
 }
 
 static int gpio_mockup_set_config(struct gpio_chip *gc,
@@ -236,7 +249,7 @@ static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	return irq_sim_irqnum(&chip->irqsim, offset);
+	return irq_create_mapping(chip->irq_sim_domain, offset);
 }
 
 static void gpio_mockup_free(struct gpio_chip *gc, unsigned int offset)
@@ -389,6 +402,19 @@ static int gpio_mockup_name_lines(struct device *dev,
 	return 0;
 }
 
+static void gpio_mockup_dispose_mappings(void *data)
+{
+	struct gpio_mockup_chip *chip = data;
+	struct gpio_chip *gc = &chip->gc;
+	int i, irq;
+
+	for (i = 0; i < gc->ngpio; i++) {
+		irq = irq_find_mapping(chip->irq_sim_domain, i);
+		if (irq)
+			irq_dispose_mapping(irq);
+	}
+}
+
 static int gpio_mockup_probe(struct platform_device *pdev)
 {
 	struct gpio_mockup_chip *chip;
@@ -456,8 +482,13 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 			return rv;
 	}
 
-	rv = devm_irq_sim_init(dev, &chip->irqsim, gc->ngpio);
-	if (rv < 0)
+	chip->irq_sim_domain = devm_irq_domain_create_sim(dev, NULL,
+							  gc->ngpio);
+	if (IS_ERR(chip->irq_sim_domain))
+		return PTR_ERR(chip->irq_sim_domain);
+
+	rv = devm_add_action_or_reset(dev, gpio_mockup_dispose_mappings, chip);
+	if (rv)
 		return rv;
 
 	rv = devm_gpiochip_add_data(dev, &chip->gc, chip);
diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index a6edf30567aa..ee85d596e528 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -37,8 +37,7 @@ struct iio_dummy_eventgen {
 	struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
 	struct mutex lock;
 	bool inuse[IIO_EVENTGEN_NO];
-	struct irq_sim irq_sim;
-	int base;
+	struct irq_domain *irq_sim_domain;
 };
 
 /* We can only ever have one instance of this 'device' */
@@ -52,13 +51,14 @@ static int iio_dummy_evgen_create(void)
 	if (!iio_evgen)
 		return -ENOMEM;
 
-	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
-	if (ret < 0) {
+	iio_evgen->irq_sim_domain = irq_domain_create_sim(NULL,
+							  IIO_EVENTGEN_NO);
+	if (IS_ERR(iio_evgen->irq_sim_domain)) {
+		ret = PTR_ERR(iio_evgen->irq_sim_domain);
 		kfree(iio_evgen);
 		return ret;
 	}
 
-	iio_evgen->base = irq_sim_irqnum(&iio_evgen->irq_sim, 0);
 	mutex_init(&iio_evgen->lock);
 
 	return 0;
@@ -80,7 +80,7 @@ int iio_dummy_evgen_get_irq(void)
 	mutex_lock(&iio_evgen->lock);
 	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
 		if (!iio_evgen->inuse[i]) {
-			ret = irq_sim_irqnum(&iio_evgen->irq_sim, i);
+			ret = irq_create_mapping(iio_evgen->irq_sim_domain, i);
 			iio_evgen->inuse[i] = true;
 			break;
 		}
@@ -101,21 +101,27 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_irq);
  */
 void iio_dummy_evgen_release_irq(int irq)
 {
+	struct irq_data *irqd = irq_get_irq_data(irq);
+
 	mutex_lock(&iio_evgen->lock);
-	iio_evgen->inuse[irq - iio_evgen->base] = false;
+	iio_evgen->inuse[irqd_to_hwirq(irqd)] = false;
+	irq_dispose_mapping(irq);
 	mutex_unlock(&iio_evgen->lock);
 }
 EXPORT_SYMBOL_GPL(iio_dummy_evgen_release_irq);
 
 struct iio_dummy_regs *iio_dummy_evgen_get_regs(int irq)
 {
-	return &iio_evgen->regs[irq - iio_evgen->base];
+	struct irq_data *irqd = irq_get_irq_data(irq);
+
+	return &iio_evgen->regs[irqd_to_hwirq(irqd)];
+
 }
 EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
 
 static void iio_dummy_evgen_free(void)
 {
-	irq_sim_fini(&iio_evgen->irq_sim);
+	irq_domain_remove_sim(iio_evgen->irq_sim_domain);
 	kfree(iio_evgen);
 }
 
@@ -131,7 +137,7 @@ static ssize_t iio_evgen_poke(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned long event;
-	int ret;
+	int ret, irq;
 
 	ret = kstrtoul(buf, 10, &event);
 	if (ret)
@@ -140,7 +146,10 @@ static ssize_t iio_evgen_poke(struct device *dev,
 	iio_evgen->regs[this_attr->address].reg_id   = this_attr->address;
 	iio_evgen->regs[this_attr->address].reg_data = event;
 
-	irq_sim_fire(&iio_evgen->irq_sim, this_attr->address);
+	irq = irq_find_mapping(iio_evgen->irq_sim_domain, this_attr->address);
+	ret = irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true);
+	if (ret)
+		return ret;
 
 	return len;
 }
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a85aada04a64..66b9a68f5e9f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -532,4 +532,31 @@ config LOONGSON_HTPIC
 	help
 	  Support for the Loongson-3 HyperTransport PIC Controller.
 
+config LOONGSON_HTVEC
+	bool "Loongson3 HyperTransport Interrupt Vector Controller"
+	depends on MACH_LOONGSON64
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Loongson3 HyperTransport Interrupt Vector Controller.
+
+config LOONGSON_PCH_PIC
+	bool "Loongson PCH PIC Controller"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
+	help
+	  Support for the Loongson PCH PIC Controller.
+
+config LOONGSON_PCH_MSI
+	bool "Loongson PCH PIC Controller"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on PCI
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	select PCI_MSI
+	help
+	  Support for the Loongson PCH MSI Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 37bbe39bf909..3a4ce283189a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -107,3 +107,6 @@ obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
+obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
+obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
+obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 124251b0ccba..cd685f521c77 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -174,6 +174,13 @@ static struct {
 	int			next_victim;
 } vpe_proxy;
 
+struct cpu_lpi_count {
+	atomic_t	managed;
+	atomic_t	unmanaged;
+};
+
+static DEFINE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
+
 static LIST_HEAD(its_nodes);
 static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
@@ -1510,42 +1517,159 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_update_config(d, 0, LPI_PROP_ENABLED);
 }
 
+static __maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+
+	return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
+static void its_inc_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+	else
+		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
+static void its_dec_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+	else
+		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
+static unsigned int cpumask_pick_least_loaded(struct irq_data *d,
+					      const struct cpumask *cpu_mask)
+{
+	unsigned int cpu = nr_cpu_ids, tmp;
+	int count = S32_MAX;
+
+	for_each_cpu(tmp, cpu_mask) {
+		int this_count = its_read_lpi_count(d, tmp);
+		if (this_count < count) {
+			cpu = tmp;
+		        count = this_count;
+		}
+	}
+
+	return cpu;
+}
+
+/*
+ * As suggested by Thomas Gleixner in:
+ * https://lore.kernel.org/r/87h80q2aoc.fsf@nanos.tec.linutronix.de
+ */
+static int its_select_cpu(struct irq_data *d,
+			  const struct cpumask *aff_mask)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	cpumask_var_t tmpmask;
+	int cpu, node;
+
+	if (!alloc_cpumask_var(&tmpmask, GFP_ATOMIC))
+		return -ENOMEM;
+
+	node = its_dev->its->numa_node;
+
+	if (!irqd_affinity_is_managed(d)) {
+		/* First try the NUMA node */
+		if (node != NUMA_NO_NODE) {
+			/*
+			 * Try the intersection of the affinity mask and the
+			 * node mask (and the online mask, just to be safe).
+			 */
+			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
+			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
+
+			/*
+			 * Ideally, we would check if the mask is empty, and
+			 * try again on the full node here.
+			 *
+			 * But it turns out that the way ACPI describes the
+			 * affinity for ITSs only deals about memory, and
+			 * not target CPUs, so it cannot describe a single
+			 * ITS placed next to two NUMA nodes.
+			 *
+			 * Instead, just fallback on the online mask. This
+			 * diverges from Thomas' suggestion above.
+			 */
+			cpu = cpumask_pick_least_loaded(d, tmpmask);
+			if (cpu < nr_cpu_ids)
+				goto out;
+
+			/* If we can't cross sockets, give up */
+			if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144))
+				goto out;
+
+			/* If the above failed, expand the search */
+		}
+
+		/* Try the intersection of the affinity and online masks */
+		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
+
+		/* If that doesn't fly, the online mask is the last resort */
+		if (cpumask_empty(tmpmask))
+			cpumask_copy(tmpmask, cpu_online_mask);
+
+		cpu = cpumask_pick_least_loaded(d, tmpmask);
+	} else {
+		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+
+		/* If we cannot cross sockets, limit the search to that node */
+		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
+		    node != NUMA_NO_NODE)
+			cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
+
+		cpu = cpumask_pick_least_loaded(d, tmpmask);
+	}
+out:
+	free_cpumask_var(tmpmask);
+
+	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);
+	return cpu;
+}
+
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	unsigned int cpu;
-	const struct cpumask *cpu_mask = cpu_online_mask;
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_collection *target_col;
 	u32 id = its_get_event_id(d);
+	int cpu, prev_cpu;
 
 	/* A forwarded interrupt should use irq_set_vcpu_affinity */
 	if (irqd_is_forwarded_to_vcpu(d))
 		return -EINVAL;
 
-       /* lpi cannot be routed to a redistributor that is on a foreign node */
-	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
-		if (its_dev->its->numa_node >= 0) {
-			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
-			if (!cpumask_intersects(mask_val, cpu_mask))
-				return -EINVAL;
-		}
-	}
+	prev_cpu = its_dev->event_map.col_map[id];
+	its_dec_lpi_count(d, prev_cpu);
 
-	cpu = cpumask_any_and(mask_val, cpu_mask);
+	if (!force)
+		cpu = its_select_cpu(d, mask_val);
+	else
+		cpu = cpumask_pick_least_loaded(d, mask_val);
 
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		goto err;
 
 	/* don't set the affinity when the target cpu is same as current one */
-	if (cpu != its_dev->event_map.col_map[id]) {
+	if (cpu != prev_cpu) {
 		target_col = &its_dev->its->collections[cpu];
 		its_send_movi(its_dev, target_col, id);
 		its_dev->event_map.col_map[id] = cpu;
 		irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	}
 
+	its_inc_lpi_count(d, cpu);
+
 	return IRQ_SET_MASK_OK_DONE;
+
+err:
+	its_inc_lpi_count(d, prev_cpu);
+	return -EINVAL;
 }
 
 static u64 its_irq_get_msi_base(struct its_device *its_dev)
@@ -3432,22 +3556,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	const struct cpumask *cpu_mask = cpu_online_mask;
 	int cpu;
 
-	/* get the cpu_mask of local node */
-	if (its_dev->its->numa_node >= 0)
-		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
-
-	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids) {
-		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
-			return -EINVAL;
-
-		cpu = cpumask_first(cpu_online_mask);
-	}
+	cpu = its_select_cpu(d, cpu_online_mask);
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
 
+	its_inc_lpi_count(d, cpu);
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -3462,6 +3577,7 @@ static void its_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
 
+	its_dec_lpi_count(d, its_dev->event_map.col_map[event]);
 	/* Stop the delivery of interrupts */
 	its_send_discard(its_dev, event);
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7006ef18a0d..cc46bc2d634b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1150,7 +1150,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	isb();
 }
 
-static void gic_smp_init(void)
+static void __init gic_smp_init(void)
 {
 	set_smp_cross_call(gic_raise_softirq);
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
@@ -1282,7 +1282,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		break;
 
 	case SPI_RANGE:
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30ab623343d3..00de05abd3c3 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -982,7 +982,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	} else {
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
new file mode 100644
index 000000000000..1ece9337c78d
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson HyperTransport Interrupt Vector support
+ */
+
+#define pr_fmt(fmt) "htvec: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+/* Registers */
+#define HTVEC_EN_OFF		0x20
+#define HTVEC_MAX_PARENT_IRQ	4
+
+#define VEC_COUNT_PER_REG	32
+#define VEC_REG_COUNT		4
+#define VEC_COUNT		(VEC_COUNT_PER_REG * VEC_REG_COUNT)
+#define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
+#define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
+
+struct htvec {
+	void __iomem		*base;
+	struct irq_domain	*htvec_domain;
+	raw_spinlock_t		htvec_lock;
+};
+
+static void htvec_irq_dispatch(struct irq_desc *desc)
+{
+	int i;
+	u32 pending;
+	bool handled = false;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct htvec *priv = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < VEC_REG_COUNT; i++) {
+		pending = readl(priv->base + 4 * i);
+		while (pending) {
+			int bit = __ffs(pending);
+
+			generic_handle_irq(irq_linear_revmap(priv->htvec_domain, bit +
+							     VEC_COUNT_PER_REG * i));
+			pending &= ~BIT(bit);
+			handled = true;
+		}
+	}
+
+	if (!handled)
+		spurious_interrupt();
+
+	chained_irq_exit(chip, desc);
+}
+
+static void htvec_ack_irq(struct irq_data *d)
+{
+	struct htvec *priv = irq_data_get_irq_chip_data(d);
+
+	writel(BIT(VEC_REG_BIT(d->hwirq)),
+	       priv->base + VEC_REG_IDX(d->hwirq) * 4);
+}
+
+static void htvec_mask_irq(struct irq_data *d)
+{
+	u32 reg;
+	void __iomem *addr;
+	struct htvec *priv = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&priv->htvec_lock);
+	addr = priv->base + HTVEC_EN_OFF;
+	addr += VEC_REG_IDX(d->hwirq) * 4;
+	reg = readl(addr);
+	reg &= ~BIT(VEC_REG_BIT(d->hwirq));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->htvec_lock);
+}
+
+static void htvec_unmask_irq(struct irq_data *d)
+{
+	u32 reg;
+	void __iomem *addr;
+	struct htvec *priv = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&priv->htvec_lock);
+	addr = priv->base + HTVEC_EN_OFF;
+	addr += VEC_REG_IDX(d->hwirq) * 4;
+	reg = readl(addr);
+	reg |= BIT(VEC_REG_BIT(d->hwirq));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->htvec_lock);
+}
+
+static struct irq_chip htvec_irq_chip = {
+	.name			= "LOONGSON_HTVEC",
+	.irq_mask		= htvec_mask_irq,
+	.irq_unmask		= htvec_unmask_irq,
+	.irq_ack		= htvec_ack_irq,
+};
+
+static int htvec_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs, void *arg)
+{
+	unsigned long hwirq;
+	unsigned int type, i;
+	struct htvec *priv = domain->host_data;
+
+	irq_domain_translate_onecell(domain, arg, &hwirq, &type);
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i, &htvec_irq_chip,
+				    priv, handle_edge_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void htvec_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops htvec_domain_ops = {
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= htvec_domain_alloc,
+	.free		= htvec_domain_free,
+};
+
+static void htvec_reset(struct htvec *priv)
+{
+	u32 idx;
+
+	/* Clear IRQ cause registers, mask all interrupts */
+	for (idx = 0; idx < VEC_REG_COUNT; idx++) {
+		writel_relaxed(0x0, priv->base + HTVEC_EN_OFF + 4 * idx);
+		writel_relaxed(0xFFFFFFFF, priv->base);
+	}
+}
+
+static int htvec_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	struct htvec *priv;
+	int err, parent_irq[4], num_parents = 0, i;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->htvec_lock);
+	priv->base = of_iomap(node, 0);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto free_priv;
+	}
+
+	/* Interrupt may come from any of the 4 interrupt line */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
+		parent_irq[i] = irq_of_parse_and_map(node, i);
+		if (parent_irq[i] <= 0)
+			break;
+
+		num_parents++;
+	}
+
+	if (!num_parents) {
+		pr_err("Failed to get parent irqs\n");
+		err = -ENODEV;
+		goto iounmap_base;
+	}
+
+	priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+						      VEC_COUNT,
+						      &htvec_domain_ops,
+						      priv);
+	if (!priv->htvec_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		err = -ENOMEM;
+		goto iounmap_base;
+	}
+
+	htvec_reset(priv);
+
+	for (i = 0; i < num_parents; i++)
+		irq_set_chained_handler_and_data(parent_irq[i],
+						 htvec_irq_dispatch, priv);
+
+	return 0;
+
+iounmap_base:
+	iounmap(priv->base);
+free_priv:
+	kfree(priv);
+
+	return err;
+}
+
+IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
new file mode 100644
index 000000000000..50becd21008c
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson PCH MSI support
+ */
+
+#define pr_fmt(fmt) "pch-msi: " fmt
+
+#include <linux/irqchip.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+struct pch_msi_data {
+	struct mutex	msi_map_lock;
+	phys_addr_t	doorbell;
+	u32		irq_first;	/* The vector number that MSIs starts */
+	u32		num_irqs;	/* The number of vectors for MSIs */
+	unsigned long	*msi_map;
+};
+
+static void pch_msi_mask_msi_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void pch_msi_unmask_msi_irq(struct irq_data *d)
+{
+	irq_chip_unmask_parent(d);
+	pci_msi_unmask_irq(d);
+}
+
+static struct irq_chip pch_msi_irq_chip = {
+	.name			= "PCH PCI MSI",
+	.irq_mask		= pch_msi_mask_msi_irq,
+	.irq_unmask		= pch_msi_unmask_msi_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static int pch_msi_allocate_hwirq(struct pch_msi_data *priv, int num_req)
+{
+	int first;
+
+	mutex_lock(&priv->msi_map_lock);
+
+	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
+					get_count_order(num_req));
+	if (first < 0) {
+		mutex_unlock(&priv->msi_map_lock);
+		return -ENOSPC;
+	}
+
+	mutex_unlock(&priv->msi_map_lock);
+
+	return priv->irq_first + first;
+}
+
+static void pch_msi_free_hwirq(struct pch_msi_data *priv,
+				int hwirq, int num_req)
+{
+	int first = hwirq - priv->irq_first;
+
+	mutex_lock(&priv->msi_map_lock);
+	bitmap_release_region(priv->msi_map, first, get_count_order(num_req));
+	mutex_unlock(&priv->msi_map_lock);
+}
+
+static void pch_msi_compose_msi_msg(struct irq_data *data,
+					struct msi_msg *msg)
+{
+	struct pch_msi_data *priv = irq_data_get_irq_chip_data(data);
+
+	msg->address_hi = upper_32_bits(priv->doorbell);
+	msg->address_lo = lower_32_bits(priv->doorbell);
+	msg->data = data->hwirq;
+}
+
+static struct msi_domain_info pch_msi_domain_info = {
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+	.chip	= &pch_msi_irq_chip,
+};
+
+static struct irq_chip middle_irq_chip = {
+	.name			= "PCH MSI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_compose_msi_msg	= pch_msi_compose_msi_msg,
+};
+
+static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
+					unsigned int virq, int hwirq)
+{
+	struct irq_fwspec fwspec;
+	int ret;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hwirq;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
+					   unsigned int virq,
+					   unsigned int nr_irqs, void *args)
+{
+	struct pch_msi_data *priv = domain->host_data;
+	int hwirq, err, i;
+
+	hwirq = pch_msi_allocate_hwirq(priv, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = pch_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto err_hwirq;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &middle_irq_chip, priv);
+	}
+
+	return 0;
+
+err_hwirq:
+	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
+	irq_domain_free_irqs_parent(domain, virq, i - 1);
+
+	return err;
+}
+
+static void pch_msi_middle_domain_free(struct irq_domain *domain,
+					   unsigned int virq,
+					   unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct pch_msi_data *priv = irq_data_get_irq_chip_data(d);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	pch_msi_free_hwirq(priv, d->hwirq, nr_irqs);
+}
+
+static const struct irq_domain_ops pch_msi_middle_domain_ops = {
+	.alloc	= pch_msi_middle_domain_alloc,
+	.free	= pch_msi_middle_domain_free,
+};
+
+static int pch_msi_init_domains(struct pch_msi_data *priv,
+				struct device_node *node,
+				struct irq_domain *parent)
+{
+	struct irq_domain *middle_domain, *msi_domain;
+
+	middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+						priv->num_irqs,
+						&pch_msi_middle_domain_ops,
+						priv);
+	if (!middle_domain) {
+		pr_err("Failed to create the MSI middle domain\n");
+		return -ENOMEM;
+	}
+
+	middle_domain->parent = parent;
+	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
+
+	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+					       &pch_msi_domain_info,
+					       middle_domain);
+	if (!msi_domain) {
+		pr_err("Failed to create PCI MSI domain\n");
+		irq_domain_remove(middle_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int pch_msi_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	struct pch_msi_data *priv;
+	struct irq_domain *parent_domain;
+	struct resource res;
+	int ret;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return -ENXIO;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->msi_map_lock);
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret) {
+		pr_err("Failed to allocate resource\n");
+		goto err_priv;
+	}
+
+	priv->doorbell = res.start;
+
+	if (of_property_read_u32(node, "loongson,msi-base-vec",
+				&priv->irq_first)) {
+		pr_err("Unable to parse MSI vec base\n");
+		ret = -EINVAL;
+		goto err_priv;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-num-vecs",
+				&priv->num_irqs)) {
+		pr_err("Unable to parse MSI vec number\n");
+		ret = -EINVAL;
+		goto err_priv;
+	}
+
+	priv->msi_map = bitmap_alloc(priv->num_irqs, GFP_KERNEL);
+	if (!priv->msi_map) {
+		ret = -ENOMEM;
+		goto err_priv;
+	}
+
+	pr_debug("Registering %d MSIs, starting at %d\n",
+		 priv->num_irqs, priv->irq_first);
+
+	ret = pch_msi_init_domains(priv, node, parent_domain);
+	if (ret)
+		goto err_map;
+
+	return 0;
+
+err_map:
+	kfree(priv->msi_map);
+err_priv:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
new file mode 100644
index 000000000000..2a05b9305012
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson PCH PIC support
+ */
+
+#define pr_fmt(fmt) "pch-pic: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+/* Registers */
+#define PCH_PIC_MASK		0x20
+#define PCH_PIC_HTMSI_EN	0x40
+#define PCH_PIC_EDGE		0x60
+#define PCH_PIC_CLR		0x80
+#define PCH_PIC_AUTO0		0xc0
+#define PCH_PIC_AUTO1		0xe0
+#define PCH_INT_ROUTE(irq)	(0x100 + irq)
+#define PCH_INT_HTVEC(irq)	(0x200 + irq)
+#define PCH_PIC_POL		0x3e0
+
+#define PIC_COUNT_PER_REG	32
+#define PIC_REG_COUNT		2
+#define PIC_COUNT		(PIC_COUNT_PER_REG * PIC_REG_COUNT)
+#define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
+#define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
+
+struct pch_pic {
+	void __iomem		*base;
+	struct irq_domain	*pic_domain;
+	u32			ht_vec_base;
+	raw_spinlock_t		pic_lock;
+};
+
+static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
+{
+	u32 reg;
+	void __iomem *addr = priv->base + offset + PIC_REG_IDX(bit) * 4;
+
+	raw_spin_lock(&priv->pic_lock);
+	reg = readl(addr);
+	reg |= BIT(PIC_REG_BIT(bit));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->pic_lock);
+}
+
+static void pch_pic_bitclr(struct pch_pic *priv, int offset, int bit)
+{
+	u32 reg;
+	void __iomem *addr = priv->base + offset + PIC_REG_IDX(bit) * 4;
+
+	raw_spin_lock(&priv->pic_lock);
+	reg = readl(addr);
+	reg &= ~BIT(PIC_REG_BIT(bit));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->pic_lock);
+}
+
+static void pch_pic_eoi_irq(struct irq_data *d)
+{
+	u32 idx = PIC_REG_IDX(d->hwirq);
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+
+	writel(BIT(PIC_REG_BIT(d->hwirq)),
+			priv->base + PCH_PIC_CLR + idx * 4);
+}
+
+static void pch_pic_mask_irq(struct irq_data *d)
+{
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+
+	pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
+	irq_chip_mask_parent(d);
+}
+
+static void pch_pic_unmask_irq(struct irq_data *d)
+{
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+
+	irq_chip_unmask_parent(d);
+	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
+}
+
+static int pch_pic_set_type(struct irq_data *d, unsigned int type)
+{
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+	int ret = 0;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static struct irq_chip pch_pic_irq_chip = {
+	.name			= "PCH PIC",
+	.irq_mask		= pch_pic_mask_irq,
+	.irq_unmask		= pch_pic_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_eoi		= pch_pic_eoi_irq,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= pch_pic_set_type,
+};
+
+static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs, void *arg)
+{
+	int err;
+	unsigned int type;
+	unsigned long hwirq;
+	struct irq_fwspec fwspec;
+	struct pch_pic *priv = domain->host_data;
+
+	irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hwirq + priv->ht_vec_base;
+
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (err)
+		return err;
+
+	irq_domain_set_info(domain, virq, hwirq,
+			    &pch_pic_irq_chip, priv,
+			    handle_fasteoi_ack_irq, NULL, NULL);
+	irq_set_probe(virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops pch_pic_domain_ops = {
+	.translate	= irq_domain_translate_twocell,
+	.alloc		= pch_pic_alloc,
+	.free		= irq_domain_free_irqs_parent,
+};
+
+static void pch_pic_reset(struct pch_pic *priv)
+{
+	int i;
+
+	for (i = 0; i < PIC_COUNT; i++) {
+		/* Write vectore ID */
+		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
+		/* Hardcode route to HT0 Lo */
+		writeb(1, priv->base + PCH_INT_ROUTE(i));
+	}
+
+	for (i = 0; i < PIC_REG_COUNT; i++) {
+		/* Clear IRQ cause registers, mask all interrupts */
+		writel_relaxed(0xFFFFFFFF, priv->base + PCH_PIC_MASK + 4 * i);
+		writel_relaxed(0xFFFFFFFF, priv->base + PCH_PIC_CLR + 4 * i);
+		/* Clear auto bounce, we don't need that */
+		writel_relaxed(0, priv->base + PCH_PIC_AUTO0 + 4 * i);
+		writel_relaxed(0, priv->base + PCH_PIC_AUTO1 + 4 * i);
+		/* Enable HTMSI transformer */
+		writel_relaxed(0xFFFFFFFF, priv->base + PCH_PIC_HTMSI_EN + 4 * i);
+	}
+}
+
+static int pch_pic_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	struct pch_pic *priv;
+	struct irq_domain *parent_domain;
+	int err;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->pic_lock);
+	priv->base = of_iomap(node, 0);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto free_priv;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		err = -ENXIO;
+		goto iounmap_base;
+	}
+
+	if (of_property_read_u32(node, "loongson,pic-base-vec",
+				&priv->ht_vec_base)) {
+		pr_err("Failed to determine pic-base-vec\n");
+		err = -EINVAL;
+		goto iounmap_base;
+	}
+
+	priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
+						       PIC_COUNT,
+						       of_node_to_fwnode(node),
+						       &pch_pic_domain_ops,
+						       priv);
+	if (!priv->pic_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		err = -ENOMEM;
+		goto iounmap_base;
+	}
+
+	pch_pic_reset(priv);
+
+	return 0;
+
+iounmap_base:
+	iounmap(priv->base);
+free_priv:
+	kfree(priv);
+
+	return err;
+}
+
+IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index d0a71febdadc..d9c53f85a68e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -76,6 +76,7 @@ struct plic_handler {
 	void __iomem		*enable_base;
 	struct plic_priv	*priv;
 };
+static bool plic_cpuhp_setup_done;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static inline void plic_toggle(struct plic_handler *handler,
@@ -176,9 +177,12 @@ static struct irq_chip plic_chip = {
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
+	struct plic_priv *priv = d->host_data;
+
 	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
+	irq_set_affinity(irq, &priv->lmask);
 	return 0;
 }
 
@@ -282,6 +286,7 @@ static int __init plic_init(struct device_node *node,
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
 	struct plic_priv *priv;
+	struct plic_handler *handler;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -301,8 +306,6 @@ static int __init plic_init(struct device_node *node,
 	nr_contexts = of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(nr_contexts < num_possible_cpus()))
-		goto out_iounmap;
 
 	error = -ENOMEM;
 	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
@@ -312,7 +315,6 @@ static int __init plic_init(struct device_node *node,
 
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
-		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
 		int cpu, hartid;
 
@@ -366,11 +368,20 @@ static int __init plic_init(struct device_node *node,
 		nr_handlers++;
 	}
 
-	cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	/*
+	 * We can have multiple PLIC instances so setup cpuhp state only
+	 * when context handler for current/boot CPU is present.
+	 */
+	handler = this_cpu_ptr(&plic_handlers);
+	if (handler->present && !plic_cpuhp_setup_done) {
+		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
-	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
-		nr_irqs, nr_handlers, nr_contexts);
+		plic_cpuhp_setup_done = true;
+	}
+
+	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
+		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 4500d453a63e..ab831e5ae748 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -1,41 +1,26 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
+ * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
 #ifndef _LINUX_IRQ_SIM_H
 #define _LINUX_IRQ_SIM_H
 
-#include <linux/irq_work.h>
 #include <linux/device.h>
+#include <linux/fwnode.h>
+#include <linux/irqdomain.h>
 
 /*
  * Provides a framework for allocating simulated interrupts which can be
  * requested like normal irqs and enqueued from process context.
  */
 
-struct irq_sim_work_ctx {
-	struct irq_work		work;
-	unsigned long		*pending;
-};
-
-struct irq_sim_irq_ctx {
-	int			irqnum;
-	bool			enabled;
-};
-
-struct irq_sim {
-	struct irq_sim_work_ctx	work_ctx;
-	int			irq_base;
-	unsigned int		irq_count;
-	struct irq_sim_irq_ctx	*irqs;
-};
-
-int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
-int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
-		      unsigned int num_irqs);
-void irq_sim_fini(struct irq_sim *sim);
-void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
-int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
+struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
+					 unsigned int num_irqs);
+struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
+					      struct fwnode_handle *fwnode,
+					      unsigned int num_irqs);
+void irq_domain_remove_sim(struct irq_domain *domain);
 
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 8d062e86d954..b37350c4fe37 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -450,6 +450,7 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 				irq_hw_number_t hwirq, struct irq_chip *chip,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
+extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
@@ -491,7 +492,6 @@ extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 struct irq_chip *chip,
 					 void *chip_data);
-extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs);
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 20d501af4f2e..d63c324895ea 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -72,6 +72,7 @@ config IRQ_DOMAIN
 config IRQ_SIM
 	bool
 	select IRQ_WORK
+	select IRQ_DOMAIN
 
 # Support for hierarchical irq domains
 config IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index b992f88c5613..48006608baf0 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -1,14 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
+ * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
-#include <linux/slab.h>
-#include <linux/irq_sim.h>
 #include <linux/irq.h>
+#include <linux/irq_sim.h>
+#include <linux/irq_work.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+struct irq_sim_work_ctx {
+	struct irq_work		work;
+	int			irq_base;
+	unsigned int		irq_count;
+	unsigned long		*pending;
+	struct irq_domain	*domain;
+};
+
+struct irq_sim_irq_ctx {
+	int			irqnum;
+	bool			enabled;
+	struct irq_sim_work_ctx	*work_ctx;
+};
 
 struct irq_sim_devres {
-	struct irq_sim		*sim;
+	struct irq_domain	*domain;
 };
 
 static void irq_sim_irqmask(struct irq_data *data)
@@ -36,159 +53,205 @@ static int irq_sim_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static int irq_sim_get_irqchip_state(struct irq_data *data,
+				     enum irqchip_irq_state which, bool *state)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		if (irq_ctx->enabled)
+			*state = test_bit(hwirq, irq_ctx->work_ctx->pending);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int irq_sim_set_irqchip_state(struct irq_data *data,
+				     enum irqchip_irq_state which, bool state)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		if (irq_ctx->enabled) {
+			assign_bit(hwirq, irq_ctx->work_ctx->pending, state);
+			if (state)
+				irq_work_queue(&irq_ctx->work_ctx->work);
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct irq_chip irq_sim_irqchip = {
-	.name		= "irq_sim",
-	.irq_mask	= irq_sim_irqmask,
-	.irq_unmask	= irq_sim_irqunmask,
-	.irq_set_type	= irq_sim_set_type,
+	.name			= "irq_sim",
+	.irq_mask		= irq_sim_irqmask,
+	.irq_unmask		= irq_sim_irqunmask,
+	.irq_set_type		= irq_sim_set_type,
+	.irq_get_irqchip_state	= irq_sim_get_irqchip_state,
+	.irq_set_irqchip_state	= irq_sim_set_irqchip_state,
 };
 
 static void irq_sim_handle_irq(struct irq_work *work)
 {
 	struct irq_sim_work_ctx *work_ctx;
 	unsigned int offset = 0;
-	struct irq_sim *sim;
 	int irqnum;
 
 	work_ctx = container_of(work, struct irq_sim_work_ctx, work);
-	sim = container_of(work_ctx, struct irq_sim, work_ctx);
 
-	while (!bitmap_empty(work_ctx->pending, sim->irq_count)) {
+	while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
 		offset = find_next_bit(work_ctx->pending,
-				       sim->irq_count, offset);
+				       work_ctx->irq_count, offset);
 		clear_bit(offset, work_ctx->pending);
-		irqnum = irq_sim_irqnum(sim, offset);
+		irqnum = irq_find_mapping(work_ctx->domain, offset);
 		handle_simple_irq(irq_to_desc(irqnum));
 	}
 }
 
+static int irq_sim_domain_map(struct irq_domain *domain,
+			      unsigned int virq, irq_hw_number_t hw)
+{
+	struct irq_sim_work_ctx *work_ctx = domain->host_data;
+	struct irq_sim_irq_ctx *irq_ctx;
+
+	irq_ctx = kzalloc(sizeof(*irq_ctx), GFP_KERNEL);
+	if (!irq_ctx)
+		return -ENOMEM;
+
+	irq_set_chip(virq, &irq_sim_irqchip);
+	irq_set_chip_data(virq, irq_ctx);
+	irq_set_handler(virq, handle_simple_irq);
+	irq_modify_status(virq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
+	irq_ctx->work_ctx = work_ctx;
+
+	return 0;
+}
+
+static void irq_sim_domain_unmap(struct irq_domain *domain, unsigned int virq)
+{
+	struct irq_sim_irq_ctx *irq_ctx;
+	struct irq_data *irqd;
+
+	irqd = irq_domain_get_irq_data(domain, virq);
+	irq_ctx = irq_data_get_irq_chip_data(irqd);
+
+	irq_set_handler(virq, NULL);
+	irq_domain_reset_irq_data(irqd);
+	kfree(irq_ctx);
+}
+
+static const struct irq_domain_ops irq_sim_domain_ops = {
+	.map		= irq_sim_domain_map,
+	.unmap		= irq_sim_domain_unmap,
+};
+
 /**
- * irq_sim_init - Initialize the interrupt simulator: allocate a range of
- *                dummy interrupts.
+ * irq_domain_create_sim - Create a new interrupt simulator irq_domain and
+ *                         allocate a range of dummy interrupts.
  *
- * @sim:        The interrupt simulator object to initialize.
- * @num_irqs:   Number of interrupts to allocate
+ * @fnode:      struct fwnode_handle to be associated with this domain.
+ * @num_irqs:   Number of interrupts to allocate.
  *
- * On success: return the base of the allocated interrupt range.
- * On failure: a negative errno.
+ * On success: return a new irq_domain object.
+ * On failure: a negative errno wrapped with ERR_PTR().
  */
-int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
+struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
+					 unsigned int num_irqs)
 {
-	int i;
+	struct irq_sim_work_ctx *work_ctx;
 
-	sim->irqs = kmalloc_array(num_irqs, sizeof(*sim->irqs), GFP_KERNEL);
-	if (!sim->irqs)
-		return -ENOMEM;
+	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
+	if (!work_ctx)
+		goto err_out;
 
-	sim->irq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
-	if (sim->irq_base < 0) {
-		kfree(sim->irqs);
-		return sim->irq_base;
-	}
+	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
+	if (!work_ctx->pending)
+		goto err_free_work_ctx;
 
-	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
-	if (!sim->work_ctx.pending) {
-		kfree(sim->irqs);
-		irq_free_descs(sim->irq_base, num_irqs);
-		return -ENOMEM;
-	}
+	work_ctx->domain = irq_domain_create_linear(fwnode, num_irqs,
+						    &irq_sim_domain_ops,
+						    work_ctx);
+	if (!work_ctx->domain)
+		goto err_free_bitmap;
 
-	for (i = 0; i < num_irqs; i++) {
-		sim->irqs[i].irqnum = sim->irq_base + i;
-		sim->irqs[i].enabled = false;
-		irq_set_chip(sim->irq_base + i, &irq_sim_irqchip);
-		irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
-		irq_set_handler(sim->irq_base + i, &handle_simple_irq);
-		irq_modify_status(sim->irq_base + i,
-				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
-	}
+	work_ctx->irq_count = num_irqs;
+	init_irq_work(&work_ctx->work, irq_sim_handle_irq);
 
-	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
-	sim->irq_count = num_irqs;
+	return work_ctx->domain;
 
-	return sim->irq_base;
+err_free_bitmap:
+	bitmap_free(work_ctx->pending);
+err_free_work_ctx:
+	kfree(work_ctx);
+err_out:
+	return ERR_PTR(-ENOMEM);
 }
-EXPORT_SYMBOL_GPL(irq_sim_init);
+EXPORT_SYMBOL_GPL(irq_domain_create_sim);
 
 /**
- * irq_sim_fini - Deinitialize the interrupt simulator: free the interrupt
- *                descriptors and allocated memory.
+ * irq_domain_remove_sim - Deinitialize the interrupt simulator domain: free
+ *                         the interrupt descriptors and allocated memory.
  *
- * @sim:        The interrupt simulator to tear down.
+ * @domain:     The interrupt simulator domain to tear down.
  */
-void irq_sim_fini(struct irq_sim *sim)
+void irq_domain_remove_sim(struct irq_domain *domain)
 {
-	irq_work_sync(&sim->work_ctx.work);
-	bitmap_free(sim->work_ctx.pending);
-	irq_free_descs(sim->irq_base, sim->irq_count);
-	kfree(sim->irqs);
+	struct irq_sim_work_ctx *work_ctx = domain->host_data;
+
+	irq_work_sync(&work_ctx->work);
+	bitmap_free(work_ctx->pending);
+	kfree(work_ctx);
+
+	irq_domain_remove(domain);
 }
-EXPORT_SYMBOL_GPL(irq_sim_fini);
+EXPORT_SYMBOL_GPL(irq_domain_remove_sim);
 
-static void devm_irq_sim_release(struct device *dev, void *res)
+static void devm_irq_domain_release_sim(struct device *dev, void *res)
 {
 	struct irq_sim_devres *this = res;
 
-	irq_sim_fini(this->sim);
+	irq_domain_remove_sim(this->domain);
 }
 
 /**
- * irq_sim_init - Initialize the interrupt simulator for a managed device.
+ * devm_irq_domain_create_sim - Create a new interrupt simulator for
+ *                              a managed device.
  *
  * @dev:        Device to initialize the simulator object for.
- * @sim:        The interrupt simulator object to initialize.
+ * @fnode:      struct fwnode_handle to be associated with this domain.
  * @num_irqs:   Number of interrupts to allocate
  *
- * On success: return the base of the allocated interrupt range.
- * On failure: a negative errno.
+ * On success: return a new irq_domain object.
+ * On failure: a negative errno wrapped with ERR_PTR().
  */
-int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
-		      unsigned int num_irqs)
+struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
+					      struct fwnode_handle *fwnode,
+					      unsigned int num_irqs)
 {
 	struct irq_sim_devres *dr;
-	int rv;
 
-	dr = devres_alloc(devm_irq_sim_release, sizeof(*dr), GFP_KERNEL);
+	dr = devres_alloc(devm_irq_domain_release_sim,
+			  sizeof(*dr), GFP_KERNEL);
 	if (!dr)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	rv = irq_sim_init(sim, num_irqs);
-	if (rv < 0) {
+	dr->domain = irq_domain_create_sim(fwnode, num_irqs);
+	if (IS_ERR(dr->domain)) {
 		devres_free(dr);
-		return rv;
+		return dr->domain;
 	}
 
-	dr->sim = sim;
 	devres_add(dev, dr);
-
-	return rv;
-}
-EXPORT_SYMBOL_GPL(devm_irq_sim_init);
-
-/**
- * irq_sim_fire - Enqueue an interrupt.
- *
- * @sim:        The interrupt simulator object.
- * @offset:     Offset of the simulated interrupt which should be fired.
- */
-void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
-{
-	if (sim->irqs[offset].enabled) {
-		set_bit(offset, sim->work_ctx.pending);
-		irq_work_queue(&sim->work_ctx.work);
-	}
-}
-EXPORT_SYMBOL_GPL(irq_sim_fire);
-
-/**
- * irq_sim_irqnum - Get the allocated number of a dummy interrupt.
- *
- * @sim:        The interrupt simulator object.
- * @offset:     Offset of the simulated interrupt for which to retrieve
- *              the number.
- */
-int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
-{
-	return sim->irqs[offset].irqnum;
+	return dr->domain;
 }
-EXPORT_SYMBOL_GPL(irq_sim_irqnum);
+EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 35b8d97c3a1d..a4c2c915511d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -132,14 +132,13 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
 {
-	struct device_node *of_node = to_of_node(fwnode);
 	struct irqchip_fwid *fwid;
 	struct irq_domain *domain;
 
 	static atomic_t unknown_domains;
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
-			      GFP_KERNEL, of_node_to_nid(of_node));
+			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
 	if (!domain)
 		return NULL;
 
@@ -162,30 +161,16 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 			domain->name = fwid->name;
 			break;
 		}
-#ifdef CONFIG_ACPI
-	} else if (is_acpi_device_node(fwnode)) {
-		struct acpi_buffer buf = {
-			.length = ACPI_ALLOCATE_BUFFER,
-		};
-		acpi_handle handle;
-
-		handle = acpi_device_handle(to_acpi_device_node(fwnode));
-		if (acpi_get_name(handle, ACPI_FULL_PATHNAME, &buf) == AE_OK) {
-			domain->name = buf.pointer;
-			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-		}
-
-		domain->fwnode = fwnode;
-#endif
-	} else if (of_node) {
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
+		   is_software_node(fwnode)) {
 		char *name;
 
 		/*
-		 * DT paths contain '/', which debugfs is legitimately
+		 * fwnode paths contain '/', which debugfs is legitimately
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kasprintf(GFP_KERNEL, "%pOF", of_node);
+		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
 		if (!name) {
 			kfree(domain);
 			return NULL;
@@ -210,7 +195,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
-	of_node_get(of_node);
+	fwnode_handle_get(fwnode);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
@@ -259,7 +244,7 @@ void irq_domain_remove(struct irq_domain *domain)
 
 	pr_debug("Removed domain %s\n", domain->name);
 
-	of_node_put(irq_domain_get_of_node(domain));
+	fwnode_handle_put(domain->fwnode);
 	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
 		kfree(domain->name);
 	kfree(domain);
@@ -1047,6 +1032,18 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 	return virq;
 }
 
+/**
+ * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
+ * @irq_data:	The pointer to irq_data
+ */
+void irq_domain_reset_irq_data(struct irq_data *irq_data)
+{
+	irq_data->hwirq = 0;
+	irq_data->chip = &no_irq_chip;
+	irq_data->chip_data = NULL;
+}
+EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
@@ -1247,18 +1244,6 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 }
 EXPORT_SYMBOL(irq_domain_set_info);
 
-/**
- * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
- * @irq_data:	The pointer to irq_data
- */
-void irq_domain_reset_irq_data(struct irq_data *irq_data)
-{
-	irq_data->hwirq = 0;
-	irq_data->chip = &no_irq_chip;
-	irq_data->chip_data = NULL;
-}
-EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
-
 /**
  * irq_domain_free_irqs_common - Clear irq_data and free the parent
  * @domain:	Interrupt domain to match
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 453a8a0f4804..761911168438 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2619,6 +2619,8 @@ int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
 
 	do {
 		chip = irq_data_get_irq_chip(data);
+		if (WARN_ON_ONCE(!chip))
+			return -ENODEV;
 		if (chip->irq_get_irqchip_state)
 			break;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -2696,6 +2698,8 @@ int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 
 	do {
 		chip = irq_data_get_irq_chip(data);
+		if (WARN_ON_ONCE(!chip))
+			return -ENODEV;
 		if (chip->irq_set_irqchip_state)
 			break;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY

