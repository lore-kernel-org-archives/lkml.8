Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EE3C3F372
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C848124691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812827;
	bh=R9SqpIgeU1zDbhHTVMDsR1tJseZFGh73G+JBMuf0/8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HCXdCM4Hqu9eTUNtHFIJVB22Xi2S7Fdf12d37uMvbpAeop2H54ZczAk4VotIxQHMk
	 Jafy9SjX6LO6FkXXjNLrUKq0gX+Kj00JUgSti/HPO/yXUokAfJfJFu2IrGjTxGJLLn
	 We9pnMfw5B1Mm+8tzyQB3FjVD1ZXkEdCjhzZREiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389009AbgB0ONq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388998AbgB0ONm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:13:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E25B224690;
        Thu, 27 Feb 2020 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812822;
        bh=R9SqpIgeU1zDbhHTVMDsR1tJseZFGh73G+JBMuf0/8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sd4KdYN+VwGJiBKT3nA0lBeR0PMJjphvot9ZbKgR6y/QIzTSqxn/MeycejJRfKQQy
         a3UBY24Siz38K9pS/DBzTEz1Cmre4D2afQ6emH+hhlD+aB/D4lr45ZnFXCT2n2YNgO
         N3F6co9CiX7QjiCiOXFfOB0t5OVxSSsfObrWgtOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Jung <jung@codemercs.com>
Subject: [PATCH 5.5 022/150] USB: misc: iowarrior: add support for the 100 device
Date:   Thu, 27 Feb 2020 14:35:59 +0100
Message-Id: <20200227132236.028215031@linuxfoundation.org>
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

commit bab5417f5f0118ce914bc5b2f8381e959e891155 upstream.

Add a new device id for the 100 devie.  It has 4 interfaces like the 28
and 28L devices but a larger endpoint so more I/O pins.

Cc: Christoph Jung <jung@codemercs.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200214161148.GA3963518@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/iowarrior.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -36,6 +36,7 @@
 /* fuller speed iowarrior */
 #define USB_DEVICE_ID_CODEMERCS_IOW28	0x1504
 #define USB_DEVICE_ID_CODEMERCS_IOW28L	0x1505
+#define USB_DEVICE_ID_CODEMERCS_IOW100	0x1506
 
 /* OEMed devices */
 #define USB_DEVICE_ID_CODEMERCS_IOW24SAG	0x158a
@@ -144,6 +145,7 @@ static const struct usb_device_id iowarr
 	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW56AM)},
 	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28)},
 	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28L)},
+	{USB_DEVICE(USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW100)},
 	{}			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, iowarrior_ids);
@@ -386,6 +388,7 @@ static ssize_t iowarrior_write(struct fi
 	case USB_DEVICE_ID_CODEMERCS_IOW56AM:
 	case USB_DEVICE_ID_CODEMERCS_IOW28:
 	case USB_DEVICE_ID_CODEMERCS_IOW28L:
+	case USB_DEVICE_ID_CODEMERCS_IOW100:
 		/* The IOW56 uses asynchronous IO and more urbs */
 		if (atomic_read(&dev->write_busy) == MAX_WRITES_IN_FLIGHT) {
 			/* Wait until we are below the limit for submitted urbs */
@@ -786,7 +789,8 @@ static int iowarrior_probe(struct usb_in
 	if ((dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56) ||
 	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56AM) ||
 	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28) ||
-	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28L)) {
+	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28L) ||
+	    (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW100)) {
 		res = usb_find_last_int_out_endpoint(iface_desc,
 				&dev->int_out_endpoint);
 		if (res) {
@@ -802,7 +806,8 @@ static int iowarrior_probe(struct usb_in
 	    ((dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56) ||
 	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56AM) ||
 	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28) ||
-	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28L)))
+	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28L) ||
+	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW100)))
 		/* IOWarrior56 has wMaxPacketSize different from report size */
 		dev->report_size = 7;
 


