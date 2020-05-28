Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3982088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kynetics-com.20150623.gappssmtp.com header.i=@kynetics-com.20150623.gappssmtp.com header.b="NqgdwDyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407400AbgE1UtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407390AbgE1Us7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:48:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618BC08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:48:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so701830wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUiYoi4oRp58+q5ZwZM3ckxVs2ohb6Fr3EU5Rh4Dl0I=;
        b=NqgdwDyljpdh0ZqDu6YHewXyVjxlQvyaoDcVNEhKu3GQyB7A9uq+7b/W1cFKNj6Auo
         mhKwV7wV1isHYxuYqarBvpiX91pHT3Vpg06C2EFiQrntIJzEQyvT2nxTAkGiivbl8QSi
         bZxMZ2vKBo3uptBm8vIzCGaUTT9IxYkHdAfQW1O58OJaSH7wmU5nxeBdmFcpQjfbRq5U
         zovuTjw8NTa9epKpX7BNnRmILXOudZyRWmSiDA3suI/YDdXWZN/ZMA8WnelIjLiUQkBK
         OzJGs/OR7cjo2MG36l32/kvopZ6nlWzQcfHIKXjfOzSmRK590aqWPoi6x17vOUbtFpeH
         sSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUiYoi4oRp58+q5ZwZM3ckxVs2ohb6Fr3EU5Rh4Dl0I=;
        b=meCSCjS6flFh8/4LkJ1LhxsUygdUnF3wuuWdTfS5sZ9tx+Vw6iTFLXqJPGINQxqVaM
         F8XD/R/rrguBq3/RcTHJoSiWDCTq/+nv1Z7soELbLRBc/tjaahrtczHcjvFPeTWyp6rX
         DOFog9j/lCO/RwI6mg0dFDZvbAUB6hpnRHVdcE4KOdSo6Vk2Q7MzsIHBVKXPXq/gR0/S
         aFW6bOmkbtajlU4U14KrHuwhsdACf1J4XL8NP/w1n9EZxheHL0RaInWJYsTLZcQ6hDa3
         HyHFiB6zgmKO7Rsmity42NuBkw5KihuNB0wNX/b9ZkLlXd2olDJdiUykXQfD0lGSZEdj
         /sCQ==
X-Gm-Message-State: AOAM530R/T40yDLsGW7OBa+YZ1sMS0v0QFPO+aatMcNBGoKWnh4QbzGo
        EzgALhhqYY4dUriqVTWPo5Ipf2bqcFo=
X-Google-Smtp-Source: ABdhPJzwOzuB9A1HKWNt34Uu6DxWwtaF4OkTIOet4cseL0Mea2TRDauwS/pcfa5XsGFhl7VbI8VA1w==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr5108720wrt.159.1590698937914;
        Thu, 28 May 2020 13:48:57 -0700 (PDT)
Received: from localhost.lan (mob-2-41-210-190.net.vodafone.it. [2.41.210.190])
        by smtp.gmail.com with ESMTPSA id a15sm7632782wra.86.2020.05.28.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:48:57 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH 1/2] ARM: dts: orange-pi-zero-plus2: enable USB OTG port
Date:   Thu, 28 May 2020 22:47:11 +0200
Message-Id: <20200528204712.552964-1-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for USB OTG port on Orange Pi Zero Plus 2 (both H3 and H5
variants). As, according to the board schematics, the USB OTG port cannot
provide power to external devices, we set dr_mode to peripheral.

Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>
---
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 23 +++++++++++++++++++
 .../sun50i-h5-orangepi-zero-plus2.dts         | 23 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
index b8f46e2802fd3..4376767699a47 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -137,3 +137,26 @@ &uart0 {
 	pinctrl-0 = <&uart0_pa_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+};
+
+&usb_otg {
+	/*
+	 * According to schematics CN1 MicroUSB port can be used to take
+	 * external 5V to power up the board VBUS. On the contrary CN1 MicroUSB
+	 * port cannot provide power externally even if the board is powered
+	 * via GPIO pins. It thus makes sense to force peripheral mode.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index c95a68541309c..d8192a7483e9e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -103,3 +103,26 @@ &uart1 {
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+};
+
+&usb_otg {
+	/*
+	 * According to schematics CN1 MicroUSB port can be used to take
+	 * external 5V to power up the board VBUS. On the contrary CN1 MicroUSB
+	 * port cannot provide power externally even if the board is powered
+	 * via GPIO pins. It thus makes sense to force peripheral mode.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
-- 
2.25.4

