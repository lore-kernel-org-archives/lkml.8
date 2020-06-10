Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2452C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9265B206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDmTN8g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgFJRaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:30:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB25C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:30:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so1169725pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSSqAri9IDFCpU3JjO79asbzoYTG2dNk47iwG0514GI=;
        b=mDmTN8g77fIQ7mXWZiV3RT0B5wwlZzKx6S+wKTcIRN4H5fwCr50Eu8/ixfWH2h65Oh
         NZEIVdGKL/Blz2c3a1qIWjVNej6Z6uG7NSEJtjJE1dVBGOkmhphDE6e5bd3R/YARk4CC
         ViMMVL6aRup/WasNXCSxmwbKgnO28mr4v7jDeGs1YV9t2gzx1Zb/HkiHg6iUtjT6jtgN
         qb+gcTP76RcJX/RHOuCYS5ZkgXOfFFKhLw+cixP0iezh5gaWRFKAUan7nq88xer4ZQ6B
         h3V+sxyEZoK82tPtqKsdXhwmQr/CE7zEK0TaCB+1ppdH+8s6t2XSPbGGQHeMaW09pVhu
         L3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSSqAri9IDFCpU3JjO79asbzoYTG2dNk47iwG0514GI=;
        b=ipIW9Ud2b9pmcl/FDDAVu4KIAJ5cJm/mlpFrbBxDWSFLqCUT50v9y1/6hVLX9CqU2P
         rn6+fRUbroTbL8L1oHeNa40Ov94mIMvt2JXW2kgGwp8ci3GeShFzETRnS9RqesS+moZy
         kB+UPI8Mft9Jz9NBDgh7FOkiMVPp2ggkQE3SzE49DJjEZgwCdIwGKX5chpwgn0g7Vtzj
         gyP2y7KEWB8ZeLr6EcAiVZWA41A515Ft9NPO4NnBNjZXWE61WNzZJmps5yScrtNvXSNI
         6M9JjFUSgO5e/ik8R0cgJQf9F/atKa9nIEdM80l0DtQUpMWlYceTq1s+VsNhM8BK2w8R
         +NUQ==
X-Gm-Message-State: AOAM530LVM4KzJ/zUbe4jYzV8JdnTjRZ2FVI2p/0HDSDM1FLrugELWfD
        9pks4JKCtDlH9VfcLBJqp/Q=
X-Google-Smtp-Source: ABdhPJzNlj5nhn4pYpEdkNQnoV/L+9+GNHKM52nJxU7AlwWynfm7U5MIiTie1V5Kla8isU83IdExAQ==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr3704408pll.273.1591810208856;
        Wed, 10 Jun 2020 10:30:08 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id l83sm490470pfd.150.2020.06.10.10.29.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 10:30:08 -0700 (PDT)
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
Subject: [PATCH v2 6/6] staging: greybus: audio: Enable GB codec, audio module compilation.
Date:   Wed, 10 Jun 2020 22:58:30 +0530
Message-Id: <54b188a59687a915f43085db7b5cf05476308cbd.1591802243.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591802243.git.vaibhav.sr@gmail.com>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
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

