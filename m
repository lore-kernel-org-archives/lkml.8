Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77235C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F3020782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2DAymgT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgHYG7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:59:23 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9418 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgHYG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598338760; x=1629874760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HgjEgkiKGTzhHa9dedX7zLtx+BB912JMHCVfd4RNaDc=;
  b=2DAymgT9JQbFzU8M2MW7cBIUZZbhtM9OBKJuttv/jwBFhx7gnlTWFgLl
   FlIoiiQzt5kEoW4mVst467I+R/JSvQjOo1u8OD0paGZotni81DtxG3GtK
   yqP1sulkgR497zmIXByGE4l81v8aHjISP/XMzAGkBdIQThWZPl4TShTYV
   nVnX4DMZKXESdRYrVTDpEpCNTClLOX4PMsAULUVApMfPy9VrrBT1l+vdS
   OpWS+ZGQEo5TkggMnFocHK58HX1rb7JTMVTZv+e32FxWcr7ybD2/Z7faS
   grJJGMiQkPxa6X9jUd9lvpIilxZBjwkAVMnM3PRAeEyydvGclEv4R8Hx3
   w==;
IronPort-SDR: RurX8EOmBuNyZZun6JOWBMi1UJoatI1WaYIR/o8QQiPLgTJ/TdLqoSK14cnfBSgwokGNiuOI/I
 r5ONgtF+uZN+L/sZY4pv4frutkTOkMwGnZvaTbe++PO17im1i0DJnJtgZncF5cYUazHU777RKb
 jD0IIKg1lwfSBO0VNpIAoeeRJPZDACHWmOJ35nHy5gkRVKltwZFv80nP3pjcA9ZwYNEypN1g0w
 ydbqwY3+doLgr6Iwasau+mtioGwuHCcyDbkFNDEWHnI1yeKTw/BvzLE2QPK7w/KNDKWzHKBH5c
 8Vg=
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="93013760"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 23:59:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 23:59:18 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 23:59:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/3] clk: at91: remove the checking of parent_name
Date:   Tue, 25 Aug 2020 09:59:09 +0300
Message-ID: <1598338751-20607-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com>
References: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check parent_name variable while assigning it to
init.parent_names. parent_name variable is already checked at
the beginning of at91_clk_register_peripheral() function.

Fixes: 6114067e437eb ("clk: at91: add PMC peripheral clocks")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-peripheral.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 7867eaf0447f..7a27ba8e0577 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -112,8 +112,8 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &peripheral_ops;
-	init.parent_names = (parent_name ? &parent_name : NULL);
-	init.num_parents = (parent_name ? 1 : 0);
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 	init.flags = 0;
 
 	periph->id = id;
-- 
2.7.4

