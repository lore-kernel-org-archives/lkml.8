Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96046C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615620678
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AnlXiIj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbgDAWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:15:25 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:10819 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDAWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1585779322; x=1617315322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BtF59sclgbkIUzvGZx2S7plS672x9H/QbHOQARgSAcU=;
  b=AnlXiIj9VXntqrlMWg/h8TffNOqeWxZHSrFOzgrQkttI/BqkAlFS5BWx
   OJIBbOKnMmjRGXiWrvpfNGocRrD+BSlX286nSJARYXftZ+zm2MubDfSaU
   YbsRIp/Oe2wCRaiM1bBK0sPdkTzgL4/r8bEneWzD7L66KXZOaf7P5zXiR
   6dgYJCg6yN26OsAvLnROof0g14beR9MYjINEMqj6PNJKDRgTOIgH0P7RK
   AAaMYsmb8Z21LAw61lWUxSBA8xE2CPW2dAvBuaai4uyZjSRfD1rXeGzn5
   IEKVybKSJn8y9UWfAZ0NseSxxrwztIKeCA+/a1v7vb1Ua6rBQBmbVXFxk
   A==;
IronPort-SDR: l8b7xfUpbftgwzw11go+/tr5dZfwAZG88vElC8C3BXAdVX7HONFdsjLmE2guogeTao6uCIOTBp
 +kXoiu0Bwi21uN0yd0AEpISP+Zeg91MO+mnY+jIhgI5SV+qJkXT9LA/APHxrNM0U87bozL7Bg/
 E7e3ifpr5u8AS4EC0NJTXz0Gx1j5e5Iq0yL9uNd8RVVZlq/27DraE8cdDh7joc2TrH4CFdywi+
 qGoVgfRmHio9ObfUtChNP5Jz/TgIN7rXPsUq+IgyVAam6WnPS4PSyXX3t0Vz/7FNFXK3sDziOR
 dbc=
X-IronPort-AV: E=Sophos;i="5.72,333,1580799600"; 
   d="scan'208";a="72005459"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2020 15:15:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 15:15:28 -0700
Received: from sekiro.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 1 Apr 2020 15:15:25 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH 4/5] ARM: dts: at91: sama5d27_som1_ek: enable i2c0
Date:   Thu, 2 Apr 2020 00:15:03 +0200
Message-ID: <20200401221504.41196-4-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401221504.41196-1-ludovic.desroches@microchip.com>
References: <20200401221504.41196-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable i2c0 controller.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index b0853bf7901ce..1a26e1a129319 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -115,6 +115,13 @@ uart2: serial@f8024000 {
 				status = "okay";
 			};
 
+			i2c0: i2c@f8028000 {
+				dmas = <0>, <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c0_default>;
+				status = "okay";
+			};
+
 			pwm0: pwm@f802c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mikrobus1_pwm &pinctrl_mikrobus2_pwm>;
@@ -281,6 +288,12 @@ pinctrl_flx3_default: flx3_default {
 					bias-disable;
 				};
 
+				pinctrl_i2c0_default: i2c0_default {
+					pinmux = <PIN_PD21__TWD0>,
+						 <PIN_PD22__TWCK0>;
+					bias-disable;
+				};
+
 				pinctrl_i2c1_default: i2c1_default {
 					pinmux = <PIN_PD4__TWD1>,
 						 <PIN_PD5__TWCK1>;
-- 
2.26.0

