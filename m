Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE80DC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4212073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgEGItj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:49:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43078 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgEGIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:49:38 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jWcDo-0003Oo-4r
        for linux-kernel@vger.kernel.org; Thu, 07 May 2020 08:49:36 +0000
Received: by mail-pj1-f70.google.com with SMTP id l40so5165333pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 01:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=nOtJNSzU/IvusKVXf0pPBVCTPzZSjjhY+JMbX/BgmI0=;
        b=GlssKzl4Q0ZkOAkWOAHk5h+dpVehN3YGmYC/u68Eq992xiuU3iXlUiypT6qTEZ09BS
         3yVhCmo2VcJgbPZVxAQ5/p6Fjoh6hc1+CDOHJyAJdvD2T13GQg45pI+URya7Wz8ysTZA
         ktfw3MYsZIttPrpHz+9FOkuLos4B+/6A5DkFXQnObWWNNSatITm+LFPImVaZfqwnxATt
         5hJJ839kRqSkVhmiRhIM/YFuQkrSZt6nm5nKIKBHPwQZJRLWxAkV1mOuSC7KM8JvMeMI
         ff3g4gqHbUBZZ5PPSAAbk6JLpAZnON156GUO5O7MAAHT4L0YgrPcOZ6YYByidUuoYryY
         x3Zw==
X-Gm-Message-State: AGi0PuZSouuc3ncu43uKDOmW8OIaUjZv2SCosAcjdbED4iY2vMXsybs7
        FHeRtcMlVFAHUB7cvVQS+A+IOzd9mFrhoN9l5m9kBFWWHKxuXKQPwNc7G+TXCBfUrWniWcKRd/d
        FLyDwmpv3HgSqI55HnVBi3qtIYsS6a2QSbDr/l+O09g==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr3533508pfs.104.1588841374686;
        Thu, 07 May 2020 01:49:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXUqWYSddTDisZFi+SRnAnomb/fR1qGtEPz+bGR8LzdXodN6VAFikD/NLG4b2CRGU95WgWTg==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr3533484pfs.104.1588841374345;
        Thu, 07 May 2020 01:49:34 -0700 (PDT)
Received: from canonical.com (111-249-71-140.dynamic-ip.hinet.net. [111.249.71.140])
        by smtp.gmail.com with ESMTPSA id w11sm3279063pgj.4.2020.05.07.01.49.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 01:49:33 -0700 (PDT)
From:   koba.ko@canonical.com
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-laptop: don't register platform::micmute if the related tokens don't exist.
Date:   Thu,  7 May 2020 16:49:32 +0800
Message-Id: <20200507084932.5486-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koba Ko <koba.ko@canonical.com>

First, get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
If one of two tokens doesn't exist, don't register platform::micmute.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/platform/x86/dell-laptop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 1e46022fb2c5..afc1ded83e56 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2208,10 +2208,13 @@ static int __init dell_init(void)
 
 	dell_laptop_register_notifier(&dell_laptop_notifier);
 
-	micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-	ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
-	if (ret < 0)
-		goto fail_led;
+	if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
+	    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
+		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+		ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
+		if (ret < 0)
+			goto fail_led;
+	}
 
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return 0;
-- 
2.17.1

