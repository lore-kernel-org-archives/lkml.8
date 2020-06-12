Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA12C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A33F207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLQrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:47:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgFLQr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:47:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E69F8ACDB;
        Fri, 12 Jun 2020 16:47:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 5/5] usb: xhci-pci: Add reset controller support
Date:   Fri, 12 Jun 2020 18:46:33 +0200
Message-Id: <20200612164632.25648-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612164632.25648-1-nsaenzjulienne@suse.de>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some atypical users of xhci-pci might need to manually reset their xHCI
controller before starting the HCD setup. Check if a reset controller
device is available to the PCI bus and trigger a reset.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/xhci-pci.c | 38 +++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 9fb6d2f763..710524fbb1 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -10,9 +10,14 @@
 #include <init.h>
 #include <log.h>
 #include <pci.h>
+#include <reset.h>
 #include <usb.h>
 #include <usb/xhci.h>
 
+struct xhci_pci_platdata {
+	struct reset_ctl reset;
+};
+
 static void xhci_pci_init(struct udevice *dev, struct xhci_hccr **ret_hccr,
 			  struct xhci_hcor **ret_hcor)
 {
@@ -39,14 +44,43 @@ static void xhci_pci_init(struct udevice *dev, struct xhci_hccr **ret_hccr,
 
 static int xhci_pci_probe(struct udevice *dev)
 {
+	struct xhci_pci_platdata *plat = dev_get_platdata(dev);
 	struct xhci_hccr *hccr;
 	struct xhci_hcor *hcor;
+	int ret;
+
+	ret = reset_get_by_index(dev, 0, &plat->reset);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "failed to get reset\n");
+		return ret;
+	}
+
+	if (reset_valid(&plat->reset)) {
+		ret = reset_assert(&plat->reset);
+		if (ret)
+			return ret;
+
+		ret = reset_deassert(&plat->reset);
+		if (ret)
+			return ret;
+	}
 
 	xhci_pci_init(dev, &hccr, &hcor);
 
 	return xhci_register(dev, hccr, hcor);
 }
 
+static int xhci_pci_remove(struct udevice *dev)
+{
+	struct xhci_pci_platdata *plat = dev_get_platdata(dev);
+
+	xhci_deregister(dev);
+	if (reset_valid(&plat->reset))
+		reset_free(&plat->reset);
+
+	return 0;
+}
+
 static const struct udevice_id xhci_pci_ids[] = {
 	{ .compatible = "xhci-pci" },
 	{ }
@@ -56,10 +90,10 @@ U_BOOT_DRIVER(xhci_pci) = {
 	.name	= "xhci_pci",
 	.id	= UCLASS_USB,
 	.probe = xhci_pci_probe,
-	.remove = xhci_deregister,
+	.remove = xhci_pci_remove,
 	.of_match = xhci_pci_ids,
 	.ops	= &xhci_usb_ops,
-	.platdata_auto_alloc_size = sizeof(struct usb_platdata),
+	.platdata_auto_alloc_size = sizeof(struct xhci_pci_platdata),
 	.priv_auto_alloc_size = sizeof(struct xhci_ctrl),
 	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
 };
-- 
2.26.2

