Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6466C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD6F20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="deeLgNWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgGVHis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:38:48 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:58066 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgGVHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403525; x=1626939525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hHros4fcZJfU9v/gZJzhgWJKTtRuOVxufGxJgvyWoMw=;
  b=deeLgNWVZmMyumClhzpkiFtef6akk5pjycOFB55IdRBsuog3Gkbt+a7n
   r2DI3CwrXmnrSo6y9KsMc8MdGI3jlfTahOhAwsVJiLs3wgWl2IRlGR4O9
   xoOOIV/1v/hVb9kvN5Sqc67Z280qFVwbrtVYPAhckPxYNlLDZLLwcN1+K
   bFjJ2SMlH6wvUdNZZfLOAi1QXZmMWUYHYl7iAHIh6SsmqKtcmgG5/wbg5
   h/sdYH2pI6bQ2jXdcIpbX7aWKTVGKeoCtmr8ibc+61S7Q8kWUwVO3NsVP
   8zKk7FgzSKtP1NsVIPwOm/wakp9GMlCnJo5VrYK7fuIYp4uWR2HCQ5nic
   Q==;
IronPort-SDR: TbJOFFs4ZntH+xGmLgA2YDBXjbn4U4YvSh/zTd/SGETnslZ446AyNIx9yg/M04Bk7wE7GLyMhY
 fWz87Eqgn1Gan+ACSSEekHnQv9sYTonK8tWmsK2Q6ATTBI+kDHl5delSffx3SoJ3Hu6OZe4I8r
 0HAdkvUE8h70S4BTJIQPiPuFCZJA2UPA08Q7bA6D/ZtQn56NNsFN+99GcMmb2A9suK+tOxsTQC
 T+xqiA96A7hXSixFtN4oNiBtreoRpG/JB6tiI35D9O0M1xlvryavWKZgPrT250Hmc+2QrfeSwE
 asU=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="80862085"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:38:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:04 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 03/18] clk: at91: clk-sam9x60-pll: fix mul mask
Date:   Wed, 22 Jul 2020 10:38:11 +0300
Message-ID: <1595403506-8209-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to datasheet mul mask is on bits 31..24.

Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

