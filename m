Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C0C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E20220BED
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796870;
	bh=niICbcBz2rtNi4SVKxMCoMeh3QFoGrH5fkVUjCceR1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzIJNwaJsPk3IR5LRK/SqCDpESVMb7ImOZMuyrq34Ug4lkldf9OV6i5gQSZBdRPop
	 20b7HDn8JoHi2TcSAJs9x4SpCuZ+dB8ho/c677Zb/g/UIrHsk7GA7QXteNGy9JSvf0
	 NgkqWKW1pJTNifGuw4elESM54gu5SVWoMvnTvR+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgH3OO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgH3NyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:16 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 083D420EDD;
        Sun, 30 Aug 2020 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795655;
        bh=niICbcBz2rtNi4SVKxMCoMeh3QFoGrH5fkVUjCceR1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koAxN9ff5ZxZ4Vb+nonO9jNTMF2DJya09+pSQmV46xR9SXaz2tPC1Tv8R86QxasQ5
         Gm5OVVXLPRC3sA9x/TwzN1hZ7fcJNZfyfHTcmOY88OtSHRDMxs1SM85tH8Z9kA/2O0
         Uo0Pf8mmb4MP0vAvuRz0jky8khp3rll9hBxU17yM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Denis GNUtoo Carikli" <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 07/33] ARM: dts: exynos: Correct S3C RTC bindings in SMDKv310
Date:   Sun, 30 Aug 2020 15:51:34 +0200
Message-Id: <20200830135200.24304-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However there is no clock provided for the PMIC and the driver registers
the clock as regulator.  This is an old driver which will not be updated
so add a workaround - a fixed-clock to fill missing clock phandle
reference in S3C RTC.

This allows to enable the S3C RTC and fixes dtbs_check warnings:

  arch/arm/boot/dts/exynos4210-smdkv310.dt.yaml: rtc@10070000: clocks: [[5, 346]] is too short
  arch/arm/boot/dts/exynos4210-smdkv310.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-smdkv310.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 77fc11e593ad..0b0e86737b26 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -40,6 +40,13 @@
 			compatible = "samsung,clock-xusbxti";
 			clock-frequency = <24000000>;
 		};
+
+		pmic_ap_clk: pmic-ap-clk {
+			/* Workaround for missing clock on PMIC */
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
 	};
 };
 
@@ -148,6 +155,11 @@
 	};
 };
 
+&rtc {
+	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &sdhci_2 {
 	bus-width = <4>;
 	pinctrl-names = "default";
-- 
2.17.1

