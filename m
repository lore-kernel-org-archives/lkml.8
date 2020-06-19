Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C809C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6888F207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNqbP6+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbgFSLWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbgFSLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:21:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA81C0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:21:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x207so4309406pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMnJVRRzK09/VbvKw7yuFnugcGkqSr1qw4/Z5xsvw+g=;
        b=JNqbP6+cXWUBzXZrKR7UOEA8LVJbGNaUA0+H4KgGXU0knATtP5jR10SCoEKZ4P+2zd
         11XoPqIS3xPiISe8/vnOeFNnUm5OvqzszeRZBwCoNR5gSnzDaNzIz4ZSHVLAqrEbbKC7
         ASdhtKm+gGdEzXL3PU7s8WGlWWdy9LWO9lrcWkdNFxLMdM2dFDVzMdSc6Sq3kQ472g7/
         Hhlw99uPuRgeTizlE8BLanl6bOb0gRfsC0G0STym3pEnfewEOMdl8y6lXBRcNZsD6E06
         dTNVgFeW4uzQ99D9n4OGJfu6W2V4svMvMBlpPw905f37t6NI13QZ4PJ/PrxGmVgHj5LP
         RJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMnJVRRzK09/VbvKw7yuFnugcGkqSr1qw4/Z5xsvw+g=;
        b=a7L/SXz2lUgBUUI3fuS0u4XUtsVd615GuAZSLHu9sOew7lyqsvPa5gI8Y7jh0wK0l/
         ssSXOr4vUuPNF2nNTw/cp2/N1VOroIiLBacDO3lMnmJnqC6+AomL1H2GykLJmWOIGxS7
         domcp0yZpYQgLEZ24jtdTp7HhmK8U45I9FN0eJ8homicOvF825EDggFa6TD85ZpBTFl0
         Qow6As6H78/DLmAm1z72UiHdcuy+IIJZ7dMbo82PWfAseM1D3tpt8gW2sJ/r88TAbsOQ
         KMRapnhjiyNoYMoy+49fDtGvfz4r2o5BCywLYHLQxjIiOhIjkbeqbY+4gN/e4TlJcKRy
         q2jA==
X-Gm-Message-State: AOAM533P/dacP/ZGkmcoOXM0M64eEvfihV66bV94Btp2GI6gGbWWKEwq
        WSad4OVipLgQb1cDinGx9V8=
X-Google-Smtp-Source: ABdhPJxipZmj5Iz98CdyoTS3c4ColLD2W0ESzWGhlG9bBctqOh2MzBwx8a9qabDG4nUQ8N1Fdzcz8w==
X-Received: by 2002:a62:1c46:: with SMTP id c67mr7524623pfc.170.1592565701246;
        Fri, 19 Jun 2020 04:21:41 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.55.41])
        by smtp.googlemail.com with ESMTPSA id d9sm4974293pgg.74.2020.06.19.04.21.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 04:21:40 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 6/6] staging: greybus: audio: Enable GB codec, audio module compilation.
Date:   Fri, 19 Jun 2020 16:50:26 +0530
Message-Id: <e9aaa09c6688aa5ed8bddf51f5cd402bb8cf39b3.1592537217.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592537217.git.vaibhav.sr@gmail.com>
References: <cover.1592537217.git.vaibhav.sr@gmail.com>
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
2.26.2

