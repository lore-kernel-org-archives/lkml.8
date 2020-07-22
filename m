Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ABCC433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C7820717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x+CkIQDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgGVHjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:02 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:35864 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgGVHi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403539; x=1626939539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HbI5cF3OYMyGbFK5qPGOxrEwnelSO1uMUt0DzfCXgCA=;
  b=x+CkIQDhKMsj2bm6pG5Au/OLZwgDvj+XmY/+poNE2S8hdFN7w/QKAA5e
   qHI/8uoCaVd3myjTzV7Cq7wBPHALi+K32/8dh4sGTzruJo6D7dQEw/71Y
   w2qrOpZJ0j3aSPq9O8u+2Mmt1dHI4IDDQusNxUt4nKntgiCkH/OG0mqtn
   lcKW4yA4foQvP74IgnwgBtKM1wrQNk59pCGxGxV5ghTopUDXf6v7aZVXH
   Btr9y9ABKpfxNYOPqMZTEIcDQr+zZg1Y5Vg4CI9qRr9PDu9mOrQXOK/6i
   bTpFhvCrOzm4o8XvFk4B53QFENIoodDi3vfNpbs9ggqhcaUwnmrRmcjhf
   Q==;
IronPort-SDR: AwrrQIxW8b0dUrRmQtOUyrDOI6upapy2dBYI+xdzDv46tVoPWYgOayqCCsWRbM94xLEsJSPEpI
 2djw56oQ4JtQ7Jejodvl3j4JUp+JUhQpjiL/JFX8O4FnhIWvvoIks6oz+/enkBtCNkRFQBE4ix
 O2/7E+I2509nSog0PK9uanW3J1sGtUoRgKW+bLY+0oQxwHV+L4qHlHmIRRWEIa3ZZ//iiGS4Q4
 ENFeLKSeglnrJ0IW4Ed5tKmjmCwSbpTUE/tic7mvyxnWcLF70SSFz5sR1btZNIPAs8c0SFcFik
 uPo=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="84153148"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:38:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:19 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 07/18] clk: at91: sam9x60: fix main rc oscillator frequency
Date:   Wed, 22 Jul 2020 10:38:15 +0300
Message-ID: <1595403506-8209-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Main RC oscillator frequency is 12MHz according to datasheet
(chapter 27.2).

Fixes: 01e2113de9a52 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com
---
 drivers/clk/at91/sam9x60.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 633891b98d43..c8703d2a0886 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -189,7 +189,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	if (!sam9x60_pmc)
 		return;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 24000000,
+	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
 					   50000000);
 	if (IS_ERR(hw))
 		goto err_free;
-- 
2.7.4

