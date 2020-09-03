Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD152C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8678220C56
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599160502;
	bh=Frls6pRZD/pqFXY0JlXvzp8zJSM8uI5MSWNm3oMPcJg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Zpc74Y4oKB8eLmFMaGpWxHSQVXkiDcOfrYqBKaMGaYQNxFQaWGIlAK2TLn+kSsSS
	 I7AzqFnzcN3WzxzJo83t9L7fpzsqajmz1+77KSps0OQHI+uKWD9a/UAherQCX+iRgm
	 aW3QHsXLXGAgdaK1xyz6KRo/akd/K6T2oopkZyNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgICTPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbgICTO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:14:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81A620C56;
        Thu,  3 Sep 2020 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160497;
        bh=Frls6pRZD/pqFXY0JlXvzp8zJSM8uI5MSWNm3oMPcJg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XGQJs2oskk3Zfb9J3Hvfnj2FhbRUhZ6sVjcGvjD4QYCChb7dV9v5oBbHHevANB72P
         fKMFJFFYEL4OUH0KQBVRvYWHkzJQ604/JRCGB/7aUTQWEqxZ7EUZG0QGmjoHQTimgF
         hNgt3Dgj4KIkUez842b9PPZpa3+6jdyY7q7kGuSk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: dts: exynos: Align OPP table name with dt-schema
Date:   Thu,  3 Sep 2020 21:14:37 +0200
Message-Id: <20200903191438.12781-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903191438.12781-1-krzk@kernel.org>
References: <20200903191438.12781-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree nodes should have hyphens instead of underscores.  This is
also expected by the bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos4412.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/exynos5250.dtsi |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index c74b1be12671..e76881dc0014 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -76,7 +76,7 @@
 		};
 	};
 
-	cpu0_opp_table: opp_table0 {
+	cpu0_opp_table: opp-table0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -402,7 +402,7 @@
 			status = "disabled";
 		};
 
-		bus_dmc_opp_table: opp_table1 {
+		bus_dmc_opp_table: opp-table1 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -429,7 +429,7 @@
 			};
 		};
 
-		bus_acp_opp_table: opp_table2 {
+		bus_acp_opp_table: opp-table2 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -495,7 +495,7 @@
 			status = "disabled";
 		};
 
-		bus_leftbus_opp_table: opp_table3 {
+		bus_leftbus_opp_table: opp-table3 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -518,7 +518,7 @@
 			};
 		};
 
-		bus_display_opp_table: opp_table4 {
+		bus_display_opp_table: opp-table4 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -530,7 +530,7 @@
 			};
 		};
 
-		bus_fsys_opp_table: opp_table5 {
+		bus_fsys_opp_table: opp-table5 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -542,7 +542,7 @@
 			};
 		};
 
-		bus_peri_opp_table: opp_table6 {
+		bus_peri_opp_table: opp-table6 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -734,7 +734,7 @@
 			  "pmu";
 	operating-points-v2 = <&gpu_opp_table>;
 
-	gpu_opp_table: opp_table {
+	gpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
 
 		opp-160000000 {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e09db3cecbff..bd2d8835dd36 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -330,7 +330,7 @@
 			power-domains = <&pd_g3d>;
 			status = "disabled";
 
-			gpu_opp_table: gpu-opp-table {
+			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
-- 
2.17.1

