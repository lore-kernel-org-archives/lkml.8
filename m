Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC6A2067D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594151306;
	bh=FzVkTRZbVTWo26JlUWux1r2hqQFY+dIy55fBtRo68nw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Fpxsn0wQTYdn0gpNoTogWImeggP/tFjYHTI1rx+WDzsbwnaHR+y33zSHlbYUSoTo2
	 hH13ko1ueolgQOalpNVQlRWHsU+l1Z6ECYNn1htt8kUMVYhrcUM5gMbuRozuOyK5FQ
	 SARcP9LE7ls7aDp4CjqYCnIuy1EfmHjcpnK9koSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGGTsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGTsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:48:25 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E90F2067D;
        Tue,  7 Jul 2020 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594151304;
        bh=FzVkTRZbVTWo26JlUWux1r2hqQFY+dIy55fBtRo68nw=;
        h=Date:From:To:Cc:Subject:From;
        b=YN2eRfFAQTisuTkdb3UVqOKJQx9daTY64aN7IyfvLHFCAzzBdWPd2oRh4CDMJTt5J
         G9mM9RXD7DymeXTdImTyOM5p0QFsBPRHyesVvYknnD3igrVuJdXYOxPuYChgcHZfUN
         RpUpIhv1Re0t8QBCiwiCT8tgu0wagWfS9pril6jg=
Date:   Tue, 7 Jul 2020 14:53:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] USB: OHCI: Use fallthrough pseudo-keyword
Message-ID: <20200707195351.GA4061@embeddedor>
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
 drivers/usb/host/ohci-hcd.c  |    4 ++--
 drivers/usb/host/ohci-hub.c  |    2 +-
 drivers/usb/host/ohci-q.c    |    6 +++---
 drivers/usb/host/ohci-tmio.c |    6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 4de91653a2c7..9b4121927d4a 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -385,7 +385,7 @@ ohci_endpoint_disable (struct usb_hcd *hcd, struct usb_host_endpoint *ep)
 			ed_free (ohci, ed);
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		/* caller was supposed to have unlinked any requests;
 		 * that's not our job.  can't recover; must leak ed.
@@ -1051,7 +1051,7 @@ int ohci_restart(struct ohci_hcd *ohci)
 			ed->ed_next = ohci->ed_rm_list;
 			ed->ed_prev = NULL;
 			ohci->ed_rm_list = ed;
-			/* FALLTHROUGH */
+			fallthrough;
 		case ED_UNLINK:
 			break;
 		default:
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 634f3c7bf774..44504c1751e0 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -58,7 +58,7 @@ __acquires(ohci->lock)
 		ohci->hc_control |= OHCI_USB_RESET;
 		ohci_writel (ohci, ohci->hc_control, &ohci->regs->control);
 		(void) ohci_readl (ohci, &ohci->regs->control);
-		/* FALL THROUGH */
+		fallthrough;
 	case OHCI_USB_RESET:
 		status = -EBUSY;
 		ohci_dbg (ohci, "needs reinit!\n");
diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
index 4ccb85a67bb3..3b445312beea 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -647,7 +647,7 @@ static void td_submit_urb (
 		/* ... and periodic urbs have extra accounting */
 		periodic = ohci_to_hcd(ohci)->self.bandwidth_int_reqs++ == 0
 			&& ohci_to_hcd(ohci)->self.bandwidth_isoc_reqs == 0;
-		/* FALLTHROUGH */
+		fallthrough;
 	case PIPE_BULK:
 		info = is_out
 			? TD_T_TOGGLE | TD_CC | TD_DP_OUT
@@ -879,11 +879,11 @@ static void ed_halted(struct ohci_hcd *ohci, struct td *td, int cc)
 	case TD_DATAUNDERRUN:
 		if ((urb->transfer_flags & URB_SHORT_NOT_OK) == 0)
 			break;
-		/* fallthrough */
+		fallthrough;
 	case TD_CC_STALL:
 		if (usb_pipecontrol (urb->pipe))
 			break;
-		/* fallthrough */
+		fallthrough;
 	default:
 		ohci_dbg (ohci,
 			"urb %p path %s ep%d%s %08x cc %d --> status %d\n",
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index fb6f5e9ae5c6..7f857bad9e95 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -97,13 +97,13 @@ static void tmio_stop_hc(struct platform_device *dev)
 	switch (ohci->num_ports) {
 		default:
 			dev_err(&dev->dev, "Unsupported amount of ports: %d\n", ohci->num_ports);
-			/* fall through */
+			fallthrough;
 		case 3:
 			pm |= CCR_PM_USBPW3;
-			/* fall through */
+			fallthrough;
 		case 2:
 			pm |= CCR_PM_USBPW2;
-			/* fall through */
+			fallthrough;
 		case 1:
 			pm |= CCR_PM_USBPW1;
 	}

