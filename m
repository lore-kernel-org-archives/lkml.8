Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467A7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2243820714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C7AZx+23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgFOJz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:55:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15679 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgFOJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592214956; x=1623750956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GzeJj/XXb+bfDz1yMw3bsPNp+jtcDG/wV7P8Xtgw3Ng=;
  b=C7AZx+23IPibIwIk6jpROLoUlX+kwNg6ris/fvsyGZu6YrSDI4mSM83q
   QK6Q4W6S5A+M1QuGDc6VVonLuIY/EkEHhLvXl4R425m55gh0uneL3wT3Y
   b2xVS2crkBWtyuEBnhLxtfGpuZOdw5v/TxlVOoBq2NCvt7I4zQXDJf8lc
   9t+pT6/vueNaEe0mES0EhTgdzyjNx0XzJ/pcoy+g9PErGtztoQ7bGqC0d
   5BhLZairauYu3a26kQO1Inj8wf1GO+sr1oB7FDaRajXOiUOTIAoicdzO8
   qvb7RmltT8AFmRis7w6YS9nRdUEqPyiwura2sRXKCkKCoDzaGTyu6Qb98
   w==;
IronPort-SDR: FLUh7f3tYdmwYeq/0GKWObURf1q1qgv21VHkgV76si99bxpQJ7GomyUsx6gbCHtDg8FKrTm3Ou
 O9Qu1RWxXaqg/C1/s1KqEavDwxx4SU/4XENFhU9gcWQTuwqFSxXYWcxB6o7wxRqoU2Nk2gNjMH
 NlEpS6tr8nmC5VDHatNayufgNOg7qcxbp/2xAbOAEcsoA3sbK5R8ag2DbjQSNmmI9/iZug+rId
 4R0CpGFWxocpdKyn/sfgmCHj3tpPXEufZMPTezRyvbBm6f0aKTxJDVHePBqBNdqy+YDKbh47El
 aAw=
X-IronPort-AV: E=Sophos;i="5.73,514,1583218800"; 
   d="scan'208";a="76588047"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2020 02:55:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 15 Jun 2020 02:55:34 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 15 Jun 2020 02:55:34 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/3] ARM: dts: at91: sama5d2_xplained: classd: pull-down the R1 and R3 lines
Date:   Mon, 15 Jun 2020 12:55:23 +0300
Message-ID: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R1 and R3 lines drive NMOS transistors that are OFF with a low level.
On the SAMA5D2 Xplained board, if the pins corresponding to R1 and R3
have pull-ups enabled, there is an extra 2 x 30uA power consumption.
Use pull-downs for these 2 lines to remove the unnecessary power
consumption.

Fixes: b133ca7a653c ("ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 055ee53e4773..54d96649da77 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -430,14 +430,18 @@ pinctrl_charger_lbo: charger_lbo {
 					bias-pull-up;
 				};
 
-				pinctrl_classd_default: classd_default {
+				pinctrl_classd_default_pfets: classd_default_pfets {
 					pinmux = <PIN_PB1__CLASSD_R0>,
-						 <PIN_PB2__CLASSD_R1>,
-						 <PIN_PB3__CLASSD_R2>,
-						 <PIN_PB4__CLASSD_R3>;
+						 <PIN_PB3__CLASSD_R2>;
 					bias-pull-up;
 				};
 
+				pinctrl_classd_default_nfets: classd_default_nfets {
+					pinmux = <PIN_PB2__CLASSD_R1>,
+						 <PIN_PB4__CLASSD_R3>;
+					bias-pull-down;
+				};
+
 				pinctrl_flx0_default: flx0_default {
 					pinmux = <PIN_PB28__FLEXCOM0_IO0>,
 						 <PIN_PB29__FLEXCOM0_IO1>;
@@ -614,7 +618,7 @@ pinctrl_pwm0_pwm2_default: pwm0_pwm2_default {
 
 			classd: classd@fc048000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_classd_default>;
+				pinctrl-0 = <&pinctrl_classd_default_pfets &pinctrl_classd_default_nfets>;
 				atmel,pwm-type = "diff";
 				atmel,non-overlap-time = <10>;
 				status = "okay";
-- 
2.25.1

