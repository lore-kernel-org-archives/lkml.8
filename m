Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F6C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B66C2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SGBWRKZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgDVOh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:37:28 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:54090 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:37:24 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 03MEaaEO012204;
        Wed, 22 Apr 2020 23:36:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 03MEaaEO012204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587566198;
        bh=Bznt0cL8BIH1py8BFs9AtQCl/NitEIeYc3BeOYY2PNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGBWRKZDHwt+YDrs9Qp7PDjDXkJtfJ45kaCh74pm7CQtbhguLhJsnI0tmJ3zfHwCR
         PkkALjzHdrXiZ8ygG1z6BDkjKsCz7gBD6N18BMNhhcX12ft1L6ET0/plZBBmWP0hCW
         Xd7uQF0FoXR09CyytL5Votq8JF8MBFv/oD6TQef6IAyEGm5tooQRptxAMYEXPT/SKS
         pqSipA1aN98IGX8BlgM3x3MJ8IlNHxPGd2CNg9a+omLm5Olk/iugxgXKpi2A28N9tB
         spzOaEEsZ4UmxqHhs0U50MnHxoVkYOnWdsjgBdqNegXEUcXP2RpQ970/TYQdM1id7e
         yLBPDHGNCND2Q==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: uniphier: add #address-cells and #size-cells to SPI nodes
Date:   Wed, 22 Apr 2020 23:36:33 +0900
Message-Id: <20200422143633.1972154-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200422143633.1972154-1-yamada.masahiro@socionext.com>
References: <20200422143633.1972154-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/spi/spi-uniphier.txt requires
#address-cells and #size-cells, but they are missing in actual DT files.

Due to this, 'make ARCH=arm64 dtbs_check' is super-noisy.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 4 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 8 ++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 60ff9b4f9126..15dcfc259854 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -129,6 +129,8 @@ spi0: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
@@ -140,6 +142,8 @@ spi1: spi@54006100 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006100 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 216 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index afa90b762ea9..f4a56b208837 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -234,6 +234,8 @@ spi0: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
@@ -245,6 +247,8 @@ spi1: spi@54006100 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006100 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 216 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
@@ -256,6 +260,8 @@ spi2: spi@54006200 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006200 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 229 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi2>;
@@ -267,6 +273,8 @@ spi3: spi@54006300 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006300 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 230 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi3>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index ba18a9661ca2..72f16881cf53 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -193,6 +193,8 @@ spi0: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
@@ -204,6 +206,8 @@ spi1: spi@54006100 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006100 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 216 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
-- 
2.25.1

