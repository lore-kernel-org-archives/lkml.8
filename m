Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E548C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC7420791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711191;
	bh=E1hVAd3lBjehhCh0G784FFWukEKouWeGXwdRL4oXW8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioJ99LEZH1DyEJbe8P33k/s1tazgurqW6ROpHWbacxnyFBVmJ2nYO6qH/MAgNdfvv
	 VdV62RCjTxRPAdryXXwM8Mc01gT4XSsSUXnvuadNzXSnO0mf3+qfr44iLLb2yNp4Rv
	 GWMPM6LNAq9t61gdQtyd/CKjipgfTWbSL/YmsRjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgH2O0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgH2OZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:25:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0B120C56;
        Sat, 29 Aug 2020 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711158;
        bh=E1hVAd3lBjehhCh0G784FFWukEKouWeGXwdRL4oXW8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cr7yPnmX9yXVCWjvWHUOp+ejxR44jkEQyY9aMINktokMsSu/4DwnEwjMCRLZlaZFO
         fXGE90a1K6Vfo1IOeauMfcjbYBAcVHFtknsboKDm3U8sYTRtNVlPDlCzgYhzItH0Fw
         6eb20eRaUV3JnU5yvHoy9DHW6KrvvOvaM5SksL6w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [RFT 09/10] arm64: dts: exynos: Correct port of USB-C connector node on Exynos5433 TM2
Date:   Sat, 29 Aug 2020 16:25:00 +0200
Message-Id: <20200829142501.31478-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
References: <20200829142501.31478-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB-C connector bindings require port@0.  Such port was already
described in DTS but outside of the connector itself.  Put it into
proper place to fix dtbs_check warnings like:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: musb_connector: ports: 'port@0' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HQ. Please kindly review and test.

Best regards,
Krzysztof
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi    | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 6246cce2a15e..bab6c1addd5f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -871,6 +871,13 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					port@0 {
+						reg = <0>;
+						muic_to_usb: endpoint {
+							remote-endpoint = <&usb_to_muic>;
+						};
+					};
+
 					port@3 {
 						reg = <3>;
 						musb_con_to_mhl: endpoint {
@@ -879,14 +886,6 @@
 					};
 				};
 			};
-
-			ports {
-				port {
-					muic_to_usb: endpoint {
-						remote-endpoint = <&usb_to_muic>;
-					};
-				};
-			};
 		};
 
 		regulators {
-- 
2.17.1

