Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED76EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C64206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wvjeMK7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635482AbgDPMV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635263AbgDPMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:19:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CBAC03C1A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:19:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so4541394wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06VGvFqoKzw4MknpDhao8YAaiP1E4E7GXSjBetVzutg=;
        b=wvjeMK7HR4FoRHPkWHI0bxnUL93aaV365SmQNatQtaw6gD3FR2FadqzhJwPwOEivCF
         0casg7mHUSwwwsrR4bgTCmGiHJsO/Tc52BodFaE86fFetRn7E77aS1EIxp7bqgwxbzbe
         +JXZ8G0sREMF0hvytrr0YztLvWAVLHaDSaOkSrZoErYY+pCWw70SP9mVsF7J9AsfOg45
         ZJVDvIyT7NKZAvSDqYjNU157edpdWL+eqI+mqTihmHZb8xJHKbswUoSU2QhVCDxe0UJm
         t5sYc/CVDPFSnFCj/CQwjELlOLu5wNHjzvjrpCSpNzKXn0wNeBn+pRQzUxOxwILmt1Md
         z2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06VGvFqoKzw4MknpDhao8YAaiP1E4E7GXSjBetVzutg=;
        b=jgIlIcec4IRM3KKggTWuQX59j7Rg2ETaee3p2hANJruW0VJ4oT9ldOYLmRHlRgdGdB
         7Qt0AHma6UtMj+t8OX1M5Xr8G/AflGM7kdkLFyKlBv9oJGIKN36T9dYQIFV+jSTyise9
         Av/boGWYbhMntAtU6LGTLbq/6CRNpOKZuOPcZjuYpT8oTQjz7uhM9Ek228Lu4FWDLc1o
         MlqF9JHJ92QnA17cm6dCr1b4UoVwyE9Gr7tMnX+UunSVPlRKaJnCELT+WgYsfUbXfQY4
         y8a035u4horVxhbmeqbnVkh6wZ1VtfQz/jbv1K4bEkylz3ttnbn54GlvyP/rBNRuAh3a
         7AeA==
X-Gm-Message-State: AGi0PuaIC+hH+mJ57Viu0ccJccn1mJVhLdMnwh83oQkYjKPL9DgUzPB2
        6ceuiIu/bO1gAzUf9QmsAt35gA==
X-Google-Smtp-Source: APiQypKDTddSSH2JXLBwj7aK/XAzpbQoRwIA7O2CRlO23e0BOWPclA7dY1h9ztPZ6WPcQVQezZGSSQ==
X-Received: by 2002:a5d:48cc:: with SMTP id p12mr36460646wrs.170.1587039561826;
        Thu, 16 Apr 2020 05:19:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i13sm22035602wro.50.2020.04.16.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 05:19:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 4/8] arm64: dts: amlogic: use the new USB control driver for GXL and GXM
Date:   Thu, 16 Apr 2020 14:19:06 +0200
Message-Id: <20200416121910.12723-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416121910.12723-1-narmstrong@baylibre.com>
References: <20200416121910.12723-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Add the correcly architectured USB Glue node and adapt all the Amlogic
GXL and GXM board to the new organization.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../dts/amlogic/meson-gx-libretech-pc.dtsi    |  3 +-
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |  3 +-
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  |  3 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts |  3 +-
 .../amlogic/meson-gxl-s905d-phicomm-n1.dts    |  4 ++
 .../boot/dts/amlogic/meson-gxl-s905w-p281.dts |  4 ++
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  4 ++
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    |  4 ++
 .../amlogic/meson-gxl-s905x-libretech-cc.dts  |  3 +-
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |  3 +-
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     |  3 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    | 45 ++++++++++---------
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     |  3 +-
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  |  3 +-
 .../boot/dts/amlogic/meson-gxm-vega-s96.dts   |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    |  7 ++-
 16 files changed, 68 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
index 248b018c83d5..ed9f89ee86a8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -360,8 +360,9 @@
 	status = "okay";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usb2_phy0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 12d5e333e5f2..d853981f1ab5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -223,6 +223,7 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "otg";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 4d5949496596..2cfea3094f6c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -243,6 +243,7 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index a1119cfb0280..867e30f1d62b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -216,6 +216,7 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
index b5667f1fb2c8..9ef210f17b4a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
@@ -29,3 +29,7 @@
 &cvbs_vdac_port {
 	status = "disabled";
 };
+
+&usb {
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
index 6509c4950950..ecc9df7ca023 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
@@ -20,3 +20,7 @@
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 };
+
+&usb {
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
index dd729ac2300d..6705c2082a78 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
@@ -24,3 +24,7 @@
 &ir {
 	linux,rc-map-name = "rc-tanix-tx3mini";
 };
+
+&usb {
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 440bc23c7342..8bcdffdf55d0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -207,3 +207,7 @@
 	pinctrl-0 = <&uart_ao_b_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index e8348b2728db..e493831a80f0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -272,8 +272,9 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usb2_phy0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 62dd87821ce5..f1acca5c4434 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -218,6 +218,7 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 6ac678f88bd8..05cb2f5e5c36 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -195,8 +195,9 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usb2_phy0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 259d86399390..95b301a7c725 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -14,26 +14,43 @@
 	compatible = "amlogic,meson-gxl";
 
 	soc {
-		usb0: usb@c9000000 {
-			status = "disabled";
-			compatible = "amlogic,meson-gxl-dwc3";
+		usb: usb@d0078080 {
+			compatible = "amlogic,meson-gxl-usb-ctrl";
+			reg = <0x0 0xd0078080 0x0 0x20>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
 
-			clocks = <&clkc CLKID_USB>;
-			clock-names = "usb_general";
+			clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1_DDR_BRIDGE>;
+			clock-names = "usb_ctrl", "ddr";
 			resets = <&reset RESET_USB_OTG>;
-			reset-names = "usb_otg";
 
-			dwc3: dwc3@c9000000 {
+			dr_mode = "otg";
+
+			phys = <&usb2_phy0>, <&usb2_phy1>;
+			phy-names = "usb2-phy0", "usb2-phy1";
+
+			dwc2: usb@c9100000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xc9100000 0x0 0x40000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_USB1>;
+				clock-names = "otg";
+				phys = <&usb2_phy1>;
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+
+			dwc3: usb@c9000000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xc9000000 0x0 0x100000>;
 				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				maximum-speed = "high-speed";
 				snps,dis_u2_susphy_quirk;
-				phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>;
 			};
 		};
 
@@ -71,18 +88,6 @@
 		reset-names = "phy";
 		status = "okay";
 	};
-
-	usb3_phy: phy@78080 {
-		compatible = "amlogic,meson-gxl-usb3-phy";
-		#phy-cells = <0>;
-		reg = <0x0 0x78080 0x0 0x20>;
-		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clkc CLKID_USB>, <&clkc_AO CLKID_AO_CEC_32K>;
-		clock-names = "phy", "peripheral";
-		resets = <&reset RESET_USB_OTG>, <&reset RESET_USB_OTG>;
-		reset-names = "phy", "peripheral";
-		status = "okay";
-	};
 };
 
 &efuse {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 27eeab71ec77..bff8ec2c1c70 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -380,6 +380,7 @@
 	vref-supply = <&vddio_ao18>;
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index c2bd4dbbf38c..83eca3af44ce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -179,6 +179,7 @@
 	pinctrl-names = "default";
 };
 
-&usb0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
index 0bdf51d041ae..d3fdba4da9a6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
@@ -39,3 +39,7 @@
 &ir {
 	linux,rc-map-name = "rc-vega-s9x";
 };
+
+&usb {
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index b6f89f108e28..40e3e123e05b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -169,8 +169,11 @@
 	compatible = "amlogic,meson-gxm-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
 };
 
-&dwc3 {
-	phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>, <&usb2_phy2>;
+&usb {
+	compatible = "amlogic,meson-gxm-usb-ctrl";
+
+	phy-names = "usb2-phy0", "usb2-phy1", "usb2-phy2";
+	phys = <&usb2_phy0>, <&usb2_phy1>, <&usb2_phy2>;
 };
 
 &vdec {
-- 
2.22.0

