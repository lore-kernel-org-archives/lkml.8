Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86435C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585B920659
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgIKIJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:09:41 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:17397 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgIKIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:09:40 -0400
X-IronPort-AV: E=Sophos;i="5.76,414,1592838000"; 
   d="scan'208";a="56802406"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2020 17:09:37 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 54288400D4DF;
        Fri, 11 Sep 2020 17:09:36 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] ARM: dts: r8a7742: Add VSP support
Date:   Fri, 11 Sep 2020 09:09:29 +0100
Message-Id: <20200911080929.15058-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VSP support to R8A7742 (RZ/G1H) SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 24647cf13c2b..c73060b075b3 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1686,6 +1686,42 @@
 			status = "disabled";
 		};
 
+		vsp@fe920000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe920000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 130>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 130>;
+		};
+
+		vsp@fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 131>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 131>;
+		};
+
+		vsp@fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 128>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 128>;
+		};
+
+		vsp@fe938000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe938000 0 0x8000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 127>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 127>;
+		};
+
 		du: display@feb00000 {
 			compatible = "renesas,du-r8a7742";
 			reg = <0 0xfeb00000 0 0x70000>;
-- 
2.17.1

