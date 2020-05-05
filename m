Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC874C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBFC206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgEEQ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:26:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:57832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbgEEQ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:26:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB82AAF5D;
        Tue,  5 May 2020 16:26:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 2/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
Date:   Tue,  5 May 2020 18:26:07 +0200
Message-Id: <20200505162607.334-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505162607.334-1-nsaenzjulienne@suse.de>
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When needed, RPi4's co-processor (called VideoCore) has to be instructed
to load VL805's firmware (the chip providing xHCI support). VideCore's
firmware expects the board's PCIe bus to be already configured in order
for it to load the xHCI chip firmware. So we have to make sure this
happens in between the PCIe configuration and xHCI startup.

Introduce a callback in xhci_pci_probe() to run this platform specific
routine.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v2:
 - Get rid of #ifdef CONFIG_BCM2711
 - Get rid of redundant error message

Changes since v1:
 - Create callback

 board/raspberrypi/rpi/rpi.c | 6 ++++++
 drivers/usb/host/xhci-pci.c | 6 ++++++
 include/usb/xhci.h          | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index e367ba3092..dcaf45fbf2 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -14,6 +14,7 @@
 #include <lcd.h>
 #include <memalign.h>
 #include <mmc.h>
+#include <usb/xhci.h>
 #include <asm/gpio.h>
 #include <asm/arch/mbox.h>
 #include <asm/arch/msg.h>
@@ -494,3 +495,8 @@ int ft_board_setup(void *blob, bd_t *bd)
 
 	return 0;
 }
+
+void xhci_pci_fixup(struct udevice *dev)
+{
+	bcm2711_notify_vl805_reset();
+}
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c1f60da541..1285dde1ef 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -11,6 +11,10 @@
 #include <usb.h>
 #include <usb/xhci.h>
 
+__weak void xhci_pci_fixup(struct udevice *dev)
+{
+}
+
 static void xhci_pci_init(struct udevice *dev, struct xhci_hccr **ret_hccr,
 			  struct xhci_hcor **ret_hcor)
 {
@@ -40,6 +44,8 @@ static int xhci_pci_probe(struct udevice *dev)
 	struct xhci_hccr *hccr;
 	struct xhci_hcor *hcor;
 
+	xhci_pci_fixup(dev);
+
 	xhci_pci_init(dev, &hccr, &hcor);
 
 	return xhci_register(dev, hccr, hcor);
diff --git a/include/usb/xhci.h b/include/usb/xhci.h
index c16106a2fc..57feed7603 100644
--- a/include/usb/xhci.h
+++ b/include/usb/xhci.h
@@ -16,6 +16,7 @@
 #ifndef HOST_XHCI_H_
 #define HOST_XHCI_H_
 
+#include <usb.h>
 #include <asm/types.h>
 #include <asm/cache.h>
 #include <asm/io.h>
@@ -1281,4 +1282,6 @@ extern struct dm_usb_ops xhci_usb_ops;
 
 struct xhci_ctrl *xhci_get_ctrl(struct usb_device *udev);
 
+extern void xhci_pci_fixup(struct udevice *dev);
+
 #endif /* HOST_XHCI_H_ */
-- 
2.26.2

