Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A5C207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0v9IQWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGVQLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgGVQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:11:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429AC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:11:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so1748903pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HmPcqdLvVGHN8YIZDSoWp5mmL8DNRYwFD2mWJlFG/CI=;
        b=m0v9IQWnDgV4s6SMh/3HK0Ls3dL54sIPnN+m5UT2/hUC3PlDl2/W4kuw8mLT/+t/cN
         HxiCHcfv8HDrIysntb62I552PqeuEOyH/S3SO3QBkcx+RYaeSULjwkP8arqM1QWO4wg1
         E6yzW6xGFhKPhLOTimdH487g2u68ZJqeiWPUxM01HC06RbE1hniX0ZTXTdPWg2yufgjd
         nLTIf5z1CQ9sfy3TvT/oebTz//xFOR4fVrxrSBEhCivva3v/3XBk4x9TSl5DGIdulDLH
         BE6h9ocHdNRBxV2BbVliv5GN8cFfm7d+CBU5ngLDUJQnsAzFN2IEdQkyveZQvervZIHb
         WyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HmPcqdLvVGHN8YIZDSoWp5mmL8DNRYwFD2mWJlFG/CI=;
        b=dfp/TUkpVg08vGDPv7LGH3PWvP03v4O17fHMSc//xw3UxdUCR3bvgrZuezXpMmbtlk
         GXBO7qXbeS0ZXAB6Fv9Wj5XyFD2Vn23CLe+DvxS9oT6EI4j4Cikqr9vdEazK1KFxgqK6
         T+V3HHsnumPRx601b5/hxlCD2/BKDmPWErIERwuoL4cMWSMcauNUfKy4hf3voN53PIyh
         VcV74mf975SBorSbbg9e8ouFeWe/59xAAaqzLK9DJf+hs6mbdMFAyokJNtohPbWpPGCI
         1YK0HSLBUMFDzb+tTO9wKIX1zn7SRcUZSyUAtTWOXaZbNiqmlc9CcSA+aNJT401cnk+G
         aSpg==
X-Gm-Message-State: AOAM533bQvx4UQQlSEWrksbpoBTED3ExTQ16bc52w9fykZv6If1fB6cm
        DZ0gBcL8Pe4XsRjdvxTfXA0pZNSQa44=
X-Google-Smtp-Source: ABdhPJzbx4BjNV5Obyp/YLufMMjsWtKMTtCF6Df/GgQvhyi0ZF27dT0hVdtJ2eX5wQF9bVXuMITvpw==
X-Received: by 2002:a17:902:b084:: with SMTP id p4mr213677plr.58.1595434261973;
        Wed, 22 Jul 2020 09:11:01 -0700 (PDT)
Received: from thinkpad.teksavvy.com ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id 21sm37393pfu.124.2020.07.22.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 09:11:01 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] staging: wlan-ng: properly check endpoint types
Date:   Wed, 22 Jul 2020 09:10:52 -0700
Message-Id: <20200722161052.999754-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As syzkaller detected, wlan-ng driver does not do sanity check of
endpoints in prism2sta_probe_usb(), add check for xfer direction and type

Reported-and-tested-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 drivers/staging/wlan-ng/prism2usb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 4689b2170e4f..456603fd26c0 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -61,11 +61,25 @@ static int prism2sta_probe_usb(struct usb_interface *interface,
 			       const struct usb_device_id *id)
 {
 	struct usb_device *dev;
-
+	const struct usb_endpoint_descriptor *epd;
+	const struct usb_host_interface *iface_desc = interface->cur_altsetting;
 	struct wlandevice *wlandev = NULL;
 	struct hfa384x *hw = NULL;
 	int result = 0;
 
+	if (iface_desc->desc.bNumEndpoints != 2) {
+		result = -ENODEV;
+		goto failed;
+	}
+
+	result = -EINVAL;
+	epd = &iface_desc->endpoint[1].desc;
+	if (!usb_endpoint_is_bulk_in(epd))
+		goto failed;
+	epd = &iface_desc->endpoint[2].desc;
+	if (!usb_endpoint_is_bulk_out(epd))
+		goto failed;
+
 	dev = interface_to_usbdev(interface);
 	wlandev = create_wlan();
 	if (!wlandev) {
-- 
2.27.0

