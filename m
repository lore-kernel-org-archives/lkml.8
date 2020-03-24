Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE27206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057447;
	bh=BJ2Wn1y+AKLeMhXpjgpfv7bwnUWM8CBInq+znT5z4d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMIXCFI7usKwsGrnIi/qF+7gYNljYXhMHM97E4zshTlOk8GGEnrN3f6zno4CXuHy5
	 SgQabTPsyB3+npGvEmm0xPEYb9Vus4dA2+i8J0yjv6BJsAwKIJrOsxzKLN1S9sXzV7
	 emDxdox6aN1T4gQg2JxUsOwLo+OfLglrMHf227Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgCXNoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgCXNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97902208DB;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=BJ2Wn1y+AKLeMhXpjgpfv7bwnUWM8CBInq+znT5z4d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLOQLa5ZI7F4/tL6b/EKjsGHyJF//QOyWW9Fk9TylVaqNuoK62cf7u49RjPKdpT6f
         s+UeyBcAhy+42vt3ZSiA+QDKwmsasQMDet/PXW6GpbtbJETnYS0EfwdimaagDFTCVo
         yopFRLWHF3WKuKPoMvs/+eWTGTlX1CBbr3/PZ5M0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025r6-Lp; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 06/20] media: Kconfig: use a sub-menu to select supported devices
Date:   Tue, 24 Mar 2020 14:42:59 +0100
Message-Id: <72a1168a8d48bd603ef1e13350bbc49bdc036544.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The media subsystem has hundreds of driver-specific options.
The *_SUPPORT config options work as a sort of filter,
allowing to reduce its complexity for users that won't
want to dig into thousands of options they don't need.

Yet, it the filtering options are becoming large. So, let's
place it on a sub-menu.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig     | 22 +++++++++++++---------
 drivers/media/mmc/Kconfig |  2 +-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 18dea82d76d7..e266d1afa912 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -25,22 +25,21 @@ menuconfig MEDIA_SUPPORT
 	  Additional info and docs are available on the web at
 	  <https://linuxtv.org>
 
-if MEDIA_SUPPORT
-
-comment "Multimedia core support"
+menu "Types of devices to be supported"
+	depends on MEDIA_SUPPORT
 
 #
 # Multimedia support - automatically enable V4L2 and DVB core
 #
 config MEDIA_CAMERA_SUPPORT
-	bool "Cameras/video grabbers support"
+	bool "Cameras and video grabbers"
 	help
 	  Enable support for webcams and video grabbers.
 
 	  Say Y when you have a webcam or a video capture grabber board.
 
 config MEDIA_ANALOG_TV_SUPPORT
-	bool "Analog TV support"
+	bool "Analog TV"
 	help
 	  Enable analog TV support.
 
@@ -52,7 +51,7 @@ config MEDIA_ANALOG_TV_SUPPORT
 		will disable support for them.
 
 config MEDIA_DIGITAL_TV_SUPPORT
-	bool "Digital TV support"
+	bool "Digital TV"
 	help
 	  Enable digital TV support.
 
@@ -60,7 +59,7 @@ config MEDIA_DIGITAL_TV_SUPPORT
 	  hybrid digital TV and analog TV.
 
 config MEDIA_RADIO_SUPPORT
-	bool "AM/FM radio receivers/transmitters support"
+	bool "AM/FM radio receivers/transmitters"
 	help
 	  Enable AM/FM radio support.
 
@@ -74,7 +73,7 @@ config MEDIA_RADIO_SUPPORT
 		disable support for them.
 
 config MEDIA_SDR_SUPPORT
-	bool "Software defined radio support"
+	bool "Software defined radio"
 	help
 	  Enable software defined radio support.
 
@@ -89,6 +88,10 @@ config MEDIA_CEC_SUPPORT
 	  Say Y when you have an HDMI receiver, transmitter or a USB CEC
 	  adapter that supports HDMI CEC.
 
+endmenu # media support types
+
+if MEDIA_SUPPORT
+
 comment "Media core options"
 
 source "drivers/media/cec/Kconfig"
@@ -177,7 +180,8 @@ source "drivers/media/common/Kconfig"
 source "drivers/media/platform/Kconfig"
 source "drivers/media/mmc/Kconfig"
 
-comment "Supported FireWire (IEEE 1394) Adapters"
+
+comment "FireWire (IEEE 1394) Adapters"
 	depends on DVB_CORE && FIREWIRE
 source "drivers/media/firewire/Kconfig"
 
diff --git a/drivers/media/mmc/Kconfig b/drivers/media/mmc/Kconfig
index de0528c6994a..5217f5bd205e 100644
--- a/drivers/media/mmc/Kconfig
+++ b/drivers/media/mmc/Kconfig
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-comment "Supported MMC/SDIO adapters"
+comment "MMC/SDIO adapters"
 source "drivers/media/mmc/siano/Kconfig"
-- 
2.24.1

