Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460BDC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148242084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOf0Dy5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAOSwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:52:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37763 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAOSwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:52:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so16832252wru.4;
        Wed, 15 Jan 2020 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZKbkfQFGcDjwsClT1OKqzInSbgiQQ9mGLFaz9bGeYd4=;
        b=AOf0Dy5Fon60mpk9fYvpXhjPf7hixSrjiVwgONswX+BJ8gWUDq/uHcM2K5eRbkAiwv
         8THTdT1rXx9bK44xOZ1ZBl4M9ciSmt4yKo49OsGp0mK9NF1wQ8a2K6oqiKeWq4ggf0qi
         lI1kmOB1Pnexkje26KK6JkCAxWXhaw4ymLKQK142EVGl9t0ptvNE1Rgjvb26KSUQcQrR
         881ghRw/MXSApVG4ou2o4yu2+oW4sxxBW919SCLhEcNGbrL4H/i65xdwIythdo7KRl5n
         mKaJx/zFPu1qsXXy17Hi9kAEYySnT/1+qNIr+aUoxib3+VZ6eYq/uCzHVV3Z1UytG5Wg
         eBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZKbkfQFGcDjwsClT1OKqzInSbgiQQ9mGLFaz9bGeYd4=;
        b=f2rZhrNC9dYYwTvONA0kTnNgBRTaPFPU1RdTLrdSoN6FZLjznwVocxH7HV7yO84Pe3
         obK4sac/zd475szw930gw9SslrFliP3UgEsF/xFBHpDANmWNJo2CEj9vXF00V61WTU+A
         l/5PlKSmq7mfmxl97px0wIoGNNuqHrDFcsqMHVZl6LWoQgT+KHHx3smiHyRHQic3CCL3
         h4cdqI7qgI+IuC/mlwsuOS8AQsF1Mxsygt8OQfKenaJ0m+kABHzWKJI2LS+knisiwJhU
         wKfexoF3xUrD12/ip6nY2x1HHTpY5t+AnfvcamY5wM7FFAFk4TUUUrASXNEi1FM+fojr
         vbXA==
X-Gm-Message-State: APjAAAWdot4wx1iWBSTnzztPRbYQrWIWO9aNAe/R2t0/tliqs2Mwdvmd
        nivkpIErmiuir2MvzdYDWR4=
X-Google-Smtp-Source: APXvYqxV12+42V6D8tiScZA75LHa8aUfF3oUkAivjr11wUSnWolsYdOchApqGdsdwKamXM031jFVvQ==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr31825959wro.56.1579114372394;
        Wed, 15 Jan 2020 10:52:52 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i5sm26296759wrv.34.2020.01.15.10.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:52:51 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: rename dwmmc node names to mmc
Date:   Wed, 15 Jan 2020 19:52:43 +0100
Message-Id: <20200115185244.18149-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'dwmmc' nodes are manually verified.
In order to automate this process rockchip-dw-mshc.txt
has to be converted to yaml. In the new setup
rockchip-dw-mshc.yaml will inherit properties from
mmc-controller.yaml and synopsys-dw-mshc-common.yaml.
'dwmmc' will no longer be a valid name for a node,
so change them all to 'mmc'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 6 +++---
 arch/arm/boot/dts/rk322x.dtsi | 6 +++---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 arch/arm/boot/dts/rk3xxx.dtsi | 6 +++---
 arch/arm/boot/dts/rv1108.dtsi | 6 +++---
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index c70182c5a..cf36e2519 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -224,7 +224,7 @@
 		status = "disabled";
 	};
 
-	sdmmc: dwmmc@10214000 {
+	sdmmc: mmc@10214000 {
 		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10214000 0x4000>;
 		clock-frequency = <37500000>;
@@ -238,7 +238,7 @@
 		status = "disabled";
 	};
 
-	sdio: dwmmc@10218000 {
+	sdio: mmc@10218000 {
 		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10218000 0x4000>;
 		max-frequency = <37500000>;
@@ -252,7 +252,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@1021c000 {
+	emmc: mmc@1021c000 {
 		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x1021c000 0x4000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 340ed6ccb..4e90efdc9 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -662,7 +662,7 @@
 		};
 	};
 
-	sdmmc: dwmmc@30000000 {
+	sdmmc: mmc@30000000 {
 		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30000000 0x4000>;
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
@@ -675,7 +675,7 @@
 		status = "disabled";
 	};
 
-	sdio: dwmmc@30010000 {
+	sdio: mmc@30010000 {
 		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30010000 0x4000>;
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
@@ -688,7 +688,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@30020000 {
+	emmc: mmc@30020000 {
 		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30020000 0x4000>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 415c75f57..9beb66216 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -247,7 +247,7 @@
 		ports = <&vopl_out>, <&vopb_out>;
 	};
 
-	sdmmc: dwmmc@ff0c0000 {
+	sdmmc: mmc@ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
@@ -261,7 +261,7 @@
 		status = "disabled";
 	};
 
-	sdio0: dwmmc@ff0d0000 {
+	sdio0: mmc@ff0d0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
@@ -275,7 +275,7 @@
 		status = "disabled";
 	};
 
-	sdio1: dwmmc@ff0e0000 {
+	sdio1: mmc@ff0e0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>,
@@ -289,7 +289,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@ff0f0000 {
+	emmc: mmc@ff0f0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		max-frequency = <150000000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 97307a405..241f43e29 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -231,7 +231,7 @@
 		status = "disabled";
 	};
 
-	mmc0: dwmmc@10214000 {
+	mmc0: mmc@10214000 {
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10214000 0x1000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
@@ -245,7 +245,7 @@
 		status = "disabled";
 	};
 
-	mmc1: dwmmc@10218000 {
+	mmc1: mmc@10218000 {
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10218000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
@@ -259,7 +259,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@1021c000 {
+	emmc: mmc@1021c000 {
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x1021c000 0x1000>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 5876690ee..1fd06e7cb 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -456,7 +456,7 @@
 		#reset-cells = <1>;
 	};
 
-	emmc: dwmmc@30110000 {
+	emmc: mmc@30110000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30110000 0x4000>;
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
@@ -468,7 +468,7 @@
 		status = "disabled";
 	};
 
-	sdio: dwmmc@30120000 {
+	sdio: mmc@30120000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30120000 0x4000>;
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
@@ -480,7 +480,7 @@
 		status = "disabled";
 	};
 
-	sdmmc: dwmmc@30130000 {
+	sdmmc: mmc@30130000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30130000 0x4000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0

