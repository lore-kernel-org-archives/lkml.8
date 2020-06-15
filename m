Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB43C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C92207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kynetics-com.20150623.gappssmtp.com header.i=@kynetics-com.20150623.gappssmtp.com header.b="vOlT6DrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgFONC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgFONCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:02:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:02:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so14573250wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yG4TX0q4STnfakhZj1Jy6LqPd0TuAXoc/J2tzd+XYRw=;
        b=vOlT6DrX6rx075X32KGHYvlAhGW2prqOHQiHu160Jm1Sx7TPbdK5EgFzjZY5ZDNTcz
         nL3jeWVLcxZ33If0/DklPgn7giQIo7U+JsYbTWa7upUdP1mCURZ6tDHN1xXutpLEXZAz
         gyaANYRm+OMChPplA5Q04hueaT4rUERoCh8lL/8e62inXpt8LZBzK4g9E3OgelBx35el
         DOQ8fWw5gtMRlpzAnk8lELnN5+aD+xe3695jvPVuVUpjPJExJi7j+GIVVHdsNOpshKjb
         Yo13cozv2dkpvDc7hvUiXdSwoOkSPOPNgGAcwJQgPe2s7YQTynkpqEt1C+eFEUQpSYEz
         kL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yG4TX0q4STnfakhZj1Jy6LqPd0TuAXoc/J2tzd+XYRw=;
        b=Dg2QTL7l3i36i1P6hveLMnZmPvBtKNti54goD1xxCvzdPl5/cdysrjZi1KdeskbpcR
         zCPMN1nWexT1MXEOSPjeXtND640L+5kCZ0p+PovdmFIurvSHro1CgiC9ZrqUgyWx4ITf
         nAUKvXRpMT91Jfk9naHfJvTw95JzmdfplTV51/n2vn3OzWw4lGqZRfWLwcMHERP1ySvK
         MSy1g0NEQLeWYw/gfeNy6wIA52BLo3GJ4pxgeEnQlTRMPlgX4gKInLqHMb1NFfKE17Ej
         qnY9cj/y2k/sk+bxTeCf2VfE6aZwIMx4E49EXZr+X+NPPqA3wHPVuxng+fInDFbCznpl
         AZTA==
X-Gm-Message-State: AOAM530MuKkVIo5VbRpuv+6u0bF4WJ1pq6AsnoMU5qpZDeaXd9hbHqq+
        mphHWWuqAFHSpbks1mhlnTGp7Q==
X-Google-Smtp-Source: ABdhPJwmvwGWDdrqCPnEhR7CHzTB8RsOUHLalrL4KmPDN1e5zRjb2fQVCDq6msGiFBDRBvGkmaT+Zg==
X-Received: by 2002:a1c:e057:: with SMTP id x84mr13695935wmg.160.1592226173500;
        Mon, 15 Jun 2020 06:02:53 -0700 (PDT)
Received: from localhost.lan (mob-37-176-61-186.net.vodafone.it. [37.176.61.186])
        by smtp.gmail.com with ESMTPSA id s132sm23900345wmf.12.2020.06.15.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:02:53 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH v2 1/2] ARM: dts: orange-pi-zero-plus2: enable USB OTG port
Date:   Mon, 15 Jun 2020 15:02:23 +0200
Message-Id: <20200615130223.34464-1-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.26.2
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
v2:
- reordered nodes alphabetically
---
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 23 +++++++++++++++++++
 .../sun50i-h5-orangepi-zero-plus2.dts         | 23 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
index b8f46e2802fd3..cbe32b975c5fe 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -88,6 +88,10 @@ &de {
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
@@ -132,8 +136,27 @@ &mmc2 {
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pa_pins>;
 	status = "okay";
 };
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
+&usbphy {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index c95a68541309c..e67733d133bb4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -48,6 +48,10 @@ &de {
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
@@ -92,6 +96,10 @@ &mmc2 {
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pa_pins>;
@@ -103,3 +111,18 @@ &uart1 {
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
 };
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
+&usbphy {
+	status = "okay";
+};
-- 
2.26.2

