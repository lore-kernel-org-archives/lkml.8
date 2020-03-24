Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FDAC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1937B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585051287;
	bh=LFIWrkxxQfc9bjlIkjwZKLLBNOxPYHNN97VjfhfF9q4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=L7+/ZXE2FrjhLDRckNvVDqvzCgHh9Yu1Olyd1lQOLsCMqgNSRoHwjC5PixybGIPKw
	 bN6bo406tQlFBewknfYm7IVNDlZ7yCJwipfKtkgobrrl6eBxpSizdpS4rHYqmvE7y0
	 2aBfdI+YleCFQufCXAYxIEzt08qezxweOa+USZOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCXMB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgCXMBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:01:24 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B7C2080C;
        Tue, 24 Mar 2020 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585051284;
        bh=LFIWrkxxQfc9bjlIkjwZKLLBNOxPYHNN97VjfhfF9q4=;
        h=From:To:Cc:Subject:Date:From;
        b=HT2aOlOknm6UL8i+jGV0O7co7F4v084Os9eEr5ADoW+a8f4uFAka7HOhXEpwiOaJL
         Ke/TZ/fNXYBNLyk10g2aW9A43rSah2qBuOtqT2pcmLW2bMoAq5IhZfA2BXN3Wy2B40
         lsH7E1HuBgE3DHmtJBjFMMHhLmusjYDH1uSs/mV8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGiFF-0022YD-U0; Tue, 24 Mar 2020 13:01:21 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] media: Kconfig: make filtering devices optional
Date:   Tue, 24 Mar 2020 13:01:21 +0100
Message-Id: <751a1be8d03e1c30d5af17cfd659ffc6a5721a35.1585051247.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-device option selection is a feature that some
developers love, while others hate...

So, let's make both happy by making it optional.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

v2: simplify the Kconfig options by using a visible menu

 drivers/media/Kconfig | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 4c06728a4ab7..e372029ac41f 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -25,14 +25,32 @@ menuconfig MEDIA_SUPPORT
 	  Additional info and docs are available on the web at
 	  <https://linuxtv.org>
 
-menu "Types of devices to be supported"
+if MEDIA_SUPPORT
+
+config MEDIA_SUPPORT_FILTER
+	bool "Filter devices by their types"
 	depends on MEDIA_SUPPORT
+	help
+	   Configuring the media subsystem can be complex, as there are
+	   hundreds of drivers and other config options.
+
+	   This menu offers option that will help the Kernel's config
+	   system to hide drivers that are out of the scope of the
+	   user needs, and disabling core support for unused APIs.
+
+	   If not selected, all non-optional media core functionality
+	   needed to support media drivers will be enabled. Also, all
+	   media device drivers should be shown.
+
+menu "Media device types"
+	visible if MEDIA_SUPPORT_FILTER
 
 #
 # Multimedia support - automatically enable V4L2 and DVB core
 #
 config MEDIA_CAMERA_SUPPORT
 	bool "Cameras and video grabbers"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable support for webcams and video grabbers.
 
@@ -40,6 +58,7 @@ config MEDIA_CAMERA_SUPPORT
 
 config MEDIA_ANALOG_TV_SUPPORT
 	bool "Analog TV"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable analog TV support.
 
@@ -52,6 +71,7 @@ config MEDIA_ANALOG_TV_SUPPORT
 
 config MEDIA_DIGITAL_TV_SUPPORT
 	bool "Digital TV"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable digital TV support.
 
@@ -60,6 +80,7 @@ config MEDIA_DIGITAL_TV_SUPPORT
 
 config MEDIA_RADIO_SUPPORT
 	bool "AM/FM radio receivers/transmitters"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable AM/FM radio support.
 
@@ -74,6 +95,7 @@ config MEDIA_RADIO_SUPPORT
 
 config MEDIA_SDR_SUPPORT
 	bool "Software defined radio"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable software defined radio support.
 
@@ -81,6 +103,7 @@ config MEDIA_SDR_SUPPORT
 
 config MEDIA_CEC_SUPPORT
 	bool "HDMI CEC support"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable support for HDMI CEC (Consumer Electronics Control),
 	  which is an optional HDMI feature.
@@ -90,6 +113,7 @@ config MEDIA_CEC_SUPPORT
 
 config MEDIA_EMBEDDED_SUPPORT
 	bool "Embedded devices (SoC)"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Enable support for complex cameras, codecs, and other hardware
 	  found on Embedded hardware (SoC).
@@ -98,6 +122,7 @@ config MEDIA_EMBEDDED_SUPPORT
 
 config MEDIA_TEST_SUPPORT
 	bool "Test drivers"
+	default y if !MEDIA_SUPPORT_FILTER
 	help
 	  Those drivers should not be used on production Kernels, but
 	  can be useful on debug ones. It enables several dummy drivers
@@ -106,10 +131,7 @@ config MEDIA_TEST_SUPPORT
 	  have regressions.
 
 	  Say Y when you have a software defined radio device.
-
-endmenu # media support types
-
-if MEDIA_SUPPORT
+endmenu # media device types
 
 comment "Media core options"
 
-- 
2.24.1


