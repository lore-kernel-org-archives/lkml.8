Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F138C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069462073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057427;
	bh=oSsb+HN55pEmPfT+clNvUwcyNluPUo3+cd4CjUseYKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GcIGndKXsldhIOV0KRRPVgjPk7nAh8o30P1EQS5Eh4+xjin1uAiGR9gxaP0luHs/5
	 630qg4HVbjH95azzCXNl/+pi7zZXXitb9gKVqwtQzujLg5gwEJilL0K9eJu5Ut+7Dx
	 cthHQIz5T8/Ebowc+rwztNOA+JIARToVkJvGO/kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgCXNnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgCXNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1CC621707;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057399;
        bh=oSsb+HN55pEmPfT+clNvUwcyNluPUo3+cd4CjUseYKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwDrH0NGxVpfHowcTOjfsJX0F5gb3vjMR178UCMw8vGNAiPuInu3hCNtkqkzDNN5V
         Uqr0LzhVyXCv306Fmq05tLPqpWt8/DJeBt8F8w1xL/qcn+1QeZ4S1YzA3lKp49HFFu
         GPfGLHYWt4xAh/NVe3cj06Otv25s1RW50YD+egEY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjpt-0025s4-5h; Tue, 24 Mar 2020 14:43:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 18/20] media: Kconfig: place all options under a sub-menu
Date:   Tue, 24 Mar 2020 14:43:11 +0100
Message-Id: <967506cc001ad7f194ee24e823a398c293b352ab.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That should make easier for people setting the media
subsystem config options, as they'll be split by the
type of functionality that will be enabled.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 026a1151273c..6c55d20458ee 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -124,48 +124,49 @@ config MEDIA_TEST_SUPPORT
 	  Say Y when you have a software defined radio device.
 endmenu # media device types
 
-comment "Media core options"
-
-#
-# Video4Linux support
-#	Only enables if one of the V4L2 types (ATV, webcam, radio) is selected
-#
+menu "Media core support"
+	visible if !MEDIA_SUPPORT_FILTER
 
 config VIDEO_DEV
-	tristate
+	tristate "Video4Linux core"
 	depends on MEDIA_SUPPORT
 	default MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT || V4L_PLATFORM_DRIVERS
+	help
+	  Enables the V4L2 API, used by cameras, analog TV, video grabbers,
+	  radio devices and by some input devices.
 
 config MEDIA_CONTROLLER
 	bool "Media Controller API"
-	depends on MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT
+	default MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT || MEDIA_EMBEDDED_SUPPORT
 	help
 	  Enable the media controller API used to query media devices internal
 	  topology and configure it dynamically.
 
 	  This API is mostly used by camera interfaces in embedded platforms.
 
-#
-# DVB Core
-#	Only enables if one of DTV is selected
-#
-
 config DVB_CORE
-	tristate
+	tristate "Digital TV core"
 	depends on MEDIA_SUPPORT
-	depends on MEDIA_DIGITAL_TV_SUPPORT
+	default MEDIA_DIGITAL_TV_SUPPORT
 	depends on (I2C || I2C=n)
-	default y
 	select CRC32
-
 	help
+	  Enables the DVB API, used by Digital TV devices. Supports several
+	  standards, including DVB, ATSC, ISDB and CMDB.
 
+endmenu # Media core support
+
+#
+# Extra per-media API core functionality
+
+menu "Media core additional options"
 source "drivers/media/v4l2-core/Kconfig"
 source "drivers/media/mc/Kconfig"
 source "drivers/media/dvb-core/Kconfig"
 source "drivers/media/cec/Kconfig"
+endmenu
 
-comment "Media drivers"
+menu "Media drivers"
 
 #
 # V4L platform/mem2mem drivers
@@ -188,7 +189,9 @@ endif # MEDIA_EMBEDDED_SUPPORT
 
 source "drivers/media/firewire/Kconfig"
 
-comment "Media ancillary drivers (tuners, sensors, i2c, spi, frontends)"
+endmenu
+
+menu "Media ancillary drivers (tuners, sensors, i2c, spi, frontends)"
 
 #
 # Ancillary drivers (tuners, i2c, spi, frontends)
@@ -233,4 +236,6 @@ source "drivers/media/spi/Kconfig"
 source "drivers/media/tuners/Kconfig"
 source "drivers/media/dvb-frontends/Kconfig"
 
+endmenu
+
 endif # MEDIA_SUPPORT
-- 
2.24.1

