Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F74EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F25206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KkF5v2Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHRSpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHRSpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:45:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1335C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:45:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x6so10149308pgx.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zsbv5mvCbZha5zbAj1OK4YZ+BCUk3LROR/vz9Y6QKVA=;
        b=KkF5v2BuZGd2iCldjPP3synY06xB4ELU6I9s9TsaRG7KnLcwop4DMFGlpFTWv5Xy+X
         ofRk7La8JMG3SwdgZUGh8eAUBFeB4o/6lLw2usFOzGVPB3BlayOuITC9g6xNcMC5Eno/
         9UsIwRhcRBKGe4P2ubvHSxj/lyBPEBQFSM3Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zsbv5mvCbZha5zbAj1OK4YZ+BCUk3LROR/vz9Y6QKVA=;
        b=FXztkxOLz6Fshc1Wnxeq8LYSv2AwD5JYOj21CsMfCMR1czq1llbodpI3wL3lvjFH4W
         tcZQtT90m4fyMfo6I9t2uJFBCwZnnm3nJEoxnoeSgBYJNTXXQuYSsq+flvy3veDpIu1T
         0qSMJwIpFqsLxfjRv0T4lXqyg8aHRw0W72FE4j3j3sdlFg4rcRFBKS3+du4K+CoSUWyA
         iIvZOw60OOmjfIoO1IoLmh54AvhueBImdwNVhNZ5vaKEMztHX9jxgCTwyDtmfylQM5nx
         aGIQM/NgrJOZEqScUn0Y7DF3qHZ8S+P4OTc+uieniKYMAJL/TuhA6V0wL0ik4I8PQBme
         o6oA==
X-Gm-Message-State: AOAM5308bkRU+0/O/6sG658Y1+3g5vRpGPURtu+8YsCDWhp36bLW4jR7
        TQWZ/7CxRKmXuEInSjSjUIa7MA==
X-Google-Smtp-Source: ABdhPJzlZUhxovAfWJU6AM4joByBcaCE6DP0XKdwA0weM+mLByskkNrau/g+/nJe8iuBfpPiTSD4tw==
X-Received: by 2002:a63:d048:: with SMTP id s8mr13866840pgi.171.1597776319942;
        Tue, 18 Aug 2020 11:45:19 -0700 (PDT)
Received: from ub-XPS-13-9350.pdxnet.pdxeng.ch ([49.37.132.72])
        by smtp.gmail.com with ESMTPSA id i14sm14459022pfu.50.2020.08.18.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 11:45:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: dts: rockchip: Fix power routing to support POE
Date:   Wed, 19 Aug 2020 00:15:05 +0530
Message-Id: <20200818184505.30064-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When POE used, the current power routing is failing to power-up
the PMIC regulators which cause Linux boot hangs.

This patch is trying to update the power routing in order to
support Type C0 and POE powering methods.

As per the schematics, sys_12v is a common output power regulator
when type c and POE power being used. sys_12v is supplied by dc_12v
which is supplied from MP8859 in type c0 power routing and sys_12v
is supplied by MP8009 PoE PD in POE power supply routing.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
 .../dts/rockchip/rk3399-roc-pc-mezzanine.dts   | 18 ++++++++++++++++--
 .../arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 12 ++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
index 2acb3d500fb9..754627d97144 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
@@ -11,6 +11,16 @@ / {
 	model = "Firefly ROC-RK3399-PC Mezzanine Board";
 	compatible = "firefly,roc-rk3399-pc-mezzanine", "rockchip,rk3399";
 
+	/* MP8009 PoE PD */
+	poe_12v: poe-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "poe_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	vcc3v3_ngff: vcc3v3-ngff {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_ngff";
@@ -22,7 +32,7 @@ vcc3v3_ngff: vcc3v3-ngff {
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&sys_12v>;
 	};
 
 	vcc3v3_pcie: vcc3v3-pcie {
@@ -34,10 +44,14 @@ vcc3v3_pcie: vcc3v3-pcie {
 		pinctrl-0 = <&vcc3v3_pcie_en>;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&sys_12v>;
 	};
 };
 
+&sys_12v {
+	vin-supply = <&poe_12v>;
+};
+
 &pcie_phy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index b85ec31cd283..e7a459fa4322 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -110,6 +110,14 @@ vcc_vbus_typec0: vcc-vbus-typec0 {
 		regulator-max-microvolt = <5000000>;
 	};
 
+	sys_12v: sys-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "sys_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&dc_12v>;
+	};
+
 	/* switched by pmic_sleep */
 	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		compatible = "regulator-fixed";
@@ -141,7 +149,7 @@ vcc3v3_sys: vcc3v3-sys {
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&sys_12v>;
 	};
 
 	vcca_0v9: vcca-0v9 {
@@ -186,7 +194,7 @@ vcc_sys: vcc-sys {
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&sys_12v>;
 	};
 
 	vdd_log: vdd-log {
-- 
2.25.1

