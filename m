Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FD9C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0282064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEGM2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:28:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51139 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgEGM2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:28:53 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jWfcJ-0005IG-Nr
        for linux-kernel@vger.kernel.org; Thu, 07 May 2020 12:27:07 +0000
Received: by mail-pl1-f198.google.com with SMTP id q4so4993213pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=sy9MiBndjg4GbOCvHlaVis5nDlxNmExV2BMm+rKhLA4=;
        b=cfuwzhOQUobaEI9QWmVWBaLeqmCj54b5SXC4hq5YwC9wZBuKHFkwOsYPX6Rd4VTMhw
         VWSXVFigcHZCBf4bk3nSWTPXBq9PdVc5hHoPkWEvleCVajwX+HdNx8OLP7t/sLlEumCz
         fEMkqLXb9PUnJ3i49OZ8uA73f/inNe3vHmO1bdpSN9tFt15/eoLUeryJTvbSkGLE8OEx
         TGnWdV4SrLTCSPCIqDjKiVYkcQI/tXp809+xDpYnB6VyJKLFBcfDhCdAgK1FDzU1Mu96
         JUjyTVjgWYLWH43XTmR4FwsujRyjdx9ZmdXyNlO6qPBibMMU2K1p3vVXrQ36CWPEo0Ux
         MqiA==
X-Gm-Message-State: AGi0PuYYapXSpcCUJSyq0nqTBaMU2dfEsndKIKvwK+q68FGggBNCASVX
        0iYC6fVtFxxBNPiPVr+NNnLPWlNkUSG9nhfAPi3vI4RixzdCLd//mMQmmhwXfhbjnsuYUdXoBJn
        X9Za947pGb4Q7cmzGFGhKp5sCFueo3RONtE6X+3FE0A==
X-Received: by 2002:a63:d74a:: with SMTP id w10mr4579335pgi.417.1588854426372;
        Thu, 07 May 2020 05:27:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLNRMSgD+3px9iOEsOl7gSFyS/RGaRGLdJoZnsUU8G4aN/YOyXpqtVeUrfUXr4TsbeOz0GyIA==
X-Received: by 2002:a63:d74a:: with SMTP id w10mr4579303pgi.417.1588854425823;
        Thu, 07 May 2020 05:27:05 -0700 (PDT)
Received: from canonical.com (111-249-71-140.dynamic-ip.hinet.net. [111.249.71.140])
        by smtp.gmail.com with ESMTPSA id c28sm4772120pfp.200.2020.05.07.05.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 05:27:05 -0700 (PDT)
From:   koba.ko@canonical.com
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: dell-laptop: don't register platform::micmute if the related tokens don't exist.
Date:   Thu,  7 May 2020 20:27:03 +0800
Message-Id: <20200507122703.14617-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koba Ko <koba.ko@canonical.com>

During boot up, Error messge is issued,
"platform::micmute: Setting an LED's brightness failed (-19)",
but the device isn't presented.

Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
If one of two tokens doesn't exist,
don't call led_classdev_register() for platform::micmute.
After that, you wouldn't see the platform::micmute in /sys/class/leds/,
and the error message wouldn't see in dmesg.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/platform/x86/dell-laptop.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 74e988f839e8..e315185dbdd6 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2164,7 +2164,7 @@ static struct led_classdev micmute_led_cdev = {
 static int __init dell_init(void)
 {
 	struct calling_interface_token *token;
-	int max_intensity = 0;
+	int max_intensity = 0, is_micmute_exist = 0;
 	int ret;
 
 	if (!dmi_check_system(dell_device_table))
@@ -2204,10 +2204,14 @@ static int __init dell_init(void)
 
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
+		is_micmute_exist = 1;
+	}
 
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return 0;
@@ -2254,7 +2258,8 @@ static int __init dell_init(void)
 fail_get_brightness:
 	backlight_device_unregister(dell_backlight_device);
 fail_backlight:
-	led_classdev_unregister(&micmute_led_cdev);
+	if (is_micmute_exist)
+		led_classdev_unregister(&micmute_led_cdev);
 fail_led:
 	dell_cleanup_rfkill();
 fail_rfkill:
-- 
2.25.1

