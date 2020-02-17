Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E3C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C5A20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgBQKHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:07:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:42610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgBQKHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:07:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76A7BAD5C;
        Mon, 17 Feb 2020 10:07:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     oneukum@suse.com, phil@raspberrypi.com, tim.gover@raspberrypi.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] usb: xhci-pci: Raspberry Pi FW loader for VIA VL805
Date:   Mon, 17 Feb 2020 11:07:00 +0100
Message-Id: <20200217100701.19949-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
VideCore.  Inform VideCore that VL805 was just reset, or defer xhci's
probe if not yet joinable trough the mailbox interface.

Based on Tim Gover's downstream implementation.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/xhci-pci.c                | 50 ++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  2 +-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 4917c5b033fa..eadace4a9339 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
 #include "xhci.h"
 #include "xhci-trace.h"
 
@@ -308,6 +310,44 @@ static int xhci_pci_setup(struct usb_hcd *hcd)
 	return xhci_pci_reinit(xhci, pdev);
 }
 
+/*
+ * On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
+ * loaded directly from an EEPROM or, if not present, by the SoC's VideCore.
+ * Inform VideCore that VL805 was just reset, or defer xhci's probe if not yet
+ * joinable trough the mailbox interface.
+ */
+static int raspberrypi_load_vl805_fw(struct pci_dev *pdev)
+{
+#ifdef CONFIG_RASPBERRYPI_FIRMWARE
+	struct device_node *fw_np;
+	struct rpi_firmware *fw;
+	u32 dev_addr;
+	int ret;
+
+	fw_np = of_find_compatible_node(NULL, NULL,
+					"raspberrypi,bcm2835-firmware");
+	if (!fw_np)
+		return 0;
+
+	fw = rpi_firmware_get(fw_np);
+	of_node_put(fw_np);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	dev_addr = pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
+		   PCI_FUNC(pdev->devfn) << 12;
+
+	ret = rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
+				    &dev_addr, sizeof(dev_addr));
+	if (ret)
+		return ret;
+
+	dev_dbg(&pdev->dev, "loaded Raspberry Pi's VL805 firmware\n");
+
+#endif
+	return 0;
+}
+
 /*
  * We need to register our own PCI probe function (instead of the USB core's
  * function) in order to create a second roothub under xHCI.
@@ -321,6 +361,16 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	driver = (struct hc_driver *)id->driver_data;
 
+	if (dev->vendor == PCI_VENDOR_ID_VIA && dev->device == 0x3483) {
+		retval = raspberrypi_load_vl805_fw(dev);
+		if (retval) {
+			if (retval != -EPROBE_DEFER)
+				dev_err(&dev->dev,
+					"Failed to load VL805's firmware");
+			return retval;
+		}
+	}
+
 	/* Prevent runtime suspending between USB-2 and USB-3 initialization */
 	pm_runtime_get_noresume(&dev->dev);
 
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 7800e12ee042..cc9cdbc66403 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -90,7 +90,7 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_PERIPH_REG =                         0x00038045,
 	RPI_FIRMWARE_GET_POE_HAT_VAL =                        0x00030049,
 	RPI_FIRMWARE_SET_POE_HAT_VAL =                        0x00030050,
-
+	RPI_FIRMWARE_NOTIFY_XHCI_RESET =                      0x00030058,
 
 	/* Dispmanx TAGS */
 	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,
-- 
2.25.0

