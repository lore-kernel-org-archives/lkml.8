Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B13C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312D4206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594141777;
	bh=Odjt+Ksu5iEmnU1+DzWsMVxiitqULRWzWch4x6q4jvk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tZ3ssXDU5N0r9hy3JDCxmt0i1ObjZCFzKYqa9Llfhl0vp/YyhtqdMCO2ZGRV3eFyi
	 +NTuyM09r+JigFDYZs6glPal1n6dz+x5KQ/yXbqFoSoVZb/eS/oleeHvijVJP5v7Ky
	 wsCpFAPBl6ecKJIxFKFADEESRPCC05TIjx1awSSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGGRJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgGGRJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:09:35 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B591206F6;
        Tue,  7 Jul 2020 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594141774;
        bh=Odjt+Ksu5iEmnU1+DzWsMVxiitqULRWzWch4x6q4jvk=;
        h=Date:From:To:Cc:Subject:From;
        b=SdWvWY8DeYxm0jmlGaXcG1+a/3cX91+QEHeLpdEB0M7liHYeV/7hVEY+2pqtTg0QR
         tU4P1/oeUa7sJDvaVzOPopa2QSO5ZjVKSIHMvAr/eq2Hbo2gSz6N7loaVM03uLwFeB
         v52QeOk1FAJX9xWPHD1uUkpqgJspqwWDVak1uSEE=
Date:   Tue, 7 Jul 2020 12:15:00 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] usb: gadget: Use fallthrough pseudo-keyword
Message-ID: <20200707171500.GA13620@embeddedor>
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
 drivers/usb/gadget/composite.c               |   16 ++++++++--------
 drivers/usb/gadget/function/f_fs.c           |    2 +-
 drivers/usb/gadget/function/f_hid.c          |    2 +-
 drivers/usb/gadget/function/f_mass_storage.c |    2 +-
 drivers/usb/gadget/function/f_phonet.c       |    4 ++--
 drivers/usb/gadget/function/f_printer.c      |    6 +++---
 drivers/usb/gadget/function/f_rndis.c        |    2 +-
 drivers/usb/gadget/function/f_tcm.c          |    2 +-
 drivers/usb/gadget/function/u_ether.c        |    4 ++--
 drivers/usb/gadget/function/u_serial.c       |    6 +++---
 drivers/usb/gadget/legacy/inode.c            |    7 +++----
 drivers/usb/gadget/udc/dummy_hcd.c           |   12 ++++++------
 drivers/usb/gadget/udc/goku_udc.c            |    9 ++++++---
 drivers/usb/gadget/udc/omap_udc.c            |    4 ++--
 drivers/usb/gadget/udc/s3c2410_udc.c         |    4 ++--
 drivers/usb/gadget/udc/tegra-xudc.c          |    2 +-
 16 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 5c1eb96a5c57..7ad648e53c05 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -72,17 +72,17 @@ function_descriptors(struct usb_function *f,
 		descriptors = f->ssp_descriptors;
 		if (descriptors)
 			break;
-		/* FALLTHROUGH */
+		fallthrough;
 	case USB_SPEED_SUPER:
 		descriptors = f->ss_descriptors;
 		if (descriptors)
 			break;
-		/* FALLTHROUGH */
+		fallthrough;
 	case USB_SPEED_HIGH:
 		descriptors = f->hs_descriptors;
 		if (descriptors)
 			break;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		descriptors = f->fs_descriptors;
 	}
@@ -170,20 +170,20 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 			want_comp_desc = 1;
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	case USB_SPEED_SUPER:
 		if (gadget_is_superspeed(g)) {
 			speed_desc = f->ss_descriptors;
 			want_comp_desc = 1;
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	case USB_SPEED_HIGH:
 		if (gadget_is_dualspeed(g)) {
 			speed_desc = f->hs_descriptors;
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		speed_desc = f->fs_descriptors;
 	}
@@ -237,7 +237,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 		case USB_ENDPOINT_XFER_ISOC:
 			/* mult: bits 1:0 of bmAttributes */
 			_ep->mult = (comp_desc->bmAttributes & 0x3) + 1;
-			/* fall through */
+			fallthrough;
 		case USB_ENDPOINT_XFER_BULK:
 		case USB_ENDPOINT_XFER_INT:
 			_ep->maxburst = comp_desc->bMaxBurst + 1;
@@ -1697,7 +1697,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (!gadget_is_dualspeed(gadget) ||
 			    gadget->speed >= USB_SPEED_SUPER)
 				break;
-			/* FALLTHROUGH */
+			fallthrough;
 		case USB_DT_CONFIG:
 			value = config_desc(cdev, w_value);
 			if (value >= 0)
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 490d353d5fde..5ff900e540c8 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2726,7 +2726,7 @@ static void __ffs_event_add(struct ffs_data *ffs,
 	switch (type) {
 	case FUNCTIONFS_RESUME:
 		rem_type2 = FUNCTIONFS_SUSPEND;
-		/* FALL THROUGH */
+		fallthrough;
 	case FUNCTIONFS_SUSPEND:
 	case FUNCTIONFS_SETUP:
 		rem_type1 = type;
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index df671acdd464..1125f4715830 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -477,7 +477,7 @@ static void hidg_set_report_complete(struct usb_ep *ep, struct usb_request *req)
 		break;
 	default:
 		ERROR(cdev, "Set report failed %d\n", req->status);
-		/* FALLTHROUGH */
+		fallthrough;
 	case -ECONNABORTED:		/* hardware forced ep reset */
 	case -ECONNRESET:		/* request dequeued */
 	case -ESHUTDOWN:		/* disconnect from host */
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 950d2a85f098..331c951d72dc 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2039,7 +2039,7 @@ static int do_scsi_command(struct fsg_common *common)
 	case RELEASE:
 	case RESERVE:
 	case SEND_DIAGNOSTIC:
-		/* Fall through */
+		fallthrough;
 
 	default:
 unknown_cmnd:
diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/function/f_phonet.c
index d7f6cc51b7ec..0b468f5d55bc 100644
--- a/drivers/usb/gadget/function/f_phonet.c
+++ b/drivers/usb/gadget/function/f_phonet.c
@@ -212,7 +212,7 @@ static void pn_tx_complete(struct usb_ep *ep, struct usb_request *req)
 	case -ESHUTDOWN: /* disconnected */
 	case -ECONNRESET: /* disabled */
 		dev->stats.tx_aborted_errors++;
-		/* fall through */
+		fallthrough;
 	default:
 		dev->stats.tx_errors++;
 	}
@@ -360,7 +360,7 @@ static void pn_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	/* Do resubmit in these cases: */
 	case -EOVERFLOW: /* request buffer overflow */
 		dev->stats.rx_over_errors++;
-		/* fall through */
+		fallthrough;
 	default:
 		dev->stats.rx_errors++;
 		break;
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 9c7ed2539ff7..ec15f7637e40 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -285,7 +285,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 
 	/* data overrun */
 	case -EOVERFLOW:
-		/* FALLTHROUGH */
+		fallthrough;
 
 	default:
 		DBG(dev, "rx status %d\n", status);
@@ -304,7 +304,7 @@ static void tx_complete(struct usb_ep *ep, struct usb_request *req)
 	switch (req->status) {
 	default:
 		VDBG(dev, "tx err %d\n", req->status);
-		/* FALLTHROUGH */
+		fallthrough;
 	case -ECONNRESET:		/* unlink */
 	case -ESHUTDOWN:		/* disconnect etc */
 		break;
@@ -919,7 +919,7 @@ static bool gprinter_req_match(struct usb_function *f,
 		if (!w_value && !w_length &&
 		   !(USB_DIR_IN & ctrl->bRequestType))
 			break;
-		/* fall through */
+		fallthrough;
 	default:
 		return false;
 	}
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index 0d8e4a364ca6..9534c8ab62a8 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -426,7 +426,7 @@ static void rndis_response_complete(struct usb_ep *ep, struct usb_request *req)
 		DBG(cdev, "RNDIS %s response error %d, %d/%d\n",
 			ep->name, status,
 			req->actual, req->length);
-		/* FALLTHROUGH */
+		fallthrough;
 	case 0:
 		if (ep != rndis->notify)
 			break;
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index eaf556ceac32..d94b814328c8 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1150,7 +1150,7 @@ static int usbg_submit_command(struct f_uas *fu,
 	default:
 		pr_debug_once("Unsupported prio_attr: %02x.\n",
 				cmd_iu->prio_attr);
-		/* fall through */
+		fallthrough;
 	case UAS_SIMPLE_TAG:
 		cmd->prio_attr = TCM_SIMPLE_TAG;
 		break;
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index fbe96ef1ac7a..0230458b4de2 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -321,7 +321,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 	/* data overrun */
 	case -EOVERFLOW:
 		dev->net->stats.rx_over_errors++;
-		/* FALLTHROUGH */
+		fallthrough;
 
 	default:
 		dev->net->stats.rx_errors++;
@@ -444,7 +444,7 @@ static void tx_complete(struct usb_ep *ep, struct usb_request *req)
 	default:
 		dev->net->stats.tx_errors++;
 		VDBG(dev, "tx err %d\n", req->status);
-		/* FALLTHROUGH */
+		fallthrough;
 	case -ECONNRESET:		/* unlink */
 	case -ESHUTDOWN:		/* disconnect etc */
 		dev_kfree_skb_any(skb);
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 3cfc6e2eba71..c1e5e72748d4 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -386,7 +386,7 @@ static void gs_rx_push(struct work_struct *work)
 			/* presumably a transient fault */
 			pr_warn("ttyGS%d: unexpected RX status %d\n",
 				port->port_num, req->status);
-			/* FALLTHROUGH */
+			fallthrough;
 		case 0:
 			/* normal completion */
 			break;
@@ -472,7 +472,7 @@ static void gs_write_complete(struct usb_ep *ep, struct usb_request *req)
 		/* presumably a transient fault */
 		pr_warn("%s: unexpected %s status %d\n",
 			__func__, ep->name, req->status);
-		/* FALL THROUGH */
+		fallthrough;
 	case 0:
 		/* normal completion */
 		gs_start_tx(port);
@@ -871,7 +871,7 @@ static void gs_console_complete_out(struct usb_ep *ep, struct usb_request *req)
 	default:
 		pr_warn("%s: unexpected %s status %d\n",
 			__func__, ep->name, req->status);
-		/* fall through */
+		fallthrough;
 	case 0:
 		/* normal completion */
 		spin_lock(&cons->lock);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 9ee0bfe7bcda..1b430b36d0a6 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -312,7 +312,7 @@ get_ready_ep (unsigned f_flags, struct ep_data *epdata, bool is_write)
 	case STATE_EP_READY:			/* not configured yet */
 		if (is_write)
 			return 0;
-		// FALLTHRU
+		fallthrough;
 	case STATE_EP_UNBOUND:			/* clean disconnect */
 		break;
 	// case STATE_EP_DISABLED:		/* "can't happen" */
@@ -1084,7 +1084,7 @@ next_event (struct dev_data *dev, enum usb_gadgetfs_event_type type)
 	case GADGETFS_DISCONNECT:
 		if (dev->state == STATE_DEV_SETUP)
 			dev->setup_abort = 1;
-		// FALL THROUGH
+		fallthrough;
 	case GADGETFS_CONNECT:
 		dev->ev_next = 0;
 		break;
@@ -1381,7 +1381,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			make_qualifier (dev);
 			break;
 		case USB_DT_OTHER_SPEED_CONFIG:
-			// FALLTHROUGH
 		case USB_DT_CONFIG:
 			value = config_buf (dev,
 					w_value >> 8,
@@ -1718,7 +1717,7 @@ gadgetfs_suspend (struct usb_gadget *gadget)
 	case STATE_DEV_UNCONNECTED:
 		next_event (dev, GADGETFS_SUSPEND);
 		ep0_readable (dev);
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		break;
 	}
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0eeaead5acea..f4ffd52010ce 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -567,12 +567,12 @@ static int dummy_enable(struct usb_ep *_ep,
 			if (max <= 1024)
 				break;
 			/* save a return statement */
-			/* fall through */
+			fallthrough;
 		case USB_SPEED_FULL:
 			if (max <= 64)
 				break;
 			/* save a return statement */
-			/* fall through */
+			fallthrough;
 		default:
 			if (max <= 8)
 				break;
@@ -590,7 +590,7 @@ static int dummy_enable(struct usb_ep *_ep,
 			if (max <= 1024)
 				break;
 			/* save a return statement */
-			/* fall through */
+			fallthrough;
 		case USB_SPEED_FULL:
 			if (max <= 1023)
 				break;
@@ -1943,7 +1943,7 @@ static void dummy_timer(struct timer_list *t)
 			 * this almost certainly polls too fast.
 			 */
 			limit = max(limit, periodic_bytes(dum, ep));
-			/* FALLTHROUGH */
+			fallthrough;
 
 		default:
 treat_control_like_bulk:
@@ -2252,7 +2252,7 @@ static int dummy_hub_control(
 					 "supported for USB 2.0 roothub\n");
 				goto error;
 			}
-			/* FALLS THROUGH */
+			fallthrough;
 		case USB_PORT_FEAT_RESET:
 			/* if it's already enabled, disable */
 			if (hcd->speed == HCD_USB3) {
@@ -2276,7 +2276,7 @@ static int dummy_hub_control(
 			 * interval? Is it still 50msec as for HS?
 			 */
 			dum_hcd->re_timeout = jiffies + msecs_to_jiffies(50);
-			/* FALLS THROUGH */
+			fallthrough;
 		default:
 			if (hcd->speed == HCD_USB3) {
 				if ((dum_hcd->port_status &
diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 91dcb1995c27..25c1d6ab5adb 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -125,11 +125,14 @@ goku_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 	max = get_unaligned_le16(&desc->wMaxPacketSize);
 	switch (max) {
 	case 64:
-		mode++; /* fall through */
+		mode++;
+		fallthrough;
 	case 32:
-		mode++; /* fall through */
+		mode++;
+		fallthrough;
 	case 16:
-		mode++; /* fall through */
+		mode++;
+		fallthrough;
 	case 8:
 		mode <<= 3;
 		break;
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 4139da885651..494da00398d7 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2831,7 +2831,7 @@ static int omap_udc_probe(struct platform_device *pdev)
 				type = "integrated";
 				break;
 			}
-			/* FALL THROUGH */
+			fallthrough;
 		case 3:
 		case 11:
 		case 16:
@@ -2848,7 +2848,7 @@ static int omap_udc_probe(struct platform_device *pdev)
 		case 14:			/* transceiverless */
 			if (cpu_is_omap1710())
 				goto bad_on_1710;
-			/* FALL THROUGH */
+			fallthrough;
 		case 13:
 		case 15:
 			type = "no";
diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index 80002d97b59d..bc2e8eb737c3 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -308,7 +308,7 @@ static int s3c2410_udc_write_fifo(struct s3c2410_ep *ep,
 	switch (idx) {
 	default:
 		idx = 0;
-		/* fall through */
+		fallthrough;
 	case 0:
 		fifo_reg = S3C2410_UDC_EP0_FIFO_REG;
 		break;
@@ -413,7 +413,7 @@ static int s3c2410_udc_read_fifo(struct s3c2410_ep *ep,
 	switch (idx) {
 	default:
 		idx = 0;
-		/* fall through */
+		fallthrough;
 	case 0:
 		fifo_reg = S3C2410_UDC_EP0_FIFO_REG;
 		break;
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index bbe1a04686da..404f77806c6a 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -2742,7 +2742,7 @@ static void tegra_xudc_handle_transfer_event(struct tegra_xudc *xudc,
 		ep_wait_for_stopped(xudc, ep_index);
 		ep->enq_ptr = ep->deq_ptr;
 		tegra_xudc_ep_nuke(ep, -EIO);
-		/* FALLTHROUGH */
+		fallthrough;
 	case TRB_CMPL_CODE_STREAM_NUMP_ERROR:
 	case TRB_CMPL_CODE_CTRL_DIR_ERR:
 	case TRB_CMPL_CODE_INVALID_STREAM_TYPE_ERR:

