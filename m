Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E23C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAA42166E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580744507;
	bh=4HTMrvy7MQ3ijT7jb6Y2VWejRaTrdTakHNy8Wy9VYWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6pwKRnA6tij59EBu+IS8gv62mULCc3dduJ0raCN9JWE8A6ESgtaKQs198XwcGb8A
	 t5h4DqObLW3ARCHm7TZH59pFcBUqRB+B66CF5KebMKBs4cdbWux65vUlCY1M2qmx2s
	 dpNCuX3kTdMLEG0RLjK1KtlmmLVnlggMrUJBhMCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgBCPlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:41:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46321 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgBCPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:41:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so15083662ljd.13;
        Mon, 03 Feb 2020 07:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEPnTpJ1A58+RhxHoD7vJrWSnZtvCUZLE3PCLpJiyt8=;
        b=EHrWohtxgyhT2FTpFEZo+V6vbr1RISI5+QKFVGCUmfW1xn5AJPJhZU86uBHrU9ltJe
         zr0g5b2C3V54Gt00oNMwxHPquYU7v+CBvc/yKt2MhqvP8pubceXvwuaBBVgNlg3IH4Ri
         +XNJebYyOpLXt4KCWKo3svnUB/gOwhG2Uus/AdJDMGKNfSCqCVVEWeCdt1R45/fHCWXu
         yRHysqxXEAvT5siwcpAgdMOBDdtNKsdyRSRstJNPwKQCuNcXgn012KdS+Lc7UJ/tkelb
         KrjbPjSGMb83d5qEpOCsQBTIi/QlCpwEc+wBxMlMmQD6Wkx8HhIKcYlJ/0x4OgfXDI/4
         NbTQ==
X-Gm-Message-State: APjAAAUmx5+VDm3hLNIWJVLcf/KouvWgqWCl4OeWnHp4eLKUbPxesGwB
        YI8XfXh29ZoS/9MyAxEJaS0=
X-Google-Smtp-Source: APXvYqyEciuyfMkxCvyoadEDctvTyOVKQG9hGQSXBntS3wekh4Qlmu58TCz84YpAkaJcciuIxzwMsw==
X-Received: by 2002:a2e:818e:: with SMTP id e14mr14219544ljg.2.1580744501178;
        Mon, 03 Feb 2020 07:41:41 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id f26sm9844917ljn.104.2020.02.03.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:41:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iydrA-0006tK-Dt; Mon, 03 Feb 2020 16:41:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, edes <edes@gmx.net>,
        Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] USB: core: clean up endpoint-descriptor parsing
Date:   Mon,  3 Feb 2020 16:38:30 +0100
Message-Id: <20200203153830.26394-4-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203153830.26394-1-johan@kernel.org>
References: <20200203153830.26394-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new usb-device pointer instead of back-casting when accessing
the struct usb_device when parsing endpoints.

Note that this introduces two lines that are longer than 80 chars on
purpose.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/core/config.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 7df22bcefa9d..b7918f695434 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -322,7 +322,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	j = 255;
 	if (usb_endpoint_xfer_int(d)) {
 		i = 1;
-		switch (to_usb_device(ddev)->speed) {
+		switch (udev->speed) {
 		case USB_SPEED_SUPER_PLUS:
 		case USB_SPEED_SUPER:
 		case USB_SPEED_HIGH:
@@ -343,8 +343,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 			/*
 			 * This quirk fixes bIntervals reported in ms.
 			 */
-			if (to_usb_device(ddev)->quirks &
-				USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL) {
+			if (udev->quirks & USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL) {
 				n = clamp(fls(d->bInterval) + 3, i, j);
 				i = j = n;
 			}
@@ -352,8 +351,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 			 * This quirk fixes bIntervals reported in
 			 * linear microframes.
 			 */
-			if (to_usb_device(ddev)->quirks &
-				USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL) {
+			if (udev->quirks & USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL) {
 				n = clamp(fls(d->bInterval), i, j);
 				i = j = n;
 			}
@@ -370,7 +368,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	} else if (usb_endpoint_xfer_isoc(d)) {
 		i = 1;
 		j = 16;
-		switch (to_usb_device(ddev)->speed) {
+		switch (udev->speed) {
 		case USB_SPEED_HIGH:
 			n = 7;		/* 8 ms = 2^(7-1) uframes */
 			break;
@@ -392,8 +390,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 * explicitly forbidden by the USB spec.  In an attempt to make
 	 * them usable, we will try treating them as Interrupt endpoints.
 	 */
-	if (to_usb_device(ddev)->speed == USB_SPEED_LOW &&
-			usb_endpoint_xfer_bulk(d)) {
+	if (udev->speed == USB_SPEED_LOW && usb_endpoint_xfer_bulk(d)) {
 		dev_warn(ddev, "config %d interface %d altsetting %d "
 		    "endpoint 0x%X is Bulk; changing to Interrupt\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
@@ -417,7 +414,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 
 	/* Find the highest legal maxpacket size for this endpoint */
 	i = 0;		/* additional transactions per microframe */
-	switch (to_usb_device(ddev)->speed) {
+	switch (udev->speed) {
 	case USB_SPEED_LOW:
 		maxpacket_maxes = low_speed_maxpacket_maxes;
 		break;
@@ -453,8 +450,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 * maxpacket sizes other than 512.  High speed HCDs may not
 	 * be able to handle that particular bug, so let's warn...
 	 */
-	if (to_usb_device(ddev)->speed == USB_SPEED_HIGH
-			&& usb_endpoint_xfer_bulk(d)) {
+	if (udev->speed == USB_SPEED_HIGH && usb_endpoint_xfer_bulk(d)) {
 		if (maxp != 512)
 			dev_warn(ddev, "config %d interface %d altsetting %d "
 				"bulk endpoint 0x%X has invalid maxpacket %d\n",
@@ -463,7 +459,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	}
 
 	/* Parse a possible SuperSpeed endpoint companion descriptor */
-	if (to_usb_device(ddev)->speed >= USB_SPEED_SUPER)
+	if (udev->speed >= USB_SPEED_SUPER)
 		usb_parse_ss_endpoint_companion(ddev, cfgno,
 				inum, asnum, endpoint, buffer, size);
 
-- 
2.24.1

