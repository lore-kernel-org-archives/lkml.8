Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F219DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0E72076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PTiM1sfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbgFYKJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:09:38 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:54417 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389915AbgFYKJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593079777; x=1624615777;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rnxg/SfWJqBp11CmjXPigJYLMp2gIu1Y+fOu8gptcnA=;
  b=PTiM1sfeveXSzf52jGNuPmuamLALXMK21S2MoylueIRR24imEWqQ/5O2
   rAJdoVH07Ofm1fX1spJUgPK8Xhow4oxA/DKMS8KUGwiAZZb4G7wuQMrQ0
   IdWh9SnpMjqYJL1NvLpj+YR71UaXFL4wHgN21TLEHHzMNWW2Kbk04s7lR
   fS3AqXbSMTTEfCRXGBiNZydiHkMwmeLgQ6hm/y3bxgz767WtGNMq6/3rz
   HfkdKqhg+BDIwg/ryuR6mpgJ5lIvKtqr4hn8fwACfor20lA/qvVvSnCOg
   KpFSZqJxLuSiipdd7WUaKqasvnpySW63PosCLiPY3FertR8WxbV+0e692
   A==;
IronPort-SDR: Nzc1KkoJRY2CYTb7HYfy6DHqtKQf3yvwU5AdJGRKj4WgEQeWQhTitPDXomGb9guBgdJTqnvr4b
 ZNEnTrPBQQWpIE9xTELjrHldR5TWGNVegVJ40KyoJ+k7GnxWu/IhZIVtBZ/OuhZlb0W7cnnQg4
 xsO5KL99AZ+vR36hCjMTx/Ru2odtDKOpvF/ztkNEi9iKOL0NVeyc9odg0T2v6mwWz5oF4n3caF
 5o79zhj3oj7PCx9GQqUiNiOcrrBWqITz8U/FCGRBnCWlmtTqKoKyEG2U6K+wAcWFlfovzQtFcJ
 WXE=
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="80856699"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jun 2020 03:09:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Jun 2020 03:09:23 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 25 Jun 2020 03:09:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-kernel@vger.kernel.org>
CC:     <mturquette@linaro.org>, <bbrezillon@kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] clk: at91: remove the checking of parent_name
Date:   Thu, 25 Jun 2020 13:09:27 +0300
Message-ID: <1593079768-9349-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check parent_name variable while assigning it to
init.parent_names. parent_name variable is already checked at
the beginning of at91_clk_register_sam9x5_peripheral() function.
Same thing with init.num_parents: it could only be 1.

Fixes: 6114067e437eb ("clk: at91: add PMC peripheral clocks")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-peripheral.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index c2ab4860a2bf..4a0f40738fe3 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -111,8 +111,8 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &peripheral_ops;
-	init.parent_names = (parent_name ? &parent_name : NULL);
-	init.num_parents = (parent_name ? 1 : 0);
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 	init.flags = 0;
 
 	periph->id = id;
@@ -340,8 +340,8 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 
 	init.name = name;
 	init.ops = &sam9x5_peripheral_ops;
-	init.parent_names = (parent_name ? &parent_name : NULL);
-	init.num_parents = (parent_name ? 1 : 0);
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 	init.flags = 0;
 
 	periph->id = id;
-- 
2.7.4

