Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179FFC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA0D206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796942;
	bh=xcU4Jo/kDMY8kA69z7qrLRBuuBBFyNvu7a/iY6erYKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ryc3K3J3whw2rgEBwSqyWXy+BoyzlASKPTQBUEqutLFuSey5/XAscer6hklFpTfn7
	 csrl12s3JUhwbUPMbN0kLR0h9bV5wmFAnNr5XwA5AjxTf3Jmn8LDWP1ldycrJ7jqLd
	 yuQH6ux2G/3aXtdsMdw+1FHlCPNsW8cpevSkA6VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgH3OPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgH3NyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA250208DB;
        Sun, 30 Aug 2020 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795652;
        bh=xcU4Jo/kDMY8kA69z7qrLRBuuBBFyNvu7a/iY6erYKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCiruBmXnYwvg2cVU8Xn7OssfHHByMYlgfi6SQps3vPUnCHQAMTgBSOlS4OWb+ZgK
         J+J2hVHlOu2KeypY4w2Q/tWXeUFap9hajLwsSHbvx/lgeiOp/WnAhqwY/ctE8ThsJL
         1jty1OmRAcSdfBiVFWFA0FCLCOpfPIih6K3RgApI=
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
Subject: [PATCH 06/33] ARM: dts: exynos: Correct S3C RTC bindings and enable it in Universal C210
Date:   Sun, 30 Aug 2020 15:51:33 +0200
Message-Id: <20200830135200.24304-6-krzk@kernel.org>
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
so add a workaround - add a fixed-clock to fill missing clock phandle
reference in S3C RTC.  The "clock" regulator in PMIC is already present
and enabled.

This allows to enable the S3C RTC and fixes dtbs_check warnings:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: rtc@10070000: clocks: [[5, 346]] is too short
  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 99ce53b120ac..9479e41bdc2a 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -39,6 +39,13 @@
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
 
 	vemmc_reg: voltage-regulator {
@@ -537,6 +544,12 @@
 	status = "okay";
 };
 
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &sdhci_0 {
 	bus-width = <8>;
 	non-removable;
-- 
2.17.1

