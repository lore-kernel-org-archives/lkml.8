Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1779C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9969D20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgGHIwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:52:05 -0400
Received: from mx.socionext.com ([202.248.49.38]:18877 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgGHIwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:52:05 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Jul 2020 17:52:03 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 77ADC60060;
        Wed,  8 Jul 2020 17:52:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 8 Jul 2020 17:52:03 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CEB341A0507;
        Wed,  8 Jul 2020 17:52:02 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] ARM: dts: uniphier: Add PCIe endpoint and PHY node for Pro5
Date:   Wed,  8 Jul 2020 17:52:00 +0900
Message-Id: <1594198320-28900-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds PCIe endpoint controller and PHY nodes for Pro5 SoC,
and also adds pinctrl node for PCIe.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi |  5 +++++
 arch/arm/boot/dts/uniphier-pro5.dtsi    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index bfdfb76..c0fd029 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -126,6 +126,11 @@
 		function = "nand";
 	};
 
+	pinctrl_pcie: pcie {
+		groups = "pcie";
+		function = "pcie";
+	};
+
 	pinctrl_sd: sd {
 		groups = "sd";
 		function = "sd";
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index feadb4a..3525125 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -613,6 +613,36 @@
 			};
 		};
 
+		pcie_ep: pcie-ep@66000000 {
+			compatible = "socionext,uniphier-pro5-pcie-ep",
+				     "snps,dw-pcie-ep";
+			status = "disabled";
+			reg-names = "dbi", "dbi2", "link", "addr_space";
+			reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
+			      <0x66010000 0x10000>, <0x67000000 0x400000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_pcie>;
+			clock-names = "gio", "link";
+			clocks = <&sys_clk 12>, <&sys_clk 24>;
+			reset-names = "gio", "link";
+			resets = <&sys_rst 12>, <&sys_rst 24>;
+			num-ib-windows = <16>;
+			num-ob-windows = <16>;
+			num-lanes = <4>;
+			phy-names = "pcie-phy";
+			phys = <&pcie_phy>;
+		};
+
+		pcie_phy: phy@66038000 {
+			compatible = "socionext,uniphier-pro5-pcie-phy";
+			reg = <0x66038000 0x4000>;
+			#phy-cells = <0>;
+			clock-names = "gio", "link";
+			clocks = <&sys_clk 12>, <&sys_clk 24>;
+			reset-names = "gio", "link";
+			resets = <&sys_rst 12>, <&sys_rst 24>;
+		};
+
 		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4

