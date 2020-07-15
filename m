Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD6BC433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11162070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CXb0loqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgGOLYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:24:52 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62426 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGOLYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812290; x=1626348290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=T1OYveV/D+zKAKeQwDPMk7Yyaqe/yTBKNsdgc95BSbk=;
  b=CXb0loqHDaUhfMm0kNs1BtvUELoia21+lxkercPyyLSSb9U3DE4U6VHb
   Hm8chSN/L/cSy0H0wVq5LLaNmxVsy5Fo0u2v8RFbK38T3qExbwczy85/m
   tDwCFlnvKos+2a8J8DmdUGMlVJ8JdFFZECRT1ZnUFb4Qd9O8DeL1HVEaa
   ni5Ke72mE8Bp+KATtg0+/64jSSbzDXPu2wXFjS10e13sQfzlIPYliZJVq
   i0s10UdOn3z4lrY2qy8xsAV20syaTZDRjr1xdN82zmeEywRbpKjRFcz8G
   XEXiNIcM+phlcffPuzgPr5NEXTGJLxt43M9mAp6kYoot12J7kFwdf0jCv
   Q==;
IronPort-SDR: ViUFu9WFGhwE9g7juizxJ6T7yuXVEYnfiqsGkltEd2s7kBf2xIUKUDKH7kFUJ1ImoEHSyimq26
 fTueqBKHmkx54rWzfv0Zjqo3dqHVZta3HZnd8eMmFghqnnkZJoQUBs4EulVWh/4zV7oYm0bXqj
 LC2iqOhIw++KzFg7AnEIcb3L4xQs5uxnnsV+EDCzWFwiZUl1u4wCw43anLlB2Ert/KOlL90BVa
 07i93OT51NnaE7atMqOcdjtnb7MJOO0yFCZ+ZMpZ0ruROSAmf8YcxClidO0UnFm2UapvzgIKjf
 ESs=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962792"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:24:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:49 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 04/19] clk: at91: sam9x60-pll: use frac when computing pll frequency
Date:   Wed, 15 Jul 2020 14:24:12 +0300
Message-ID: <1594812267-6697-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to datasheet the PLL frequency is computed using the following
formula: parent_rate * (mul + 1 + frac/2^22)/(div + 1). Use this
formula.

Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 3522eae2edd6..d3152c0afcbf 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -152,7 +152,8 @@ static unsigned long sam9x60_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
 
-	return (parent_rate * (pll->mul + 1)) / (pll->div + 1);
+	return DIV_ROUND_CLOSEST_ULL((parent_rate * (pll->mul + 1) +
+		((u64)parent_rate * pll->frac >> 22)), (pll->div + 1));
 }
 
 static long sam9x60_pll_get_best_div_mul(struct sam9x60_pll *pll,
-- 
2.7.4

