Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A89C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4657F206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796330;
	bh=UnqZkO538P3VTBEgrV3OxJqxre1q+xhSq04m0APAXkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vgoc2bPavP0vVwnoVWZ56WduUoUP2Yl24cKvUnGmAix66gxZjXbGZOBa4ejiQNF6E
	 ereIstdF1Dzk3J72eChMl49+kZXGNR8N2ZikSufMkhyo/lF01NWsPcfbEuSYrM7Awk
	 aejSor+SjYKmZMBRK4Oup2szTtFp5D6LX7PVVLeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgH3OEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728973AbgH3Nzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:55:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C7820707;
        Sun, 30 Aug 2020 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795731;
        bh=UnqZkO538P3VTBEgrV3OxJqxre1q+xhSq04m0APAXkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuWtO4mcaZ1vLZO4arAJrZgMwK0zNw/QZ5IDuLrRmP+ZPhtORSnaUhoc56xIaROsx
         6lyoGWOWKwSFOGUB7H7Oi1LVhlPQF8g81deVVtlFysUgVEVWCYfxVRApaOPTlwmyrf
         OvdHHlD/fILpM+9MjEdwm16rxiob0uawZGDslwxI=
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
Subject: [PATCH 32/33] ARM: dts: exynos: Correct S3C RTC bindings in Tiny4412
Date:   Sun, 30 Aug 2020 15:51:59 +0200
Message-Id: <20200830135200.24304-32-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However the PMIC is not described in DTS at all so at least add a
workaround to model its clock with fixed-clock.  This fixes S3C RTC and
silences dtbs_check warnings like:

  arch/arm/boot/dts/exynos4412-tiny4412.dt.yaml: rtc@10070000: clocks: [[7, 346]] is too short
  arch/arm/boot/dts/exynos4412-tiny4412.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 7512c86e634e..017b26108bb0 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -65,6 +65,13 @@
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
 
 	panel {
@@ -110,6 +117,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &sdhci_2 {
-- 
2.17.1

