Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9811120720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464428;
	bh=Lh3dzYXSrs+vBBw5yfOr7+OhUwSsd0+MyH/UH8tKOb0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aH6Kh+PdrYuPqVKJy4B1jPmlsdd4Cqrr68zjiHPbx2XMSyHXCuRrCrxy1PLayAp2A
	 /FjKS48rITYnpKo0s+VY8mWv0JUxFaImdEMe1HExH6vbx8JyVkHByV9c2hqe10FXxC
	 PO9I5xboY8te2bsd3jgnx1rpJGtPm3sWxie3jsws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbgF2VA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387950AbgF2VAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:00:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E9B20720;
        Mon, 29 Jun 2020 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593464421;
        bh=Lh3dzYXSrs+vBBw5yfOr7+OhUwSsd0+MyH/UH8tKOb0=;
        h=From:To:Cc:Subject:Date:From;
        b=kupGB0hbbgG6pMG1gVN5xphVJj+12dZ1xKSPlkX2A8B6AmtuglmspwxWi1U8a7rmS
         79mcXRtRF3gL6cFZeOQ88ZKlMAQRyq8JphSQAhpOrzMsGg4cIhhTiJ1cvYqesf+Pql
         PN7vnxw4+JHTNM1V+rrxLS8broP9JfjrOo74VD3Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] ARM: dts: exynos: Fix missing empty reg/ranges property regulators on Trats
Date:   Mon, 29 Jun 2020 22:59:48 +0200
Message-Id: <20200629205948.32250-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the regulators node entirely because its children do not have any
unit addresses.  This fixes DTC warning:

    Warning (simple_bus_reg): /regulators/regulator-0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove the node, not only compatible, as pointed out by Sylwester.
---
 arch/arm/boot/dts/exynos4210-trats.dts | 98 ++++++++++++--------------
 1 file changed, 47 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 3d791db6095c..5cc96f04a4fa 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -30,62 +30,58 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		vemmc_reg: regulator-0 {
-			compatible = "regulator-fixed";
-			regulator-name = "VMEM_VDD_2.8V";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			gpio = <&gpk0 2 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	vemmc_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VMEM_VDD_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpk0 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		tsp_reg: regulator-1 {
-			compatible = "regulator-fixed";
-			regulator-name = "TSP_FIXED_VOLTAGES";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	tsp_reg: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "TSP_FIXED_VOLTAGES";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		cam_af_28v_reg: regulator-2 {
-			compatible = "regulator-fixed";
-			regulator-name = "8M_AF_2.8V_EN";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			gpio = <&gpk1 1 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	cam_af_28v_reg: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "8M_AF_2.8V_EN";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpk1 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		cam_io_en_reg: regulator-3 {
-			compatible = "regulator-fixed";
-			regulator-name = "CAM_IO_EN";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			gpio = <&gpe2 1 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	cam_io_en_reg: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "CAM_IO_EN";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpe2 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		cam_io_12v_reg: regulator-4 {
-			compatible = "regulator-fixed";
-			regulator-name = "8M_1.2V_EN";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			gpio = <&gpe2 5 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	cam_io_12v_reg: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "8M_1.2V_EN";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		gpio = <&gpe2 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		vt_core_15v_reg: regulator-5 {
-			compatible = "regulator-fixed";
-			regulator-name = "VT_CORE_1.5V";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
-			gpio = <&gpe2 2 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	vt_core_15v_reg: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "VT_CORE_1.5V";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		gpio = <&gpe2 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	gpio-keys {
-- 
2.17.1

