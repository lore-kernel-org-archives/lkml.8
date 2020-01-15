Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CBC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D58E24681
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3Yvbzc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAOSw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:52:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39428 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:52:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so16796594wrt.6;
        Wed, 15 Jan 2020 10:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fKeq8tFcSLHJkn6QSQqYD/5g8utINbdDLtdwNyNEqW4=;
        b=g3Yvbzc2/oSJbfhTH6JaJp2Qe9E1DGE7f7QjCd+z+Ij4tcyCxl2FfLxNq2ZV2xJMb/
         an7c+Akg/FwWYUEcDwDw/vfxSgZkYEB+XRpPDDjkIjuNe8KTJuggT0go8chdesQzK41r
         ScQiU7ArJmzpm1pobwp2EjOhJRgd6/K5chAGj+FzLtbbHKR0mG4umBN+XrYBkPcD3Vgm
         Mpj6e/oVvYZjUFwusNQ/0b4oCMDU4EdrfCdcTy+oy1HoJ5ysZUjfghfLg8myoqx6MRm+
         Dc0BPvdGD7VvS8+mn5tPHWl2E45CBef30B3QEYk8+C7lGCvrqwp1HSYF05PnEdYDBcF4
         o4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fKeq8tFcSLHJkn6QSQqYD/5g8utINbdDLtdwNyNEqW4=;
        b=MIyxSWY/wsTfJxstlidRA8CjHCdnhG/hf06pYRhSzlVwqTzu2GGFnYziFGK/jTyvg6
         Q1Itc5kypRfUHf5uqD0STj1RbvkKP0D/cryZEHJEx5fjEcyXV6ifZTqaMYc43vtopQJG
         sRglphW5bO7nGD0rPij33/JJAqN2h9HcnieMKqnq0G6ctKJ5fhRW6WO7FcGqVF9MsKVg
         GXWFF1rgoangbBkZaVBjZXhtdaJ2cbs62GhH8mnRaTvaC1aCZqS8lSYfav8E3HYGVHHD
         6ETElIiAjbURMrdgOvvWaeTndhurjWVS4umNEyQk5gHNPlW9TU4dVHqG7TnVQ9q0mXiW
         24yQ==
X-Gm-Message-State: APjAAAWXOneELfsMd/ZSDBruxRO7CPN0xRgU8h2bzwDHb7ehh/05T6lP
        bN6eAplfC66ICi63g9EiaFE=
X-Google-Smtp-Source: APXvYqzkLZfz2dbHy4Hqedrh3BrPKB+8frv2Otn76ljLVvnsbG51oSX9N6Z8/7bKT/Porz+sJ+Xf4w==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr33079769wrw.31.1579114373365;
        Wed, 15 Jan 2020 10:52:53 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i5sm26296759wrv.34.2020.01.15.10.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:52:53 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: rename dwmmc node names to mmc
Date:   Wed, 15 Jan 2020 19:52:44 +0100
Message-Id: <20200115185244.18149-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200115185244.18149-1-jbx6244@gmail.com>
References: <20200115185244.18149-1-jbx6244@gmail.com>
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
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 07fe187cf..32e752312 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -879,7 +879,7 @@
 		status = "disabled";
 	};
 
-	sdmmc: dwmmc@ff370000 {
+	sdmmc: mmc@ff370000 {
 		compatible = "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff370000 0x0 0x4000>;
 		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
@@ -894,7 +894,7 @@
 		status = "disabled";
 	};
 
-	sdio: dwmmc@ff380000 {
+	sdio: mmc@ff380000 {
 		compatible = "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff380000 0x0 0x4000>;
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
@@ -909,7 +909,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@ff390000 {
+	emmc: mmc@ff390000 {
 		compatible = "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff390000 0x0 0x4000>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index fa0d55f1a..116f1900e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -584,7 +584,7 @@
 		status = "disabled";
 	};
 
-	sdmmc: dwmmc@ff480000 {
+	sdmmc: mmc@ff480000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff480000 0x0 0x4000>;
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -599,7 +599,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@ff490000 {
+	emmc: mmc@ff490000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff490000 0x0 0x4000>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -612,7 +612,7 @@
 		status = "disabled";
 	};
 
-	sdio: dwmmc@ff4a0000 {
+	sdio: mmc@ff4a0000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff4a0000 0x0 0x4000>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 91306ebed..acfaefdd3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -837,7 +837,7 @@
 		};
 	};
 
-	sdmmc: dwmmc@ff500000 {
+	sdmmc: mmc@ff500000 {
 		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff500000 0x0 0x4000>;
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
@@ -849,7 +849,7 @@
 		status = "disabled";
 	};
 
-	sdio: dwmmc@ff510000 {
+	sdio: mmc@ff510000 {
 		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff510000 0x0 0x4000>;
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
@@ -861,7 +861,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@ff520000 {
+	emmc: mmc@ff520000 {
 		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff520000 0x0 0x4000>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index fd8618801..a0df61c61 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -204,7 +204,7 @@
 		#clock-cells = <0>;
 	};
 
-	sdmmc: dwmmc@ff0c0000 {
+	sdmmc: mmc@ff0c0000 {
 		compatible = "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff0c0000 0x0 0x4000>;
 		max-frequency = <150000000>;
@@ -218,7 +218,7 @@
 		status = "disabled";
 	};
 
-	sdio0: dwmmc@ff0d0000 {
+	sdio0: mmc@ff0d0000 {
 		compatible = "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff0d0000 0x0 0x4000>;
 		max-frequency = <150000000>;
@@ -232,7 +232,7 @@
 		status = "disabled";
 	};
 
-	emmc: dwmmc@ff0f0000 {
+	emmc: mmc@ff0f0000 {
 		compatible = "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff0f0000 0x0 0x4000>;
 		max-frequency = <150000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e62ea0e2b..ed654758c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -291,7 +291,7 @@
 		status = "disabled";
 	};
 
-	sdio0: dwmmc@fe310000 {
+	sdio0: mmc@fe310000 {
 		compatible = "rockchip,rk3399-dw-mshc",
 			     "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe310000 0x0 0x4000>;
@@ -307,7 +307,7 @@
 		status = "disabled";
 	};
 
-	sdmmc: dwmmc@fe320000 {
+	sdmmc: mmc@fe320000 {
 		compatible = "rockchip,rk3399-dw-mshc",
 			     "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe320000 0x0 0x4000>;
-- 
2.11.0

