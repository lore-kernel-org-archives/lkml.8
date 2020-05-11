Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B7C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6528A20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgEKBQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:16:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49551 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgEKBQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:16:10 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jXx3A-0004k3-5j
        for linux-kernel@vger.kernel.org; Mon, 11 May 2020 01:16:08 +0000
Received: by mail-pl1-f200.google.com with SMTP id w11so6160080pll.15
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 18:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=npzJ2ssQsHpN36Phgsl48fh9Ati/w9bnMfzts9WzPbU=;
        b=Ee5KpJZeLZvjMfjgNwr9MjcCmZ2Rw/iVrAw3WvK4feRD5Mu0JFmPFPIkNdVXQIRyhR
         ucf4BvKsmPgDG0MdevyaZAog7i37SxuyvfQK6SC8ZxFzdWSpLASArPUw+ZEzZNSYu4Q0
         yKtzWZiaKMbr5nUrX/MgcPSSGzqfOxn1qUC332OWSY8FQ9I7H/nGjORJ2KD+AE8Sse0F
         8EnQBZ/Tyjxj7cbCv1t5yUjbXV8NTFLwFbbBBgO8jXpTknGHZgxurdib5Npt/q9uAPiI
         C+QWNVjyVszn35VKqqwEI6K2c5OZR4/MvBL6U4sPQAWwQLh1pllBZUgmvfwpu+Rrivr5
         y3+Q==
X-Gm-Message-State: AGi0PubLQ53DVJjJo/M4Y8M0Yhy2oiS7MAoaRC04Qr4K+PBuo/wdcKx5
        ZKXwdZ69+3x5RnBTW1HpUV6CBdCSCSeFixmtpTWJsg3HNeZvu5/bqa8IxpYPOzJNsOfE3SaSHdM
        jWeKvVLXOorTVpyxrQC3iybzQx5VZEDHx1Y/REGjOfQ==
X-Received: by 2002:a17:902:6114:: with SMTP id t20mr13273898plj.324.1589159766647;
        Sun, 10 May 2020 18:16:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypJGi34Y7+bcHYm0CJ9vm2SKrXWsH/PUviBBdaQ8jLAip9Hqej9PLKvFL95Z95aS1Ec7YYUrLg==
X-Received: by 2002:a17:902:6114:: with SMTP id t20mr13273867plj.324.1589159766166;
        Sun, 10 May 2020 18:16:06 -0700 (PDT)
Received: from canonical.com (111-249-68-192.dynamic-ip.hinet.net. [111.249.68.192])
        by smtp.gmail.com with ESMTPSA id y8sm7887771pfg.216.2020.05.10.18.16.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 May 2020 18:16:05 -0700 (PDT)
From:   koba.ko@canonical.com
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario.Limonciello@dell.com
Subject: [PATCH] platform/x86: dell-laptop: don't register platform::micmute if the related tokens don't exist.
Date:   Mon, 11 May 2020 09:16:03 +0800
Message-Id: <20200511011603.4278-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koba Ko <koba.ko@canonical.com>

On dell G3-3590, error message is issued during boot up,
"platform::micmute: Setting an LED's brightness failed (-19)",
but there's no micmute led on the machine.

Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
If one of two tokens doesn't exist,
don't call led_classdev_register() for platform::micmute.
After that, you wouldn't see the platform::micmute in /sys/class/leds/,
and the error message wouldn't see in dmesg.

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

