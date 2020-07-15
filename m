Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056ACC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA13820672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YYbdkIb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgGOIeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgGOIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:34:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s26so1783556pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjN8zayeMZG2DU4GzukY5NcBfZcnl9ozMGccHHoLtc4=;
        b=YYbdkIb4NzCVM5ThpHJVKE+9NAsXOXJTj+D6B8nmH5lQdIEXveNyFBeVGCzWHF4Cae
         7afdV4DglRasGGq/V++HxOQzigizkffo3+SKyy8UVaZ7uYW8vs24JXdcLBvn026paZPk
         UGv0PDNSEyd42/LE12glkZusDFK4hpCRLnFXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjN8zayeMZG2DU4GzukY5NcBfZcnl9ozMGccHHoLtc4=;
        b=llpqoEWl3W/ql8YCAdX8crFvD+2I5P1burh7eLgXHLdGABZTBMK1qXRvWfrObzkzSV
         dNNBFLAUMvSoCaTMX6/N+jbj8+vt15fgMDk/+6ZcLskZ5j6iNNl3HbuWHHhT79M5m2ka
         iLGCQ+2BQ8adTQmtwi90BuFswaI7asfF/5cDerJsfLjnsHiIRe5RNx3PtAhfAOO+6hkL
         uT+YgJpx4HwnQznVTbHia5dhK22hEeX/vZXPcsOdetErvn7Q0y2T9Df1b79n+Gx6nJ+B
         4zUWMO65z7mx43AJctKLtkIJC7LCjxAg0YD+NExLMDSrPbIr0uP0k3tOW0im3vS9V19h
         CLKQ==
X-Gm-Message-State: AOAM530Imq+OEqEndM6GTjOhomizrCVrK5Y172RiNta7SHm4WUvPjhWY
        O6DMxxSZT/PILNPqbB7935idng==
X-Google-Smtp-Source: ABdhPJzY09Yixyw9mcn93UTId1G4FU8OwXFbvjOYbJonZQY2YfJnqUJgR/gCMvQikYHIyDgK1dR9fA==
X-Received: by 2002:a62:1b4e:: with SMTP id b75mr7485926pfb.33.1594802085172;
        Wed, 15 Jul 2020 01:34:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9887:56a8:c916:cfdb])
        by smtp.gmail.com with ESMTPSA id m92sm1467584pje.13.2020.07.15.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:34:44 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 1/7] ARM: dts: rockchip: dalang-carrier: Move i2c nodes into SOM
Date:   Wed, 15 Jul 2020 14:04:12 +0530
Message-Id: <20200715083418.112003-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715083418.112003-1-jagan@amarulasolutions.com>
References: <20200715083418.112003-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C nodes and associated slave devices defined in Carrier board
are specific to rk3399pro vmrac SOM.

So, move them into SOM dtsi.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- spilt of previous version Trivial patch

 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 32 -------------------
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 29 +++++++++++++++++
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index df3712aedf8a..176b53b8e41a 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -17,29 +17,6 @@ &gmac {
 	status = "okay";
 };
 
-&i2c1 {
-	status = "okay";
-	i2c-scl-rising-time-ns = <140>;
-	i2c-scl-falling-time-ns = <30>;
-};
-
-&i2c2 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	hym8563: hym8563@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "hym8563";
-		pinctrl-names = "default";
-		pinctrl-0 = <&hym8563_int>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
 &pwm0 {
 	status = "okay";
 };
@@ -70,12 +47,3 @@ &uart0 {
 &uart2 {
 	status = "okay";
 };
-
-&pinctrl {
-	hym8563 {
-		hym8563_int: hym8563-int {
-			rockchip,pins =
-				<4 RK_PD6 0 &pcfg_pull_up>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 0a516334f15f..e11538171e67 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -297,6 +297,29 @@ regulator-state-mem {
 	};
 };
 
+&i2c1 {
+	i2c-scl-falling-time-ns = <30>;
+	i2c-scl-rising-time-ns = <140>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	hym8563: hym8563@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD6 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcca_1v8>;
@@ -324,6 +347,12 @@ &tsadc {
 };
 
 &pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <4 RK_PD6 0 &pcfg_pull_up>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins =
-- 
2.25.1

