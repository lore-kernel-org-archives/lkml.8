Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2F3C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357002070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585046399;
	bh=Vr30dNMEWIjGd6IiJI50wytyImepg0RxkrgoIh9ce/M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wxV5QoiBTrY2mz93dyW+MbT8PP7WMlGcdWV8VpvD7QntdxN/nmvplAsE/t1ZBWScG
	 kSaWhzOEXuy2b+HXk0NS5nBfoNtSvis7HR4x1DHMWMlS97entVMA4YCdgbbF4VNEmR
	 0Ti/SH/KQ307ebtQ/AsPin5jK18zR90kHfYaetH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCXKj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCXKj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:39:57 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422622070A;
        Tue, 24 Mar 2020 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585046397;
        bh=Vr30dNMEWIjGd6IiJI50wytyImepg0RxkrgoIh9ce/M=;
        h=From:To:Cc:Subject:Date:From;
        b=OwII8d/0znQrCeCBrD91pnGAB1RdIbDPCXxoWnRUIAAuvsi3hbq5vNOz4g2jgiSq3
         P2K2KT1+FyA85uWb7GFU6wGJj+K4IbN9V5YZSGIWZMyLa8DVjqIYugBVcArbCISbj1
         uyKTZ0zUiELLBH/m9Uk+CeeHPQPI4rciHJOM81AI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGgyR-0021eA-2k; Tue, 24 Mar 2020 11:39:55 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] media: Kconfig: make filtering devices optional
Date:   Tue, 24 Mar 2020 11:39:53 +0100
Message-Id: <b0b805a9e89136607f4dbb018d5e0c2498eb6aa2.1585046350.git.mchehab+huawei@kernel.org>
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

 drivers/media/Kconfig | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 4c06728a4ab7..85476197837c 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -25,9 +25,13 @@ menuconfig MEDIA_SUPPORT
 	  Additional info and docs are available on the web at
 	  <https://linuxtv.org>
 
-menu "Types of devices to be supported"
+if MEDIA_SUPPORT
+
+menuconfig MEDIA_SUPPORT_FILTER
+	bool "Filter devices by their types"
 	depends on MEDIA_SUPPORT
 
+if MEDIA_SUPPORT_FILTER
 #
 # Multimedia support - automatically enable V4L2 and DVB core
 #
@@ -106,10 +110,41 @@ config MEDIA_TEST_SUPPORT
 	  have regressions.
 
 	  Say Y when you have a software defined radio device.
+endif #MEDIA_SUPPORT_FILTER
 
-endmenu # media support types
+if !MEDIA_SUPPORT_FILTER
+config MEDIA_CAMERA_SUPPORT
+	bool
+	default y
 
-if MEDIA_SUPPORT
+config MEDIA_ANALOG_TV_SUPPORT
+	bool
+	default y
+
+config MEDIA_DIGITAL_TV_SUPPORT
+	bool
+	default y
+
+config MEDIA_RADIO_SUPPORT
+	bool
+	default y
+
+config MEDIA_SDR_SUPPORT
+	bool
+	default y
+
+config MEDIA_CEC_SUPPORT
+	bool
+	default y
+
+config MEDIA_EMBEDDED_SUPPORT
+	bool
+	default y
+
+config MEDIA_TEST_SUPPORT
+	bool
+	default y
+endif #MEDIA_SUPPORT_FILTER
 
 comment "Media core options"
 
-- 
2.24.1


