Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B332DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D2920663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kMuQxiqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgCPHYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:24:34 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51314 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgCPHYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:24:34 -0400
Received: by mail-pj1-f68.google.com with SMTP id hg10so3866443pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLUgCPvVOCvF8ic/BSG/ZxXsTtJMwTgOpQVJ7e+heWY=;
        b=kMuQxiqU57kWg/ztLMlBenWljwjmhZQDTdo8lF6ZnktWO9hAQoLEW0vmC+GR6Fr2XF
         SUNvaEk/hiVoLdT6jvusYNa1z8OKm2OOMAvzHfu+VPGtzzhBQkHfmB1cAKM78SPAo0iC
         KrPQCq+o6VcV5YiWZbz0/HW3XGpXKg6KhZU1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLUgCPvVOCvF8ic/BSG/ZxXsTtJMwTgOpQVJ7e+heWY=;
        b=htt/zREW1weJTjH+H+FT34laX1VrTYT8R5laClIrJLGZwIGmwyf2qQwljXQZeL7KwN
         A3RRi5coeE7pWJsN/kJlz9MhzhiZksn00x6rvnIUPb4GbsxG/ivGaEcUB6OwIj0vNxuu
         sawT7kyh3VLV/lRfl7V9q3LNd9l0Ig7U2sjuqVFAz3a5htQGbcqhyyv96we9Ccq7o2Z0
         sO6UrV5+dgAJGtQYQnw6FalZ4ifPdJYio0R6VUHlfpdgJ9t97Q2xD1DFd6fzWS8Ejv5V
         pmWCOujDEQ48JF+e42qpdjBQZaVtKVGmD8rjtohM6GxdvMjwxwz4mAhIbjTi+PqoQf+Z
         vv7w==
X-Gm-Message-State: ANhLgQ3UbiBJ7iSyyXzzgUovBxLTy2r5f4iTr7U6kVziGSgFrjvxRhGz
        yZ12FE+lBcBwvb1NXSw4IVJ6YpOpCdM=
X-Google-Smtp-Source: ADFU+vucMcjPp3LwOXrUtWLkuAbmJ2uc05Q9aXkxqUCrIKWthUBIo5SspQ+RNFdUy6ZVmfbPnj/q0w==
X-Received: by 2002:a17:902:8215:: with SMTP id x21mr26540359pln.59.1584343471978;
        Mon, 16 Mar 2020 00:24:31 -0700 (PDT)
Received: from chentsungp920.tpe.corp.google.com ([2401:fa00:1:10:6780:e5ae:c662:3d59])
        by smtp.gmail.com with ESMTPSA id kb18sm1204543pjb.14.2020.03.16.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 00:24:31 -0700 (PDT)
From:   Chen-Tsung Hsieh <chentsung@chromium.org>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org
Subject: [PATCH] HID: google: add moonball USB id
Date:   Mon, 16 Mar 2020 15:24:19 +0800
Message-Id: <20200316072419.65274-1-chentsung@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 1 additional hammer-like device.

Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 2aa4ed157aec..85a054f1ce38 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -532,6 +532,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MASTERBALL) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MOONBALL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3a400ce603c4..33fddab41722 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -478,6 +478,7 @@
 #define USB_DEVICE_ID_GOOGLE_WHISKERS	0x5030
 #define USB_DEVICE_ID_GOOGLE_MASTERBALL	0x503c
 #define USB_DEVICE_ID_GOOGLE_MAGNEMITE	0x503d
+#define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.25.1.481.gfbce0eb801-goog

