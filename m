Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472242078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796653;
	bh=TJtlygoY/w0YlAC0Y0RpJRO7BKHHMoo0CEZk3p9WflY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1RLXkvYjUDPRzYu/42J2WwnJHuoub5Wt+C2kZE2Ri1UOc9aWURQ86wqvOlSHhQTJ
	 Rblzovvvi/y3B9o1DOvQNlr5xUa7oHAjsxKRSL4gjBQSYK6N3NYPXMOD4S0E4WHSc+
	 naKZ58t3LWSBukhjaiz3TRJ/dKJ746MBicBcr/OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgH3OKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgH3Nyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:44 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CB0208DB;
        Sun, 30 Aug 2020 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795683;
        bh=TJtlygoY/w0YlAC0Y0RpJRO7BKHHMoo0CEZk3p9WflY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbrFTJu+Plki7WU9nsnZnOp0gTSCYfuO/EDNkowUAG74VGP0BbeR6r+abmkGlDzqo
         qnplg66HY9FikwXcmkcpRWqCLEdLzq1yKw6Gvntxq+0MbX232caNAF7xRSNReJRYQ6
         vGf2bd7PsUQW1yf46bIhOtrEgCa22649XJpd2fbI=
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
Subject: [PATCH 16/33] ARM: dts: exynos: Override thermal by label in Exynos4210
Date:   Sun, 30 Aug 2020 15:51:43 +0200
Message-Id: <20200830135200.24304-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using full paths to extend or override a device tree node is error prone
since if there was a typo error, a new node will be created instead of
extending the node as it was desired.  This will lead to run-time errors
that could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210.dtsi | 36 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 73360f29d53e..fddc661ded28 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -365,26 +365,24 @@
 			};
 		};
 	};
+};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert0: cpu-alert-0 {
-					temperature = <85000>; /* millicelsius */
-				};
-				cpu_alert1: cpu-alert-1 {
-					temperature = <100000>; /* millicelsius */
-				};
-				cpu_alert2: cpu-alert-2 {
-					temperature = <110000>; /* millicelsius */
-				};
-			};
-		};
-	};
+&cpu_alert0 {
+	temperature = <85000>; /* millicelsius */
+};
+
+&cpu_alert1 {
+	temperature = <100000>; /* millicelsius */
+};
+
+&cpu_alert2 {
+	temperature = <110000>; /* millicelsius */
+};
+
+&cpu_thermal {
+	polling-delay-passive = <0>;
+	polling-delay = <0>;
+	thermal-sensors = <&tmu 0>;
 };
 
 &gic {
-- 
2.17.1

