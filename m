Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE8C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA32121556
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598795734;
	bh=fNOR3ktNBhKbqIJUVlvuY0rQ8hgLEd0Ryu6hSGGEjtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gfvi/A3xkRX8Qfva9Zcq2AQQI0OwERiYbPq9gAv3FBJPnigaUIxiAfpZ6IVte0SV2
	 HNepJwZ8Q4ULIXtEVTtyuTMynby5fjDsxxXKSMxhx3uaQ2NgujFBBUKqs6leTGPt3e
	 3JQhHuizoMvcl5SGaXJojrvCEJOExhTqs+FhZ78c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgH3NzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgH3NyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76A820757;
        Sun, 30 Aug 2020 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795646;
        bh=fNOR3ktNBhKbqIJUVlvuY0rQ8hgLEd0Ryu6hSGGEjtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVvzd4AVp0qCPY1TAvQxfzalqgqRidkWpPHa+A101iHsRcBlMxzLX8ys5tc6+C3TW
         Ee60kfyn11e5TTzxZnmsRaSWApM5GWzG2pjQrj0/1jXkK7qpMYsvmQ0mKFKwboRI5v
         PUXY/uVZtXisEkWbSWaJH/D3Fr+NjgrIJQnHUtJk=
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
Subject: [PATCH 04/33] ARM: dts: exynos: Correct S3C RTC bindings and enable it in Origen
Date:   Sun, 30 Aug 2020 15:51:31 +0200
Message-Id: <20200830135200.24304-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC
(Maxim MAX8997).  However there is no clock provided for the PMIC and
the driver registers the clock as regulator.  This is an old driver
which will not be updated so add a workaround:
1. Enable the "clock" regulator in PMIC,
2. Add a fixed-clock to fill missing clock phandle reference in S3C RTC.

This allows to enable the S3C RTC and fixes dtbs_check warnings:

  arch/arm/boot/dts/exynos4210-origen.dt.yaml: rtc@10070000: clocks: [[5, 346]] is too short
  arch/arm/boot/dts/exynos4210-origen.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 890525b10d22..747221bbb856 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -100,6 +100,13 @@
 			compatible = "samsung,clock-xusbxti";
 			clock-frequency = <24000000>;
 		};
+
+		pmic_ap_clk: pmic-ap-clk {
+			/* Workaround for missing clock on max8997 PMIC */
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
 	};
 
 	display-timings {
@@ -286,6 +293,11 @@
 				regulator-boot-on;
 				regulator-always-on;
 			};
+
+			EN32KHZ_AP {
+				regulator-name = "EN32KHZ_AP";
+				regulator-always-on;
+			};
 		};
 	};
 };
@@ -331,6 +343,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &tmu {
-- 
2.17.1

