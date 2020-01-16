Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4A7C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D8120684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Njjn073v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbgAPSXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404147AbgAPSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so20092016wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WVBFXvcdikb0EBWWJxfXewbVknSl3HJfok0bccJ1mn4=;
        b=Njjn073vtyfRWfMNpPGNi87b1AlndHTlUqb9WEz+a0nVmP9EmYLfdnzHPd8SR882/9
         f4h490mf9MDOOWFOjnjLFRyovB2m/se99jUSBTuF6dfQEDi0EAz1YUesw2VKrvm3hA3r
         1TryQ1o4STVDnzwEgV5zxMXqPzbtTkqFhOmLFEU9p0ZGV+g8MbBRtLOlzbY+K1nP9g0x
         mzCfYyO+V7t7xocl8WReElIcALjBVce4N5vmnOy6SbLYTuC2raTpwQQHpOcnWKFqS1J1
         zSyfi+OkDgHSl9lDezpfk4T9t20Iu4cao5a5DrAwvFT8yzxkZitKYZp4VACru9f75f9t
         OFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WVBFXvcdikb0EBWWJxfXewbVknSl3HJfok0bccJ1mn4=;
        b=hvz4ZzH8ub1GLD6OPM0HPepElFIAXcKJH2+IReeI18czTNzJiuu7x6h72k9JZq/kBE
         e8sn0BvfB/uHCnNNV7tiWJlVVqYmwTImuPtzsGpRrUIV7eoM/fWK5+ds6uhoU/ZNYLDR
         1XAyGkC3RcRGkIFjPL4+y/19Dt2dtTjrwgBdvpaqUpAqtYEyBtC3+sYmGDrIygO3o2ZP
         KjAZAeA7JYitpTVwRTNxapHghqGWu4vjabEYvpV2u3o4Y2gDXss5mjwUmsTRMkwv63SY
         s2zDhl6abNbGJck06vu8vNsww8HfY3p3v4KcfPin2kzqpi4C7BCh0fVxAu54MPnsnx9l
         uV5w==
X-Gm-Message-State: APjAAAWg/lAZZHUKj8WEq9lKyezia7Szu1LW+Tst2JLHz3MNal0E1Sa9
        uxF1xqYZ85TFwJ9YQ+nGop3nSQ==
X-Google-Smtp-Source: APXvYqyMTwkevn7sxHDKUSBLpxLkM1qNdB7oXIfmvE5EDXBsvQiY79VoCtwItpMAusX3iVNqFblewA==
X-Received: by 2002:adf:db41:: with SMTP id f1mr4768994wrj.392.1579198998646;
        Thu, 16 Jan 2020 10:23:18 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 02/17] clocksource: Fix Kconfig indentation
Date:   Thu, 16 Jan 2020 19:22:49 +0100
Message-Id: <20200116182304.4926-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191120134236.15959-1-krzk@kernel.org
---
 drivers/clocksource/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fdd76cb1768..c981ff64bc13 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -470,7 +470,7 @@ config OXNAS_RPS_TIMER
 	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
 
 config SYS_SUPPORTS_SH_CMT
-        bool
+	bool
 
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
@@ -490,13 +490,13 @@ config SPRD_TIMER
 	  Enables support for the Spreadtrum timer driver.
 
 config SYS_SUPPORTS_SH_MTU2
-        bool
+	bool
 
 config SYS_SUPPORTS_SH_TMU
-        bool
+	bool
 
 config SYS_SUPPORTS_EM_STI
-        bool
+	bool
 
 config CLKSRC_JCORE_PIT
 	bool "J-Core PIT timer driver" if COMPILE_TEST
@@ -591,21 +591,21 @@ config CLKSRC_PXA
 	  platforms.
 
 config H8300_TMR8
-        bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 8 bits timer for the H8300 platform.
 
 config H8300_TMR16
-        bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 16 bits timer for the H8300 platform with the
 	  H83069 cpu.
 
 config H8300_TPU
-        bool "Clocksource for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clocksource for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the clocksource for the H8300 platform with the
 	  H8S2678 cpu.
-- 
2.17.1

