Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B93C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B779208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cObS6mFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgFRP3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:29:15 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:15756 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgFRP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592494147; x=1624030147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zm+f5NC0s8tHPMJu0+UciLLciIrxqv4wIAMMNwcR3sg=;
  b=cObS6mFQIB5fnu+VmA+7kBOJbvYVjHNv87W+mLMf3KQh0x7cimW75OyY
   LcaGJlfxN93v9VgAxkYrpTtFcrO7J5e+n4szh1Xh27XH4fw/Iwt1IdmIL
   R/1uyufmZJUXv4/Nl9qomST0/DUDnLSG3uX0xz3MTGLaeQ/v1mp0GIL7d
   6P36RdXQvl6nBlCnSeSCBdeTfSerhzi8WxxPoArLMkouhacNodrZAslex
   ZxeX3NGyOiloEwVKRYeCr2IvD9pTMXPoCemmWnUNJNnR2RKzl/33PklJp
   8BcdRH+pU0h0KEwb/TCMOAt6wVh70Mj/mtGEho9SGYGnF9hRK7cl+mXbj
   w==;
IronPort-SDR: BBpKP0k80BnzTU0KNlP6t6swWUaLBzHXrPQ8Ly60CEey804TPvXbbsK0m9ZcnqXXTXx822ANG2
 uTjRRrwsDJ9VfbqeLQKzOHZnHHGzijHMuUujh2w0D0ixwz1XliJhUfghlM28+0Iqf8gNGTADoI
 bOzRHkPl+n1YoaZnqRUXMMfXQYqhVJJz3zn9GTz29hdb3KKVxH5wg/1d64f0eYJIYaOjqVpaMQ
 3pvBw6dGw7pVNd4i5lXU9OiJwxG3/1yI/9RsYapsRpqt0ZS/gONstlQ6mOcGYUxQ7Kcms8rDfj
 26g=
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="16258207"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 08:29:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 08:29:05 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 08:28:46 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2] ARM: dts: at91: sama5d2_xplained: Remove pdmic node
Date:   Thu, 18 Jun 2020 18:28:45 +0300
Message-ID: <20200618152845.682723-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PDMIC needs PDM microphones to work. sama5d2 xplained doesn't have
such microphones, so there is no reason to enable PDMIC and take the
pins since there is no-one using them.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - rebased on top of at91-dt;
 - added more details in the commit description;
 - changed subject from:
  "[PATCH 3/3] Revert "ARM: at91/dt: sama5d2 Xplained: add pdmic node""
to
  "[PATCH v2] ARM: dts: at91: sama5d2_xplained: Remove pdmic node"


 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0e17df568d0b..058fae1b4a76 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -168,16 +168,6 @@ timer1: timer@1 {
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
@@ -599,12 +589,6 @@ pinctrl_macb0_phy_irq: macb0_phy_irq {
 					bias-disable;
 				};
 
-				pinctrl_pdmic_default: pdmic_default {
-					pinmux = <PIN_PB26__PDMIC_DAT>,
-						<PIN_PB27__PDMIC_CLK>;
-					bias-disable;
-				};
-
 				pinctrl_qspi0_default: qspi0_default {
 					sck_cs {
 						pinmux = <PIN_PA22__QSPI0_SCK>,
-- 
2.25.1

