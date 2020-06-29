Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73213C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A91F206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464142;
	bh=pNN4gqHLLPuHdeY3rwPqJyTQ2QEC0Lul2Iwl6qbr9EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7JPYklSDZAqnt5l2d8RDILz6To9nUWki26pZPxW+KRyEpo5n7o/IDkHyAvJP+3Ah
	 N+gmDhNXJK0jpmr7WtbnwXQZWJ35E1UxUlIzNJWe71dtKllKj2Xa1o1vuuNjafqlVr
	 gE1zkDvvncvgO7IsIkkNqa5Dm+q8XrI/xLn3u5Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389940AbgF2Uzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389927AbgF2Uzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:55:35 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902FE2071A;
        Mon, 29 Jun 2020 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593464134;
        bh=pNN4gqHLLPuHdeY3rwPqJyTQ2QEC0Lul2Iwl6qbr9EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keBqJYOJt7lQ3wq5+ooET7lVHtr3HdVUlgPPhGUUcOofQzcqlTUPTA5XcJeXik/rL
         /Q3EtkyMg5Bxw/wIifvT9a4Q8vbUwv3yUBe1+8g4VHtOY33GvIWFWnqnYI50tq985Z
         uwWeJHbuBciXzFgNO7iijoqXkWG9Qw4GRfIkzZUg=
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
Subject: [PATCH 2/4] arm64: dts: exynos: Remove generic arm,armv8-pmuv3 compatible
Date:   Mon, 29 Jun 2020 22:44:40 +0200
Message-Id: <20200629204442.17336-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629204442.17336-1-krzk@kernel.org>
References: <20200629204442.17336-1-krzk@kernel.org>
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
index 523547b3d539..96ed93a21e40 100644
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

