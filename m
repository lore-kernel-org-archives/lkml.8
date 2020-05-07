Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38814208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEGJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:42:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44439 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgEGJms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:42:48 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jWd3G-000232-7f
        for linux-kernel@vger.kernel.org; Thu, 07 May 2020 09:42:46 +0000
Received: by mail-pg1-f200.google.com with SMTP id g11so3723662pgd.20
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 02:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2c0eBBtIepmDWT5vtHR8eCLoQ0+DU8y3zdqCJbavP80=;
        b=eExVK199R6uAt8yorrj+LXQhHqHS+jt7vdbUIvHRJ48YBlQVHcFTN6QtSDUB9EbePW
         1rfG3Xnnoz2WCESYQ/lqXkut1NeUq1TBnt+Amkh6paX2dhuhuxCfxq96Ycj3Hbz2frpy
         GMGyU9Je6wIlNlO7RM515838zThUWb0UmJfkDIs9FtUHM19DV8cLVbYAHyhPpjAeYJ/y
         1Nqt0IcdDGVhRIdtCIste6WWkFnxeATUeSB+S5/wofhLsQrOdjog0NizWsLTmFO9LGn4
         GDhxHOuxUcPn59Ckk6jtKsc0vd4gYnLAY9S0KQLySSYVziAODDXc70PQzdWrmHEgrLnc
         f6ZA==
X-Gm-Message-State: AGi0PubxEbtShrFn2SaGOyFdo5tbplUkhW6wYb0kN3+5M+QiCcWL54Eb
        x2kwu2X8wf/Cs5Ej/SSSCnhlicQ00dKmlyl+RPihiasCEN1ZjvH2eWK0M4MugeqQ1ZS2VWA6rcd
        6t94n5hy/E+NC+jHcykhcdYKNDIDoXIzEpW6TYH8FZA==
X-Received: by 2002:a17:90a:3441:: with SMTP id o59mr3759898pjb.185.1588844564678;
        Thu, 07 May 2020 02:42:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypJeLg3AcGy7HrqF6YZ9GdowrY4PLIXUeYZxe5vuntsu3tjrUThWNi8FjX7u4WnCciQkOx+rRg==
X-Received: by 2002:a17:90a:3441:: with SMTP id o59mr3759880pjb.185.1588844564483;
        Thu, 07 May 2020 02:42:44 -0700 (PDT)
Received: from canonical.com (111-249-71-140.dynamic-ip.hinet.net. [111.249.71.140])
        by smtp.gmail.com with ESMTPSA id i190sm4423030pfe.114.2020.05.07.02.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 02:42:43 -0700 (PDT)
From:   koba.ko@canonical.com
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-laptop: don't register platform::micmute if the related tokens don't exist.
Date:   Thu,  7 May 2020 17:42:42 +0800
Message-Id: <20200507094242.7523-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koba Ko <koba.ko@canonical.com>

Error messge is issued,
"platform::micmute: Setting an LED's brightness failed (-19)",
Even the device isn't presented.

Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
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

