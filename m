Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906CBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB282068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T0HTIX/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgFOJ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:56:02 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15679 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgFOJz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592214958; x=1623750958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=692fkDEuh1BmOmtP0c+bSMMGsuxUEiPJurUSSpS4uUw=;
  b=T0HTIX/IsF43+IXO3T2hh9t9SO2bvYXEwHHl70lgPjBfuwPv5G+WnAe1
   ks4zqFwCOFRjWmYsY1pdCU8yoMwWHQx4lzNWVIkKplfa/KOnoaArEs6KO
   m14K4xE07F3FZlmwqeMnVXXsduc9uOBzGeslWeUomUxiOXkUJqopWQ3s0
   zLGT73xYJjOiJrpQXvFJZiCWiWRrArgnkZz7yEtBF5RXEySKep7d/dWPC
   LFjb3F6+vKNSlCXALZchIf4o6Fmpz0jvhq0OjETLbOk/ljKE9UCVFWV/H
   JGt2Wf4ROU0tKDYlLjRwDMof069dueDZ0jj8mN79wtACufCjwPAbUxS0D
   w==;
IronPort-SDR: rLYBr+VslBxEOPYBjxUKEiYArqrXdl9kzqgrpURDyTHV2dKN/ngSX3uyqdBTUkBqCkl/1lr0xw
 BrLv8RVagFWn3O4YnP872q1Mh8APTyh86pbT858yl0HVl+FTLRdCiyCxL6Dsbqa2XDa9ruKkGN
 gN3PUdg8PZPxdyuXLzock7a4rHmjYn7p7zAflOPDYIXnlpe/MXcM3RrJ27RF8G0E9EPJfYIFvU
 /3f9df31Sd7y4Hb2IMxza02O8Be5Cc/J2f0v8eNdcezxJZ3Ktx/VszckxGyYgIaCjBXyFzkb6J
 2eo=
X-IronPort-AV: E=Sophos;i="5.73,514,1583218800"; 
   d="scan'208";a="76588062"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2020 02:55:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 15 Jun 2020 02:55:40 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 15 Jun 2020 02:55:40 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 3/3] Revert "ARM: at91/dt: sama5d2 Xplained: add pdmic node"
Date:   Mon, 15 Jun 2020 12:55:25 +0300
Message-ID: <20200615095525.43414-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
References: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no PDM microphones on SAMA5D2 Xplained, to exercize the
PDMIC.

This reverts commit ca6349a8c51f2e3d6f2acdb36431e7d7328261f7.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 54d96649da77..c0a255bda477 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -109,16 +109,6 @@ timer1: timer@1 {
 				};
 			};
 
-			pdmic@f8018000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_pdmic_default>;
-				atmel,model = "PDMIC @ sama5d2_xplained";
-				atmel,mic-min-freq = <1000000>;
-				atmel,mic-max-freq = <3246000>;
-				atmel,mic-offset = <0x0>;
-				status = "okay";
-			};
-
 			uart1: serial@f8020000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1_default>;
@@ -533,12 +523,6 @@ pinctrl_macb0_phy_irq: macb0_phy_irq {
 					bias-disable;
 				};
 
-				pinctrl_pdmic_default: pdmic_default {
-					pinmux = <PIN_PB26__PDMIC_DAT>,
-						<PIN_PB27__PDMIC_CLK>;
-					bias-disable;
-				};
-
 				pinctrl_sdmmc0_default: sdmmc0_default {
 					cmd_data {
 						pinmux = <PIN_PA1__SDMMC0_CMD>,
-- 
2.25.1

