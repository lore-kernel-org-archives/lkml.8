Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B69BC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54B12145D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598795696;
	bh=BJu2ygEsYuHqBLXUZVb62si7DnFLg02WRfhJZMLE0UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVRi5GDWLiyjQE3hYycBS1nINv+rZztJTxymnZ6cQwtO9/qouyuNutcKaDdlia+sx
	 /JUsTtGIjyqJcKasGm+m/gvgPcZHh8Xowy9qynhxtbMMgRbMvHbV8r42bXi9daaJU6
	 ZsCf1IrVnnCElHgoquzHmXheZtU00s3yKXydjVgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgH3Nyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbgH3NyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C302087D;
        Sun, 30 Aug 2020 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795643;
        bh=BJu2ygEsYuHqBLXUZVb62si7DnFLg02WRfhJZMLE0UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPorNLpJOPZEfol6g1uhSKyL6ir4bsR56fQH0IekTnhwGqn+NC2t98/ep8mo0ssRn
         vuWC9pqPgKt1iChhUQOFz2QG6c0erlx0bdoSNisEtKH+G4eag7uHF4kwvCwVOZ2vvB
         ambJwAqajcYm44zGT5ayAqcCIGKEGfr3nvhCVC5U=
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
Subject: [PATCH 03/33] ARM: dts: exynos: Correct S3C RTC bindings and enable it in Galaxy I9100
Date:   Sun, 30 Aug 2020 15:51:30 +0200
Message-Id: <20200830135200.24304-3-krzk@kernel.org>
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

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: rtc@10070000: clocks: [[5, 346]] is too short
  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 6fa57d1fa1d7..d63274c8539d 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -209,6 +209,13 @@
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
 
 	thermal-zones {
@@ -568,6 +575,11 @@
 				regulator-max-microvolt = <4100000>;
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
@@ -688,6 +700,12 @@
 	};
 };
 
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &sdhci_0 {
 	status = "okay";
 
-- 
2.17.1

