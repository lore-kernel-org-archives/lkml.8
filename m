Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4B0C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ABE20735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEDJUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:20:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgEDJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:20:02 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVXGZ-0006Es-4z; Mon, 04 May 2020 09:19:59 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xhci: Prevent runtime suspend all the time with XHCI_RESET_ON_RESUME quirk
Date:   Mon,  4 May 2020 17:19:52 +0800
Message-Id: <20200504091952.15820-1-kai.heng.feng@canonical.com>
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

So instead of conditionally runtime suspend the controller, always
prevent runtime suspend with XHCI_RESET_ON_RESUME quirk.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-pci.c |  3 ++-
 drivers/usb/host/xhci.c     | 19 -------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 766b74723e64..7d2660923dae 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -371,7 +371,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		xhci->shared_hcd->can_do_streams = 1;
 
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
-	pm_runtime_put_noidle(&dev->dev);
+	if (!(xhci->quirks & XHCI_RESET_ON_RESUME))
+		pm_runtime_put_noidle(&dev->dev);
 
 	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bee5deccc83d..8a1e3172405b 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3860,16 +3860,6 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_slot_ctx *slot_ctx;
 	int i, ret;
 
-#ifndef CONFIG_USB_DEFAULT_PERSIST
-	/*
-	 * We called pm_runtime_get_noresume when the device was attached.
-	 * Decrement the counter here to allow controller to runtime suspend
-	 * if no devices remain.
-	 */
-	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-		pm_runtime_put_noidle(hcd->self.controller);
-#endif
-
 	ret = xhci_check_args(hcd, udev, NULL, 0, true, __func__);
 	/* If the host is halted due to driver unload, we still need to free the
 	 * device.
@@ -4020,15 +4010,6 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 
 	xhci_debugfs_create_slot(xhci, slot_id);
 
-#ifndef CONFIG_USB_DEFAULT_PERSIST
-	/*
-	 * If resetting upon resume, we can't put the controller into runtime
-	 * suspend if there is a device attached.
-	 */
-	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-		pm_runtime_get_noresume(hcd->self.controller);
-#endif
-
 	/* Is this a LS or FS device under a HS hub? */
 	/* Hub or peripherial? */
 	return 1;
-- 
2.17.1

