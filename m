Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B6BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146612076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tD2s/s6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgHYG7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:59:30 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9439 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgHYG70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598338766; x=1629874766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IQ3W6SU5sxrboBq5t8pIzes6VBRBmqD928/Ulc8ETT0=;
  b=tD2s/s6Ma65qnmJthiLnoYUhxDTo4jzPkqZUaR4fIHUWwXlZD/MLfWIU
   2sjR9DPHzRLUwUfn6D58+JEXaHrS3l3mfjGW/PmBTcBIbtGKoxGI9lv6S
   FbRd/PAoolNHc/aUrh7VJtgdFSo/cuTyWTSsVkxEbzjnm9DNihCuh5Ex6
   ac8D/j/DHb8BUxKEG9MAo4TMyl5FFfbW9oPvo7jP3UVUKn08rTDYkzPeo
   yeV7h8zl5FDN8LfJiSoJJ/lk9hxGSq6AZfyATOKZj1yfDx0SRXTutFnQU
   tx10kiY+2HqJL4nYtAFfaAdU4BE9M9ZQxE0YLZf13qkGexPhKCeuiD8oI
   A==;
IronPort-SDR: Dq93KiIJVzmKnFPK59vhOtHy2KkvpPDco0kUNkAaIL/iWvcUUNRl8gsW0w4g/UE3r1dNu7RNdx
 BC/5NqM5OldhJc5BSlfjIa2PO8gH+bf9ja3O0D/6uou6KPgoroEUCNDMPzHhp+A5hfoYh3QE8W
 hriWe/ytojaSY7X3vi+AuBxRmvAnIDXPJY2perHORI0BbmNhMkA0DawGuuNnjjIhoreho776iz
 sDgw2KFO6BNg2qfnA1ozcPfbWNHZQzNcIDgTpORUhQwb40Us0J/NxsZ+UZAP/CETOahUyQthy1
 gUk=
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="93013773"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 23:59:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 23:59:24 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 23:59:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/3] clk: at91: clk-sam9x60-pll: remove unused variable
Date:   Tue, 25 Aug 2020 09:59:11 +0300
Message-ID: <1598338751-20607-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com>
References: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix variable set but not used compilation warning.

Fixes: 43b1bb4a9b3e ("clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple outputs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index b473298ef7e6..78f458a7b2ef 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -331,7 +331,7 @@ static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
 	struct clk_hw *parent = clk_hw_get_parent(&core->hw);
 	unsigned long tmp_rate, tmp_parent_rate, tmp_diff;
 	long best_diff = -1, best_rate = -EINVAL;
-	u32 divid, best_div;
+	u32 divid;
 
 	if (!rate)
 		return 0;
@@ -352,7 +352,6 @@ static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
 			*parent_rate = tmp_parent_rate;
 			best_rate = tmp_rate;
 			best_diff = tmp_diff;
-			best_div = divid;
 		}
 
 		if (!best_diff)
-- 
2.7.4

