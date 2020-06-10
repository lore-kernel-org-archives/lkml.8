Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2484C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00ED207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFJGmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:42:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51343 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:42:40 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jiuRX-0001Se-Lm; Wed, 10 Jun 2020 06:42:36 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] xhci: Suspend ports to U3 directly from U1 or U2
Date:   Wed, 10 Jun 2020 14:42:30 +0800
Message-Id: <20200610064231.9454-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xHCI spec "4.15.1 Port Suspend" states that port can be put to U3 as long
as Enabled bit is set and from U0, U1 or U2 state.

Currently only USB_PORT_FEAT_LINK_STATE puts port to U3 directly, let's
do the same for USB_PORT_FEAT_SUSPEND and bus suspend case.

This is particularly useful for USB2 devices, which may take a very long
time to switch USB2 LPM on and off.

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-hub.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index f37316d2c8fa..f9375b77d17d 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1196,15 +1196,6 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		/* FIXME: What new port features do we need to support? */
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			temp = readl(ports[wIndex]->addr);
-			if ((temp & PORT_PLS_MASK) != XDEV_U0) {
-				/* Resume the port to U0 first */
-				xhci_set_link_state(xhci, ports[wIndex],
-							XDEV_U0);
-				spin_unlock_irqrestore(&xhci->lock, flags);
-				msleep(10);
-				spin_lock_irqsave(&xhci->lock, flags);
-			}
 			/* In spec software should not attempt to suspend
 			 * a port unless the port reports that it is in the
 			 * enabled (PED = ‘1’,PLS < ‘3’) state.
@@ -1645,8 +1636,10 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 			xhci_dbg(xhci, "Bus suspend bailout, port over-current detected\n");
 			return -EBUSY;
 		}
-		/* suspend ports in U0, or bail out for new connect changes */
-		if ((t1 & PORT_PE) && (t1 & PORT_PLS_MASK) == XDEV_U0) {
+		/* suspend ports in U0/U1/U2, or bail out for new connect changes */
+		if ((t1 & PORT_PE) && ((t1 & PORT_PLS_MASK) == XDEV_U0 ||
+				       (t1 & PORT_PLS_MASK) == XDEV_U1 ||
+				       (t1 & PORT_PLS_MASK) == XDEV_U2)) {
 			if ((t1 & PORT_CSC) && wake_enabled) {
 				bus_state->bus_suspended = 0;
 				spin_unlock_irqrestore(&xhci->lock, flags);
-- 
2.17.1

