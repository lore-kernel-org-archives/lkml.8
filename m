Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C2CC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFD02075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BN5twPSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgAPMvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:51:44 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:25747 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:51:42 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 00GCp0LM004484;
        Thu, 16 Jan 2020 21:51:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 00GCp0LM004484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579179061;
        bh=fMZaburuU4urQ/r10xZu/T0T7Qs+Nao/bvyk3yFijQU=;
        h=From:To:Cc:Subject:Date:From;
        b=BN5twPSBRxD8vQeyMWYE8Z7obDb8ZNKD+aM0tNUKCByY/VVLDFgyHybtXtLFkuyzZ
         KHWywEldhCGuTNJtt3tKTKmdR/oQuRAFilnwfPN7L3ot5oAiOxJD6lagF0Oyy/06Py
         kTKXEYKl3n3Rn47Nv2uIfPwYLLahE/xBsyVKpO9SSusZjkP/Ypjov/NdBFUWmvQMYy
         ATDnjikpaTBT6OYp03V+aRoL7Nr3D2AwcVC2Bi76naqZncMyG74MbIrmSKkLz0w3xA
         T6TSk0JXXcvX9/JRrOxd/6vpKNBTKzed1RfcUwoQjVFlpNo2yqEqTZ35Ob8ZPBTQB8
         Gs13PZVEMgNDA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: uniphier: add reset-names to NAND controller node
Date:   Thu, 16 Jan 2020 21:50:44 +0900
Message-Id: <20200116125045.17581-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali NAND controller IP has separate reset control for the
controller core and registers.

Add the reset-names, and one more phandle accordingly. This is the
approved DT-binding.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 3 ++-
 arch/arm/boot/dts/uniphier-pro4.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pro5.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 58cd4e8fa5be..64ec46c72a4c 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -410,7 +410,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 7f64e5a616d6..2ec04d7972ef 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -600,7 +600,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index eff74717b37c..ea3961f920a0 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -465,7 +465,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 
 		emmc: sdhc@68400000 {
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 4eddbb8d7fca..13b0d4a7741f 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -773,7 +773,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index cbebb6e4c616..4fc6676f5486 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -414,7 +414,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 	};
 };
-- 
2.17.1

