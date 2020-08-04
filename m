Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDEBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACF621744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+dv9nc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgHDO4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgHDO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:56:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBC7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:56:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so4875314pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zlkQXHTnbRlJd/3ZzLVxh5Iw6jOTtxiQTFs7UMIY4o=;
        b=I+dv9nc4PtO8E1z1HGrGyeZqlKQ/KFSiH5myPv/OeubgWRxa/VU3Dl9gjYSz2SIsjX
         YDxTn7bbhKcQs9jw5p1i2fpDt0gVW1E2zQelqWpMfQ9FsOaXX3tSweevlSHJQrcMzyLU
         uEdqK4IRJ8kQwHtkm+pLXtVYjDcPH/NlVl36yh980e+E66BrpDCpjyNrl8QvAnDQbjAq
         LY6nBqOx2kpI8P9y7T4PoLK4CB4V/0ox8i1CJgCrQ+c2k+FgmbBh8R+MXPkFn+dOSdQt
         h0nOeP/06w/IXWu5h8Kx4V04IZ7pHByIoI338w6AHyzQIJsvziLHGsewoDScYRvUDHN+
         GbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zlkQXHTnbRlJd/3ZzLVxh5Iw6jOTtxiQTFs7UMIY4o=;
        b=onGVeJ+xYG6PBeLZq1Y5r2HncpyuAP0+O2rZW2iolN0L7nrJppSE5UrBjFZeYETB1/
         KIreSBz3yYASwDB7OlyvMC5wOb5OuaE1pbTm8GSxYoZgXSEfPSNrt90hVrYy0ZQDEbfF
         9lAW86Ia0dH74sWGMvxZ9A8fUxLNowXbOc2hh8PzRBNvYNYpbt/GXeQBaH3SN3ZfAMUy
         y6agEC5Xc0O4qUaCtTNelnmwFEKj5Ckgo93JJsb8C9NJBGGjYD9ClnFsCQmP9MUoCsn0
         E2gN47cXz6HxuYgCOeZAhNIR9FVbZFGVWkAd8k6WBImAHjndXvtAl+duJQ4WEp/+11dj
         2j9w==
X-Gm-Message-State: AOAM531eUopwze5VZ6xsbmxPwRYyuPZtpMOQ31BpqQcckFK1K4BaCwA3
        0k7iPwzp1VAkSaZMmxyNM5BEbdqcl20=
X-Google-Smtp-Source: ABdhPJx8ZsVNiNGW+px8G91BilooiJIDKuK7z464JjO6ei/v3BMnlnwVWClLH9Lc7sqHENLZzxPb9A==
X-Received: by 2002:aa7:9ace:: with SMTP id x14mr10446574pfp.216.1596553002225;
        Tue, 04 Aug 2020 07:56:42 -0700 (PDT)
Received: from thinkpad.teksavvy.com (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id j198sm21321310pfd.205.2020.08.04.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:56:41 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] staging: wlan-ng: fix out of bounds read in prism2sta_probe_usb()
Date:   Tue,  4 Aug 2020 07:56:14 -0700
Message-Id: <20200804145614.104320-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

let's use usb_find_common_endpoints() to discover endpoints, it does all
necessary checks for type and xfer direction

remove memset() in hfa384x_create(), because we now assign endpoints in
prism2sta_probe_usb() and because create_wlan() uses kzalloc() to
allocate hfa384x struct before calling hfa384x_create()

Fixes: faaff9765664 ("staging: wlan-ng: properly check endpoint types")
Reported-and-tested-by: syzbot+22794221ab96b0bab53a@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=22794221ab96b0bab53a
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x_usb.c |  5 -----
 drivers/staging/wlan-ng/prism2usb.c   | 19 ++++++-------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index fa1bf8b069fd..2720f7319a3d 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -524,13 +524,8 @@ static void hfa384x_usb_defer(struct work_struct *data)
  */
 void hfa384x_create(struct hfa384x *hw, struct usb_device *usb)
 {
-	memset(hw, 0, sizeof(*hw));
 	hw->usb = usb;
 
-	/* set up the endpoints */
-	hw->endp_in = usb_rcvbulkpipe(usb, 1);
-	hw->endp_out = usb_sndbulkpipe(usb, 2);
-
 	/* Set up the waitq */
 	init_waitqueue_head(&hw->cmdq);
 
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 456603fd26c0..4b08dc1da4f9 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -61,23 +61,14 @@ static int prism2sta_probe_usb(struct usb_interface *interface,
 			       const struct usb_device_id *id)
 {
 	struct usb_device *dev;
-	const struct usb_endpoint_descriptor *epd;
-	const struct usb_host_interface *iface_desc = interface->cur_altsetting;
+	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
+	struct usb_host_interface *iface_desc = interface->cur_altsetting;
 	struct wlandevice *wlandev = NULL;
 	struct hfa384x *hw = NULL;
 	int result = 0;
 
-	if (iface_desc->desc.bNumEndpoints != 2) {
-		result = -ENODEV;
-		goto failed;
-	}
-
-	result = -EINVAL;
-	epd = &iface_desc->endpoint[1].desc;
-	if (!usb_endpoint_is_bulk_in(epd))
-		goto failed;
-	epd = &iface_desc->endpoint[2].desc;
-	if (!usb_endpoint_is_bulk_out(epd))
+	result = usb_find_common_endpoints(iface_desc, &bulk_in, &bulk_out, NULL, NULL);
+	if (result)
 		goto failed;
 
 	dev = interface_to_usbdev(interface);
@@ -96,6 +87,8 @@ static int prism2sta_probe_usb(struct usb_interface *interface,
 	}
 
 	/* Initialize the hw data */
+	hw->endp_in = usb_rcvbulkpipe(dev, bulk_in->bEndpointAddress);
+	hw->endp_out = usb_sndbulkpipe(dev, bulk_out->bEndpointAddress);
 	hfa384x_create(hw, dev);
 	hw->wlandev = wlandev;
 
-- 
2.27.0

