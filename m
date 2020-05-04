Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C394BC47259
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77972073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgEDRQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:16:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgEDRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:16:51 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVehz-0006iO-CS; Mon, 04 May 2020 17:16:47 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] xhci: Prevent runtime suspend on Etron EJ168
Date:   Tue,  5 May 2020 01:16:42 +0800
Message-Id: <20200504171642.26947-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Etron EJ168 USB 3.0 Host Controller stops working after S3, if it was
runtime suspended previously:
[  370.080359] pci 0000:02:00.0: can't change power state from D3cold to D0 (config space inaccessible)
[  370.080477] xhci_hcd 0000:04:00.0: can't change power state from D3cold to D0 (config space inaccessible)
[  370.080532] pcieport 0000:00:1c.0: DPC: containment event, status:0x1f05 source:0x0200
[  370.080533] pcieport 0000:00:1c.0: DPC: ERR_FATAL detected
[  370.080536] xhci_hcd 0000:04:00.0: can't change power state from D3hot to D0 (config space inaccessible)
[  370.080552] xhci_hcd 0000:04:00.0: AER: can't recover (no error_detected callback)
[  370.080566] usb usb3: root hub lost power or was reset
[  370.080566] usb usb4: root hub lost power or was reset
[  370.080572] xhci_hcd 0000:04:00.0: Host halt failed, -19
[  370.080574] xhci_hcd 0000:04:00.0: Host not accessible, reset failed.
[  370.080575] xhci_hcd 0000:04:00.0: PCI post-resume error -19!
[  370.080586] xhci_hcd 0000:04:00.0: HC died; cleaning up

This can be fixed by not runtime suspend the controller at all.

So disable runtime suspend for EJ168 xHCI device.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Balance rpm refcount in remove callback.

v2:
 - Use a new quirk to avoid changing existing behavior.

 drivers/usb/host/xhci-pci.c | 7 ++++++-
 drivers/usb/host/xhci.h     | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 766b74723e64..67b4b433a93e 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -227,6 +227,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_DISABLE_RUNTIME_SUSPEND;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
@@ -371,7 +372,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		xhci->shared_hcd->can_do_streams = 1;
 
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
-	pm_runtime_put_noidle(&dev->dev);
+	if (!(xhci->quirks & XHCI_DISABLE_RUNTIME_SUSPEND))
+		pm_runtime_put_noidle(&dev->dev);
 
 	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
@@ -397,6 +399,9 @@ static void xhci_pci_remove(struct pci_dev *dev)
 	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_forbid(&dev->dev);
 
+	if (!(xhci->quirks & XHCI_DISABLE_RUNTIME_SUSPEND))
+		pm_runtime_get_noresume(&dev->dev);
+
 	if (xhci->shared_hcd) {
 		usb_remove_hcd(xhci->shared_hcd);
 		usb_put_hcd(xhci->shared_hcd);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 86cfefdd6632..d9c209a10d3f 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1873,6 +1873,7 @@ struct xhci_hcd {
 #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
 #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
 #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
+#define XHCI_DISABLE_RUNTIME_SUSPEND    BIT_ULL(36)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.17.1

