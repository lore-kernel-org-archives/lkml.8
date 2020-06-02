Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D531C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E5D2077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdnedtkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFBFWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBFWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:22:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:22:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nm22so827681pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxRa6VcY2LMBz3zcWZQ3W5R2LRvt5t09mwNFn3RdLfA=;
        b=kdnedtkUWGH0EgiiSkOM6lz6ez0QnNlc8zFGS7E1FXfVPHfLGSWGwMOnK4MTDMgets
         49gpArFoPZY7hatliqTT9EBVVETbW/eUQgLO/MxWMlqiG1otNOmKV8PkRGZ5kbBjNKCt
         kYU+8WfieLU8FeTewg7zVMqcqqjl/d+eisprHQAveG+vgAhTZgONgmVeFXZwrBFdwQi0
         iVhvgadIyJGh9PVswSu+cJOMvzUKESCQJhXKEUvfc9/fx/+eIuWpoNXrrYqcj/Ph0MT4
         +C+zrdrcExdLdysSWFXC+ikhjahhSGBLqXVJmdMuhH7+MA8bQGZYmdWxfq6WSCYyd6Jb
         eLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxRa6VcY2LMBz3zcWZQ3W5R2LRvt5t09mwNFn3RdLfA=;
        b=cegZfxS0qOZ65fPpuuJPs5OXK2PJDKqNRxiDuG05fljENgrjIRLu69LWyIcL8VEgPJ
         w1zKCKyZBhQESS4qqEY4PGed0Yl+YDQ+j9+PtC+GS7kD3A+6OAsus3o9kPXZ/nIssnzS
         +d2lKgmB+aPnlgeGVY8YP5eTwVIsf2zeN9wgkQ58uhUtNSSFO5gmrR2AflWGiK5dEogo
         TtJrIHf3kA0u2IGgj09olf1cALrhkEwNI3ZQGL++kp0mX5mke6WMY98VS33YImGdu43G
         uvZnd4OAcZhq717MmwHGAis2tm0CxJyTz7Ldek3KK14Jr67m7suuJYbh/774U3ht2tfB
         rUdw==
X-Gm-Message-State: AOAM532cvvtQDJZgA+9V6ZKxGPo4jLHY82VGxLsSi02bbqJOVYp9rFss
        9e2WKsiEUXZclBJk1KZEE7E=
X-Google-Smtp-Source: ABdhPJyvOPpNZ5sQza/sxtxZPtqR21/AwrWkuze4ajZeTe84L9t4Y1EK8depRG0U3GJcQvnI7YurYg==
X-Received: by 2002:a17:90a:32ee:: with SMTP id l101mr3564174pjb.213.1591075362317;
        Mon, 01 Jun 2020 22:22:42 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.55.41])
        by smtp.googlemail.com with ESMTPSA id f18sm1004764pga.75.2020.06.01.22.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 22:22:41 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [RESEND PATCH v1 6/6] staging: greybus: audio: Enable GB codec, audio module compilation.
Date:   Tue,  2 Jun 2020 10:51:15 +0530
Message-Id: <77cfc355b87ee21636430f787764700de1983f38.1591040859.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591040859.git.vaibhav.sr@gmail.com>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.26.2

