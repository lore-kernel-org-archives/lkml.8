Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD7EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E936F20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgDXPU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:20:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59559 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727868AbgDXPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:20:22 -0400
Received: (qmail 6320 invoked by uid 500); 24 Apr 2020 11:20:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2020 11:20:21 -0400
Date:   Fri, 24 Apr 2020 11:20:21 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
In-Reply-To: <0000000000007c083305a4088d09@google.com>
Message-ID: <Pine.LNX.4.44L0.2004241114460.2596-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> WARNING in usb_queue_reset_device
> 
> ------------[ cut here ]------------
> usbhid 3-1:0.0: Device reset
...
>  hid_reset+0x219/0x3e0 drivers/hid/usbhid/hid-core.c:138
>  process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
>  worker_thread+0x96/0xe20 kernel/workqueue.c:2412

Okay, that's weird.  hid_reset is already running in a work queue 
thread; it has no need to queue a request for a device reset.  It can 
just reset the device directly.  Anyway, let's see where it gets called 
from.

Alan Stern

#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -4440,6 +4440,7 @@ void usb_ep0_reinit(struct usb_device *u
 	usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
 	usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
 	usb_enable_endpoint(udev, &udev->ep0, true);
+	udev->alan1 = 0;
 }
 EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 
@@ -4471,6 +4472,7 @@ static int hub_set_address(struct usb_de
 		update_devnum(udev, devnum);
 		/* Device now using proper address. */
 		usb_set_device_state(udev, USB_STATE_ADDRESS);
+		udev->alan1 = 1;
 		usb_ep0_reinit(udev);
 	}
 	return retval;
@@ -4838,6 +4840,7 @@ hub_port_init(struct usb_hub *hub, struc
 		else
 			dev_warn(&udev->dev, "Using ep0 maxpacket: %d\n", i);
 		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(i);
+		udev->alan1 = 2;
 		usb_ep0_reinit(udev);
 	}
 
@@ -5226,6 +5229,7 @@ static void hub_port_connect(struct usb_
 loop_disable:
 		hub_port_disable(hub, port1, 1);
 loop:
+		udev->alan1 = 3;
 		usb_ep0_reinit(udev);
 		release_devnum(udev);
 		hub_free_dev(udev);
@@ -5766,6 +5770,7 @@ static int usb_reset_and_verify_device(s
 
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
+		udev->alan1 = 4;
 		usb_ep0_reinit(udev);
 		ret = hub_port_init(parent_hub, udev, port1, i);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
@@ -6007,6 +6012,8 @@ EXPORT_SYMBOL_GPL(usb_reset_device);
  */
 void usb_queue_reset_device(struct usb_interface *iface)
 {
+	dev_WARN(&iface->dev, "Device reset\n");
+
 	if (schedule_work(&iface->reset_ws))
 		usb_get_intf(iface);
 }
Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -204,8 +204,12 @@ int usb_urb_ep_type_check(const struct u
 	const struct usb_host_endpoint *ep;
 
 	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
-	if (!ep)
+	if (!ep) {
+		dev_info(&urb->dev->dev, "Ep %d disabled: %d\n",
+			usb_pipeendpoint(urb->pipe),
+			urb->dev->alan1);
 		return -EINVAL;
+	}
 	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
 		return -EINVAL;
 	return 0;
Index: usb-devel/include/linux/usb.h
===================================================================
--- usb-devel.orig/include/linux/usb.h
+++ usb-devel/include/linux/usb.h
@@ -629,6 +629,7 @@ struct usb3_lpm_parameters {
  * usb_set_device_state().
  */
 struct usb_device {
+	int		alan1;
 	int		devnum;
 	char		devpath[16];
 	u32		route;
Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -135,7 +135,7 @@ static void hid_reset(struct work_struct
 
 	if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
 		dev_dbg(&usbhid->intf->dev, "resetting device\n");
-		usb_queue_reset_device(usbhid->intf);
+		usb_reset_device(interface_to_usbdev(usbhid->intf));
 	}
 }
 
@@ -168,7 +168,7 @@ static void hid_io_error(struct hid_devi
 		/* Retries failed, so do a port reset unless we lack bandwidth*/
 		if (!test_bit(HID_NO_BANDWIDTH, &usbhid->iofl)
 		     && !test_and_set_bit(HID_RESET_PENDING, &usbhid->iofl)) {
-
+			dump_stack();
 			schedule_work(&usbhid->reset_work);
 			goto done;
 		}
@@ -299,6 +299,7 @@ static void hid_irq_in(struct urb *urb)
 		usbhid_mark_busy(usbhid);
 		clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 		set_bit(HID_CLEAR_HALT, &usbhid->iofl);
+		dump_stack();
 		schedule_work(&usbhid->reset_work);
 		return;
 	case -ECONNRESET:	/* unlink */
@@ -1438,8 +1439,10 @@ static void hid_restart_io(struct hid_de
 	clear_bit(HID_SUSPENDED, &usbhid->iofl);
 	usbhid_mark_busy(usbhid);
 
-	if (clear_halt || reset_pending)
+	if (clear_halt || reset_pending) {
+		dump_stack();
 		schedule_work(&usbhid->reset_work);
+	}
 	usbhid->retry_delay = 0;
 	spin_unlock_irq(&usbhid->lock);
 

