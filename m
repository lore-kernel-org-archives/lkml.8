Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E807C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D55A206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796618;
	bh=K6hP5em2cMBqAr9JCMCNwOg3Qlcira5hs32UsXYBhzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YY53XYPvejUUT8Wx2CbXzxUFmdQBWN9t5poR4YWrJ16FSsGiPJ3YyhttobKt2bd4f
	 IjKwOqiEfjh5L+DDyCJK5FO/y2ipQVY6Urkgddo1svvb3mYIahyDnVezJFmlSXw5IH
	 YYDnhklwRTLr8qlPkw1WQQiryVndrTEPMOclmy0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgH3OKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgH3NzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:55:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39D020757;
        Sun, 30 Aug 2020 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795707;
        bh=K6hP5em2cMBqAr9JCMCNwOg3Qlcira5hs32UsXYBhzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCC9YjOkPtkDouaK/fBh7kQgqO7NjzrBubNhb6KsyLsRcGY4tmg/SWF/3I3csgdd8
         S9zFYqnK02sWeT6H7zcmqEwQGJyJcHY/BquLbkNXF1NjpQqUunYXCYpUn9F1hgorlf
         ScWw3XFQBqrL9Cngat6GRXNa/OmrrtrNd3VEBE0Q=
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
Subject: [PATCH 24/33] ARM: dts: exynos: Correct compatible of fixed clocks in Midas boards
Date:   Sun, 30 Aug 2020 15:51:51 +0200
Message-Id: <20200830135200.24304-24-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed clocks implemented by Samsung clock drivers use only one
compatible so drop the additional "fixed-clock" to fix dtbs_check
warnings like:

  arch/arm/boot/dts/exynos4412-i9300.dt.yaml: xxti: compatible:0: 'fixed-clock' was expected
    From schema: Documentation/devicetree/bindings/clock/fixed-clock.yaml
  arch/arm/boot/dts/exynos4412-i9300.dt.yaml: xxti: compatible: ['samsung,clock-xxti', 'fixed-clock'] is too long
  arch/arm/boot/dts/exynos4412-i9300.dt.yaml: xxti: compatible: Additional items are not allowed ('fixed-clock' was unexpected)
  arch/arm/boot/dts/exynos4412-i9300.dt.yaml: xxti: '#clock-cells' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 8e7a03228d7b..32d2e539b2dd 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -37,12 +37,12 @@
 
 	fixed-rate-clocks {
 		xxti {
-			compatible = "samsung,clock-xxti", "fixed-clock";
+			compatible = "samsung,clock-xxti";
 			clock-frequency = <0>;
 		};
 
 		xusbxti {
-			compatible = "samsung,clock-xusbxti", "fixed-clock";
+			compatible = "samsung,clock-xusbxti";
 			clock-frequency = <24000000>;
 		};
 	};
-- 
2.17.1

