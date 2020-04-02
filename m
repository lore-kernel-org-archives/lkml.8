Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A927BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F2620719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbgDBTAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:00:04 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44597 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388843AbgDBTAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:00:04 -0400
Received: (qmail 4070 invoked by uid 500); 2 Apr 2020 15:00:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Apr 2020 15:00:03 -0400
Date:   Thu, 2 Apr 2020 15:00:03 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <ingrassia@epigenesys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
In-Reply-To: <0000000000000e8b8005a2520af1@google.com>
Message-ID: <Pine.LNX.4.44L0.2004021428320.852-100000@netrider.rowland.org>
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
> usb 3-1: BOGUS urb xfer, pipe 2 != type 2, ep addr 0x00, pipe 0x80001a00, xfertype 0

Not much help, I'm afraid.  The pipe value decodes to:

	Direction:	OUT
	Device address:	26 (which agrees with the console output)
	Endpoint:	0
	Pipe type:	Control (which is appropriate for ep 0
			and agrees with xfertype)

Unfortunately, the values printed here need not be the same as the 
values checked by usb_urb_ep_type_check(), if either the URB or the 
descriptor is modified concurrently by another thread.

Let's try a different approach.  Since this modifies the code before 
the test, it may not trigger the warning.  But it's worth a try.

Alan Stern

#syz test: https://github.com/google/kasan.git 0fa84af8

Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -199,15 +199,27 @@ static const int pipetypes[4] = {
  * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
  * a negative error code.
  */
+unsigned int alan_pipe, alan_epaddr, alan_epattr;
 int usb_urb_ep_type_check(const struct urb *urb)
 {
 	const struct usb_host_endpoint *ep;
+	unsigned int pipe, epattr;
 
-	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
-	if (!ep)
+	pipe = READ_ONCE(urb->pipe);
+	ep = usb_pipe_endpoint(urb->dev, pipe);
+	if (!ep) {
+		alan_pipe = pipe;
+		alan_epattr = 0;
+		alan_epaddr = 0xff;
 		return -EINVAL;
-	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	}
+	epattr = READ_ONCE(ep->desc.bmAttributes);
+	if (usb_pipetype(pipe) != pipetypes[epattr & USB_ENDPOINT_XFERTYPE_MASK]) {
+		alan_pipe = pipe;
+		alan_epattr = epattr;
+		alan_epaddr = ep->desc.bEndpointAddress;
 		return -EINVAL;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
@@ -475,8 +487,9 @@ int usb_submit_urb(struct urb *urb, gfp_
 
 	/* Check that the pipe's type matches the endpoint's type */
 	if (usb_urb_ep_type_check(urb))
-		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
-			usb_pipetype(urb->pipe), pipetypes[xfertype]);
+		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x, pipe 0x%x, ep attr 0x%02x, ep addr 0x%02x\n",
+			usb_pipetype(urb->pipe), pipetypes[xfertype],
+			alan_pipe, alan_epattr, alan_epaddr);
 
 	/* Check against a simple/standard policy */
 	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |


