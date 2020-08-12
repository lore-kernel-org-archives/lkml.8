Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0482C206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlO2z448"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHLUUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:20:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD3AC061384;
        Wed, 12 Aug 2020 13:20:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so1692822pjr.0;
        Wed, 12 Aug 2020 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uccu95PRXmKxZHBeQCOoazjl3urZNrqvEdVXCkGpHe4=;
        b=UlO2z448ApUxre6aTjn1730gZ9JPksIa9Cf559Vif7hw+EMeS8OXZsBsVQQ5WUTGeH
         c8FtB1Ib6TzwVjexTg3cj8hon4M1M9DZyzfZ/rFFZd+0W68nPvSUUZiSO6LIqd4S4yPu
         lylH8Vc9tgbYGPqRYMkiovATkSVro4TWsw2wbroNy4zxtBkdwUoSWn5Cpifa9QrCzD+4
         YRupHEuEBwvgUhuvwmhk5HOmgnQm+WCNWTeogC+9P+VMCYGshcuPdBpIylwqJ7wC5Ghm
         uPS/PaXz2s7aXR/URKcXRa+GdSKbUfQrdCViXJaPeVehTMHmv+qwpwo9vve4gDYUng8u
         koZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uccu95PRXmKxZHBeQCOoazjl3urZNrqvEdVXCkGpHe4=;
        b=IhFknTBAkp0b095JxZvUebfEM9BWg6stZ/FZcTL0WWgssusOSV1sXl4DHEoYdQyrgO
         7kWEAqKVKDtjeQ/0FfTf0w/w8/5v0URqQDSxwG148RWcNk7mTJ1NQAaKD4tyV4ynq8Zp
         4UxSqmUwKt1kvp6kIRPJv18t1Q3eTNt6T3ssmqVcrW9oCBkS4M1LDBSjiP+Jej9VnXK4
         bDCRMmWL1lXwMMAzkSDaSq9Hmcnoe5p1fZ1se+FThKKYjYDFxBzyheVFUBzlTk5a/gvA
         DeDEpWRlMV5Fe2GWBjnppr+LOL9BdUlTZnQhTNRW4dGvbHKboT0GhVWHn7y2GuKJjP6H
         zbCw==
X-Gm-Message-State: AOAM5311GR48ils2AVHYh3dc5dsMEuevTabKnIe940qdlDgAimDM8DFl
        H92piFtkvRyDn5IdklSLg6l9HAxJ
X-Google-Smtp-Source: ABdhPJx6kdR4K1vjHtPcM8xAr4FXB1UDfT0nL2CIGERv1NTs/z7Gk9eILZTle+t1N6++zuf20L8d/A==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr977592plb.4.1597263653859;
        Wed, 12 Aug 2020 13:20:53 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 75sm3292999pfx.187.2020.08.12.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:20:53 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <al.cooper@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/3] usb: Add driver to allow any GPIO to be used for 7211 USB signals
Date:   Wed, 12 Aug 2020 16:20:17 -0400
Message-Id: <20200812202018.49046-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812202018.49046-1-alcooperx@gmail.com>
References: <20200812202018.49046-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Cooper <al.cooper@broadcom.com>

The Broadcom 7211 has new functionality that allows some USB low
speed side band signals, that go from the XHCI host controller to
pins on the chip, to be remapped to use any GPIO pin instead of the
limited set selectable by hardware. This can be done without changing
the standard driver for the host controller. There is currently
support for three USB signals, PWRON, VBUS_PRESENT and PWRFLT. This
driver will allow the remapping of any of these three signals based
on settings in the Device Tree node for the driver. The driver was
written so that it could handle additional signals added in the
future by just adding the correct properties to the DT node.

Below is an example of a DT node that would remap all three
signals:

usb_pinmap: usb-pinmap@22000d0 {
	compatible = "brcm,usb-pinmap";
	reg = <0x22000d0 0x4>;
	in-names = "VBUS", "PWRFLT";
	in-gpios = <&gpio 18 0>, <&gpio 19 0>;
	in-masks = <0x8000 0x40000 0x10000 0x80000>;
	out-names = "PWRON";
	out-gpios = <&gpio 20 0>;
	out-masks = <0x20000 0x800000 0x400000 0x200000>;
	interrupts = <0x0 0xb2 0x4>;
};

refs #SWLINUX-5537

Signed-off-by: Al Cooper <al.cooper@broadcom.com>
---
 drivers/usb/host/brcmstb-usb-pinmap.c | 348 ++++++++++++++++++++++++++
 1 file changed, 348 insertions(+)
 create mode 100644 drivers/usb/host/brcmstb-usb-pinmap.c

diff --git a/drivers/usb/host/brcmstb-usb-pinmap.c b/drivers/usb/host/brcmstb-usb-pinmap.c
new file mode 100644
index 000000000000..647373b7e53b
--- /dev/null
+++ b/drivers/usb/host/brcmstb-usb-pinmap.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Broadcom */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
+#include <linux/gpio/consumer.h>
+
+struct out_pin {
+	u32 enable_mask;
+	u32 value_mask;
+	u32 changed_mask;
+	u32 clr_changed_mask;
+	struct gpio_desc *gpiod;
+	const char *name;
+};
+
+struct in_pin {
+	u32 enable_mask;
+	u32 value_mask;
+	struct gpio_desc *gpiod;
+	const char *name;
+	struct brcmstb_usb_pinmap_data *pdata;
+};
+
+struct brcmstb_usb_pinmap_data {
+	void __iomem *regs;
+	int in_count;
+	struct in_pin *in_pins;
+	int out_count;
+	struct out_pin *out_pins;
+};
+
+
+static void pinmap_set(void __iomem *reg, u32 mask)
+{
+	u32 val;
+
+	val = readl(reg);
+	val |= mask;
+	writel(val, reg);
+}
+
+static void pinmap_unset(void __iomem *reg, u32 mask)
+{
+	u32 val;
+
+	val = readl(reg);
+	val &= ~mask;
+	writel(val, reg);
+}
+
+static void sync_in_pin(struct in_pin *pin)
+{
+	u32 val;
+
+	val = gpiod_get_value(pin->gpiod);
+	if (val)
+		pinmap_set(pin->pdata->regs, pin->value_mask);
+	else
+		pinmap_unset(pin->pdata->regs, pin->value_mask);
+}
+
+/*
+ * Interrupt from override register, propagate from override bit
+ * to GPIO.
+ */
+static irqreturn_t brcmstb_usb_pinmap_ovr_isr(int irq, void *dev_id)
+{
+	struct brcmstb_usb_pinmap_data *pdata = dev_id;
+	struct out_pin *pout;
+	u32 val;
+	u32 bit;
+	int x;
+
+	pr_debug("%s: reg: 0x%x\n", __func__, readl(pdata->regs));
+	pout = pdata->out_pins;
+	for (x = 0; x < pdata->out_count; x++) {
+		val = readl(pdata->regs);
+		if (val & pout->changed_mask) {
+			pinmap_set(pdata->regs, pout->clr_changed_mask);
+			pinmap_unset(pdata->regs, pout->clr_changed_mask);
+			bit = val & pout->value_mask;
+			gpiod_set_value(pout->gpiod, bit ? 1 : 0);
+			pr_debug("%s: %s bit changed state to %d\n",
+				 __func__, pout->name, bit ? 1 : 0);
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * Interrupt from GPIO, propagate from GPIO to override bit.
+ */
+static irqreturn_t brcmstb_usb_pinmap_gpio_isr(int irq, void *dev_id)
+{
+	struct in_pin *pin = dev_id;
+
+	pr_debug("%s: %s pin changed state\n", __func__, pin->name);
+	sync_in_pin(pin);
+	return IRQ_HANDLED;
+}
+
+
+static void get_pin_counts(struct device_node *dn, int *in_count,
+			   int *out_count)
+{
+	int in;
+	int out;
+
+	*in_count = 0;
+	*out_count = 0;
+	in = of_property_count_strings(dn, "in-names");
+	if (in < 0)
+		return;
+	out = of_property_count_strings(dn, "out-names");
+	if (out < 0)
+		return;
+	*in_count = in;
+	*out_count = out;
+}
+
+static int parse_pins(struct device *dev, struct device_node *dn,
+		      struct brcmstb_usb_pinmap_data *pdata)
+{
+	struct out_pin *pout;
+	struct in_pin *pin;
+	int index;
+	int res;
+	int x;
+
+	pin = pdata->in_pins;
+	for (x = 0, index = 0; x < pdata->in_count; x++) {
+		pin->gpiod = devm_gpiod_get_index(dev, "in", x, GPIOD_IN);
+		if (IS_ERR(pin->gpiod)) {
+			dev_err(dev, "Error getting gpio %s\n", pin->name);
+			return PTR_ERR(pin->gpiod);
+
+		}
+		res = of_property_read_string_index(dn, "in-names", x,
+						    &pin->name);
+		if (res < 0) {
+			dev_err(dev, "Error getting in-names for %s\n",
+				pin->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "in-masks", index++,
+						 &pin->enable_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting first in-masks for %s\n",
+				pin->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "in-masks", index++,
+						 &pin->value_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting second in-masks for %s\n",
+				pin->name);
+			return res;
+		}
+		pin->pdata = pdata;
+		pin++;
+	}
+	pout = pdata->out_pins;
+	for (x = 0, index = 0; x < pdata->out_count; x++) {
+		pout->gpiod = devm_gpiod_get_index(dev, "out", x,
+						   GPIOD_OUT_HIGH);
+		if (IS_ERR(pout->gpiod)) {
+			dev_err(dev, "Error getting gpio %s\n", pin->name);
+			return PTR_ERR(pout->gpiod);
+		}
+		res = of_property_read_string_index(dn, "out-names", x,
+						    &pout->name);
+		if (res < 0) {
+			dev_err(dev, "Error getting out-names for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "out-masks", index++,
+						 &pout->enable_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting first out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "out-masks", index++,
+						 &pout->value_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting second out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "out-masks", index++,
+						 &pout->changed_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting third out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		res = of_property_read_u32_index(dn, "out-masks", index++,
+						 &pout->clr_changed_mask);
+		if (res < 0) {
+			dev_err(dev, "Error getting fourth out-masks for %s\n",
+				pout->name);
+			return res;
+		}
+		pout++;
+	}
+	return 0;
+}
+
+void sync_all_pins(struct brcmstb_usb_pinmap_data *pdata)
+{
+	struct out_pin *pout;
+	struct in_pin *pin;
+	int val;
+	int x;
+
+	/*
+	 * Enable the override, clear any changed condition and
+	 * propagate the state to the GPIO for all out pins.
+	 */
+	pout = pdata->out_pins;
+	for (x = 0; x < pdata->out_count; x++) {
+		pinmap_set(pdata->regs, pout->enable_mask);
+		pinmap_set(pdata->regs, pout->clr_changed_mask);
+		pinmap_unset(pdata->regs, pout->clr_changed_mask);
+		val = readl(pdata->regs) & pout->value_mask;
+		gpiod_set_value(pout->gpiod, val ? 1 : 0);
+		pout++;
+	}
+
+	/* sync and enable all in pins. */
+	pin = pdata->in_pins;
+	for (x = 0; x < pdata->in_count; x++) {
+		sync_in_pin(pin);
+		pinmap_set(pdata->regs, pin->enable_mask);
+		pin++;
+	}
+}
+
+static int __init brcmstb_usb_pinmap_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct brcmstb_usb_pinmap_data *pdata;
+	struct in_pin *pin;
+	struct resource *r;
+	int out_count;
+	int in_count;
+	int err;
+	int irq;
+	int x;
+
+	get_pin_counts(dn, &in_count, &out_count);
+	if ((in_count + out_count) == 0)
+		return -EINVAL;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	pdata = devm_kzalloc(&pdev->dev,
+			     sizeof(*pdata) +
+			     (sizeof(struct in_pin) * in_count) +
+			     (sizeof(struct out_pin) * out_count), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->in_count = in_count;
+	pdata->out_count = out_count;
+	pdata->in_pins = (struct in_pin *)(pdata + 1);
+	pdata->out_pins = (struct out_pin *)(pdata->in_pins + in_count);
+
+	pdata->regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (IS_ERR(pdata->regs))
+		return PTR_ERR(pdata->regs);
+	platform_set_drvdata(pdev, pdata);
+
+	err = parse_pins(&pdev->dev, dn, pdata);
+	if (err)
+		return err;
+
+	sync_all_pins(pdata);
+
+	if (out_count) {
+
+		/* Enable interrupt for out pins */
+		irq = platform_get_irq(pdev, 0);
+		err = devm_request_irq(&pdev->dev, irq,
+				       brcmstb_usb_pinmap_ovr_isr,
+				       IRQF_TRIGGER_RISING,
+				       pdev->name, pdata);
+		if (err < 0) {
+			dev_err(&pdev->dev, "Error requesting IRQ\n");
+			return err;
+		}
+	}
+
+	for (x = 0, pin = pdata->in_pins; x < pdata->in_count; x++, pin++) {
+		irq = gpiod_to_irq(pin->gpiod);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "Error getting IRQ for %s pin\n",
+				pin->name);
+			return irq;
+		}
+		err = devm_request_irq(&pdev->dev, irq,
+				       brcmstb_usb_pinmap_gpio_isr,
+				       IRQF_SHARED | IRQF_TRIGGER_RISING |
+				       IRQF_TRIGGER_FALLING,
+				       pdev->name, pin);
+		if (err < 0) {
+			dev_err(&pdev->dev, "Error requesting IRQ for %s pin\n",
+				pin->name);
+			return err;
+		}
+	}
+
+	dev_info(&pdev->dev, "Driver probe succeeded\n");
+	dev_dbg(&pdev->dev, "In pin count: %d, out pin count: %d\n",
+		pdata->in_count, pdata->out_count);
+	return 0;
+}
+
+
+static const struct of_device_id brcmstb_usb_pinmap_of_match[] = {
+	{ .compatible = "brcm,usb-pinmap" },
+	{ },
+};
+
+static struct platform_driver brcmstb_usb_pinmap_driver = {
+	.driver = {
+		.name	= "brcm-usb-pinmap",
+		.of_match_table = brcmstb_usb_pinmap_of_match,
+	},
+};
+
+static int __init brcmstb_usb_pinmap_init(void)
+{
+	return platform_driver_probe(&brcmstb_usb_pinmap_driver,
+				     brcmstb_usb_pinmap_probe);
+}
+
+module_init(brcmstb_usb_pinmap_init);
-- 
2.17.1

