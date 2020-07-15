Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B5C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3062070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X9usl+cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgGOLYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:24:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62426 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGOLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812286; x=1626348286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NWRbAXwZzlbpLpztrBRlc5oG6laOjJ+4SYUh9eKkE6c=;
  b=X9usl+cZ7+LFR/izz88E2XpQb1dV/CwR7lVwGwqikstLx9k9r4V2XAZc
   Ctf6XE04JUUOE6ogDSphVQq+BVF24ZKpcuMBmVjtIrUklnqNcTCuo68PZ
   Ho38s72uCoKfbZ1i42cGyV7omeRqN+nCmahXTJjScKu+V86B4W5Dh6JWg
   XFOGv6cuMOc/4ZA0/H6+IdxF3pJL+g8aezkBa5KG8Ywh+8BfeXwAe1f3q
   utymZKcFKWE4yPmokLwFYtmJ3IqtUMH7yreMy8zQz/RoS2Z++FiSRGIvj
   Kuq2HbWl8DIti6c09t7WJUDc2p4vBvqdkU0TzPVcoexDF8+Cu0qjCX8GA
   g==;
IronPort-SDR: q2TgooqmdlrZEw/PuKHZ5C1flNs0OoCwNLqcwEkyEeD2ZxbcVA4Zgg5fFnzb12pHrRRjrtEiEp
 r2v54TW7v6/c1ih47MoytP0/fHICopr3ZNpGF/j4XO5k9HzGblECTxbvuR2Ant0qER8m0zFRlB
 n5W0lW4EoPxfScra8TrTcv+mgz9rH7i8CgimljWb3eriyZwiJdNyd2tScwdvJe0frBFJc8j3Dg
 MGU6lVLA/R37hUc6uuuzFYDOJzsnrwKEGcYnkOlnFXOVA7TCyrDLdqsIYniyRLruGcIPz3WOJg
 PKY=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:24:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:13 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 03/19] clk: at91: clk-sam9x60-pll: fix mul mask
Date:   Wed, 15 Jul 2020 14:24:11 +0300
Message-ID: <1594812267-6697-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to datasheet mul mask is on bits 31..24.

Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index e699803986e5..3522eae2edd6 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -15,7 +15,7 @@
 #include "pmc.h"
 
 #define	PMC_PLL_CTRL0_DIV_MSK	GENMASK(7, 0)
-#define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(30, 24)
+#define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(31, 24)
 
 #define PLL_DIV_MAX		(FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, UINT_MAX) + 1)
 #define UPLL_DIV		2
-- 
2.7.4

