Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD31C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916292076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uhQprA4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgHYG7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:59:25 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:48281 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgHYG7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598338763; x=1629874763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YLBI2VSPJLXETAxNgEX17p7s44o5bRsrSACE1OZwLZI=;
  b=uhQprA4soWwFKYA8WukEbty85hnZ4Zbnz+v1WG7rF/77u9UGJJhU/jXB
   tcVDyV24EY0XXPHPi7DrcLl1a1cOpuxKFaXvZhqK2ztZIskV8OWRyhaM5
   aYOo9hQDzfE7j7QkkfUEZ+f+DQhpqgjF3UxXZeVaie5cygbawOKRi0o8H
   PFG9CRYYgxFV7B7z+T7U9z3bz+vp9sLIoezHQdHkclqn1y4/g94tW+Pdw
   2CmKPebSKkf8K3ibEp/yPv6Ztu+ueKzJZK3Rzdl3Q0h9BVXTqTBu0ZS6D
   CpWW6cKwpTWQuLqe/RxVthy6C8c9xKZRO3PzgVoi0OUEA3sTDtB03Zl4/
   w==;
IronPort-SDR: sm2A0RzpQIxvooQwr2CT1B5KUIYFkmxp2PHcr0kQ0fRbm573/k/k9MhfpzAiibjqlKUNm6QbtA
 M6jMOsRm3qpcd+K4XT+w9WttPOW4BBXjVN19w1j9rI9VJJiTFB6jmYWZ1Jn/hnkOSg67PrOvia
 ry+esOR9m7A5IXU/KqaF3vzH/luqOOhcQI8nJJ9NxyMTHmGnPZ7jQ71mPw+rseQOPT2j5gkmu9
 tP9KDsfVVbTnshPuTZjpVY8vvWz1fs4AWIx7oUVMp9GZa0g2hjZMo+m/tFIOIvcsTDc0fJMPJh
 p4s=
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="84625126"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 23:59:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 23:59:21 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 23:59:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/3] clk: at91: clk-main: update key before writing AT91_CKGR_MOR
Date:   Tue, 25 Aug 2020 09:59:10 +0300
Message-ID: <1598338751-20607-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com>
References: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com>
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
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

