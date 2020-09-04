Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC694206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Js+dMC2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgIDTTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgIDTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:18:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80590C061246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:18:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p37so4822119pgl.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0r4W9mwB3hElBdfBrvtjd4X0q5DQJLDeKjMbcplMDU=;
        b=Js+dMC2y6bJOPfgi+dpPWCdzalyDqvjHxyFNDwMUi825KGhHDJI1Ytib81Zz86k6fH
         QK6do1e81kvyEHJvPtSMRRA6NEoB51cFZHAzoUMfgMZwIi9++wQiqIPG4ONZluvE3hPf
         zIV0UTmQ9bHzSJk31E9ibifexitYDo7hzHx98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0r4W9mwB3hElBdfBrvtjd4X0q5DQJLDeKjMbcplMDU=;
        b=DrL/dGy3Q0ylz1ldqDB7ZtUnfIzONRI+F0J8568B6TWADTVDdrlNokAkMwdwOMoGAA
         D6Kp9WLRgfprFTKjn18cmvERZstKdBm1C3q/KNWrdD6B1ZwODPhPfz9eULVKcuYmIbJX
         Hydb2WmvON0bBfB+qOmLOpfGCm8XA48cZrRHfj6eeiWWUzJh9iFJ3ZT3TXAJrvhMesmf
         auQGeopSCux2GJOuNt622c7uVfMaNRmOk2j74+nHr3izJudk+4iUDIQNvrSSNz7kzOQw
         pbPuEcUfvx3OFgvgDyrpS8PIGKxLZhH+JtllaBo5UinAUqwWQFcpasoTBdd97WVzN+9A
         QmJQ==
X-Gm-Message-State: AOAM532C9ILHuQMife04aXNaTuIzvs2Z5RxRm1h9tge3EbMTaxXDpsRG
        iiuJ2mNhQOULzqWToK8zt8phXQ==
X-Google-Smtp-Source: ABdhPJwPFAeSEqozQ2oq/5q8jmzdSVhlRwP56anlVHCYZpX7bRboVFg0gwDr5Qiwv41Zg6sEsTBtew==
X-Received: by 2002:a63:6fc6:: with SMTP id k189mr8132738pgc.165.1599247136913;
        Fri, 04 Sep 2020 12:18:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b9ea:24bf:6b2b:1eee])
        by smtp.gmail.com with ESMTPSA id t4sm5986001pje.56.2020.09.04.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 12:18:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Tom Cubie <tom@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/3] extcon: Add Type-C Virtual PD driver
Date:   Sat,  5 Sep 2020 00:48:29 +0530
Message-Id: <20200904191830.387296-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904191830.387296-1-jagan@amarulasolutions.com>
References: <20200904191830.387296-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Type-C protocol supports various modes of operations
includes PD, USB3, and Altmode. If the platform design
supports a Type-C connector then configuring these modes
can be done via enumeration.

However, there are some platforms that design these modes
of operations as separate protocol connectors like design
Display Port from on-chip USB3 controller. So accessing
Type-C Altmode Display Port via onboard Display Port
connector instead of a Type-C connector.

These kinds of platforms require an explicit extcon driver
in order to handle Power Delivery and Port Detection.

Add extcon driver for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 MAINTAINERS                             |   6 +
 drivers/extcon/Kconfig                  |  10 +
 drivers/extcon/Makefile                 |   1 +
 drivers/extcon/extcon-usbc-virtual-pd.c | 285 ++++++++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 drivers/extcon/extcon-usbc-virtual-pd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..aeb161b19dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6466,6 +6466,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 F:	Documentation/filesystems/ext4/
 F:	fs/ext4/
 
+EXTCON DRIVER FOR TYPE-C VIRTUAL PD
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/extcon/extcon-usbc-virtual-pd.yaml
+F:	drivers/extcon/extcon-usbc-virtual-pd.c
+
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index aac507bff135..edd6c3c52699 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -186,4 +186,14 @@ config EXTCON_USBC_CROS_EC
 	  Say Y here to enable USB Type C cable detection extcon support when
 	  using Chrome OS EC based USB Type-C ports.
 
+config EXTCON_USBC_VIRTUAL_PD
+	tristate "Virtual Type-C PD EXTCON support"
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say Y here to enable Virtual Type-C PD extcon driver support, if
+	  hardware platform designed Type-C modes separately.
+
+	  Example, of designing Display Port separately from Type-C Altmode
+	  instead of accessing Altmode Display Port in Type-C connector.
+
 endif
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 52096fd8a216..c35191eef0e1 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
 obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
 obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
 obj-$(CONFIG_EXTCON_USBC_CROS_EC) += extcon-usbc-cros-ec.o
+obj-$(CONFIG_EXTCON_USBC_VIRTUAL_PD) += extcon-usbc-virtual-pd.o
diff --git a/drivers/extcon/extcon-usbc-virtual-pd.c b/drivers/extcon/extcon-usbc-virtual-pd.c
new file mode 100644
index 000000000000..e0713670e33d
--- /dev/null
+++ b/drivers/extcon/extcon-usbc-virtual-pd.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Type-C Virtual PD Extcon driver
+ *
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2019 Radxa Limited
+ * Copyright (c) 2019 Amarula Solutions(India)
+ */
+
+#include <linux/extcon-provider.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static const unsigned int vpd_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_DISP_DP,
+	EXTCON_NONE,
+};
+
+enum vpd_data_role {
+	DR_NONE,
+	DR_HOST,
+	DR_DEVICE,
+	DR_DISPLAY_PORT,
+};
+
+enum vpd_polarity {
+	POLARITY_NORMAL,
+	POLARITY_FLIP,
+};
+
+enum vpd_usb_ss {
+	USB_SS_USB2,
+	USB_SS_USB3,
+};
+
+struct vpd_extcon {
+	struct device *dev;
+	struct extcon_dev *extcon;
+	struct gpio_desc *det_gpio;
+
+	u8 polarity;
+	u8 usb_ss;
+	enum vpd_data_role data_role;
+
+	int irq;
+	bool enable_irq;
+	struct work_struct work;
+	struct delayed_work irq_work;
+};
+
+static void vpd_extcon_irq_work(struct work_struct *work)
+{
+	struct vpd_extcon *vpd = container_of(work, struct vpd_extcon, irq_work.work);
+	bool host_connected = false, device_connected = false, dp_connected = false;
+	union extcon_property_value property;
+	int det;
+
+	det = vpd->det_gpio ? gpiod_get_raw_value(vpd->det_gpio) : 0;
+	if (det) {
+		device_connected = (vpd->data_role == DR_DEVICE) ? true : false;
+		host_connected = (vpd->data_role == DR_HOST) ? true : false;
+		dp_connected = (vpd->data_role == DR_DISPLAY_PORT) ? true : false;
+	}
+
+	extcon_set_state(vpd->extcon, EXTCON_USB, host_connected);
+	extcon_set_state(vpd->extcon, EXTCON_USB_HOST, device_connected);
+	extcon_set_state(vpd->extcon, EXTCON_DISP_DP, dp_connected);
+
+	property.intval = vpd->polarity;
+	extcon_set_property(vpd->extcon, EXTCON_USB,
+			    EXTCON_PROP_USB_TYPEC_POLARITY, property);
+	extcon_set_property(vpd->extcon, EXTCON_USB_HOST,
+			    EXTCON_PROP_USB_TYPEC_POLARITY, property);
+	extcon_set_property(vpd->extcon, EXTCON_DISP_DP,
+			    EXTCON_PROP_USB_TYPEC_POLARITY, property);
+
+	property.intval = vpd->usb_ss;
+	extcon_set_property(vpd->extcon, EXTCON_USB,
+			    EXTCON_PROP_USB_SS, property);
+	extcon_set_property(vpd->extcon, EXTCON_USB_HOST,
+			    EXTCON_PROP_USB_SS, property);
+	extcon_set_property(vpd->extcon, EXTCON_DISP_DP,
+			    EXTCON_PROP_USB_SS, property);
+
+	extcon_sync(vpd->extcon, EXTCON_USB);
+	extcon_sync(vpd->extcon, EXTCON_USB_HOST);
+	extcon_sync(vpd->extcon, EXTCON_DISP_DP);
+}
+
+static irqreturn_t vpd_extcon_irq_handler(int irq, void *dev_id)
+{
+	struct vpd_extcon *vpd = dev_id;
+
+	schedule_delayed_work(&vpd->irq_work, msecs_to_jiffies(10));
+
+	return IRQ_HANDLED;
+}
+
+static enum vpd_data_role vpd_extcon_data_role(struct vpd_extcon *vpd)
+{
+	const char *const data_roles[] = {
+		[DR_NONE]		= "NONE",
+		[DR_HOST]		= "host",
+		[DR_DEVICE]		= "device",
+		[DR_DISPLAY_PORT]	= "display-port",
+	};
+	struct device *dev = vpd->dev;
+	int ret;
+	const char *dr;
+
+	ret = device_property_read_string(dev, "vpd-data-role", &dr);
+	if (ret < 0)
+		return DR_NONE;
+
+	ret = match_string(data_roles, ARRAY_SIZE(data_roles), dr);
+
+	return (ret < 0) ? DR_NONE : ret;
+}
+
+static int vpd_extcon_parse_dts(struct vpd_extcon *vpd)
+{
+	struct device *dev = vpd->dev;
+	bool val = false;
+	int ret;
+
+	val = device_property_read_bool(dev, "vpd-polarity");
+	if (val)
+		vpd->polarity = POLARITY_FLIP;
+	else
+		vpd->polarity = POLARITY_NORMAL;
+
+	val = device_property_read_bool(dev, "vpd-super-speed");
+	if (val)
+		vpd->usb_ss = USB_SS_USB3;
+	else
+		vpd->usb_ss = USB_SS_USB2;
+
+	vpd->data_role = vpd_extcon_data_role(vpd);
+
+	vpd->det_gpio = devm_gpiod_get_optional(dev, "det", GPIOD_OUT_LOW);
+	if (IS_ERR(vpd->det_gpio)) {
+		ret = PTR_ERR(vpd->det_gpio);
+		dev_warn(dev, "failed to get det gpio: %d\n", ret);
+		return ret;
+	}
+
+	vpd->irq = gpiod_to_irq(vpd->det_gpio);
+	if (vpd->irq < 0) {
+		dev_err(dev, "failed to get irq for gpio: %d\n", vpd->irq);
+		return vpd->irq;
+	}
+
+	ret = devm_request_threaded_irq(dev, vpd->irq, NULL,
+					vpd_extcon_irq_handler,
+					IRQF_TRIGGER_FALLING |
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					NULL, vpd);
+	if (ret)
+		dev_err(dev, "failed to request gpio irq\n");
+
+	return ret;
+}
+
+static int vpd_extcon_probe(struct platform_device *pdev)
+{
+	struct vpd_extcon *vpd;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	vpd = devm_kzalloc(dev, sizeof(*vpd), GFP_KERNEL);
+	if (!vpd)
+		return -ENOMEM;
+
+	vpd->dev = dev;
+	ret = vpd_extcon_parse_dts(vpd);
+	if (ret)
+		return ret;
+
+	INIT_DELAYED_WORK(&vpd->irq_work, vpd_extcon_irq_work);
+
+	vpd->extcon = devm_extcon_dev_allocate(dev, vpd_cable);
+	if (IS_ERR(vpd->extcon)) {
+		dev_err(dev, "allocat extcon failed\n");
+		return PTR_ERR(vpd->extcon);
+	}
+
+	ret = devm_extcon_dev_register(dev, vpd->extcon);
+	if (ret) {
+		dev_err(dev, "register extcon failed: %d\n", ret);
+		return ret;
+	}
+
+	extcon_set_property_capability(vpd->extcon, EXTCON_USB,
+				       EXTCON_PROP_USB_VBUS);
+	extcon_set_property_capability(vpd->extcon, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_VBUS);
+
+	extcon_set_property_capability(vpd->extcon, EXTCON_USB,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+	extcon_set_property_capability(vpd->extcon, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+	extcon_set_property_capability(vpd->extcon, EXTCON_USB,
+				       EXTCON_PROP_USB_SS);
+	extcon_set_property_capability(vpd->extcon, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_SS);
+
+	extcon_set_property_capability(vpd->extcon, EXTCON_DISP_DP,
+				       EXTCON_PROP_USB_SS);
+	extcon_set_property_capability(vpd->extcon, EXTCON_DISP_DP,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+
+	platform_set_drvdata(pdev, vpd);
+
+	vpd_extcon_irq_work(&vpd->irq_work.work);
+
+	return 0;
+}
+
+static int vpd_extcon_remove(struct platform_device *pdev)
+{
+	struct vpd_extcon *vpd = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&vpd->irq_work);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int vpd_extcon_suspend(struct device *dev)
+{
+	struct vpd_extcon *vpd = dev_get_drvdata(dev);
+
+	if (!vpd->enable_irq) {
+		disable_irq_nosync(vpd->irq);
+		vpd->enable_irq = true;
+	}
+
+	return 0;
+}
+
+static int vpd_extcon_resume(struct device *dev)
+{
+	struct vpd_extcon *vpd = dev_get_drvdata(dev);
+
+	if (vpd->enable_irq) {
+		enable_irq(vpd->irq);
+		vpd->enable_irq = false;
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(vpd_extcon_pm_ops,
+			 vpd_extcon_suspend, vpd_extcon_resume);
+
+static const struct of_device_id vpd_extcon_dt_match[] = {
+	{ .compatible = "linux,extcon-usbc-virtual-pd", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver vpd_extcon_driver = {
+	.probe		= vpd_extcon_probe,
+	.remove		= vpd_extcon_remove,
+	.driver		= {
+		.name	= "extcon-usbc-virtual-pd",
+		.pm	= &vpd_extcon_pm_ops,
+		.of_match_table = vpd_extcon_dt_match,
+	},
+};
+
+module_platform_driver(vpd_extcon_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Type-C Virtual PD extcon driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

