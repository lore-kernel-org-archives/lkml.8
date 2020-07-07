Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F48206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594151099;
	bh=dJp+PL8g3KNnzNGMS1VZ8Vt2dsb5EvBdpIBRC+C9sWY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=A5UrqSW1aNtQxWysFYYOJaNjIVKaQcXonu0bwP5vMjrUL/kFVz0Mm0LEnmMYCJl7i
	 jwSUTyjZhkFMvFTpEuEYLF1zUXfOJ1peVN0faPa5w4ACzIQai1M53lmr6vchBfiLpj
	 LFyYgdGP6UsxYnqv6xbThOudy/FDMxdJQje8ZsGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgGGTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGGTo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:44:57 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5494206BE;
        Tue,  7 Jul 2020 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594151097;
        bh=dJp+PL8g3KNnzNGMS1VZ8Vt2dsb5EvBdpIBRC+C9sWY=;
        h=Date:From:To:Cc:Subject:From;
        b=BoRFD0r9+TcHRnVv+FIm6BwXiROBx8ed8M7u7mDC4gIYFVPEKAmatVdp9Sm5VdD4B
         GJHbRulK1zxhW90BdSn6+UZFJ3f6JB/dgPngZseEGCZAutEFojqTCNolQhQH0hVJHI
         J05mOUGHz8xvps0JZ3DFovWmLqxaGkHidq4L/55U=
Date:   Tue, 7 Jul 2020 14:50:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] usb: host: Use fallthrough pseudo-keyword
Message-ID: <20200707195023.GA3792@embeddedor>
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
 drivers/usb/host/ehci-dbg.c   |    2 +-
 drivers/usb/host/ehci-fsl.c   |    4 ++--
 drivers/usb/host/ehci-hcd.c   |    4 ++--
 drivers/usb/host/ehci-q.c     |    2 +-
 drivers/usb/host/ehci-sched.c |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index 7619cfb06883..0b7f1edd9eec 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -823,7 +823,7 @@ static ssize_t fill_registers_buffer(struct debug_buffer *buf)
 				break;
 			case 0:		/* illegal reserved capability */
 				cap = 0;
-				/* FALLTHROUGH */
+				fallthrough;
 			default:		/* unknown */
 				break;
 			}
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 9e9c232e896f..6c2b53baa515 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -234,7 +234,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		break;
 	case FSL_USB2_PHY_UTMI_WIDE:
 		portsc |= PORT_PTS_PTW;
-		/* fall through */
+		fallthrough;
 	case FSL_USB2_PHY_UTMI:
 		/* Presence of this node "has_fsl_erratum_a006918"
 		 * in device-tree is used to stop USB controller
@@ -244,7 +244,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 			dev_warn(dev, "USB PHY clock invalid\n");
 			return -EINVAL;
 		}
-		/* fall through */
+		fallthrough;
 	case FSL_USB2_PHY_UTMI_DUAL:
 		/* PHY_CLK_VALID bit is de-featured from all controller
 		 * versions below 2.4 and is to be checked only for
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index cf2b7ae93b7e..6257be4110ca 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -982,7 +982,7 @@ ehci_endpoint_disable (struct usb_hcd *hcd, struct usb_host_endpoint *ep)
 			start_unlink_async(ehci, qh);
 		else
 			start_unlink_intr(ehci, qh);
-		/* FALL THROUGH */
+		fallthrough;
 	case QH_STATE_COMPLETING:	/* already in unlinking */
 	case QH_STATE_UNLINK:		/* wait for hw to finish? */
 	case QH_STATE_UNLINK_WAIT:
@@ -999,7 +999,7 @@ ehci_endpoint_disable (struct usb_hcd *hcd, struct usb_host_endpoint *ep)
 			qh_destroy(ehci, qh);
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		/* caller was supposed to have unlinked any requests;
 		 * that's not our job.  just leak this memory.
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 8a5c9b3ebe1e..a826715ae9bd 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -874,7 +874,7 @@ qh_make (
 	switch (urb->dev->speed) {
 	case USB_SPEED_LOW:
 		info1 |= QH_LOW_SPEED;
-		/* FALL THROUGH */
+		fallthrough;
 
 	case USB_SPEED_FULL:
 		/* EPS 0 means "full" */
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index da7b00a6110b..847979f265b1 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -2475,7 +2475,7 @@ static void scan_isoc(struct ehci_hcd *ehci)
 			ehci_dbg(ehci, "corrupt type %d frame %d shadow %p\n",
 					type, frame, q.ptr);
 			/* BUG(); */
-			/* FALL THROUGH */
+			fallthrough;
 		case Q_TYPE_QH:
 		case Q_TYPE_FSTN:
 			/* End of the iTDs and siTDs */

