Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC15207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwPUiDVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgEQRSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgEQRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:18:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3CC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:18:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so3683006pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uMSEWPFfgwS2F0KG3ny+C2pAjIupU8hYBG5jXbhcaL4=;
        b=jwPUiDVAgwv3eFPA7k87+mUDcLg2cXxubQstVF8w1bht2LvhefR1Jr2S/aP22KK4Xk
         ZY/Q9DlwdTOGINd966qh0PU1Kaeo30xObNAL1HzXvmyGGjlOkefOCaTSazYleyn/4/Kk
         tKWrUYASMu/NVTPi0ugBZ8q1nrErSxLL7yv8Q3wC+4gSiRJ0bWtM8s18OJ9C7r2MMk1C
         qIe9QbECzAXmwwnGM/qN8F8tzjphzyx16Dkv2ayzVI1xxh23s1FWpaDbBye4yVviNtLy
         hs2s9+vVcgWJ++H+74Sr7XnL38+zhwXtgLmlOAOrpAgYotQeBJXvIch3Rir1cngj1U5+
         fI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uMSEWPFfgwS2F0KG3ny+C2pAjIupU8hYBG5jXbhcaL4=;
        b=PbQrk3c1ZMs7/7K4g+ODWOXh+psiXKrWZlIqhB8O9xR9ida9FQWmQKh+hiOLE2zCJ/
         /HQHsQKFDNybDgQ18H88IJ+2F1TNbI8cIfKSXKce61LlmS3HnvmHXZMuvEpCjnoQ2Qdt
         D0TY1jct3V6lF4/WLX8peyOkZiDG/rVIjG+/gnsgz3byPjN7r4V3UjYr5BmlWd8tpm9N
         GdhWqJRRvOC+i4edLJqi4MTbfJX2H30b2TNaFK0njDSBgJ56JAuxqJZMYIj+DKNwNZTj
         joGiMSbB9PaXURjFhP/lJAm1m79NjQJwrGXKjkV3Y7h2QvlWFgSB/pePI1/r4MoMtfFO
         u0bw==
X-Gm-Message-State: AOAM533giyctH9tYmSl09ZZZG1ZC8b+W2fjx/PPUATS0d62peICFk7n8
        /xe8hphbFpUtcciez001j18=
X-Google-Smtp-Source: ABdhPJxh0VKtzLo5Kn/yiWxgiWQBskj7KIfuUEc5zofpePE6a0Le1r5mEoFkT0otR6ImaE83sLrlvw==
X-Received: by 2002:a17:90a:33a7:: with SMTP id n36mr14708728pjb.126.1589735903146;
        Sun, 17 May 2020 10:18:23 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.googlemail.com with ESMTPSA id n69sm6513900pjc.8.2020.05.17.10.18.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 10:18:22 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH V1 6/6] staging: greybus: audio: Enable GB codec, audio module compilation.
Date:   Sun, 17 May 2020 22:47:21 +0530
Message-Id: <77cfc355b87ee21636430f787764700de1983f38.1589734179.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, GB codec and audio module is conditionally compiled based on
GREYBUS_AUDIO_MSM8994. However, audio module is not dependent on MSM8994
platform and can be used generically with any platform that follows
GB Audio class specification.

Also, GB codec driver corresponds to dummy codec represented by I2S port
available on Toshiba AP Bridge. Added config option for the same in
kconfig file and accordingly updated Makefile.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
 drivers/staging/greybus/Kconfig  | 14 +++++++++++++-
 drivers/staging/greybus/Makefile |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index d4777f5a8b90..cbcfcbba239b 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -3,7 +3,7 @@ if GREYBUS
 
 config GREYBUS_AUDIO
 	tristate "Greybus Audio Class driver"
-	depends on SOUND
+	depends on SOUND && SND_SOC
 	---help---
 	  Select this option if you have a device that follows the
 	  Greybus Audio Class specification.
@@ -11,6 +11,18 @@ config GREYBUS_AUDIO
 	  To compile this code as a module, chose M here: the module
 	  will be called gb-audio.ko
 
+config GREYBUS_AUDIO_APB_CODEC
+	tristate "Greybus APBridge Audio codec driver"
+	depends on SND_SOC && GREYBUS_AUDIO
+	help
+	  Select this option if you have a Toshiba APB device that has I2S
+          ports and acts as a Greybus "Dummy codec". This device is a
+          bridge from an APB-I2S port to a Unipro network.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called gb-audio-codec.ko
+
+
 config GREYBUS_BOOTROM
 	tristate "Greybus Bootrom Class driver"
 	---help---
diff --git a/drivers/staging/greybus/Makefile b/drivers/staging/greybus/Makefile
index 3b4b6cabff19..7c5e89622334 100644
--- a/drivers/staging/greybus/Makefile
+++ b/drivers/staging/greybus/Makefile
@@ -40,8 +40,8 @@ gb-audio-manager-y	:= audio_manager.o audio_manager_module.o
 #ccflags-y += -DGB_AUDIO_MANAGER_SYSFS
 #endif
 
-obj-$(CONFIG_GREYBUS_AUDIO_MSM8994)	+= gb-audio-codec.o
-obj-$(CONFIG_GREYBUS_AUDIO_MSM8994)	+= gb-audio-module.o
+obj-$(CONFIG_GREYBUS_AUDIO_APB_CODEC)  	+= gb-audio-codec.o
+obj-$(CONFIG_GREYBUS_AUDIO_APB_CODEC)	+= gb-audio-module.o
 obj-$(CONFIG_GREYBUS_AUDIO)		+= gb-audio-gb.o
 obj-$(CONFIG_GREYBUS_AUDIO)		+= gb-audio-apbridgea.o
 obj-$(CONFIG_GREYBUS_AUDIO)		+= gb-audio-manager.o
-- 
2.7.4

