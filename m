Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEACC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8253C21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBFPKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:10:43 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55970 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgBFPKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:10:41 -0500
Received: from alexis.zapto.org (85-171-52-99.rev.numericable.fr [85.171.52.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aballier)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 94BEE34E821;
        Thu,  6 Feb 2020 15:10:39 +0000 (UTC)
From:   Alexis Ballier <aballier@gentoo.org>
Cc:     Alexis Ballier <aballier@gentoo.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: rk3399-orangepi: Explicitly pinmix the regulator configuration GPIOs
Date:   Thu,  6 Feb 2020 16:10:25 +0100
Message-Id: <20200206151025.3813-2-aballier@gentoo.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206151025.3813-1-aballier@gentoo.org>
References: <20200206151025.3813-1-aballier@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those GPIOs define which register is used by the GPU & CPUB regulators
for sleep mode. The register is defined here, so better have the GPIOs
explicitly set too.

Signed-off-by: Alexis Ballier <aballier@gentoo.org>
Cc: devicetree@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index 1767015e684c..f9f7246d4d2f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -432,6 +432,8 @@ vdd_cpu_b: regulator@40 {
 		compatible = "silergy,syr827";
 		reg = <0x40>;
 		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cpu_b_sleep>;
 		regulator-name = "vdd_cpu_b";
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
@@ -449,6 +451,8 @@ vdd_gpu: regulator@41 {
 		compatible = "silergy,syr828";
 		reg = <0x41>;
 		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpu_sleep>;
 		regulator-name = "vdd_gpu";
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
@@ -561,6 +565,14 @@ phy_rstb: phy-rstb {
 	};
 
 	pmic {
+		cpu_b_sleep: cpu-b-sleep {
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		gpu_sleep: gpu-sleep {
+			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
 		pmic_int_l: pmic-int-l {
 			rockchip,pins =
 				<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.25.0

