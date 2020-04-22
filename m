Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE71C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8692082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Bbe8fkiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgDVOhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:37:24 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:54089 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDVOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:37:24 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 03MEaaEN012204;
        Wed, 22 Apr 2020 23:36:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 03MEaaEN012204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587566197;
        bh=qtkMM7xy3zIEAGobkYGRENcGZkyxHsxrtwH6kA03juo=;
        h=From:To:Cc:Subject:Date:From;
        b=Bbe8fkiZi25X8K0u0JC3pEpd+M3uyHKiWQ3Fh4HnAabPhqW4l2sjIJ8g5wCkeNGnW
         YNrhw/idkidv98yShZ11vbP2W0VlKyHelFmYmP6L2gheRnHRMmS2RBpYp98hIPpyrA
         SYusnuIHSSaRIo+JSYIQ0Q5+U0Qz5NYFx901ctAXi5ylhE/Z0Kl/o3HPLiaH1IZ7+p
         69cyQwSd/CdB4f1FNHz2ZGqz0eAuh7fDdAbUFsFIwAogFgZgumHJGtVN3Xs+zV4vDG
         TDj1XXFVqYE0v/h0AM+oLFNxl8ZvlQw2wDB2N7gKV6oOQ6IQ8HMX0Mevz2V1mhGaM3
         HwxyadhtZ83FA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: uniphier: add #address-cells and #size-cells to SPI nodes
Date:   Wed, 22 Apr 2020 23:36:32 +0900
Message-Id: <20200422143633.1972154-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/spi/spi-uniphier.txt requires
#address-cells and #size-cells, but they are missing in actual DT files.

Due to this, 'make ARCH=arm dtbs_check' is super-noisy.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 2 ++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 2 ++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 4 ++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 4 ++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 2 ++
 5 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 06e7400d2940..b52957ccda0d 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -67,6 +67,8 @@ spi: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 1c866f0306fc..012d9b181311 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -75,6 +75,8 @@ spi0: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 8f1ae0957f5f..03a9fd33243a 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -160,6 +160,8 @@ spi0: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
@@ -171,6 +173,8 @@ spi1: spi@54006100 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006100 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 216 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 2f2a24994c69..a04fba6d4064 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -173,6 +173,8 @@ spi0: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
@@ -184,6 +186,8 @@ spi1: spi@54006100 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006100 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 216 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 09992163e1f4..96a766deb8d1 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -67,6 +67,8 @@ spi: spi@54006000 {
 			compatible = "socionext,uniphier-scssi";
 			status = "disabled";
 			reg = <0x54006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 39 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
-- 
2.25.1

