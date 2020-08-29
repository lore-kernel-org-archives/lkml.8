Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB38EC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82909206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598721952;
	bh=jlnlsBMlKXrkOdFQa9f0gqcbNKcSuLQh0Ah9oW8TIcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hEY9ZXh66WW/vOHHy3bN+EoHE3yxXMlX5aVQgFOvVSmcV9nCKXHVLk5EBLoPTWrbt
	 WvOMdb+WCWGB0PeD5NdJr/7w53EHT8z43xv4cXCFhG2h5MN7NECbA9JZ4g+1/2LIS7
	 j96jYm9M+OA/hxxFrdVeplZ04WKrF0b9Z1rp9pT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgH2RZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgH2RZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:25:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069A320714;
        Sat, 29 Aug 2020 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598721945;
        bh=jlnlsBMlKXrkOdFQa9f0gqcbNKcSuLQh0Ah9oW8TIcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IY9GkRDpdokU8Qw4KBE/GAtPw4sE/H/PPR3ZQMN3aPBpNxpQgBrUT/DuSIT1eLQZM
         p5NKkaNGW0sm7BiFSpqsl3TKJ3KqE8H+Xn1NVmJzwXO5qVnTNhS5Va1qj1iQA7e4pW
         E3QJGS4vKyIfYS2Jme3pp7wLDSxDwE60kBaSWEVg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [RFT 2/4] ARM: dts: exynos: Move fixed clocks under root node in Exynos3250
Date:   Sat, 29 Aug 2020 19:25:30 +0200
Message-Id: <20200829172532.29358-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829172532.29358-1-krzk@kernel.org>
References: <20200829172532.29358-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed clocks are kept under dedicated node fixed-rate-clocks, thus a
fake "reg" was added.  This is not correct with dtschema as fixed-clock
binding does not have a "reg" property:

  arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 42 +++++++++++++------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index d3fb45a56527..c67c70e46794 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -97,33 +97,25 @@
 		};
 	};
 
-	fixed-rate-clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		xusbxti: clock@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			clock-frequency = <0>;
-			#clock-cells = <0>;
-			clock-output-names = "xusbxti";
-		};
+	xusbxti: clock-0 {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		#clock-cells = <0>;
+		clock-output-names = "xusbxti";
+	};
 
-		xxti: clock@1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			clock-frequency = <0>;
-			#clock-cells = <0>;
-			clock-output-names = "xxti";
-		};
+	xxti: clock-1 {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		#clock-cells = <0>;
+		clock-output-names = "xxti";
+	};
 
-		xtcxo: clock@2 {
-			compatible = "fixed-clock";
-			reg = <2>;
-			clock-frequency = <0>;
-			#clock-cells = <0>;
-			clock-output-names = "xtcxo";
-		};
+	xtcxo: clock-2 {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		#clock-cells = <0>;
+		clock-output-names = "xtcxo";
 	};
 
 	pmu {
-- 
2.17.1

