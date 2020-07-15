Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0145C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C569520658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DCXKH6nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgGOLYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:24:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62426 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGOLYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812281; x=1626348281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SnrVXchj5oje7KzV5m8bHCbpwoS/HOfvs9d3eno49eU=;
  b=DCXKH6nqp8d59zRluP4VK+M324Z6k4i0nYgPksxtnatYE33IeYTpO9JC
   MEZOxnXaE6TKCFbHQmizzW5FzoZArcW7xAzUarydrEYW3ozE5ap9m0Fhl
   9n62R4QQ8G/gYYiVxM7/CK6NnDspq5GwNirC8NZvGTAxSVcJMQdhcQpQV
   jYPBG8Z+upNEZPU1Wzsy8FoWN6osLe15GiYAeHo/oA//Vs+54fwkmUPVO
   HrNim2zRtDELGHWdkU4y6eFMGZxNApGaxy9rMAxACdBtCPVwLl8qVwEFP
   4O1PCWYY5HFS6TAZrCrD/eTpESKZxy0LY1D81no6Gn4FfQBLnmjac39dm
   w==;
IronPort-SDR: PXXQ6iws6jNB7HWOdIevOcnYrYk/9g2UBkrGV+A9h60NqbExZ4FrpSUp/u/MIb1DMX0e1IO8Ta
 9f5pXkGfa5cf/DVwWI/tDGgsbHWOPvvA4F/hRHZwK+wrgRIAMhjFYbePyKbyB5I/ZgDs7zJjAs
 xGOLgQ78ySdQ5c5Jr02MuInBAwFoRyMenENGoHA2F50wZO/RNgwtPbCzjPzXhJeJMwWumFp9C1
 EAOYR62I4rmsIA/F6ThJUOHSkNmwtwOIbcOwC3w9RdLdfVZ45BpBZ5CtUNCI1h63wcrMYgSiF9
 06Q=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962772"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:24:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:41 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 02/19] clk: at91: clk-generated: check best_rate against ranges
Date:   Wed, 15 Jul 2020 14:24:10 +0300
Message-ID: <1594812267-6697-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check best_rate against available clock ranges.

Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-generated.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 995a13133cfb..f8e557e0e1b8 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -185,8 +185,8 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 		 __clk_get_name((req->best_parent_hw)->clk),
 		 req->best_parent_rate);
 
-	if (best_rate < 0)
-		return best_rate;
+	if (best_rate < 0 || (gck->range.max && best_rate > gck->range.max))
+		return -EINVAL;
 
 	req->rate = best_rate;
 	return 0;
-- 
2.7.4

