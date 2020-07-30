Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0519C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BCA20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lI6HSdOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgG3JDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:03:34 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:54833 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3JDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596099811; x=1627635811;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wG0qc9Qe3PmllwLgrljUElhepPvWWpfYNaS3kbDUyic=;
  b=lI6HSdOsCb9fPW3NAwFhwI1/ga6hveAcvjMeWTtTo26KeaFBQY8lTUOA
   jgH5GUDBWedrT07anJegr7pBnxpGprCBjWY0lPoFbHqwLzoBMQ0otMsP7
   PUMeYJj0JyWRu4DAjcYMqZVlu96Azhbl4fi8Hll3gII8EI3hl50VKw+Kw
   EpCNoQZbKP5RoYUzG6ORex9Owbql9mX+tltXmiqrpo4fHVNt6jHQqX667
   Hw+QMr2Uy6CZWRcjvEHSwBJeKgj7qmzK4dCtAPJ5h6/lF1J2EQSNFbF/s
   bjGSJDIDHb1Fem7QD2o+tXed61NuzLJdRx/Z9nl6s3bZbLHLP+uOFfhyP
   w==;
IronPort-SDR: /LnkmD0fcoQxRE5257n9DoPutsYPD8XlBWm6digJP66ACvdxM74XPMzlytKlYpjnMrRA93ypUC
 JXRwfIqabsQ7nb+HaVxXrEZ/+CM+xOvpE+063JYq9StAxiWt1/hRHNFIplY0trc1nqKpxEiXgx
 jlxMjL+PW+7HipneCPkmp5mBhtHtsDV1AvtHkxWSf76i1dQFUW0Utd30PCFJ85u3GJKv38hRvO
 FvVn9LJT9bVlLqHKeEAdHqUp14VcCWViGm4zWDhD4xgfaA/fW0NhTE3eQBs8XEaazqwhEXwt9X
 ixA=
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="21081936"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jul 2020 02:03:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 02:03:30 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 30 Jul 2020 02:03:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <mturquette@linaro.org>,
        <bbrezillon@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] clk: at91: clk-main: update key before writing AT91_CKGR_MOR
Date:   Thu, 30 Jul 2020 12:03:23 +0300
Message-ID: <1596099803-1393-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA5D2 datasheet specifies on chapter 33.22.8 (PMC Clock Generator
Main Oscillator Register) that writing any value other than
0x37 on KEY field aborts the write operation. Use the key when
selecting main clock parent.

Fixes: 27cb1c2083373 ("clk: at91: rework main clk implementation")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 5c83e899084f..cfae2f59df66 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -437,12 +437,17 @@ static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
 		return -EINVAL;
 
 	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
-	tmp &= ~MOR_KEY_MASK;
 
 	if (index && !(tmp & AT91_PMC_MOSCSEL))
-		regmap_write(regmap, AT91_CKGR_MOR, tmp | AT91_PMC_MOSCSEL);
+		tmp = AT91_PMC_MOSCSEL;
 	else if (!index && (tmp & AT91_PMC_MOSCSEL))
-		regmap_write(regmap, AT91_CKGR_MOR, tmp & ~AT91_PMC_MOSCSEL);
+		tmp = 0;
+	else
+		return 0;
+
+	regmap_update_bits(regmap, AT91_CKGR_MOR,
+			   AT91_PMC_MOSCSEL | MOR_KEY_MASK,
+			   tmp | AT91_PMC_KEY);
 
 	while (!clk_sam9x5_main_ready(regmap))
 		cpu_relax();
-- 
2.7.4

