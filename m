Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D48CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73F3208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O7ge+z+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgIGIdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgIGIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:33:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E1C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:33:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so13525519wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BskRtsfSrtTPxUTZWhMJwYdJ0y7cfpBILFNcmq3oTKY=;
        b=O7ge+z+DXSflA2nuhw8jVKX1cOoi2X7CTELrpMw2/JGMs2hKuKOPfL7/7V5uAs9yUi
         ZdLkBakj3/HuYnaFmYJlAyO2c51F1xS4YVRtdYc3lyIvtBnHcL0FlfjOgxXtZuJWv6Kw
         C0pEd8mu+v/Go3GuN8jjGNyaYN41uj0AjePn5n2D2nbp4KeAtJFuLLMFu//SynsnmINp
         JKTl66vaA43c/AoDvFjnciRhInMhoDn4pJedefiCPEK9ZNYCTJkUsyygkpqCWm5xZIRC
         fisfxfJJOeoH9KjVRQmZ1dlYqAL3EQ1Wmv/HGEkSJXd3dWu2meUCd+jRcuYkRXdN2jG0
         qhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BskRtsfSrtTPxUTZWhMJwYdJ0y7cfpBILFNcmq3oTKY=;
        b=uoV+0om9nu61O29HPAiso9afpWGkfIXTU3hOtKBHwECsyyRGuVjyU4s13ljkk5Ytxo
         Jw+xqhUFw2qdhwMOB5bhL01ma3ijuIYocEGl2tjhENIGl5ir5yBUWKq/Cf+b9Q5L7Aju
         poP5VEKTOeyjd6KmNZ9wQyqA4bO5ziadXqyM+xUyeQFPaD8Nc9hMIY8Xh6F+Ol6gB0eI
         UEhh71ZLB5wfZ0SdQqBGDlkAcVxYU992i7EempQNxO1XLfnTxSaFUjcHWOZp4MpL8WP5
         j0oBT96wKdBkXcFmOZTEnGo3GVNRttL3sK6vXx1IhaxXvVp2jLdZ3kQGzplVCcArbyp6
         WFnA==
X-Gm-Message-State: AOAM533hPumRSSoLqvuwGJ9C9vxTGSlJ8B/sQLWgwHDZu1+ybM2APJx4
        FqwOek4SeqOmtkJpzvE3g0sm3Q==
X-Google-Smtp-Source: ABdhPJwLZwS9A3Au5pjUdBGSVp1oaVkRMPuW6y501Mdqjo5E2ZTDunW08wCkhCnOFN3MICg6WGnM+w==
X-Received: by 2002:a05:600c:410e:: with SMTP id j14mr20714139wmi.13.1599467586730;
        Mon, 07 Sep 2020 01:33:06 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id o5sm25205111wmc.33.2020.09.07.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:33:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/3] arm64: dts: meson-axg: add VPU and PWRC nodes
Date:   Mon,  7 Sep 2020 10:32:58 +0200
Message-Id: <20200907083300.14412-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907083300.14412-1-narmstrong@baylibre.com>
References: <20200907083300.14412-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the display VPU node and the power controller PWRC node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b9efc8469265..4a93e3fecd90 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+#include <dt-bindings/power/meson-axg-power.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -187,6 +188,7 @@
 				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
+			power-domains = <&pwrc PWRC_AXG_ETHERNET_MEM_ID>;
 			status = "disabled";
 		};
 
@@ -1117,6 +1119,46 @@
 					clocks = <&xtal>;
 					clock-names = "xtal";
 				};
+
+				pwrc: power-controller {
+					compatible = "amlogic,meson-axg-pwrc";
+					#power-domain-cells = <1>;
+					amlogic,ao-sysctrl = <&sysctrl_AO>;
+					resets = <&reset RESET_VIU>,
+						 <&reset RESET_VENC>,
+						 <&reset RESET_VCBUS>,
+						 <&reset RESET_VENCL>,
+						 <&reset RESET_VID_LOCK>;
+					reset-names = "viu", "venc", "vcbus",
+						      "vencl", "vid_lock";
+					clocks = <&clkc CLKID_VPU>,
+						 <&clkc CLKID_VAPB>;
+					clock-names = "vpu", "vapb";
+					/*
+					 * VPU clocking is provided by two identical clock paths
+					 * VPU_0 and VPU_1 muxed to a single clock by a glitch
+					 * free mux to safely change frequency while running.
+					 * Same for VAPB but with a final gate after the glitch free mux.
+					 */
+					assigned-clocks = <&clkc CLKID_VPU_0_SEL>,
+							  <&clkc CLKID_VPU_0>,
+							  <&clkc CLKID_VPU>, /* Glitch free mux */
+							  <&clkc CLKID_VAPB_0_SEL>,
+							  <&clkc CLKID_VAPB_0>,
+							  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
+					assigned-clock-parents = <&clkc CLKID_FCLK_DIV4>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VPU_0>,
+								 <&clkc CLKID_FCLK_DIV4>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VAPB_0>;
+					assigned-clock-rates = <0>, /* Do Nothing */
+							       <250000000>,
+							       <0>, /* Do Nothing */
+							       <0>, /* Do Nothing */
+							       <250000000>,
+							       <0>; /* Do Nothing */
+				};
 			};
 		};
 
@@ -1563,6 +1605,22 @@
 			};
 		};
 
+		vpu: vpu@ff900000 {
+			compatible = "amlogic,meson-axg-vpu";
+			reg = <0x0 0xff900000 0x0 0x100000>,
+			      <0x0 0xff63c000 0x0 0x1000>;
+			reg-names = "vpu", "hhi";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&pwrc PWRC_AXG_VPU_ID>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* DPI output port */
+			dpi_port: port@2 {
+				reg = <2>;
+			};
+		};
+
 		gic: interrupt-controller@ffc01000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0xffc01000 0 0x1000>,
-- 
2.22.0

