Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3AC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B00E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jd6rxWIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgGVHix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:38:53 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:58066 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgGVHit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403528; x=1626939528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1lgGYgjpKH2HGPHaQHzzdMzBnMOFYGIAlTJ2p5Kf5wU=;
  b=Jd6rxWIV5X4U9xPBR0zPV/PhUk77eifNRCMoWDd22sVhLttczsBOw1DI
   HRyIU4Jnr96Onp0uzHugTr6Mzv4/r3nCRKzvfj+4BgNJVWFjduojx2MCp
   dpvsUi2kEVSTSDkoO/obgcoxuBNgKvkMjvAZnPWNwk9nRTYWxdPbe/KiN
   KxmMfLQVNGemn6blIk0LK9eojgc95B34bYX3z2zkR7LFBxFwAJzScbfrA
   x7R2uyHEkN34aR9LkLIQ7+qjGBPmcOhd24gTZf0c17yRq1v7AaL7jF6A/
   MeaV88/AgQeXlxUf5h/3ItfvG3pA9fYs/z3L/O8fX8KHmyOv5ijL8QK2g
   w==;
IronPort-SDR: cW1cbX+autDWg6THeeQ1ukLA4jZOGqtLAxReC21dFS7YZN/RTWXu3rIHFM9KsXh22fkqM7WvzF
 7itHJ86DaLwTY8qUc6E890eQgxuis8ujiRA968r3Su0mM7ppQhyDTEpm+09lYZT5M9hIcxlZ0b
 kWj9p2pMN1f23enX2wZdirmiSDuaOwz6h5dvgvkBD9bSszta19ibaiVesjfc5RJlz2JP5LaGEa
 ioOxi/LDynCQmfAo9sJc8aEc/BTdpJkKdCfgFFov+5m/wJNl2UB8HFm+QQvUw3Xp8cn22tgPI9
 f+I=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="80862097"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:38:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:48 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 04/18] clk: at91: sam9x60-pll: use logical or for range check
Date:   Wed, 22 Jul 2020 10:38:12 +0300
Message-ID: <1595403506-8209-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use logical or for range check. In case bestrate is not in
characteristics->output[0].min..characteristics->output[0].max
range we should return -ERANGE.

Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 3522eae2edd6..4b7b6c435d4e 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -231,7 +231,7 @@ static long sam9x60_pll_get_best_div_mul(struct sam9x60_pll *pll,
 	}
 
 	/* Check if bestrate is a valid output rate  */
-	if (bestrate < characteristics->output[0].min &&
+	if (bestrate < characteristics->output[0].min ||
 	    bestrate > characteristics->output[0].max)
 		return -ERANGE;
 
-- 
2.7.4

