Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3711DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1130420772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqaNmGTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGIK22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGIK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:28:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCCC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:28:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so665463plx.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3lv9e08Jsq1SUZ9ZdK01L3LTi6uM1M8FSp5FnExf/g0=;
        b=YqaNmGTzOpkzdWwVfJOR4ZQrDG9okqHOfTleBT35Kuhq+xjRdb+0qmURwVxpSIPI8u
         k0150jW28CY5i4tpFWsd3n/ib+n+EOWsHRLD2PEvHsmtB7SAYK0KSDs8+ItrxeAaPBO1
         0kxuReIQ+gPgUXb0TKtZzCgL14ClUFXlLMPvemOTUZ/Um6I5PkGId2SYpE+SOf3gny1J
         3EveQ7Q0MYdR/oTL+EJQXAnCAspWjEnRsvBawvH3j0m0wBSU2tZeVJRTtXoGaCmeeB89
         VwzmQpeFEpLBlZTh9ERhLuA8AWoj34J05GyF4ehk4asYgfhmc307uTxQ+JcA8alOmWGY
         RNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lv9e08Jsq1SUZ9ZdK01L3LTi6uM1M8FSp5FnExf/g0=;
        b=JKkGVxRIOvgwJMXkFQRPGZifM2jMpfaLxXIzAkhz2PpgB6vCaq7s2XWrA7xQRmprjg
         uGJMgQZDL6gM8JLbXpGuHM2tGo2cTDFn3LoL8ugqqGfBwGOoh0nJFIVs+6Np+4lHz0Sl
         GxFF2YwKsUtm795vlFaoXNtdvsHxMC04ipRmtbp/jc1DQ5ysRSHFNL/VyxqrDQT9InTY
         0Ajrj6SRBMKey8xkSnZpzhZmyCGP6u/3b/dlTnIyodihOx8QLZBPOtu4BpWbIok/eA5v
         TRyYghaZGUKMH9NCvsfTdC7IUAXJVve4grsdCYWoksAgXXHQCDM9jvUnY2X5+lslyLjK
         Ww9w==
X-Gm-Message-State: AOAM532cAZQuI6hzGGBTQFH/I7HZaXVjWlMvzedIlskrfM/QB2NEQACL
        Escy7j6bR6CPQdMn+k8J3RE=
X-Google-Smtp-Source: ABdhPJzjiR29udJayndhouR2e9Sx47u+KKoGK0HRiAPaF0AEugJy0j7IBYQWAkAkUzv2bNWZnoBWeg==
X-Received: by 2002:a17:90a:cf01:: with SMTP id h1mr14226941pju.234.1594290506645;
        Thu, 09 Jul 2020 03:28:26 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id y8sm2125163pju.49.2020.07.09.03.28.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:28:26 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 6/7] staging: greybus: audio: Enable GB codec, audio module compilation.
Date:   Thu,  9 Jul 2020 15:57:22 +0530
Message-Id: <2b50959ccffe5a4372880d27e79ef3be1873372c.1594290158.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594290158.git.vaibhav.sr@gmail.com>
References: <cover.1594290158.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently you can't enable the Gey Bus Audio Codec because there is no
entry for it in the Kconfig file. Originally the config name was going
to be AUDIO_MSM8994 but that's not correct because other types of
hardware are supported now. I have chosen the name AUDIO_APB_CODEC
instead.  Also I had to update the dependencies for GREYBUS_AUDIO to
make the compile work.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/greybus/Kconfig  | 14 +++++++++++++-
 drivers/staging/greybus/Makefile |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index 9389e7a922fa..927cfa4bc989 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -3,7 +3,7 @@ if GREYBUS
 
 config GREYBUS_AUDIO
 	tristate "Greybus Audio Class driver"
-	depends on SOUND
+	depends on SOUND && SND_SOC
 	help
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
 	help
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
2.27.0

