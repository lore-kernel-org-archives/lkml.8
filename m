Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2BC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363AD206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEMX7DFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgDHUlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:41:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45719 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgDHUlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:41:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id f8so6178053lfe.12;
        Wed, 08 Apr 2020 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiPLo7L7o5X3XMTpFhfcFXYBuEPLy7YCy7cOsYfZsCQ=;
        b=HEMX7DFkwIUIOCjFojR26SSvaWwE1IXCm4PvhD/mO+4f+XTiQho3ipYvy8qkJu/+X8
         UQ131ozajkQsNhqU2ZM/MnkFvGYRgKYfR/WQjLzdqO5yPl/i5qY9GfV4h3pee+JX4nTn
         4z1CKWr6fjM9/t2XPT3QzfpcpHyLYqGjoNOeJW8Sp+McENVjwujx2aDBxf5TTUdTl8oi
         x51v9UZsB6kbTzAt1USXdavPIVWfwSQemIXgpUFQxzSGj2WUuZIizqGCcTmtdowcxiqK
         ObZzTqfeIBWN7Oo3il+MJrlJK0t8N6xMtVxl+3POHVRQkyfUbGiS/fzpC33WF140W1gQ
         U5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiPLo7L7o5X3XMTpFhfcFXYBuEPLy7YCy7cOsYfZsCQ=;
        b=OMF8fVhNff+3TDv4BYiSuJF6UBxDuy4RVSAiJi451NRtxV4Los6Em9kRaqXTAaUw9j
         giIh1kEhT6qwdNGIB7RLsAjfzZ6WzVH25oXKkjnzcczCq+MUaFM32QEwOdk+7ME2VvC4
         eRiWmomFc9cpLRP72gVf7cqEeJREbFThpXQEAt0OdjBQy41Zru+EJeLpsZgr+Dqjfl/7
         I+Mhtb0hyQFEe5uftEFmAkvyonWyew/GVbVwstGw2vmJIe2U3ywCQoC1rsMz6c227i9Y
         OdLep1JqCaKMYOjuZTmhBdJruyVQ649uOT7gGwkEgYljDexg3r5z6oaMmYkjoHqzrvuF
         BOaA==
X-Gm-Message-State: AGi0PuabChsi0dT89CAiC4VPocWKPrjr1gOWZutRzk+UhLkP36BrKkKr
        bU9zj9uz59Op4RPotQAFgd0=
X-Google-Smtp-Source: APiQypIEcMpVq/6zkrDHZungyqrgS3b2nYnZfFHqfSGs3p0LQZkA9n+LGlpNjL0YDGP4XGsjZuGmZg==
X-Received: by 2002:a05:6512:79:: with SMTP id i25mr5707058lfo.87.1586378470683;
        Wed, 08 Apr 2020 13:41:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id p14sm13189727lfe.87.2020.04.08.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:41:10 -0700 (PDT)
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
Subject: [PATCH v3 6/6] ARM: tegra_defconfig: Enable options useful for Nexus 7 and Acer A500
Date:   Wed,  8 Apr 2020 23:39:45 +0300
Message-Id: <20200408203945.10329-7-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408203945.10329-1-digetx@gmail.com>
References: <20200408203945.10329-1-digetx@gmail.com>
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
Link: https://github.com/digetx/alsa-ucm-conf
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 0029259a6bf5..6644cbc7ab4f 100644
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
@@ -142,13 +153,21 @@ CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_BATTERY_SBS=y
+CONFIG_BATTERY_BQ27XXX=y
+CONFIG_CHARGER_GPIO=y
+CONFIG_CHARGER_SMB347=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
+CONFIG_THERMAL=y
+CONFIG_THERMAL_STATISTICS=y
+CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_MAX77620_WATCHDOG=y
 CONFIG_TEGRA_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
+CONFIG_MFD_MAX77620=y
 CONFIG_MFD_MAX8907=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
@@ -159,6 +178,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_TPS51632=y
@@ -174,7 +194,10 @@ CONFIG_USB_GSPCA=y
 CONFIG_DRM=y
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_TEGRA=y
+CONFIG_DRM_TEGRA_STAGING=y
+CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_LVDS_CODEC=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_BACKLIGHT_GENERIC is not set
@@ -238,6 +261,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
+CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
@@ -259,11 +283,18 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
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
@@ -283,6 +314,13 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_SQUASHFS=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
+CONFIG_PSTORE=y
+CONFIG_PSTORE_LZO_COMPRESS=y
+CONFIG_PSTORE_LZ4_COMPRESS=y
+CONFIG_PSTORE_LZ4HC_COMPRESS=y
+CONFIG_PSTORE_842_COMPRESS=y
+CONFIG_PSTORE_CONSOLE=y
+CONFIG_PSTORE_RAM=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-- 
2.25.1

