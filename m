Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50478C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2408A2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996474;
	bh=2LyRKRdbA5SZ6xlA3llIC3ouPv99BFtpcpHQ2YBOzIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aYp2zvsnfE8oCPXN5nTCVlUlM8S6FpT1+tuLcg/nQwk9Q+lEBqC33GdpM2sHsZH7T
	 Yp69M+85+rvyHt6POks04lcwMaYZ5DNEjjCx4ABKH/gVIXQzkvSq1FZSOpizT+FGgn
	 OSAZLu/h4i80lVW6fg38yI3cIzApP8f/6Bq6V2z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgANKHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730747AbgANKHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC072467D;
        Tue, 14 Jan 2020 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996469;
        bh=2LyRKRdbA5SZ6xlA3llIC3ouPv99BFtpcpHQ2YBOzIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCUXynyIhAvpJCaN9nN0X0uakuVbXezqxshKlM+ixvm7HMRXfitlYpmuISuh3D7dp
         Kw3f08FIFBdpaqiM+b5yxgiwtgpfVXrYnsWKULQUO80vt6VtYW2R0gUrhyCbCspJiB
         TYVgkJA7iYjwOAxs5sU8+yKksUJT/GVGLLtKlXLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 26/46] USB: serial: option: add ZLP support for 0x1bc7/0x9010
Date:   Tue, 14 Jan 2020 11:01:43 +0100
Message-Id: <20200114094345.726789934@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

commit 2438c3a19dec5e98905fd3ffcc2f24716aceda6b upstream.

Telit FN980 flashing device 0x1bc7/0x9010 requires zero packet
to be sent if out data size is is equal to the endpoint max size.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
[ johan: switch operands in conditional ]
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c   |    8 ++++++++
 drivers/usb/serial/usb-wwan.h |    1 +
 drivers/usb/serial/usb_wwan.c |    4 ++++
 3 files changed, 13 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -567,6 +567,9 @@ static void option_instat_callback(struc
 /* Interface must have two endpoints */
 #define NUMEP2		BIT(16)
 
+/* Device needs ZLP */
+#define ZLP		BIT(17)
+
 
 static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
@@ -1198,6 +1201,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1901, 0xff),	/* Telit LN940 (MBIM) */
 	  .driver_info = NCTRL(0) },
+	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9010),				/* Telit SBL FN980 flashing device */
+	  .driver_info = NCTRL(0) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, ZTE_PRODUCT_MF622, 0xff, 0xff, 0xff) }, /* ZTE WCDMA products */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0002, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) },
@@ -2098,6 +2103,9 @@ static int option_attach(struct usb_seri
 	if (!(device_flags & NCTRL(iface_desc->bInterfaceNumber)))
 		data->use_send_setup = 1;
 
+	if (device_flags & ZLP)
+		data->use_zlp = 1;
+
 	spin_lock_init(&data->susp_lock);
 
 	usb_set_serial_data(serial, data);
--- a/drivers/usb/serial/usb-wwan.h
+++ b/drivers/usb/serial/usb-wwan.h
@@ -36,6 +36,7 @@ struct usb_wwan_intf_private {
 	spinlock_t susp_lock;
 	unsigned int suspended:1;
 	unsigned int use_send_setup:1;
+	unsigned int use_zlp:1;
 	int in_flight;
 	unsigned int open_ports;
 	void *private;
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -490,6 +490,7 @@ static struct urb *usb_wwan_setup_urb(st
 				      void (*callback) (struct urb *))
 {
 	struct usb_serial *serial = port->serial;
+	struct usb_wwan_intf_private *intfdata = usb_get_serial_data(serial);
 	struct urb *urb;
 
 	urb = usb_alloc_urb(0, GFP_KERNEL);	/* No ISO */
@@ -500,6 +501,9 @@ static struct urb *usb_wwan_setup_urb(st
 			  usb_sndbulkpipe(serial->dev, endpoint) | dir,
 			  buf, len, callback, ctx);
 
+	if (intfdata->use_zlp && dir == USB_DIR_OUT)
+		urb->transfer_flags |= URB_ZERO_PACKET;
+
 	return urb;
 }
 


