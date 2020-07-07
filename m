Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD08C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A54206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594151444;
	bh=8A78yW/bqxjUgM+7cxfs7+Q4U/fFl0T8gWDS8JaA17c=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=e5ASOV7iyI0UaAORqNPGW5SybcyFv7w4uG+8rmPShqAufduO/PILXhUlOHpT29zjx
	 EjZQCHTCifP3FpvRkglodW6r67T7ZVWUycN9Uxuo58v87IehiqZkGlDqh3owE06NHT
	 C7gv0zbWZI4aRYLrvhxNtg/dYCQmnt+s2Sk54nJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgGGTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgGGTum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:50:42 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2822067D;
        Tue,  7 Jul 2020 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594151441;
        bh=8A78yW/bqxjUgM+7cxfs7+Q4U/fFl0T8gWDS8JaA17c=;
        h=Date:From:To:Cc:Subject:From;
        b=k0C+6OuL4zBn3Ayd79Yg7KA4ZCRDQSi8p8LRaUvSx7fjVL5JgqmaWXMbfk9lRg4xI
         by67p24rurLSrlzb2yz2keNX0K5zQcGz9veBcEX8B7gteQCdjUzjidpK26jWnkPJ5o
         xrGLU2AsByMuP3YQMKcu+T0aZZHbvudKl7fO0qAo=
Date:   Tue, 7 Jul 2020 14:56:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        accessrunner-general@lists.sourceforge.net,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] usb: Use fallthrough pseudo-keyword
Message-ID: <20200707195607.GA4198@embeddedor>
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
 drivers/usb/atm/cxacru.c               |    4 ++--
 drivers/usb/cdns3/gadget.c             |    4 ++--
 drivers/usb/class/usbtmc.c             |    2 +-
 drivers/usb/core/config.c              |    2 +-
 drivers/usb/core/hcd.c                 |    8 ++++----
 drivers/usb/core/hub.c                 |    2 +-
 drivers/usb/core/urb.c                 |    4 ++--
 drivers/usb/host/fotg210-hcd.c         |    8 ++++----
 drivers/usb/host/isp1362-hcd.c         |    2 +-
 drivers/usb/host/max3421-hcd.c         |    6 +++---
 drivers/usb/host/oxu210hp-hcd.c        |    8 ++++----
 drivers/usb/image/mdc800.c             |    2 +-
 drivers/usb/isp1760/isp1760-hcd.c      |    4 ++--
 drivers/usb/misc/appledisplay.c        |    2 +-
 drivers/usb/misc/usbtest.c             |    8 ++++----
 drivers/usb/misc/yurex.c               |    2 +-
 drivers/usb/renesas_usbhs/mod_gadget.c |    2 +-
 drivers/usb/renesas_usbhs/pipe.c       |    2 +-
 18 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 5d41f85a7445..ea66f8f385ba 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -408,7 +408,7 @@ static ssize_t adsl_state_store(struct device *dev,
 		case CXPOLL_STOPPING:
 			/* abort stop request */
 			instance->poll_state = CXPOLL_POLLING;
-			/* fall through */
+			fallthrough;
 		case CXPOLL_POLLING:
 		case CXPOLL_SHUTDOWN:
 			/* don't start polling */
@@ -802,7 +802,7 @@ static int cxacru_atm_start(struct usbatm_data *usbatm_instance,
 	case CXPOLL_STOPPING:
 		/* abort stop request */
 		instance->poll_state = CXPOLL_POLLING;
-		/* fall through */
+		fallthrough;
 	case CXPOLL_POLLING:
 	case CXPOLL_SHUTDOWN:
 		/* don't start polling */
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 5e24c2e57c0d..d1e1353fe0b1 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2814,7 +2814,7 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
 		dev_err(priv_dev->dev,
 			"invalid maximum_speed parameter %d\n",
 			max_speed);
-		/* fall through */
+		fallthrough;
 	case USB_SPEED_UNKNOWN:
 		/* default to superspeed */
 		max_speed = USB_SPEED_SUPER;
@@ -3055,7 +3055,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 	default:
 		dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
 			max_speed);
-		/* fall through */
+		fallthrough;
 	case USB_SPEED_UNKNOWN:
 		/* default to superspeed */
 		max_speed = USB_SPEED_SUPER;
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index ffc9c6fdd7e1..e8f558d07bb2 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2282,7 +2282,7 @@ static void usbtmc_interrupt(struct urb *urb)
 	case -EOVERFLOW:
 		dev_err(dev, "overflow with length %d, actual length is %d\n",
 			data->iin_wMaxPacketSize, urb->actual_length);
-		/* fall through */
+		fallthrough;
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index b7918f695434..de00b5981406 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -427,7 +427,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 			i = maxp & (BIT(12) | BIT(11));
 			maxp &= ~i;
 		}
-		/* fallthrough */
+		fallthrough;
 	default:
 		maxpacket_maxes = high_speed_maxpacket_maxes;
 		break;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index de624c47e190..a33b849e8beb 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -564,7 +564,7 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
 	case DeviceRequest | USB_REQ_GET_CONFIGURATION:
 		tbuf[0] = 1;
 		len = 1;
-			/* FALLTHROUGH */
+		fallthrough;
 	case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
 		break;
 	case DeviceRequest | USB_REQ_GET_DESCRIPTOR:
@@ -633,7 +633,7 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
 	case DeviceRequest | USB_REQ_GET_INTERFACE:
 		tbuf[0] = 0;
 		len = 1;
-			/* FALLTHROUGH */
+		fallthrough;
 	case DeviceOutRequest | USB_REQ_SET_INTERFACE:
 		break;
 	case DeviceOutRequest | USB_REQ_SET_ADDRESS:
@@ -651,7 +651,7 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
 		tbuf[0] = 0;
 		tbuf[1] = 0;
 		len = 2;
-			/* FALLTHROUGH */
+		fallthrough;
 	case EndpointOutRequest | USB_REQ_CLEAR_FEATURE:
 	case EndpointOutRequest | USB_REQ_SET_FEATURE:
 		dev_dbg (hcd->self.controller, "no endpoint features yet\n");
@@ -2726,7 +2726,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	case HCD_USB32:
 		rhdev->rx_lanes = 2;
 		rhdev->tx_lanes = 2;
-		/* fall through */
+		fallthrough;
 	case HCD_USB31:
 		rhdev->speed = USB_SPEED_SUPER_PLUS;
 		break;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b1e14beaac5f..9bffaca9610b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4698,7 +4698,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 						r = 0;
 						break;
 					}
-					/* FALL THROUGH */
+					fallthrough;
 				default:
 					if (r == 0)
 						r = -EPROTO;
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index da923ec17612..7bc23469f4e4 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -486,7 +486,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 	case USB_ENDPOINT_XFER_INT:
 		if (is_out)
 			allowed |= URB_ZERO_PACKET;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:			/* all non-iso endpoints */
 		if (!is_out)
 			allowed |= URB_SHORT_NOT_OK;
@@ -519,7 +519,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 			if ((urb->interval < 6)
 				&& (xfertype == USB_ENDPOINT_XFER_INT))
 				return -EINVAL;
-			/* fall through */
+			fallthrough;
 		default:
 			if (urb->interval <= 0)
 				return -EINVAL;
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index f967adf2d8df..6f4960724b3a 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -2807,7 +2807,7 @@ static struct fotg210_qh *qh_make(struct fotg210_hcd *fotg210, struct urb *urb,
 	switch (urb->dev->speed) {
 	case USB_SPEED_LOW:
 		info1 |= QH_LOW_SPEED;
-		/* FALL THROUGH */
+		fallthrough;
 
 	case USB_SPEED_FULL:
 		/* EPS 0 means "full" */
@@ -4634,7 +4634,7 @@ static inline int scan_frame_queue(struct fotg210_hcd *fotg210, unsigned frame,
 		default:
 			fotg210_dbg(fotg210, "corrupt type %d frame %d shadow %p\n",
 					type, frame, q.ptr);
-			/* FALL THROUGH */
+			fallthrough;
 		case Q_TYPE_QH:
 		case Q_TYPE_FSTN:
 			/* End of the iTDs and siTDs */
@@ -5412,7 +5412,7 @@ static void fotg210_endpoint_disable(struct usb_hcd *hcd,
 		 */
 		if (tmp)
 			start_unlink_async(fotg210, qh);
-		/* FALL THROUGH */
+		fallthrough;
 	case QH_STATE_UNLINK:		/* wait for hw to finish? */
 	case QH_STATE_UNLINK_WAIT:
 idle_timeout:
@@ -5426,7 +5426,7 @@ static void fotg210_endpoint_disable(struct usb_hcd *hcd,
 			qh_destroy(fotg210, qh);
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		/* caller was supposed to have unlinked any requests;
 		 * that's not our job.  just leak this memory.
diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index 4a3a2852523f..2cecb36d241b 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -1748,7 +1748,7 @@ static int isp1362_bus_suspend(struct usb_hcd *hcd)
 		isp1362_hcd->hc_control &= ~OHCI_CTRL_HCFS;
 		isp1362_hcd->hc_control |= OHCI_USB_RESET;
 		isp1362_write_reg32(isp1362_hcd, HCCONTROL, isp1362_hcd->hc_control);
-		/* FALL THROUGH */
+		fallthrough;
 	case OHCI_USB_RESET:
 		status = -EBUSY;
 		pr_warn("%s: needs reinit!\n", __func__);
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 8819f502b6a6..05828c0ab7de 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -925,7 +925,7 @@ max3421_handle_error(struct usb_hcd *hcd, u8 hrsl)
 			spi_wr8(hcd, MAX3421_REG_HCTL,
 				BIT(sndtog + MAX3421_HCTL_SNDTOG0_BIT));
 		}
-		/* FALL THROUGH */
+		fallthrough;
 	case MAX3421_HRSL_BADBC:	/* bad byte count */
 	case MAX3421_HRSL_PIDERR:	/* received PID is corrupted */
 	case MAX3421_HRSL_PKTERR:	/* packet error (stuff, EOP) */
@@ -1715,7 +1715,7 @@ max3421_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
 			dev_dbg(hcd->self.controller, "power-off\n");
 			max3421_gpout_set_value(hcd, pdata->vbus_gpout,
 						!pdata->vbus_active_level);
-			/* FALLS THROUGH */
+			fallthrough;
 		default:
 			max3421_hcd->port_status &= ~(1 << value);
 		}
@@ -1768,7 +1768,7 @@ max3421_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
 			break;
 		case USB_PORT_FEAT_RESET:
 			max3421_reset_port(hcd);
-			/* FALLS THROUGH */
+			fallthrough;
 		default:
 			if ((max3421_hcd->port_status & USB_PORT_STAT_POWER)
 			    != 0)
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 120666a0d590..913d31a53e96 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -1858,7 +1858,7 @@ static struct ehci_qh *qh_make(struct oxu_hcd *oxu,
 	switch (urb->dev->speed) {
 	case USB_SPEED_LOW:
 		info1 |= (1 << 12);	/* EPS "low" */
-		/* FALL THROUGH */
+		fallthrough;
 
 	case USB_SPEED_FULL:
 		/* EPS 0 means "full" */
@@ -3378,7 +3378,7 @@ static int oxu_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		switch (qh->qh_state) {
 		case QH_STATE_LINKED:
 			intr_deschedule(oxu, qh);
-			/* FALL THROUGH */
+			fallthrough;
 		case QH_STATE_IDLE:
 			qh_completions(oxu, qh);
 			break;
@@ -3450,7 +3450,7 @@ static void oxu_endpoint_disable(struct usb_hcd *hcd,
 		if (!tmp)
 			goto nogood;
 		unlink_async(oxu, qh);
-		/* FALL THROUGH */
+		fallthrough;
 	case QH_STATE_UNLINK:		/* wait for hw to finish? */
 idle_timeout:
 		spin_unlock_irqrestore(&oxu->lock, flags);
@@ -3461,7 +3461,7 @@ static void oxu_endpoint_disable(struct usb_hcd *hcd,
 			qh_put(qh);
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 nogood:
 		/* caller was supposed to have unlinked any requests;
diff --git a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
index 2388674042a9..fc0e22cc6fda 100644
--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -880,7 +880,7 @@ static ssize_t mdc800_device_write (struct file *file, const char __user *buf, s
 						return -EIO;
 					}
 					mdc800->pic_len=-1;
-					/* fall through */
+					fallthrough;
 
 				case 0x09: /* Download Thumbnail */
 					mdc800->download_left=answersize+64;
diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 579a21bd70ad..dd74ab7a2f9c 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -788,11 +788,11 @@ static void collect_qtds(struct usb_hcd *hcd, struct isp1760_qh *qh,
 					mem_reads8(hcd->regs, qtd->payload_addr,
 							qtd->data_buffer,
 							qtd->actual_length);
-					/* Fall through */
+					fallthrough;
 				case OUT_PID:
 					qtd->urb->actual_length +=
 							qtd->actual_length;
-					/* Fall through */
+					fallthrough;
 				case SETUP_PID:
 					break;
 				}
diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index ba1eaabc7796..91cfd917f6df 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -89,7 +89,7 @@ static void appledisplay_complete(struct urb *urb)
 		dev_err(dev,
 			"OVERFLOW with data length %d, actual length is %d\n",
 			ACD_URB_BUFFER_LEN, pdata->urb->actual_length);
-		/* fall through */
+		fallthrough;
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 98ada1a3425c..0f5aa5ed416c 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -182,7 +182,7 @@ get_endpoints(struct usbtest_dev *dev, struct usb_interface *intf)
 			case USB_ENDPOINT_XFER_ISOC:
 				if (dev->info->iso)
 					endpoint_update(edi, &iso_in, &iso_out, e);
-				/* FALLTHROUGH */
+				fallthrough;
 			default:
 				continue;
 			}
@@ -364,7 +364,7 @@ static void simple_fill_buf(struct urb *urb)
 
 	switch (pattern) {
 	default:
-		/* FALLTHROUGH */
+		fallthrough;
 	case 0:
 		memset(buf, 0, len);
 		break;
@@ -681,7 +681,7 @@ static int get_altsetting(struct usbtest_dev *dev)
 		return dev->buf[0];
 	case 0:
 		retval = -ERANGE;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		return retval;
 	}
@@ -1951,7 +1951,7 @@ static void complicated_callback(struct urb *urb)
 			dev_err(&ctx->dev->intf->dev,
 					"resubmit err %d\n",
 					status);
-			/* FALLTHROUGH */
+			fallthrough;
 		case -ENODEV:			/* disconnected */
 		case -ESHUTDOWN:		/* endpoint disabled */
 			ctx->submit_error = 1;
diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index be0505b8b5d4..6e7d34e7fec4 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -472,7 +472,7 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 		break;
 	case CMD_SET:
 		data++;
-		/* FALL THROUGH */
+		fallthrough;
 	case '0' ... '9':
 		set = 1;
 		c = c2 = simple_strtoull(data, NULL, 0);
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 53489cafecc1..105132ae87ac 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -509,7 +509,7 @@ static int usbhsg_irq_ctrl_stage(struct usbhs_priv *priv,
 	case READ_STATUS_STAGE:
 	case WRITE_STATUS_STAGE:
 		usbhs_dcp_control_transfer_done(pipe);
-		/* fall through */
+		fallthrough;
 	default:
 		return ret;
 	}
diff --git a/drivers/usb/renesas_usbhs/pipe.c b/drivers/usb/renesas_usbhs/pipe.c
index 9e5afdde1adb..e7334b7fb3a6 100644
--- a/drivers/usb/renesas_usbhs/pipe.c
+++ b/drivers/usb/renesas_usbhs/pipe.c
@@ -308,7 +308,7 @@ static void __usbhsp_pid_try_nak_if_stall(struct usbhs_pipe *pipe)
 	switch (pid) {
 	case PID_STALL11:
 		usbhsp_pipectrl_set(pipe, PID_MASK, PID_STALL10);
-		/* fall-through */
+		fallthrough;
 	case PID_STALL10:
 		usbhsp_pipectrl_set(pipe, PID_MASK, PID_NAK);
 	}

