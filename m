Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09939C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D746A2067D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594151210;
	bh=5xc6pN2TBXNWEcR01qSPAYpgcIpDgrzlDuJ85S1dAn0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uiHc8ZVBjrLkDkzLNMW+wPHaQ4MOYVMObCs96xwGGK3JdDGtUbt4cgI+9WuaHFEAe
	 Uq7HHpVb9UV7fEZ1HglzM7M/OEthB0Svtt8G5U7NaJofyJ+RmxexypYxlN/k1gVEyb
	 N6iYHOUWEPVxwRs24Ma/6ccRgYB4ueGiwFZgzdVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGGTqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgGGTqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:46:49 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54282067D;
        Tue,  7 Jul 2020 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594151208;
        bh=5xc6pN2TBXNWEcR01qSPAYpgcIpDgrzlDuJ85S1dAn0=;
        h=Date:From:To:Cc:Subject:From;
        b=KrIiJh2ef4ESA5x5pkG3fH9Aqt75oiH5qXW4bb+WlvyY6y6Qy03uKi4QJO7rruhQT
         bR4FAhRPYXNpm7ijlVoOmofnRAGYniIEV9QH3eBYXOL6/2gK4+3oR1DpdTLOj19b+A
         P13h67E+N3b7oAmrDa7T6ZM9b76xeLAa7S4D/s3w=
Date:   Tue, 7 Jul 2020 14:52:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] usbip: Use fallthrough pseudo-keyword
Message-ID: <20200707195214.GA3932@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/usbip/stub_rx.c       |    2 +-
 drivers/usb/usbip/vhci_hcd.c      |    7 +++----
 drivers/usb/usbip/vhci_rx.c       |    2 +-
 drivers/usb/usbip/vudc_transfer.c |    4 ++--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index e2b019532234..325c22008e53 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -424,7 +424,7 @@ static void masking_bogus_flags(struct urb *urb)
 	case USB_ENDPOINT_XFER_BULK:
 		if (is_out)
 			allowed |= URB_ZERO_PACKET;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:			/* all non-iso endpoints */
 		if (!is_out)
 			allowed |= URB_SHORT_NOT_OK;
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 65850e9c7190..1b598db5d8b9 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -508,7 +508,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_U1_TIMEOUT:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
-			/* Fall through */
+			fallthrough;
 		case USB_PORT_FEAT_U2_TIMEOUT:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
@@ -561,7 +561,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				       "supported for USB 2.0 roothub\n");
 				goto error;
 			}
-			/* FALLS THROUGH */
+			fallthrough;
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
@@ -584,8 +584,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 			/* 50msec reset signaling */
 			vhci_hcd->re_timeout = jiffies + msecs_to_jiffies(50);
-
-			/* FALLS THROUGH */
+			fallthrough;
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index 00fc98741c5d..266024cbb64f 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -27,7 +27,7 @@ struct urb *pickup_urb_and_free_priv(struct vhci_device *vdev, __u32 seqnum)
 
 		switch (status) {
 		case -ENOENT:
-			/* fall through */
+			fallthrough;
 		case -ECONNRESET:
 			dev_dbg(&urb->dev->dev,
 				 "urb seq# %u was unlinked %ssynchronously\n",
diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
index c9db846ee4f6..7e801fee33bf 100644
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -404,7 +404,7 @@ static void v_timer(struct timer_list *t)
 			 * for now, give unlimited bandwidth
 			 */
 			limit += urb->transfer_buffer_length;
-			/* fallthrough */
+			fallthrough;
 		default:
 treat_control_like_bulk:
 			total -= transfer(udc, urb, ep, limit);
@@ -479,7 +479,7 @@ void v_kick_timer(struct vudc *udc, unsigned long time)
 		return;
 	case VUDC_TR_IDLE:
 		t->state = VUDC_TR_RUNNING;
-		/* fallthrough */
+		fallthrough;
 	case VUDC_TR_STOPPED:
 		/* we may want to kick timer to unqueue urbs */
 		mod_timer(&t->timer, time);

