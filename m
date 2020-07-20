Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A616C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BC322CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fcs+8Vbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgGTLD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgGTLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:03:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595FFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:03:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so9917524pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZpfzFnX8WqDOlpA9HEWnI2tpqRJdN7b0nMifIKxRt8=;
        b=fcs+8VbuWGNf1oxNKQwZnvGJPD/QaJ3RhoO4oRPf3vmjd1YMiMzi9vv38Uz6PCNdMe
         m4hJ1A0BkoIQ+teqNgXeCrWysMh9ti4WzwXOEa3ChiW7sBhPqe09KvOf10u6eujhn8U2
         PrCWj+JWfYVBZAlQ2nPP97mbMTLHVHIkSM4BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZpfzFnX8WqDOlpA9HEWnI2tpqRJdN7b0nMifIKxRt8=;
        b=N13vLtXgTN30lPFK0hvxON2M7BrHHNfMkjy5Tk7H2VQfn5iHk2m5X2p98DmabGgcHT
         0OrwV6mEz5/C4mkbbOB4AU9VCV0NwmB4wVt6QdW1NUsKkBrrO2tLLtjXeT3XxBgMrrf8
         SokSCasb6iw0iqVcTJ8UPa/Lzp+Nj57/eumh5aKhtvjNgogTm8nhbxcQF8Ok6m6oU7ml
         3kiu7VPJmBuH+Orovyqm8ICuW3FNAiSGCgk7ahkcBPpLso9EIkTKIdBoHHBOe+nEs+ML
         a73SQ6qKHP7Bk2ZISYFPaxwjqoNVVwA3+p0P1z8bnE/Wr9hf9yRt4WhbIsZ7mXIfXZ23
         BV6w==
X-Gm-Message-State: AOAM532nLC+BL6miK7Ay+Q46eSfjCBiWdtxjbZbuqY3+X/JJHo8+vONV
        G5h7ct6sz8CHFZrD3u9XGl/PfPJTEYAWZw==
X-Google-Smtp-Source: ABdhPJyYuFoGgRbx+53KR1oquEeqgi7QbPMQVW0P5UXinT7PjM14QfPFT1Gj7VUjePEdDQaAndVrug==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr18141835plq.128.1595243004882;
        Mon, 20 Jul 2020 04:03:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8c21:db7b:4558:fba3])
        by smtp.gmail.com with ESMTPSA id o10sm11445876pjs.27.2020.07.20.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 04:03:23 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add PCIe for RockPI N10
Date:   Mon, 20 Jul 2020 16:32:30 +0530
Message-Id: <20200720110230.367985-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720110230.367985-1-jagan@amarulasolutions.com>
References: <20200720110230.367985-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to enable PCIe for RockPI N10.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index ebccc4a153a2..b415b8a16c78 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -11,6 +11,19 @@
 
 / {
 	compatible = "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
+
+
+	vcc3v3_pcie: vcc-pcie-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_pwr>;
+		regulator-name = "vcc3v3_pcie";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &cpu_l0 {
@@ -142,7 +155,8 @@ vcca_0v9: LDO_REG1 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-state-mem {
-					regulator-off-in-suspend;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
 				};
 			};
 
@@ -177,7 +191,8 @@ vcca_1v8: LDO_REG4 {
 				regulator-min-microvolt = <1850000>;
 				regulator-max-microvolt = <1850000>;
 				regulator-state-mem {
-					regulator-off-in-suspend;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1850000>;
 				};
 			};
 
@@ -304,6 +319,22 @@ &io_domains {
 	sdmmc-supply = <&vccio_sd>;
 };
 
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	max-link-speed = <2>;
+	num-lanes = <4>;
+	pinctrl-0 = <&pcie_clkreqnb_cpm>;
+	pinctrl-names = "default";
+	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
+	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
@@ -311,6 +342,12 @@ hym8563_int: hym8563-int {
 		};
 	};
 
+	pcie {
+		pcie_pwr: pcie-pwr {
+			rockchip,pins =	<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <1 RK_PC2 0 &pcfg_pull_up>;
-- 
2.25.1

