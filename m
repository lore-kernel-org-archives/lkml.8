Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA48C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025D9207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599062276;
	bh=W9GtgbTtPV8u6xuJ7QZzRjhftGM/+5lf6NpGwGwHAY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XlJztgbnRXPtZAYVLIEW4rzG4yDE2/lodhBhSGDNBytI9Q4rAkY5RywIlzvMjsbxu
	 SeACa3R3sjr3aXJfDNRw2bt9XuYbghI+xUYdrQ8YT5b1AUNbl7e+789G0RaGSNrTU6
	 NC5scr9g/srG1d9GyhdlpU9x4fz5LBceNLPuaBrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgIBP5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIBP5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:57:50 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC72120829;
        Wed,  2 Sep 2020 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599062269;
        bh=W9GtgbTtPV8u6xuJ7QZzRjhftGM/+5lf6NpGwGwHAY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vurcLCtr86GlRFt0Rc6NSgX2mtmqBFYltbjgOrswmydZ9oWV9VnxaL+rapsIb5+3Y
         sURxbx2hiv6zyMhLKqFOvlJN52fq9o16rmx0TZwLQ59uElq0MpsNuOuHJ7+pJVmPGS
         6YerirqarU+Ihp8Gy7wf0a+bRkEShZ36X4Xav9FY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v2 2/2] ARM: dts: exynos: Silence SATA PHY warning in Exynos5250
Date:   Wed,  2 Sep 2020 17:57:33 +0200
Message-Id: <20200902155733.20271-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902155733.20271-1-krzk@kernel.org>
References: <20200902155733.20271-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SATA PHY in Exynos5250 SoCs has two interfaces and two device nodes:
1. sata-phy@12170000
2. i2c-9/i2c@38

The first node represents the actual SATA PHY device with phy-cells.

The second represents an additional I2C interface, needed by the driver
to communicate with the SATA PHY device.  It is not a PHY-provider in
the terms of dtschema so rename it to silence dtbs_check warning:

  arch/arm/boot/dts/exynos5250-arndale.dt.yaml: sata-phy@38: '#phy-cells' is a required property
    From schema: lib/python3.6/site-packages/dtschema/schemas/phy/phy-provider.yaml

This second device node is also a property of SoC, not a board so move
it there.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Move to Exynos5250
---
 arch/arm/boot/dts/exynos5250-arndale.dts  | 9 ++++-----
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 9 ++++-----
 arch/arm/boot/dts/exynos5250.dtsi         | 6 ++++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index d37479ea4fa2..79546f11af26 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -542,11 +542,6 @@
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <40000>;
-
-	sata_phy_i2c: sata-phy@38 {
-		compatible = "samsung,exynos-sataphy-i2c";
-		reg = <0x38>;
-	};
 };
 
 &i2s0 {
@@ -618,6 +613,10 @@
 	samsung,exynos-sataphy-i2c-phandle = <&sata_phy_i2c>;
 };
 
+&sata_phy_i2c {
+	status = "okay";
+};
+
 &soc {
 	/*
 	 * For unknown reasons HDMI-DDC does not work with Exynos I2C
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index bd8827c69ff1..186790f39e4d 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -326,11 +326,6 @@
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <40000>;
-
-	sata_phy_i2c: sata-phy@38 {
-		compatible = "samsung,exynos-sataphy-i2c";
-		reg = <0x38>;
-	};
 };
 
 &i2s0 {
@@ -382,6 +377,10 @@
 	samsung,exynos-sataphy-i2c-phandle = <&sata_phy_i2c>;
 };
 
+&sata_phy_i2c {
+	status = "okay";
+};
+
 &spi_1 {
 	status = "okay";
 	cs-gpios = <&gpa2 5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 488d3f9fab59..e09db3cecbff 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -473,6 +473,12 @@
 			clocks = <&clock CLK_SATA_PHYI2C>;
 			clock-names = "i2c";
 			status = "disabled";
+
+			sata_phy_i2c: sata-phy-i2c@38 {
+				compatible = "samsung,exynos-sataphy-i2c";
+				reg = <0x38>;
+				status = "disabled";
+			};
 		};
 
 		spi_0: spi@12d20000 {
-- 
2.17.1

