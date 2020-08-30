Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F25DC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F1320707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598795995;
	bh=j77CktKo3T9lOAIW0GGqvgAET3t3oeLi6WGf+te7xiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HYzq8mNPlJDAYRxEmwK4z9H+MnnMPgl4rxVn1IDLoCIPWU7wOQuWLL1fsYFmFkaWH
	 UREHLlZ/Ynz61oqV6g9HaNK/tEkzysXMT0gXiVuhDheJhSu2rGWE8J9wTV+EG2olpT
	 pu/cJqFyktGSW0zMiatZkdedVtHcaKFtSYurh89A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgH3N7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgH3Nyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:47 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CD82145D;
        Sun, 30 Aug 2020 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795686;
        bh=j77CktKo3T9lOAIW0GGqvgAET3t3oeLi6WGf+te7xiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ddfgfj+GfV+bDD537Y7xdMhWXrxjfVOH1up1ZICU7i2Mma97xCV9UIDAK9Dr4ooDO
         iMqFopjvTMn+2FLfiFSXDEt4b3Ljlm4gSYoxHL1fbq+XyIP5G5VvcevKVbYTgNWGCS
         ZRIWE7/yM79SowZEJhXGcig6cO/57LgKqALDTrhM=
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
Subject: [PATCH 17/33] ARM: dts: exynos: Override thermal by label in Galaxy I9000
Date:   Sun, 30 Aug 2020 15:51:44 +0200
Message-Id: <20200830135200.24304-17-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos4210-i9100.dts | 28 ++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 5623e17889a5..799b69e1a93a 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -217,21 +217,6 @@
 			clock-frequency = <32768>;
 		};
 	};
-
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			cooling-maps {
-				map0 {
-					/* Corresponds to 800MHz */
-					cooling-device = <&cpu0 2 2>;
-				};
-				map1 {
-					/* Corresponds to 200MHz */
-					cooling-device = <&cpu0 4 4>;
-				};
-			};
-		};
-	};
 };
 
 &camera {
@@ -242,6 +227,19 @@
 	cpu0-supply = <&varm_breg>;
 };
 
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			/* Corresponds to 800MHz */
+			cooling-device = <&cpu0 2 2>;
+		};
+		map1 {
+			/* Corresponds to 200MHz */
+			cooling-device = <&cpu0 4 4>;
+		};
+	};
+};
+
 &ehci {
 	status = "okay";
 
-- 
2.17.1

