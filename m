Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82550C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641032072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgBELWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:22:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54443 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgBELWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:22:43 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1izIlR-0003Hw-Ul; Wed, 05 Feb 2020 11:22:38 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/3] xhci: Wait until link state trainsits to U0 after setting USB_SS_PORT_LS_U0
Date:   Wed,  5 Feb 2020 19:22:27 +0800
Message-Id: <20200205112228.25155-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205112228.25155-1-kai.heng.feng@canonical.com>
References: <20200205112228.25155-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like U3 case, xHCI spec doesn't specify the upper bound of U0 transition
time. The 20ms is not enough for some devices.

Intead of polling PLS or PLC, we can facilitate the port change event to
know that the link transits to U0 is completed.

While at it, seperate U0 and U3 case 

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-hub.c  | 34 +++++++++++++++++++++-------------
 drivers/usb/host/xhci-mem.c  |  2 ++
 drivers/usb/host/xhci-ring.c |  1 +
 drivers/usb/host/xhci.h      |  1 +
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index d3c5bcf76755..28a5c1c46079 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1297,7 +1297,23 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					 wIndex, link_state);
 				goto error;
 			}
+
+			if (link_state == USB_SS_PORT_LS_U0) {
+				if ((temp & PORT_PLS_MASK) == XDEV_U0)
+					break;
+
+				reinit_completion(&bus_state->link_change_done[wIndex]);
+				xhci_set_link_state(xhci, ports[wIndex], USB_SS_PORT_LS_U0);
+				spin_unlock_irqrestore(&xhci->lock, flags);
+				if (!wait_for_completion_timeout(&bus_state->link_change_done[wIndex], msecs_to_jiffies(100)))
+					xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n", hcd->self.busnum, wIndex + 1);
+				spin_lock_irqsave(&xhci->lock, flags);
+				temp = readl(ports[wIndex]->addr);
+				break;
+			}
+
 			if (link_state == USB_SS_PORT_LS_U3) {
+				int retries = 10;
 				slot_id = xhci_find_slot_id_by_port(hcd, xhci,
 						wIndex + 1);
 				if (slot_id) {
@@ -1308,26 +1324,18 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					xhci_stop_device(xhci, slot_id, 1);
 					spin_lock_irqsave(&xhci->lock, flags);
 				}
-			}
-
-			xhci_set_link_state(xhci, ports[wIndex], link_state);
-
-			spin_unlock_irqrestore(&xhci->lock, flags);
-			if (link_state == USB_SS_PORT_LS_U3) {
-				int retries = 10;
-
+				xhci_set_link_state(xhci, ports[wIndex], USB_SS_PORT_LS_U3);
+				spin_unlock_irqrestore(&xhci->lock, flags);
 				while (retries--) {
 					msleep(10); /* wait device to enter */
 					temp = readl(ports[wIndex]->addr);
 					if ((temp & PORT_PLS_MASK) == XDEV_U3)
 						break;
 				}
-			}
-			spin_lock_irqsave(&xhci->lock, flags);
-
-			temp = readl(ports[wIndex]->addr);
-			if (link_state == USB_SS_PORT_LS_U3)
+				spin_lock_irqsave(&xhci->lock, flags);
+				temp = readl(ports[wIndex]->addr);
 				bus_state->suspended_ports |= 1 << wIndex;
+			}
 			break;
 		case USB_PORT_FEAT_POWER:
 			/*
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 3b1388fa2f36..aceb8c1af775 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2531,6 +2531,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		xhci->usb3_rhub.bus_state.resume_done[i] = 0;
 		/* Only the USB 2.0 completions will ever be used. */
 		init_completion(&xhci->usb2_rhub.bus_state.rexit_done[i]);
+		init_completion(&xhci->usb2_rhub.bus_state.link_change_done[i]);
+		init_completion(&xhci->usb3_rhub.bus_state.link_change_done[i]);
 	}
 
 	if (scratchpad_alloc(xhci, flags))
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d23f7408c81f..4d0f8dab069a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1677,6 +1677,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	     (portsc & PORT_PLS_MASK) == XDEV_U1 ||
 	     (portsc & PORT_PLS_MASK) == XDEV_U2)) {
 		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
+		complete(&bus_state->link_change_done[hcd_portnum]);
 		/* We've just brought the device into U0/1/2 through either the
 		 * Resume state after a device remote wakeup, or through the
 		 * U3Exit state after a host-initiated resume.  If it's a device
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 13d8838cd552..b5d443ce0750 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1694,6 +1694,7 @@ struct xhci_bus_state {
 	/* Which ports are waiting on RExit to U0 transition. */
 	unsigned long		rexit_ports;
 	struct completion	rexit_done[USB_MAXCHILDREN];
+	struct completion	link_change_done[USB_MAXCHILDREN];
 };
 
 
-- 
2.17.1

