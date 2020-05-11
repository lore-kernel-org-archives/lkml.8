Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ABCC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAC820746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgEKBpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:45:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgEKBpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:45:02 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jXxV6-00073X-C2
        for linux-kernel@vger.kernel.org; Mon, 11 May 2020 01:45:00 +0000
Received: by mail-pj1-f69.google.com with SMTP id l3so16052269pjk.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 18:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=hEHAUhWa+zZj3u4Ik7sq9BKzxxux9cy1aGraeqlf/6Q=;
        b=OjxOkysyUlpENzMZ0b64odCQ4r02yFQ75GraG2dJycKtGrMz4sHir5T0sIB0r+ftqj
         WRJP2/pWYBeZfkvTxciwrjneryfIYu3POVfALM3vPWuD7YtQqhwtA9HJU/iK+Czvt9sY
         0EKwXf8nFXD01tsDI+dvHdVE3via9d3qoCLCaaBpH70T3HpeP8R4mIfz76AZSFP140Ic
         3pRdE2Gs6vnHpzj7Re+BXWCVt2WRZci36f1uzVUDyfvC1K8LBM46/4HFWWnSh+wei2ey
         ljgVh7FdgH6HeDEL25uagAmCFeityoLW5VNwB7Y4ZujOQyUWqcbsJE5tYRGyIAWC6XNZ
         DbdA==
X-Gm-Message-State: AGi0PuZHw8CZJxi41rqg5fXGUkGjYSY8AYVJ2gajFYZrEUUiHmoIizwT
        WqI4E4Np+ZpBIgO9K04MlZ5Synl8nv7IzpaDIV+tZfVfAgtylal/q2GfCO8UYT+YwFpLEFggpM4
        gCfQfsC2eCbNCrcRB9ERwb8/pcgURXanUHuW5v8Od1Q==
X-Received: by 2002:a62:1452:: with SMTP id 79mr13934744pfu.108.1589161498834;
        Sun, 10 May 2020 18:44:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLnRZWXUIcETS71SVZqgeMWnDICgaW1k3Zf4pzobw8um3R4E7c/N4NS1crSSlU64QzgIRe6vA==
X-Received: by 2002:a62:1452:: with SMTP id 79mr13934731pfu.108.1589161498586;
        Sun, 10 May 2020 18:44:58 -0700 (PDT)
Received: from canonical.com (111-249-68-192.dynamic-ip.hinet.net. [111.249.68.192])
        by smtp.gmail.com with ESMTPSA id 78sm3272197pgd.33.2020.05.10.18.44.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 May 2020 18:44:58 -0700 (PDT)
From:   koba.ko@canonical.com
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario.Limonciello@dell.com
Subject: [PATCH] V2: platform/x86: dell-laptop: don't register platform::micmute if the related tokens don't exist.
Date:   Mon, 11 May 2020 09:44:56 +0800
Message-Id: <20200511014456.5149-1-koba.ko@canonical.com>
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
Changelog:
1. Refine the typo of comment.
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

