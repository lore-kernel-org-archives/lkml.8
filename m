Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE13C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF262074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Uq9EQWvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCMJOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:14:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40462 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:14:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id z12so227810wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E70oj/WzyijwJdfPjeZpJL/TnPPgDCbN1C/+b4ziaYU=;
        b=Uq9EQWvXN+7M20yu7voSmq83vDSTrffh8f2SJRZ7xOSQzmTw7UFNqSV/zMaj+qbldO
         I09tl+0BRTTnwz1QXcfg3E03NXqP9VcLsjoU0JUvX1ptuE+9omUWdEIqRJHMxfTV9myy
         /3bHwaSVGeLmU5gDataY+uOXd/s0LBEC5zsAvQWZcLMxJafqF83MtFd2fo3Uv3hi7zSy
         p6IBhGz4/KI6RWPHZM1bSsbKzlUlHoixfGutpTZ390FGXwUXGh+dgs1LIZjVv7GfbKi0
         y4zfPsh9adv2p5F8TEUBDf7Y7AnErfF99RmIyLbzXlThlj1suyS4n3u+EeL1tVP1tAeT
         NBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E70oj/WzyijwJdfPjeZpJL/TnPPgDCbN1C/+b4ziaYU=;
        b=SmO1vzCg7k8aXU/LFPsku7VFMlzTmbC1YXK+AFiDnQ83FP0ieRBFPAi0OxlRHpQ4fg
         /viPeQKkUZpCiJM0dJHh4EO0GKW+hgRjEcYuzsh1EyXZ8EHstuIeCZplFRFe3QT7EMsM
         rTuOopfVE8uD31GTI4ymQIpHA8u6FJdHQ7+cLmtAG0E2j5rUedWQb5p6MkdjT01YFzJ8
         inMH/A9wrUloCJ/ImXScF9eanaoH6MMtAlofcaa9WA7S3IgyPnMN9kWc1ZTbhQCi5xaU
         wg9rPXnQ/rZtaXDwzr38Ka9W0adkGU+WFg8zxMffTc7c2nnjwVKiAElY2aLGF0Ggpb88
         47Xw==
X-Gm-Message-State: ANhLgQ1bqbPfMxXcDHEJfkt/iVzAqdDskGcQ2xhAtB9Pw/3Bcxvi7jPS
        N6g4k+smxx8tkZC0YrsJIDASzlB6RU61mA==
X-Google-Smtp-Source: ADFU+vsUGjCjoPvn78i2h2y/UPx6n/9ZiqzP07HFNclTzgvoivDZdY21eVjZkNHVfoQc6hEKkjcNwg==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr10226228wmc.31.1584090843727;
        Fri, 13 Mar 2020 02:14:03 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id s1sm7952666wrp.41.2020.03.13.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:14:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] arm64: dts: meson-g12-common: add spicc controller nodes
Date:   Fri, 13 Mar 2020 10:14:01 +0100
Message-Id: <20200313091401.15888-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the controller and pinctrl nodes for the Amlogic G12A SPICC
controllers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Kevin,

This depends on the CLKID_SPICC0_SCLK and CLKID_SPICC1_SCLK introduced
in https://lore.kernel.org/linux-arm-kernel/20200219084928.28707-2-narmstrong@baylibre.com/

Neil

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index abe04f4ad7d8..3e1dfa80651d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -957,6 +957,57 @@
 						};
 					};
 
+					spicc0_x_pins: spicc0-x {
+						mux {
+							groups = "spi0_mosi_x",
+							       "spi0_miso_x",
+							       "spi0_clk_x";
+							function = "spi0";
+							drive-strength-microamp = <4000>;
+							bias-disable;
+						};
+					};
+
+					spicc0_ss0_x_pins: spicc0-ss0-x {
+						mux {
+							groups = "spi0_ss0_x";
+							function = "spi0";
+							drive-strength-microamp = <4000>;
+							bias-disable;
+						};
+					};
+
+					spicc0_c_pins: spicc0-c {
+						mux {
+							groups = "spi0_mosi_c",
+							       "spi0_miso_c",
+							       "spi0_ss0_c",
+							       "spi0_clk_c";
+							function = "spi0";
+							drive-strength-microamp = <4000>;
+							bias-disable;
+						};
+					};
+
+					spicc1_pins: spicc1 {
+						mux {
+							groups = "spi1_mosi",
+							       "spi1_miso",
+							       "spi1_clk";
+							function = "spi1";
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					spicc1_ss0_pins: spicc1-ss0 {
+						mux {
+							groups = "spi1_ss0";
+							function = "spi1";
+							drive-strength-microamp = <4000>;
+							bias-disable;
+						};
+					};
+
 					tdm_a_din0_pins: tdm-a-din0 {
 						mux {
 							groups = "tdm_a_din0";
@@ -2051,6 +2102,30 @@
 				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
 			};
 
+			spicc0: spi@13000 {
+				compatible = "amlogic,meson-g12a-spicc";
+				reg = <0x0 0x13000 0x0 0x44>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_SPICC0>,
+					 <&clkc CLKID_SPICC0_SCLK>;
+				clock-names = "core", "pclk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spicc1: spi@15000 {
+				compatible = "amlogic,meson-g12a-spicc";
+				reg = <0x0 0x15000 0x0 0x44>;
+				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_SPICC1>,
+					 <&clkc CLKID_SPICC1_SCLK>;
+				clock-names = "core", "pclk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			pwm_ef: pwm@19000 {
 				compatible = "amlogic,meson-g12a-ee-pwm";
 				reg = <0x0 0x19000 0x0 0x20>;
-- 
2.22.0

