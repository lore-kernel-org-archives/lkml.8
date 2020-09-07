Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823FC2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583832145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JxENpTaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgIGIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgIGIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:33:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C6C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:33:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so14840335wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6qLbu0TtBTfYgth1hWlAemiGy5RB2khWzOLpHhAyBI=;
        b=JxENpTaSzdENzNRSzGCLWUGLeF/XmOTECCoSk1vC7uO9L8B2ykKPDu6K64peit6pOx
         0NZvd7zEhkh1fXOsvxqTJKFnXnbgSD7qe6VT0SFEn531G+cEYazGPu5V4ViroD7XgF3p
         zU7y4SaS8J8ulJhY+h1hnwANDAcAxWHmR0lFgh83Crj3bdd/xNPFtG7aujyKaERRvuSp
         D0PrVnkrL/4KB9Luno+bGiWUcjTE6jSYNFx34Pz5B0MgMfCeR5nSSTL65snHqc+qTtk6
         mP/QJMlkNIIZ1by97c1xVA68Be+jZk11dvGB/Vvmv7xKg74HgrSY0+Ux5uZHcJbTrXym
         THFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6qLbu0TtBTfYgth1hWlAemiGy5RB2khWzOLpHhAyBI=;
        b=iV+iALXyQnaopzpc2oDmFM1l7jPTTCmT4KXu+/hm4idGVDbOrJKIYLOPChTUEyjxtX
         x028LOPrRLT4U5jFjtxEgITcRj4goqMGgmdIxlgIaePGULp/OIpdps5nFd4sHxrywgvG
         vxkxTp1s6+QT4QR5jDRsdrq1rbjTE9kxrQwnkBGqLx+fKVulkabMILUtCKcryXF3R3wY
         b+BKjpI2QXisRf6MN3BvflbK1FHECJ5hjhyL1zGHsroFjw0nOE6NG88DTrfRebvkUckl
         zdFznejk5yK4D535YB/dkdmH2tDJv2T5bwPTJp3gHu+yX76vYWn6t0MngKtexXGWXQlW
         gBOA==
X-Gm-Message-State: AOAM53137ThMU5ZCVtjOhtjnYDjJtYYnTY9BeFidUwdkZ1xRQ+XDyK/D
        c1sdbDgo8kNbYi53cATq16X81w==
X-Google-Smtp-Source: ABdhPJyLgypVdwA1Lo6t3FhgX081NBLm9msKduMOXHwEixOYFiNCnVa+gMazKFjvp9LbLHgOFoeoWQ==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr20609544wrp.168.1599467587962;
        Mon, 07 Sep 2020 01:33:07 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id o5sm25205111wmc.33.2020.09.07.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:33:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] arm64: dts: meson-axg: add MIPI DSI Nodes
Date:   Mon,  7 Sep 2020 10:32:59 +0200
Message-Id: <20200907083300.14412-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907083300.14412-1-narmstrong@baylibre.com>
References: <20200907083300.14412-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the nodes for :
- MIPI DSI+PCIe analog phy
- MIPI D-PHY
- Synopsys MIPI-DSI Transceiver

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 4a93e3fecd90..f1501b19f617 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 #include <dt-bindings/power/meson-axg-power.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -1111,6 +1112,8 @@
 			sysctrl: system-controller@0 {
 				compatible = "amlogic,meson-axg-hhi-sysctrl",
 					     "simple-mfd", "syscon";
+				#address-cells = <2>;
+				#size-cells = <2>;
 				reg = <0 0 0 0x400>;
 
 				clkc: clock-controller {
@@ -1159,6 +1162,12 @@
 							       <250000000>,
 							       <0>; /* Do Nothing */
 				};
+
+				mipi_pcie_analog_dphy: phy {
+					compatible = "amlogic,axg-mipi-pcie-analog-phy";
+					#phy-cells = <0>;
+					status = "disabled";
+				};
 			};
 		};
 
@@ -1171,6 +1180,19 @@
 			#mbox-cells = <1>;
 		};
 
+		mipi_dphy: phy@ff640000 {
+			compatible = "amlogic,axg-mipi-dphy";
+			reg = <0x0 0xff640000 0x0 0x100>;
+			clocks = <&clkc CLKID_MIPI_DSI_PHY>;
+			clock-names = "pclk";
+			resets = <&reset RESET_MIPI_PHY>;
+			reset-names = "phy";
+			phys = <&mipi_pcie_analog_dphy>;
+			phy-names = "analog";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		audio: bus@ff642000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff642000 0x0 0x2000>;
@@ -1618,6 +1640,10 @@
 			/* DPI output port */
 			dpi_port: port@2 {
 				reg = <2>;
+
+				dpi_out: endpoint {
+					remote-endpoint = <&mipi_dsi_in>;
+				};
 			};
 		};
 
@@ -1647,6 +1673,40 @@
 				#reset-cells = <1>;
 			};
 
+			mipi_dsi: dsi@7000 {
+				compatible = "amlogic,meson-axg-dw-mipi-dsi";
+				reg = <0x0 0x6000 0x0 0x400>;
+				resets = <&reset RESET_MIPI_HOST>;
+				reset-names = "top";
+				clocks = <&clkc CLKID_MIPI_DSI_HOST>,
+					 <&clkc CLKID_GP0_PLL>;
+				clock-names = "pclk", "px_clk";
+				phys = <&mipi_dphy>;
+				phy-names = "dphy";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					/* VPU VENC Input */
+					mipi_dsi_venc_port: port@0 {
+						reg = <0>;
+
+						mipi_dsi_in: endpoint {
+							remote-endpoint = <&dpi_out>;
+						};
+					};
+
+					/* DSI Output */
+					mipi_dsi_panel_port: port@1 {
+						reg = <1>;
+					};
+				};
+			};
+
 			gpio_intc: interrupt-controller@f080 {
 				compatible = "amlogic,meson-axg-gpio-intc",
 					     "amlogic,meson-gpio-intc";
-- 
2.22.0

