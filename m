Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FF5C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3212075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgEGGS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:18:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39561 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:18:25 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jWZr6-0008KV-FO; Thu, 07 May 2020 06:18:00 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xhci: Make debug message consistent with bus and port number
Date:   Thu,  7 May 2020 14:17:55 +0800
Message-Id: <20200507061755.13280-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current xhci debug message doesn't always output bus number, so it's
hard to figure out it's from USB2 or USB3 root hub.

In addition to that, some port numbers are offset to 0 and others are
offset to 1. Use the latter to match the USB core.

So use "bus number - port index + 1" to make debug message consistent.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-hub.c | 41 +++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index f37316d2c8fa..83088c262cc4 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1241,7 +1241,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			temp = readl(ports[wIndex]->addr);
 			/* Disable port */
 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
-				xhci_dbg(xhci, "Disable port %d\n", wIndex);
+				xhci_dbg(xhci, "Disable port %d-%d\n",
+					 hcd->self.busnum, wIndex + 1);
 				temp = xhci_port_state_to_neutral(temp);
 				/*
 				 * Clear all change bits, so that we get a new
@@ -1257,7 +1258,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 			/* Put link in RxDetect (enable port) */
 			if (link_state == USB_SS_PORT_LS_RX_DETECT) {
-				xhci_dbg(xhci, "Enable port %d\n", wIndex);
+				xhci_dbg(xhci, "Enable port %d-%d\n",
+					 hcd->self.busnum, wIndex + 1);
 				xhci_set_link_state(xhci, ports[wIndex],
 							link_state);
 				temp = readl(ports[wIndex]->addr);
@@ -1289,8 +1291,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					goto error;
 				}
 
-				xhci_dbg(xhci, "Enable compliance mode transition for port %d\n",
-						wIndex);
+				xhci_dbg(xhci, "Enable compliance mode transition for port %d-%d\n",
+					 hcd->self.busnum, wIndex + 1);
 				xhci_set_link_state(xhci, ports[wIndex],
 						link_state);
 
@@ -1304,8 +1306,9 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			/* Can't set port link state above '3' (U3) */
 			if (link_state > USB_SS_PORT_LS_U3) {
-				xhci_warn(xhci, "Cannot set port %d link state %d\n",
-					 wIndex, link_state);
+				xhci_warn(xhci, "Cannot set port %d-%d link state %d\n",
+					  hcd->self.busnum, wIndex + 1,
+					  link_state);
 				goto error;
 			}
 
@@ -1340,8 +1343,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				if (!wait_for_completion_timeout(&bus_state->u3exit_done[wIndex],
 								 msecs_to_jiffies(100)))
-					xhci_dbg(xhci, "missing U0 port change event for port %d\n",
-						 wIndex);
+					xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n",
+						 hcd->self.busnum, wIndex + 1);
 				spin_lock_irqsave(&xhci->lock, flags);
 				temp = readl(ports[wIndex]->addr);
 				break;
@@ -1386,15 +1389,15 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			writel(temp, ports[wIndex]->addr);
 
 			temp = readl(ports[wIndex]->addr);
-			xhci_dbg(xhci, "set port reset, actual port %d status  = 0x%x\n", wIndex, temp);
+			xhci_dbg(xhci, "set port reset, actual port %d-%d status  = 0x%x\n",
+				 hcd->self.busnum, wIndex + 1, temp);
 			break;
 		case USB_PORT_FEAT_REMOTE_WAKE_MASK:
 			xhci_set_remote_wake_mask(xhci, ports[wIndex],
 						  wake_mask);
 			temp = readl(ports[wIndex]->addr);
-			xhci_dbg(xhci, "set port remote wake mask, "
-					"actual port %d status  = 0x%x\n",
-					wIndex, temp);
+			xhci_dbg(xhci, "set port remote wake mask, actual port %d-%d status  = 0x%x\n",
+				 hcd->self.busnum, wIndex + 1, temp);
 			break;
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			temp |= PORT_WR;
@@ -1634,8 +1637,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			msleep(XHCI_PORT_POLLING_LFPS_TIME);
 			spin_lock_irqsave(&xhci->lock, flags);
-			xhci_dbg(xhci, "port %d polling in bus suspend, waiting\n",
-				 port_index);
+			xhci_dbg(xhci, "port %d-%d polling in bus suspend, waiting\n",
+				 hcd->self.busnum, port_index + 1);
 			goto retry;
 		}
 		/* bail out if port detected a over-current condition */
@@ -1653,7 +1656,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 				xhci_dbg(xhci, "Bus suspend bailout, port connect change\n");
 				return -EBUSY;
 			}
-			xhci_dbg(xhci, "port %d not suspended\n", port_index);
+			xhci_dbg(xhci, "port %d-%d not suspended\n",
+				 hcd->self.busnum, port_index + 1);
 			t2 &= ~PORT_PLS_MASK;
 			t2 |= PORT_LINK_STROBE | XDEV_U3;
 			set_bit(port_index, &bus_state->bus_suspended);
@@ -1783,7 +1787,8 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 		if ((xhci->quirks & XHCI_MISSING_CAS) &&
 		    (hcd->speed >= HCD_USB3) &&
 		    xhci_port_missing_cas_quirk(ports[port_index])) {
-			xhci_dbg(xhci, "reset stuck port %d\n", port_index);
+			xhci_dbg(xhci, "reset stuck port %d-%d\n",
+				 hcd->self.busnum, port_index + 1);
 			clear_bit(port_index, &bus_state->bus_suspended);
 			continue;
 		}
@@ -1830,8 +1835,8 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 		sret = xhci_handshake(ports[port_index]->addr, PORT_PLC,
 				      PORT_PLC, 10 * 1000);
 		if (sret) {
-			xhci_warn(xhci, "port %d resume PLC timeout\n",
-				  port_index);
+			xhci_warn(xhci, "port %d-%d resume PLC timeout\n",
+				  hcd->self.busnum, port_index + 1);
 			continue;
 		}
 		xhci_test_and_clear_bit(xhci, ports[port_index], PORT_PLC);
-- 
2.17.1

