Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C2622D06
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073206;
	bh=6Z0wpNCnyCWnQvnEZI5gwp9SLhd+PbsBcvUv0+XNS44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPNXmuZXH6LlMdC8n32Ifl2hx7ob/vU9z5fG1pgcNkYQYpLk+a6L88Wi3Uo4AADJT
	 ZXHbCt5Qayg7vuHNOTtXn8Bdmm0zfNS1mxsHXZ4htyiMZFxwuAhOSJkWTmbQzwVjmv
	 c/Qfcj1Y/ZDn/4IPjMYzEke7uYdf+j8X2E/eDTzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHJP0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgHJP0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:26:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF3B22B47;
        Mon, 10 Aug 2020 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073201;
        bh=6Z0wpNCnyCWnQvnEZI5gwp9SLhd+PbsBcvUv0+XNS44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8sovuYML8HTjQjPgFNs+sFIV0XtY735p6YOyl9CV/z1MH+mbrXwGf7g4yk46psbe
         ChrikEyZCWU65U/R+/TwA5N0ukT4sQgH1dOGRj15tLrjuWXi3rM0RViPiWK6AQ4+0s
         WPuzydrohuS/uwBTqrLxrq3aPClYxX6M8wu4tgng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable <stable@kernel.org>,
        Christoph Jung <jung@codemercs.com>
Subject: [PATCH 5.4 03/67] USB: iowarrior: fix up report size handling for some devices
Date:   Mon, 10 Aug 2020 17:20:50 +0200
Message-Id: <20200810151809.611667366@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 17a82716587e9d7c3b246a789add490b2b5dcab6 upstream.

In previous patches that added support for new iowarrior devices, the
handling of the report size was not done correct.

Fix that up and update the copyright date for the driver

Reworked from an original patch written by Christoph Jung.

Fixes: bab5417f5f01 ("USB: misc: iowarrior: add support for the 100 device")
Fixes: 5f6f8da2d7b5 ("USB: misc: iowarrior: add support for the 28 and 28L devices")
Fixes: 461d8deb26a7 ("USB: misc: iowarrior: add support for 2 OEMed devices")
Cc: stable <stable@kernel.org>
Reported-by: Christoph Jung <jung@codemercs.com>
Link: https://lore.kernel.org/r/20200726094939.1268978-1-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/iowarrior.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -2,8 +2,9 @@
 /*
  *  Native support for the I/O-Warrior USB devices
  *
- *  Copyright (c) 2003-2005  Code Mercenaries GmbH
- *  written by Christian Lucht <lucht@codemercs.com>
+ *  Copyright (c) 2003-2005, 2020  Code Mercenaries GmbH
+ *  written by Christian Lucht <lucht@codemercs.com> and
+ *  Christoph Jung <jung@codemercs.com>
  *
  *  based on
 
@@ -802,14 +803,28 @@ static int iowarrior_probe(struct usb_in
 
 	/* we have to check the report_size often, so remember it in the endianness suitable for our machine */
 	dev->report_size = usb_endpoint_maxp(dev->int_in_endpoint);
-	if ((dev->interface->cur_altsetting->desc.bInterfaceNumber == 0) &&
-	    ((dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56) ||
-	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW56AM) ||
-	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28) ||
-	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW28L) ||
-	     (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW100)))
-		/* IOWarrior56 has wMaxPacketSize different from report size */
-		dev->report_size = 7;
+
+	/*
+	 * Some devices need the report size to be different than the
+	 * endpoint size.
+	 */
+	if (dev->interface->cur_altsetting->desc.bInterfaceNumber == 0) {
+		switch (dev->product_id) {
+		case USB_DEVICE_ID_CODEMERCS_IOW56:
+		case USB_DEVICE_ID_CODEMERCS_IOW56AM:
+			dev->report_size = 7;
+			break;
+
+		case USB_DEVICE_ID_CODEMERCS_IOW28:
+		case USB_DEVICE_ID_CODEMERCS_IOW28L:
+			dev->report_size = 4;
+			break;
+
+		case USB_DEVICE_ID_CODEMERCS_IOW100:
+			dev->report_size = 13;
+			break;
+		}
+	}
 
 	/* create the urb and buffer for reading */
 	dev->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);


