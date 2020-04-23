Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D06CC55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6422075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDWBS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:18:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37697 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726324AbgDWBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 21:18:25 -0400
Received: (qmail 8173 invoked by uid 500); 22 Apr 2020 21:18:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2020 21:18:24 -0400
Date:   Wed, 22 Apr 2020 21:18:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
In-Reply-To: <0000000000001cfc5605a2556fb7@google.com>
Message-ID: <Pine.LNX.4.44L0.2004222111060.7643-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> WARNING in usbhid_raw_request/usb_submit_urb
> 
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 2 != type 2, pipe 0x80005600, ep attr 0x00, ep addr 0xff

This means that the ep_out[0] pointer was NULL.  Let's try to find out 
why.

Alan Stern

#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -4437,9 +4437,11 @@ int hub_port_debounce(struct usb_hub *hu
 
 void usb_ep0_reinit(struct usb_device *udev)
 {
+	udev->alan1 = 2;
 	usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
 	usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
 	usb_enable_endpoint(udev, &udev->ep0, true);
+	udev->alan1 = 3;
 }
 EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 
Index: usb-devel/drivers/usb/core/message.c
===================================================================
--- usb-devel.orig/drivers/usb/core/message.c
+++ usb-devel/drivers/usb/core/message.c
@@ -1198,6 +1198,10 @@ void usb_disable_interface(struct usb_de
 	int i;
 
 	for (i = 0; i < alt->desc.bNumEndpoints; ++i) {
+		if ((alt->endpoint[i].desc.bEndpointAddress & 0x0f) == 0)
+			dev_info(&dev->dev, "Ep 0 is %d in interface %d-%d\n",
+					i, alt->desc.bInterfaceNumber,
+					alt->desc.bAlternateSetting);
 		usb_disable_endpoint(dev,
 				alt->endpoint[i].desc.bEndpointAddress,
 				reset_hardware);
@@ -1275,6 +1279,8 @@ void usb_disable_device(struct usb_devic
 		mutex_unlock(hcd->bandwidth_mutex);
 		/* Second pass: remove endpoint pointers */
 	}
+	if (!skip_ep0)
+		dev->alan1 = 1;
 	for (i = skip_ep0; i < 16; ++i) {
 		usb_disable_endpoint(dev, i, true);
 		usb_disable_endpoint(dev, i + USB_DIR_IN, true);
Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -204,8 +204,12 @@ int usb_urb_ep_type_check(const struct u
 	const struct usb_host_endpoint *ep;
 
 	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
-	if (!ep)
+	if (!ep) {
+		dev_info(&urb->dev->dev, "Ep %d disabled: %d %d\n",
+			usb_pipeendpoint(urb->pipe),
+			urb->dev->alan1, urb->dev->alan2);
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
+	int		alan1, alan2;
 	int		devnum;
 	char		devpath[16];
 	u32		route;

