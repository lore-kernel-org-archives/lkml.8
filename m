Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC84EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A985F208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593705129;
	bh=hLE/WHG614Fqr+65rEXe8Hvb8MiKmdRH/OazfRBiUqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z14LKI1wNWActuhXs7YoCyxBEvBolUHiO+pyWISJ4Z4Ag/xr0NYGss5tfa0xsPBB5
	 W7RoNGCQugQeBcPVZrrKc9afKlWyiZbPdKL+5jEeLuTmARbaNTAEav2qvCK4/ohMtR
	 Hjhjg1Se0tAZGxQl4oGYtV5qMvGb/lKsG3zMZjHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGBPwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgGBPwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:52:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A7A20885;
        Thu,  2 Jul 2020 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593705125;
        bh=hLE/WHG614Fqr+65rEXe8Hvb8MiKmdRH/OazfRBiUqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bc4cWwuDlpi17h/NZ4Bi5hKhxXyZQJSkRb892K8RYu5oCcCd1CN7MS0DLcPyBFBFA
         f4w/C9z1SxT7WGLJiDwLfCp2+HlHO4zAi7ZjyTjUVDerduiZ4LqyZH0HuWD08SucfJ
         /X2MCf7Jjxs/y06XWcStlhdkWhF0Pd9AD6b2h3Co=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 3/8] arm64: dts: exynos: Remove generic arm,armv8-pmuv3 compatible
Date:   Thu,  2 Jul 2020 17:51:44 +0200
Message-Id: <20200702155149.12854-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM PMU node is described enough with first compatible so remove the
arm,armv8-pmuv3 to fix dtschema warnings like:

    arm-pmu: compatible: Additional items are not allowed ('arm,armv8-pmuv3' was unexpected)
    arm-pmu: compatible: ['arm,cortex-a57-pmu', 'arm,armv8-pmuv3'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None

Not tested although no effect expected.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ++--
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index ebe089469b5f..57b433a1c900 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -24,7 +24,7 @@
 	interrupt-parent = <&gic>;
 
 	arm_a53_pmu {
-		compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
@@ -33,7 +33,7 @@
 	};
 
 	arm_a57_pmu {
-		compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a57-pmu";
 		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 709742b98c9c..c0b63b0d39ab 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -29,7 +29,7 @@
 	};
 
 	arm-pmu {
-		compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a57-pmu";
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1

