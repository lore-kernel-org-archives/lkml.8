Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE85206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459242;
	bh=0/qT+6hY+eTg55XNf7QvFEvr0fFMkg9fWPy0NAfij6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G24BoOu6+CDvxgaS/4LZPUJOv00pnzEOfXLlW8axBdGUFEZO/U/9gJkzgd/ro7Mw8
	 MtRIp72DXjKvnIhxx+eXllvwjy3Z9Nn6i62vu3aM85k4U7P+UMMBeG2yVXh9eBTbSY
	 LSdgCprHp7r29Ky5W56JKmDuXI5mwJU57G2DTgjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgF2TeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733202AbgF2Tdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:33:54 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112F9206F1;
        Mon, 29 Jun 2020 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593459233;
        bh=0/qT+6hY+eTg55XNf7QvFEvr0fFMkg9fWPy0NAfij6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkUr7orAJ1o4l//CB8whx7CubQPPH4BgwQS3R9ACPKCJwbdq3ocQdTHDPOcloY7Cg
         1LQR7Bk6nGr8ihrALZ8QDTWucoEb2Fv4gKn6RO03P3Ok6CJv6g17PHhrD0roeB2la3
         YjLNWc7JyVfPatR9YfqQVX0X/Hqcr13w5ixgn2D8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFT 3/3] arm64: dts: exynos: Add unit address to soc node and move thermal zones on Exynos7
Date:   Mon, 29 Jun 2020 21:33:38 +0200
Message-Id: <20200629193338.29540-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629193338.29540-1-krzk@kernel.org>
References: <20200629193338.29540-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add @0 unit address to 'soc' node match its 'reg' property and move the
thermal zones out of 'soc' to main root as it this is usually not a
property of a Soc.

This silences DTC warnings:

    Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
    Warning (simple_bus_reg): /soc/thermal-zones: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 300ad7326ea8..f590891efe25 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -83,7 +83,7 @@
 		method = "smc";
 	};
 
-	soc: soc {
+	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -597,15 +597,6 @@
 			#thermal-sensor-cells = <0>;
 		};
 
-		thermal-zones {
-			atlas_thermal: cluster0-thermal {
-				polling-delay-passive = <0>; /* milliseconds */
-				polling-delay = <0>; /* milliseconds */
-				thermal-sensors = <&tmuctrl_0>;
-				#include "exynos7-trip-points.dtsi"
-			};
-		};
-
 		ufs: ufs@15570000 {
 			compatible = "samsung,exynos7-ufs";
 			reg = <0x15570000 0x100>,  /* 0: HCI standard */
@@ -675,6 +666,15 @@
 		};
 	};
 
+	thermal-zones {
+		atlas_thermal: cluster0-thermal {
+			polling-delay-passive = <0>; /* milliseconds */
+			polling-delay = <0>; /* milliseconds */
+			thermal-sensors = <&tmuctrl_0>;
+			#include "exynos7-trip-points.dtsi"
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.17.1

