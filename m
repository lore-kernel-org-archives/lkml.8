Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4473EC433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1649B2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TIynM0Jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgGOLZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:25:14 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62473 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgGOLZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812310; x=1626348310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eMYiczZoooU+bD36WSG4xqAZTjUj5NiLwkluOK7Exls=;
  b=TIynM0JoIeiJAidz4fhLoAOo7LoaJHWSWzyWpNc2fky2xSbR6kmIFWfJ
   v1cXsZ955MA+6JRI7WzT5aFPx6RlaFKaRI0Hzavau6UHJglwvukOCdQAf
   vGGAL1SIJ/hfPa2vgzs0oIJRQfC1qOVqQ9Zt8Oip5IQ8gr9XfNK8Xg0Bb
   J5HFxqcjnFYhqbqoLJCnD8W5AzWxsJj7zRmkvz+YxCoyXqw6mcRqhqrLN
   NxsdBSlCEBwkOdeQQxse8xHzLigm7gnvvwTUf+WTqdbQJZyaez7KmYtmp
   IzdLc4+XV2MfQulBIoXkdl6RAlObuH0nZAEJL5AdaEtuAXU78cSsaKE6E
   A==;
IronPort-SDR: F6+ctOcpSq1Vdg7zWetTWvdqIEBMbJLnJGV9/pcxoVw0sLirG0GR2KYdboVycLxJ08qmja2Jpm
 /rBF3GKZR1Bql7yrKrP6ieTw+0Po/2IgPN3PyX1shwrLREhjmNFCUARZlTuPo8ZHmJknljLGPS
 Wqt3m4G2LZfdvcv9JVlpZGRBesQlumBZiz/J1odMwuRx7UWUAb1oM7Tf4bHKJ5dkzlIgOZHYTD
 3uVEM5j/TwByZefnDYwkRLTnzi8EJWD4DJvTxlt6cvBjZznLps8BGpWvIPGETOHya4gQWstvWl
 PcQ=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962852"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:25:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:37 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 09/19] clk: at91: sckc: register slow_rc with accuracy option
Date:   Wed, 15 Jul 2020 14:24:17 +0300
Message-ID: <1594812267-6697-10-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register slow rc with accuracy option.

Fixes: 04bcc4275e601 ("clk: at91: sckc: add support for SAM9X60")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 15dc4cd86d76..2d65770d8665 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -471,8 +471,9 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 	if (!regbase)
 		return;
 
-	slow_rc = clk_hw_register_fixed_rate(NULL, parent_names[0], NULL, 0,
-					     32768);
+	slow_rc = clk_hw_register_fixed_rate_with_accuracy(NULL, parent_names[0],
+							   NULL, 0, 32768,
+							   93750000);
 	if (IS_ERR(slow_rc))
 		return;
 
-- 
2.7.4

