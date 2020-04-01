Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD95CC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BF3207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wuLMWW3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbgDAWPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:15:21 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:55217 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDAWPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1585779320; x=1617315320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=roL7pAuCeMrEZzb4jmaWDZnAb9YNN/kPLY9E/yXOwSY=;
  b=wuLMWW3FwXRruyJ33UkHlrlVcehiMNACtH1cCOHZv3CnT90Dy3YCU8is
   GjYOqNmULz+G4p4fKsmCx3erUsv8tjys6t4zwUa/OH69fxzScHCGLwxyG
   1WwSScGhXS2axAM7fTiFu7FhKAaBFgfgXgg92e6jHYEbqFNF28CfOVOPC
   8VpOofB2MxeSa7ORxn4Mv+HJ8DVXJLz2vmIbjtaWKOZYPIz/ZTvm8wjys
   GqlKJyLyT8vSX+PW0BJNRSNBG+7LtZP9a821dEHqt30GkWHs+qgzcQOpe
   7RhfXZPUT31ZOLteed34lC52IYcyMXVw0kcLVQFXw3xCPBQwmVlmKv9y4
   w==;
IronPort-SDR: vvADddCKU7kNsFIzXcUbE7USJheeTdMZyZITxJSybmvRyMmYssg7QDrD405rrEpdHWrSL+Z8TZ
 wEI3VWAmmwshtLWNJM/clfXC1N/s5C7kMBXUvPjtCc1Es3F+rnrSHcRSELmrcjACS1bqevmDJe
 Vrj2V3EhBfmXyS/3rRJVOTIv5eXL9mwQ/2RiHQ95A0yBaTtB2Pvj1maPt2R0yUEmAa0LMpxNka
 c3g0KUxJgEO5WklD9AIVKpHAoWB8/cLH3BYACMyNu5z/HSxpxLqAlwTRNgiCjngWZL5qg91O0e
 Xeg=
X-IronPort-AV: E=Sophos;i="5.72,333,1580799600"; 
   d="scan'208";a="71132656"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2020 15:15:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 15:15:25 -0700
Received: from sekiro.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 1 Apr 2020 15:15:22 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH 3/5] ARM: dts: at91: sama5d2_ptc_ek: add PB_USER as wakeup source
Date:   Thu, 2 Apr 2020 00:15:02 +0200
Message-ID: <20200401221504.41196-3-ludovic.desroches@microchip.com>
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

Add the push button PB_USER as wakeup source

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index b803fa1f20391..32435ce1dab22 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -412,6 +412,7 @@ bp1 {
 			label = "PB_USER";
 			gpios = <&pioA PIN_PA10 GPIO_ACTIVE_LOW>;
 			linux,code = <0x104>;
+			wakeup-source;
 		};
 	};
 
-- 
2.26.0

