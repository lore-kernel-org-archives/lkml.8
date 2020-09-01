Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B61C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A929A206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8Cvs4SN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgIAUVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgIAUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:21:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897CC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 13:21:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so1175427pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DxL6u3e7kvKdyV4knLMNNIE0lTzHJCqq8TUt2xh/bs=;
        b=O8Cvs4SNOdpst6RWC5nBpOS+LgIXtcr1DxmJzvLTWMcud+ix0Wym9ktL6MGk2OhQuO
         5BGC7//V2Xa9290LbSD4W5QtpKEk/s3QZvT9NCE85zuTllyd0nBnJH0n2OTMMiJRg0aj
         JFmPT6FYEbaFyV1gwHcpDpNU0e+AH6M57/CsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DxL6u3e7kvKdyV4knLMNNIE0lTzHJCqq8TUt2xh/bs=;
        b=mf+H1B5BNwJQZLYxDzgWPbzQX42drkj33gvDpdAtQa+62Azb+ff0tXWAI3Cakqf63E
         sBs6eE4ryVq13Z16zTm7g9l7zeL/beyhTGa55Su5FoTDJIVoIWPAIwB/rIY1COMTMP/g
         SOaIE/r2OYQvsg0rZXrFEkRrShUoOLNPvIaEMxSgWgKRZPskGXp155RhZ3R6jupJ1xMB
         gZpHf1ZFwlKEO6KXQXirypUN2zh00llLAM+Y7BN0n685C+8BsmQZPBuToIvzEfDqgFc+
         4HpgGRswIq2BOjx8DAAmkgIHFfvVtVpBA5gAMZGZnxhPxN9k+if1vJud/B5hz2WtOCca
         FYdw==
X-Gm-Message-State: AOAM531vLAfkY5a8LrkoxDCm6vEz3HcSNmM9tMeJtSU0FjDxxwLnwIKF
        NoZl0SMqj/UGZhBEddiGl1/G8A==
X-Google-Smtp-Source: ABdhPJwBqk0SrzIKEd3x4Cq/di9rOn2f3ybqZRnRj5XlYfWESo+NleAfQkdf7RjOTrzG0o9WUnuJ/g==
X-Received: by 2002:a17:90a:de09:: with SMTP id m9mr3101753pjv.231.1598991706803;
        Tue, 01 Sep 2020 13:21:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id lw2sm2280811pjb.34.2020.09.01.13.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 13:21:46 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Date:   Tue,  1 Sep 2020 13:21:43 -0700
Message-Id: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver combo usb_hub_pwr/usb_hub_psupply allows to control
the power supply of an onboard USB hub.

The drivers address two issues:
 - a USB hub needs to be powered before it can be discovered
 - battery powered devices may want to switch the USB hub off
   during suspend to extend battery life

The regulator of the hub is controlled by the usb_hub_psupply
platform driver. The regulator is switched on when the platform
device is initialized, which enables discovery of the hub. The
driver provides an external interface to enable/disable the
power supply which is used by the usb_hub_pwr driver.

The usb_hub_pwr extends the generic USB hub driver. The device is
initialized when the hub is discovered by the USB subsystem. It
uses the usb_hub_psupply interface to make its own request to
enable the regulator (increasing the use count to 2).

During system suspend usb_hub_pwr checks if any wakeup capable
devices are connected to the hub. If not it 'disables' the hub
regulator (decreasing the use count to 1, hence the regulator
stays enabled for now). When the usb_hub_psupply device suspends
it disables the hub regulator unconditionally (decreasing the use
count to 0 or 1, depending on the actions of usb_hub_pwr). This
is done to allow the usb_hub_pwr device to control the state of
the regulator during system suspend.

Upon resume usb_hub_psupply enables the regulator again, the
usb_hub_pwr device does the same if it disabled the regulator
during resume.

Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
The driver currently only supports a single power supply. This should
work for most/many configurations/hubs, support for multiple power
supplies can be added later if needed.

No DT bindings are included since this is just a RFC. Here is a DT
example:

usb_hub_psupply: usb-hub-psupply {
    compatible = "linux,usb_hub_psupply";
    vdd-supply = <&pp3300_hub>;
};

&usb_1_dwc3 {
    /* 2.0 hub on port 1 */
    hub@1 {
        compatible = "usbbda,5411";
        reg = <1>;
        psupply = <&usb_hub_psupply>;
    };

    /* 3.0 hub on port 2 */
    hub@2 {
        compatible = "usbbda,411";
        reg = <2>;
        psupply = <&usb_hub_psupply>;
    };
};

 drivers/usb/misc/Kconfig           |  14 +++
 drivers/usb/misc/Makefile          |   1 +
 drivers/usb/misc/usb_hub_psupply.c | 112 ++++++++++++++++++
 drivers/usb/misc/usb_hub_psupply.h |   9 ++
 drivers/usb/misc/usb_hub_pwr.c     | 177 +++++++++++++++++++++++++++++
 5 files changed, 313 insertions(+)
 create mode 100644 drivers/usb/misc/usb_hub_psupply.c
 create mode 100644 drivers/usb/misc/usb_hub_psupply.h
 create mode 100644 drivers/usb/misc/usb_hub_pwr.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6818ea689cd9..79ed50e6a7bf 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -275,3 +275,17 @@ config USB_CHAOSKEY
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called chaoskey.
+
+config USB_HUB_PWR
+	tristate "Control power supply for onboard USB hubs"
+	depends on PM
+	help
+	  Say Y here if you want to control the power supply of an
+	  onboard USB hub. The driver switches the power supply of the
+	  hub on, to make sure the hub can be discovered. During system
+	  suspend the power supply is switched off, unless a wakeup
+	  capable device is connected to the hub. This may reduce power
+	  consumption on battery powered devices.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called usb_hub_pwr.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index da39bddb0604..2bd02388ca62 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
+obj-$(CONFIG_USB_HUB_PWR)		+= usb_hub_pwr.o usb_hub_psupply.o
diff --git a/drivers/usb/misc/usb_hub_psupply.c b/drivers/usb/misc/usb_hub_psupply.c
new file mode 100644
index 000000000000..6a155ae1f831
--- /dev/null
+++ b/drivers/usb/misc/usb_hub_psupply.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, Google LLC
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+struct usb_hub_psupply_dev {
+	struct regulator *vdd;
+};
+
+int usb_hub_psupply_on(struct device *dev)
+{
+	struct usb_hub_psupply_dev *usb_hub_psupply = dev_get_drvdata(dev);
+	int err;
+
+	err = regulator_enable(usb_hub_psupply->vdd);
+	if (err) {
+		dev_err(dev, "failed to enable regulator: %d\n", err);
+		return err;
+	}
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(usb_hub_psupply_on);
+
+int usb_hub_psupply_off(struct device *dev)
+{
+	struct usb_hub_psupply_dev *usb_hub_psupply = dev_get_drvdata(dev);
+	int err;
+
+	err = regulator_disable(usb_hub_psupply->vdd);
+	if (err) {
+		dev_err(dev, "failed to enable regulator: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_hub_psupply_off);
+
+static int usb_hub_psupply_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct usb_hub_psupply_dev *usb_hub_psupply;
+
+	usb_hub_psupply = devm_kzalloc(dev, sizeof(*usb_hub_psupply), GFP_KERNEL);
+	if (!usb_hub_psupply)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, usb_hub_psupply);
+
+	usb_hub_psupply->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(usb_hub_psupply->vdd))
+		return PTR_ERR(usb_hub_psupply->vdd);
+
+	return usb_hub_psupply_on(dev);
+}
+
+static int usb_hub_psupply_remove(struct platform_device *pdev)
+{
+	return usb_hub_psupply_off(&pdev->dev);
+}
+
+static int usb_hub_psupply_suspend(struct platform_device *pdev, pm_message_t msg)
+{
+	return usb_hub_psupply_off(&pdev->dev);
+}
+
+static int usb_hub_psupply_resume(struct platform_device *pdev)
+{
+	return usb_hub_psupply_on(&pdev->dev);
+}
+
+static const struct of_device_id usb_hub_psupply_match[] = {
+	{ .compatible = "linux,usb_hub_psupply" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, usb_hub_psupply_match);
+
+static struct platform_driver usb_hub_psupply_driver = {
+	.probe = usb_hub_psupply_probe,
+	.remove = usb_hub_psupply_remove,
+	.suspend = usb_hub_psupply_suspend,
+	.resume = usb_hub_psupply_resume,
+	.driver = {
+		.name = "usb-hub-psupply",
+		.of_match_table = usb_hub_psupply_match,
+	},
+};
+
+static int __init usb_hub_psupply_init(void)
+{
+	return platform_driver_register(&usb_hub_psupply_driver);
+}
+device_initcall(usb_hub_psupply_init);
+
+static void __exit usb_hub_psupply_exit(void)
+{
+	platform_driver_unregister(&usb_hub_psupply_driver);
+}
+module_exit(usb_hub_psupply_exit);
+
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("USB Hub Power Supply");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/misc/usb_hub_psupply.h b/drivers/usb/misc/usb_hub_psupply.h
new file mode 100644
index 000000000000..284e88f45fcf
--- /dev/null
+++ b/drivers/usb/misc/usb_hub_psupply.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _USB_HUB_PSUPPLY_H
+#define _USB_HUB_PSUPPLY_H
+
+int usb_hub_psupply_on(struct device *dev);
+int usb_hub_psupply_off(struct device *dev);
+
+#endif /* _USB_HUB_PSUPPLY_H */
diff --git a/drivers/usb/misc/usb_hub_pwr.c b/drivers/usb/misc/usb_hub_pwr.c
new file mode 100644
index 000000000000..33945ca4a8c0
--- /dev/null
+++ b/drivers/usb/misc/usb_hub_pwr.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * USB hub power control
+ *
+ * Copyright (c) 2020, Google LLC
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/power_supply.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include "../core/usb.h"
+#include "usb_hub_psupply.h"
+
+#define VENDOR_ID_REALTEK	0x0bda
+
+struct usb_hub_pwr_dev {
+	struct regulator *vdd;
+	struct device *psupply_dev;
+	bool powered_off;
+};
+
+static struct device *usb_pwr_find_psupply_dev(struct device *dev)
+{
+	const phandle *ph;
+	struct device_node *np;
+	struct platform_device *pdev;
+
+	ph = of_get_property(dev->of_node, "psupply", NULL);
+	if (!ph) {
+		dev_err(dev, "failed to read 'psupply' property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	np = of_find_node_by_phandle(be32_to_cpu(*ph));
+	if (!np) {
+		dev_err(dev, "failed find device node for power supply\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return &pdev->dev;
+}
+
+static int usb_hub_pwr_probe(struct usb_device *udev)
+{
+	struct device *dev = &udev->dev;
+	struct usb_hub_pwr_dev *uhpw;
+	struct device *psupply_dev;
+	int err;
+
+	/* ignore supported hubs without device tree node */
+	if (!dev->of_node)
+		return -ENODEV;
+
+	psupply_dev = usb_pwr_find_psupply_dev(dev);
+	if (IS_ERR(psupply_dev))
+		return PTR_ERR(psupply_dev);
+
+	err = usb_generic_driver_probe(udev);
+	if (err) {
+		put_device(psupply_dev);
+		return err;
+	}
+
+	uhpw = devm_kzalloc(dev, sizeof(*uhpw), GFP_KERNEL);
+	if (!uhpw) {
+		put_device(psupply_dev);
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&udev->dev, uhpw);
+
+	uhpw->psupply_dev = psupply_dev;
+
+	err = usb_hub_psupply_on(psupply_dev);
+	if (err) {
+		dev_err(dev, "failed to enable regulator: %d\n", err);
+		put_device(psupply_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void usb_hub_pwr_disconnect(struct usb_device *udev)
+{
+	struct usb_hub_pwr_dev *uhpw = dev_get_drvdata(&udev->dev);
+
+	usb_hub_psupply_off(uhpw->psupply_dev);
+	put_device(uhpw->psupply_dev);
+}
+
+static int usb_hub_pwr_suspend(struct usb_device *udev, pm_message_t msg)
+{
+	struct usb_hub_pwr_dev *uhpw = dev_get_drvdata(&udev->dev);
+	int err;
+
+	err = usb_generic_driver_suspend(udev, msg);
+	if (err)
+		return err;
+
+	if (!usb_wakeup_enabled_descendants(udev)) {
+		usb_port_disable(udev);
+
+		err = usb_hub_psupply_off(uhpw->psupply_dev);
+		if (err)
+			return err;
+
+		uhpw->powered_off = true;
+	}
+
+	return 0;
+}
+
+static int usb_hub_pwr_resume(struct usb_device *udev, pm_message_t msg)
+{
+	struct usb_hub_pwr_dev *uhpw = dev_get_drvdata(&udev->dev);
+	int err;
+
+	if (uhpw->powered_off) {
+		err = usb_hub_psupply_on(uhpw->psupply_dev);
+		if (err)
+			return err;
+
+		uhpw->powered_off = false;
+	}
+
+	return usb_generic_driver_resume(udev, msg);
+}
+
+static const struct usb_device_id hub_id_table[] = {
+	{ .idVendor = VENDOR_ID_REALTEK,
+	  .idProduct = 0x0411, /* RTS5411 USB 3.0 */
+	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
+	{ .idVendor = VENDOR_ID_REALTEK,
+	  .idProduct = 0x5411, /* RTS5411 USB 2.0 */
+	  .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
+	{},
+};
+
+MODULE_DEVICE_TABLE(usb, hub_id_table);
+
+static struct usb_device_driver usb_hub_pwr_driver = {
+
+	.name = "usb-hub-pwr",
+	.probe = usb_hub_pwr_probe,
+	.disconnect = usb_hub_pwr_disconnect,
+	.suspend = usb_hub_pwr_suspend,
+	.resume = usb_hub_pwr_resume,
+	.id_table = hub_id_table,
+};
+
+static int __init usb_hub_pwr_driver_init(void)
+{
+	return usb_register_device_driver(&usb_hub_pwr_driver, THIS_MODULE);
+}
+
+static void __exit usb_hub_pwr_driver_exit(void)
+{
+	usb_deregister_device_driver(&usb_hub_pwr_driver);
+}
+
+module_init(usb_hub_pwr_driver_init);
+module_exit(usb_hub_pwr_driver_exit);
+
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("USB Hub Power Control");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0.402.g5ffc5be6b7-goog

