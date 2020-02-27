Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9089FC54FFD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6853E24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813376;
	bh=oy3JXFVtuovHSbwn/6OeH3Anas8ue2THvxVsmTNABYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRpbicXx9+kUKmr7qaOUI1+NhHbHpy+EK/5WT8NSWoDvKIMJjXvnVjEoJrPpOo2YF
	 yjnuxg/FJ3r3p58bCL21+9p+r7dKwxQOVw/snqeJRyEOIxgHlKRo3d/GN1t0p4puvG
	 bCr5wu9TJ4qNNGR7rgiluLcB6mKEUWdFuQRaELY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbgB0OP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389281AbgB0OPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:15:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9265E20578;
        Thu, 27 Feb 2020 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812922;
        bh=oy3JXFVtuovHSbwn/6OeH3Anas8ue2THvxVsmTNABYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Az0Fu9QlSvL0ovKfJKxeoI3jofOYVYsZbkK2V+AufNZXwyW1CKmdCZn0wORamU6yi
         uOfXg6Gc7D+rV7ks0G/eBMbKjaaAbHjDOf0469YONwH7cN4IFyrLPI/UcDi+3Xx+55
         mO8CuigcBNAPTzBZb+4+7mvsxxjvTgXLF04jFoXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Jung <jung@codemercs.com>
Subject: [PATCH 5.5 021/150] USB: misc: iowarrior: add support for the 28 and 28L devices
Date:   Thu, 27 Feb 2020 14:35:58 +0100
Message-Id: <20200227132235.857066268@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 5f6f8da2d7b5a431d3f391d0d73ace8edfb42af7 upstream.

Add new device ids for the 28 and 28L devices.  These have 4 interfaces
instead of 2, but the driver binds the same, so the driver changes are
minimal.

Cc: Christoph Jung <jung@codemercs.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200212040422.2991-2-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/iowarrior.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -33,6 +33,9 @@
 #define USB_DEVICE_ID_CODEMERCS_IOWPV2	0x1512
 /* full speed iowarrior */
 #define USB_DEVICE_ID_CODEMERCS_IOW56	0x1503
+/* fuller speed iowarrior */
+#define USB_DEVICE_ID_CODEMERCS_IOW28	0x1504
+#define USB_DEVICE_ID_CODEMERCS_IOW28L	0x1505
 
 /* OEMed devices */
 #define USB_DEVICE_ID_CODEMERCS_IOW24SAG	0x158a
@@ -139,6 +142,8 @@ static const struct usb_device_id iowarr
 	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW56)},
 	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW24SAG)},
 	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW56AM)},
+	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28)},
+	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28L)},
 	{}			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, iowarrior_ids);
@@ -379,6 +384,8 @@ static ssize_t iowarrior_write(struct fi
 		break;
 	case USB_DEVICE_ID_CODEMERCS_IOW56:
 	case USB_DEVICE_ID_CODEMERCS_IOW56AM:
+	case USB_DEVICE_ID_CODEMERCS_IOW28:
+	case USB_DEVICE_ID_CODEMERCS_IOW28L:
 		/* The IOW56 uses asynchronous IO and more urbs */
 		if (atomic_read(&dev->write_busy) == MAX_WRITES_IN_FLIGHT) {
 			/* Wait until we are below the limit for submitted urbs */
@@ -777,7 +784,9 @@ static int iowarrior_probe(struct usb_in
 	}
 
 	if ((dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56) ||
-	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56AM)) {
+	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56AM) ||
+	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28) ||
+	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28L)) {
 		res = usb_find_last_int_out_endpoint(iface_desc,
 				&dev->int_out_endpoint);
 		if (res) {
@@ -791,7 +800,9 @@ static int iowarrior_probe(struct usb_in
 	dev->report_size = usb_endpoint_maxp(dev->int_in_endpoint);
 	if ((dev->interface->cur_altsetting->desc.bInterfaceNumber == 0) &&
 	    ((dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56) ||
-	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56AM)))
+	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56AM) ||
+	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28) ||
+	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28L)))
 		/* IOWarrior56 has wMaxPacketSize different from report size */
 		dev->report_size = 7;
 


