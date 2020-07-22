Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BF4C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6D820717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NeDCIzB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgGVHjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:31 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:35912 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgGVHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403568; x=1626939568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qmtse3ezZBDbL3lav7ENe4KS00OrB/uSxDu7u4s5/FQ=;
  b=NeDCIzB52QPQLQGbggTgzza2Vik71dM9YUpRbpF7aHbhO0y0QJZx8xZp
   8XiDvkbLDnaia3kKqhqKFtnWTL23UoMnZb/+C52XiAkDwp+bUgAKw0hEj
   YyE34k+E6KBDofN1/xqSj9NbeoBvfDqr6RfkE688fBK/p207rdV8J1kgM
   yf7j9IvMhTZIBRlkIFGUlO0Na87QdB9iUekDaSW3VmsvBbukGEgnwVsDE
   INe7M9/N8NyoNFl2IuaIvpiSOF/4Hk1E7wNCUphsQG+eurZ5iXiEadr6Q
   K4m6EScxBbhznXPRoosHK46lXef99NXoXOgB+5ln/s4hcRrB7osPQ0/d+
   g==;
IronPort-SDR: mTI/Bz9VvFLKfMGITPfZbe80wnCDtgqMX06VvISX2tu+vrgIU9Og9AhlHQlvva4ZDlkL0bYWeN
 GedqQZIu0nUEy/Qb6ba+6PsXTffUpiz+GD1pmztd1AjLgJstoxRtBLNDpyyntl/+/MMlGWUZa0
 ZI/y8A0+mGHXhwpQERUC765jCncJD/jB5Z+C8zIG0z5Sr1leRuafI4n5sGaoy/1pu7uyCgnJzz
 GI0oHoTLnhjf1zHecZcjaZDcWol0c0oFppHqXQalwiY//rr7xNcoqUK2xKZwfVAp7nt13kGOd4
 Tng=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="84153250"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:47 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 15/18] clk: at91: add macro for pll ids mask
Date:   Wed, 22 Jul 2020 10:38:23 +0300
Message-ID: <1595403506-8209-16-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
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

