Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560D5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294A62072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DozKuOIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDFToA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:44:00 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43867 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDFTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:54 -0400
Received: by mail-lf1-f44.google.com with SMTP id k28so445317lfe.10;
        Mon, 06 Apr 2020 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/P0AXifXD7tANSoj1fREn68L0S32q1vEpifJGcG77J4=;
        b=DozKuOIsBSVoCV27ns5nKcv3HJ1eX9TTUBar0+Uo4RZkHm1kvhtqLbKWxVwXy9S6Hp
         s2bSLOBV+Sx7nycKrvZ+yQOk/p360bwA0c3QDa0/euoWkJRJTFQ0nbhGU7nIC55ErN6F
         Fti9H64CO4uGI17S22Addk9cY926P5Z881+lIKczvmEXeUW/YpNbCsdWHA6cJuzWhkVo
         NU2Wj2RiepasNt04beZOKe4o1z8LeH8uDkrkUODIl+Ut1ifgj7cHiSnhmi4J+ieA21pE
         UZWU1BAW00UNF0y2k7BJgfUjBcGm9vJGCtaeBEJu0A4BOesKswHC5KFC0oVppM/WGSwF
         nCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/P0AXifXD7tANSoj1fREn68L0S32q1vEpifJGcG77J4=;
        b=maymGgLqchZjNofQhycxSni/+UPP/loatWB4gKdSs/RFKhhtFStyrISBR0Skw+nWtC
         c5//+tfiGHyr9WB8Vpx+FfE2aEzA/4avYBccq1f/UCDMABC3BT9dtjan/rnaLCunEKHB
         mYrUW/46wAsChu2qUKudnrcEoysyssFp8vctKyptcrWwTP0P5l3PTCb3WaDwAzHaNZIr
         hQVPRpw2ue7Hn6v7GmLNexZY4ncDv2iHQkNWLMy+zC2j/W2R+7WT8ftMZLjRbXYF/Htf
         WltAVKjmsg4L+OL4VqUPFeXzde1QS6vA2OuVKkLpO6uf2DzNS3RxnNqLDljQ1Aq6V1UE
         CF5w==
X-Gm-Message-State: AGi0PubmQSKiZDKxsfDkxwH6iQa8jRZGNtPMlSNKyyq4507BEutUppOh
        gG4UR5ww7EGHT4xXSMn4hOQ=
X-Google-Smtp-Source: APiQypI39uvOM/RmHzylYzqHKMsRhsoS9awnN5HWbW99wBSl2rATBxEedIvfObijqG8Gwo09vbd6yQ==
X-Received: by 2002:a19:ac41:: with SMTP id r1mr14294925lfc.113.1586202231598;
        Mon, 06 Apr 2020 12:43:51 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id r206sm4996233lff.65.2020.04.06.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:43:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: tegra_defconfig: Enable options useful for Nexus 7 and Acer A500
Date:   Mon,  6 Apr 2020 22:41:10 +0300
Message-Id: <20200406194110.21283-7-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406194110.21283-1-digetx@gmail.com>
References: <20200406194110.21283-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable several drivers for hardware that is found on Nexus 7 and Acer A500
tablet devices. Please note that some drivers may require firmware files
extracted from original Android image.

Link: https://github.com/digetx/linux-firmware
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 0029259a6bf5..6b78a9ad4d57 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -63,11 +63,17 @@ CONFIG_BT_RFCOMM=y
 CONFIG_BT_BNEP=y
 CONFIG_BT_HIDP=y
 CONFIG_BT_HCIBTUSB=m
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_BCM=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
 CONFIG_RFKILL_INPUT=y
 CONFIG_RFKILL_GPIO=y
+CONFIG_NFC=y
+CONFIG_NFC_HCI=y
+CONFIG_NFC_SHDLC=y
+CONFIG_NFC_PN544_I2C=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
@@ -106,20 +112,24 @@ CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
+CONFIG_KEYBOARD_CAP11XX=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_ELAN=y
 CONFIG_TOUCHSCREEN_WM97XX=y
 # CONFIG_TOUCHSCREEN_WM9705 is not set
 # CONFIG_TOUCHSCREEN_WM9713 is not set
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_GPIO_VIBRA=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_TEGRA=y
+CONFIG_SERIAL_DEV_BUS=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
@@ -135,6 +145,7 @@ CONFIG_PINCTRL_PALMAS=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
+CONFIG_GPIO_MAX77620=y
 CONFIG_GPIO_PALMAS=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
@@ -142,13 +153,18 @@ CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_BATTERY_SBS=y
+CONFIG_BATTERY_BQ27XXX=y
+CONFIG_CHARGER_GPIO=y
+CONFIG_CHARGER_SMB347=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_WATCHDOG=y
+CONFIG_MAX77620_WATCHDOG=y
 CONFIG_TEGRA_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
+CONFIG_MFD_MAX77620=y
 CONFIG_MFD_MAX8907=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
@@ -159,6 +175,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_TPS51632=y
@@ -174,7 +191,10 @@ CONFIG_USB_GSPCA=y
 CONFIG_DRM=y
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_TEGRA=y
+CONFIG_DRM_TEGRA_STAGING=y
+CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_LVDS_ENCODER=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_BACKLIGHT_GENERIC is not set
@@ -238,6 +258,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
+CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
@@ -259,11 +280,18 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
+CONFIG_PM_DEVFREQ=y
+CONFIG_ARM_TEGRA_DEVFREQ=y
+CONFIG_ARM_TEGRA20_DEVFREQ=y
 CONFIG_MEMORY=y
 CONFIG_IIO=y
+CONFIG_KXCJK1013=y
 CONFIG_MPU3050_I2C=y
+CONFIG_INV_MPU6050_I2C=y
+CONFIG_AL3010=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
+CONFIG_AK8974=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
-- 
2.25.1

