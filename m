Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4256CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1537B20678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgHaRMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:12:03 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37419 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgHaRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:11:46 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1F896C000C;
        Mon, 31 Aug 2020 17:11:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/5] ARM: dts: at91: sama5d2: add missing flexcom spi node properties
Date:   Mon, 31 Aug 2020 19:11:29 +0200
Message-Id: <20200831171129.3886857-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
References: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI nodes require #address-cells and #size-cells add those properties in
the flexcom spi nodes.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index c4aecfa4a2be..2ddc85dff8ce 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -542,6 +542,8 @@ spi2: spi@400 {
 					compatible = "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
 					interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
 					clock-names = "spi_clk";
 					dmas = <&dma0
@@ -610,6 +612,8 @@ spi3: spi@400 {
 					compatible = "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
 					interrupts = <20 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
 					clock-names = "spi_clk";
 					dmas = <&dma0
@@ -817,6 +821,8 @@ spi4: spi@400 {
 					compatible = "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
 					interrupts = <21 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 21>;
 					clock-names = "spi_clk";
 					dmas = <&dma0
@@ -885,6 +891,8 @@ spi5: spi@400 {
 					compatible = "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
 					interrupts = <22 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
 					clock-names = "spi_clk";
 					dmas = <&dma0
@@ -954,6 +962,8 @@ spi6: spi@400 {
 					compatible = "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
 					interrupts = <23 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 					clock-names = "spi_clk";
 					dmas = <&dma0
-- 
2.26.2

