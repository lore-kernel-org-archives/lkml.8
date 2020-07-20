Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C98C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D31320773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RtUNFEDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgGTK4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgGTK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:56:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA25C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:56:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ls15so10046623pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jsB7/zG2Zw1ViCb1957FBxqdpipMGGh3/SxIaRSDfI=;
        b=RtUNFEDVjRgv0TzEz/tvJ49cF/RkIU07clngL4wNDeLuPPmOwXha4YC3a7IPZj9Gnd
         GoEUOq9NRykz8x57FMUAZwVaS8GXFK1Jx8F8RZnaKv/57O4RnL96bYD2sTMSuaZBIgZL
         xBT8Tdjk57G7V/DoFWneQMLDLm2x9lVW7kTVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jsB7/zG2Zw1ViCb1957FBxqdpipMGGh3/SxIaRSDfI=;
        b=paQf165t7hDNwoqR4YPibxGPuuayVXe4ES+8NCycF1GLK8/bQZ/66BIgPF2hPmnMI1
         cff60ZGIuE02g2sQ+N0tXbFz7gqt4O4tiyjiiEV777K2ORaX6JmR9809YZBeZc/LvwCd
         OuGu8EBfUgDyni0xF8QvSGQIng4p8K9rLcxxnMeauRZ9k+cWB8tuWIwWeQr7PGUGTIE9
         eT+/QQhklImirnDbyHKtrTqiopgvZX0yMAVComk99wZqajc7mSHMa4pYiHdoGwag4LOC
         HGI++E0hI6L8tsyuBBXT8FYWslbSC7GNhtoU2NUqFlyXm6RPOxxXiipN/6TAqWazJXUM
         ogYg==
X-Gm-Message-State: AOAM532Ouyuh/0SSCgDUaPY6U/rV2OWlTsdmZ/+eMGn+XEP2Y14Bn9M7
        RaviyJtTGZ8I1Frb2CFQHDf+Kw==
X-Google-Smtp-Source: ABdhPJx0qGJ0CZAGE3I7RRc8YyKyBoidf1YIOIZAM2kwFQPhOwxiTs+T4p23lvnOobnqT+ThT0d7Sg==
X-Received: by 2002:a17:90a:a106:: with SMTP id s6mr22863520pjp.53.1595242571727;
        Mon, 20 Jul 2020 03:56:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8c21:db7b:4558:fba3])
        by smtp.gmail.com with ESMTPSA id j5sm13984721pgi.42.2020.07.20.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 03:56:10 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: Add Radxa ROCK Pi 4B support
Date:   Mon, 20 Jul 2020 16:25:30 +0530
Message-Id: <20200720105531.367671-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720105531.367671-1-jagan@amarulasolutions.com>
References: <20200720105531.367671-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RockPI 4B has AP6256 Wifi/BT, so enable them in 4B dts
instead of enable in common dtsi.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 23 ----------
 .../boot/dts/rockchip/rk3399-rock-pi-4b.dts   | 42 +++++++++++++++++++
 3 files changed, 43 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 42f9e1861461..8832d05c2571 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index c39334b139cc..1c55a4645b59 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -584,17 +584,6 @@ &sdio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
 	sd-uhs-sdr104;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		compatible = "brcm,bcm4329-fmac";
-		reg = <1>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
-		interrupt-names = "host-wake";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_host_wake_l>;
-	};
 };
 
 &sdmmc {
@@ -663,18 +652,6 @@ u2phy1_host: host-port {
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		clocks = <&rk808 1>;
-		clock-names = "ext_clock";
-		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
-	};
 };
 
 &uart2 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
new file mode 100644
index 000000000000..4ca970acacd3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi 4B";
+	compatible = "radxa,rockpi4", "rockchip,rk3399";
+};
+
+&sdio0 {
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+	};
+};
-- 
2.25.1

