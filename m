Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2120C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC526206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qVwuQ94E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgDUQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729229AbgDUQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:39:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8217EC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so4451186wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSq+1dY+s2wqxJXpzBejZpUD2cmQ/ZnOcfRfM3+zRhM=;
        b=qVwuQ94EVKJNM5c4/L7Lq0dWLPAS3S5he/E8AN2JESJwREN7swYVQFZo6N0+H0DpIY
         6lk/Fuazohmex7z6sh1Vb623QDDHdcY3AldEo2PhoJVnAIV3s9oAe8sm4XwjPMWFWJLz
         m3jDyFijpDtAa9EM1UIhMXAWeE3eQecde6TusuSY8fqzYO+7zVxoELV0Zzi74fAhvsKf
         LAnUf0UHW7qt70FpcyRQGFeyQ+JJYFo4dQ5lk0io+Suyrf5KC9YRCokQ3WZiL27Qdsv+
         vSS17j3siMe/SIXtByoT6Vjq7CSUbXnMVyVoQ01PHuwgwMYZIJppaogSDZ5MBd+VyJjC
         iwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSq+1dY+s2wqxJXpzBejZpUD2cmQ/ZnOcfRfM3+zRhM=;
        b=MYSYc0P2iMH9SA8eAYzZMSHjS9W2DbTR6Xe3qMx+xNGhoXDgLal6qfuShKPVmjew44
         SKYMxFNiUfFQnTGqCF1GLeBZZ1I6nqnjjHFQxVl2n6isc+X0JHRfhJz4xG2lO4wzoKaQ
         W1nQjBTtdXxfn0UXLoMQ6zwBZ8+6isruelwGgismjCtqfZG0SX2jEUpQbIlsrLGmhLs1
         1JPfm7pS9MjAZwM1onSSTr+hLR65Je+sVprqzsVJkyAhcbweHEvKp5SqFW0qnbR2JtWa
         kyBFe8UWWSds+k9Yk8l4NXWCITwScbuuZJxx2cfT+VRr+hHGIcybbjbVNpzZGEMpuchN
         MvcQ==
X-Gm-Message-State: AGi0PubIarewQw70/v/jYmvpGOt/3ucD3hvjlCsyjXRGOp/psk/qjLtL
        iLmHq1fAcZSxGCcOoooHANFvlTvPwAY=
X-Google-Smtp-Source: APiQypKp5LX/dlC8rFMls5G6cEKKafXN01MeK8ZE1Tn9jhSLH4l0aCCuLRtXEmonmT6Y6Yh8sa7fUQ==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr5756984wmm.104.1587487182212;
        Tue, 21 Apr 2020 09:39:42 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 33sm4578513wrp.5.2020.04.21.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:39:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: meson-gx: add aiu support
Date:   Tue, 21 Apr 2020 18:39:31 +0200
Message-Id: <20200421163935.775935-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421163935.775935-1-jbrunet@baylibre.com>
References: <20200421163935.775935-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the AIU audio device to the Amlogic GX SoC family DT.
ATM, this device provides the i2s and spdif output stages and also
the hdmi and internal codec glues.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 13 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 23 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 23 +++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 03f79fe045b7..a8dc8f810253 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -278,6 +278,17 @@ reset: reset-controller@4404 {
 				#reset-cells = <1>;
 			};
 
+			aiu: audio-controller@5400 {
+				compatible = "amlogic,aiu";
+				#sound-dai-cells = <2>;
+				sound-name-prefix = "AIU";
+				reg = <0x0 0x5400 0x0 0x2ac>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "i2s", "spdif";
+				status = "disabled";
+			};
+
 			uart_A: serial@84c0 {
 				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x84c0 0x0 0x18>;
@@ -626,6 +637,8 @@ hdmi_tx: hdmi-tx@c883a000 {
 			interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "HDMITX";
 			status = "disabled";
 
 			/* VPU VENC Input */
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 0cb40326b0d3..234490d3ee68 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -60,6 +60,29 @@ usb1: usb@c9100000 {
 	};
 };
 
+&aiu {
+	compatible = "amlogic,aiu-gxbb", "amlogic,aiu";
+	clocks = <&clkc CLKID_AIU_GLUE>,
+		 <&clkc CLKID_I2S_OUT>,
+		 <&clkc CLKID_AOCLK_GATE>,
+		 <&clkc CLKID_CTS_AMCLK>,
+		 <&clkc CLKID_MIXER_IFACE>,
+		 <&clkc CLKID_IEC958>,
+		 <&clkc CLKID_IEC958_GATE>,
+		 <&clkc CLKID_CTS_MCLK_I958>,
+		 <&clkc CLKID_CTS_I958>;
+	clock-names = "pclk",
+		      "i2s_pclk",
+		      "i2s_aoclk",
+		      "i2s_mclk",
+		      "i2s_mixer",
+		      "spdif_pclk",
+		      "spdif_aoclk",
+		      "spdif_mclk",
+		      "spdif_mclk_sel";
+	resets = <&reset RESET_AIU>;
+};
+
 &aobus {
 	pinctrl_aobus: pinctrl@14 {
 		compatible = "amlogic,meson-gxbb-aobus-pinctrl";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 259d86399390..d9f00c5a9a5c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -49,6 +49,29 @@ crypto: crypto@c883e000 {
 	};
 };
 
+&aiu {
+	compatible = "amlogic,aiu-gxl", "amlogic,aiu";
+	clocks = <&clkc CLKID_AIU_GLUE>,
+		 <&clkc CLKID_I2S_OUT>,
+		 <&clkc CLKID_AOCLK_GATE>,
+		 <&clkc CLKID_CTS_AMCLK>,
+		 <&clkc CLKID_MIXER_IFACE>,
+		 <&clkc CLKID_IEC958>,
+		 <&clkc CLKID_IEC958_GATE>,
+		 <&clkc CLKID_CTS_MCLK_I958>,
+		 <&clkc CLKID_CTS_I958>;
+	clock-names = "pclk",
+		      "i2s_pclk",
+		      "i2s_aoclk",
+		      "i2s_mclk",
+		      "i2s_mixer",
+		      "spdif_pclk",
+		      "spdif_aoclk",
+		      "spdif_mclk",
+		      "spdif_mclk_sel";
+	resets = <&reset RESET_AIU>;
+};
+
 &apb {
 	usb2_phy0: phy@78000 {
 		compatible = "amlogic,meson-gxl-usb2-phy";
-- 
2.25.2

