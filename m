Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A61C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EEB2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593801911;
	bh=VOTi1V2zpkYNZEtWGYLh7ChvI2/wVXR9VoyMzyTCcfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TtksnujoY1pIDPxIVilUXf/yLP7FTIW5Qn1Im2CYpAUDWRN7j2G+qTMNmO4/QoY1U
	 5wXhSCwuqRNyk/kQeyktN9KsqP/sf7yLdhb12Bbvy2qKcBcSMkzAQ9jP4VyynG1D+I
	 CaTUwXTCLZcsBykqRltFm9bGdtlqi9YkbMzczl8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGCSpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgGCSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:45:08 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D20242084C;
        Fri,  3 Jul 2020 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593801908;
        bh=VOTi1V2zpkYNZEtWGYLh7ChvI2/wVXR9VoyMzyTCcfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDukjuyUkFjF3oBik86tY+eZc0sVKGM9gFvfH9FujniO+XFg3xJOVdomLKi2n7Jc6
         kfx0ikweHXe1ZX7wsCLQtjYx9+/NG/I0Iex7Q9xDOO7xTpbLX1Sttz4x7FpO+WguTs
         7TxPRxHBI/59QNf5XtSi5rcmTg+p/WWLHo4Oj9ek=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v3 3/3] ARM: dts: exynos: Define fixed regulators in root node for consistency in SMDK5420
Date:   Fri,  3 Jul 2020 20:44:51 +0200
Message-Id: <20200703184451.19535-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703184451.19535-1-krzk@kernel.org>
References: <20200703184451.19535-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the regulators node and define fixed regulators directly under
the root node.  This makes SMDK5420 board consistent with other Exynos
boards.

Name the fixed regulator nodes consistently.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Remove also "reg" property

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts | 53 ++++++++++-------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index e3f2afe8359a..83fa800fa1eb 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -32,40 +32,31 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vdd: fixed-regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "vdd-supply";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
+	vdd: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 
-		dbvdd: fixed-regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "dbvdd-supply";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	dbvdd: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "dbvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		spkvdd: fixed-regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "spkvdd-supply";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	spkvdd: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "spkvdd-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
-	usb300_vbus_reg: regulator-usb300 {
+	usb300_vbus_reg: regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VBUS0";
 		regulator-min-microvolt = <5000000>;
@@ -76,7 +67,7 @@
 		enable-active-high;
 	};
 
-	usb301_vbus_reg: regulator-usb301 {
+	usb301_vbus_reg: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "VBUS1";
 		regulator-min-microvolt = <5000000>;
-- 
2.17.1

