Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9071CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D9F2071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FKRycT0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgGOLZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:25:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:21114 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgGOLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812339; x=1626348339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qmtse3ezZBDbL3lav7ENe4KS00OrB/uSxDu7u4s5/FQ=;
  b=FKRycT0qHcP5dPFZMr88DFMQMfdRaq9IE7KuP3TVaLz/j4lWGsivwmIY
   i3c9pwli6+HcAxwVIEH2Yauple3Yy8OIs3H36IU4EXVZ2JAbjkGKHgQuh
   dSiCYK1PdxieTX2y9UhpYYic8WB1eDjO0l8ZpAy3ekZT6FM1FBlBzT8tx
   PeFW3XszphItooEu2Vo67EdYi9cQo0uVhWirqbSIaBaVbWEXz7/CHHu3v
   5JDC1TLcm0UhiIk4Oa9MFycrITe3JST/ZlzBKWKnnsrRZtNrG4+pGLnmw
   VUsNBAXPQmlsUQp+QZ/RnxfnVwA5oHla9VF5dMj8FziLgkECaXLtmjzqF
   g==;
IronPort-SDR: EQwujtVKrhhOhBjpKG1nVKcbLZ2qESYQlnGwFARM9NouhC6OjDJZlV0pRHVceRkyf2m4436ZX5
 2q8bRdMraKf0ZFlSFzwDOrKFWsOb749pfPQA68suyvR6ajrlHvVaOJlHOFgZnQkKkazZ1AydzZ
 339mcQgjYAXbKi44MLdJWxUHmH+/NqYnkD0NvMR3YiSibY8rC1fJECuqywFK6EL7N+SpHTsN4s
 HQriu4Ms6uhOku5S1LqU2AAiI4c08lsYWi13vl00MNn1Uezy7ai1JLJeK1ganhRLj4L4CYEn4I
 iMs=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="19269536"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:25:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:25:38 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:25:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 16/19] clk: at91: add macro for pll ids mask
Date:   Wed, 15 Jul 2020 14:24:24 +0300
Message-ID: <1594812267-6697-17-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro for PLL IDs mask.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/clk/at91_pmc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 77d6dabc4c3c..dc5e85f124e0 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -59,6 +59,7 @@
 #define AT91_PMC_PLL_UPDT		0x1C		/* PMC PLL update register [for SAM9X60] */
 #define		AT91_PMC_PLL_UPDT_UPDATE	(1 << 8)	/* Update PLL settings */
 #define		AT91_PMC_PLL_UPDT_ID		(1 << 0)	/* PLL ID */
+#define		AT91_PMC_PLL_UPDT_ID_MSK	(0xf)		/* PLL ID mask */
 #define		AT91_PMC_PLL_UPDT_STUPTIM	(0xff << 16)	/* Startup time */
 
 #define	AT91_CKGR_MOR		0x20			/* Main Oscillator Register [not on SAM9RL] */
-- 
2.7.4

