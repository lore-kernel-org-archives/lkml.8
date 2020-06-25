Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F64C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112D1206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yAkZzlAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbgFYKJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:09:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:20063 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389646AbgFYKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593079783; x=1624615783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=91wcyIUMXvrszLtEiAYcm3v1KkXgyJ9lJRfph/lUfUM=;
  b=yAkZzlAiKEe0iVyJvWdbP7PSeRajuYMVV/+2+UMcR+ACUK+lsNBDHK2Q
   Z6mcUFVuyTXMUVJUSuAN3lqzBv+U6k2HNr7jWACO365fRUNxpp3kFMApn
   qkyZaFhGhE+sQaj4fk8U2P10T8L86GGtgcQYLxxByTvQnkWLnqouyYJt0
   7BksTLlRrInQDkdNlY7smcTVGSnmtUHWWc4ugsVE534Ha3+cB4EWOhtyC
   gsEh7ZxsAjgwC87Q+18IEBa0DAGVJQ8H8Wpe1G2igEGIA5FaPQkT9a6YO
   3FkSPOcpHlcHU8KaGKe9zr9ZvBq5NakJmZ5/JVqeK/QNnwpO0u1PLMugW
   A==;
IronPort-SDR: 3h7MP/Kw1EztnhrxpuyFO/5vmmb6b0aJ0i+b6BD2UmPTng9SIQUBK8BHEGcefl2n4n0d990fnY
 FzClEBR0ile38wSUyvAiggCEEjCKnQtnyLKATbh3B1cyqpynsAW7bsfoVDYPNJmGAyyRqYv2a6
 M2CTSD1rPkQdge3JzWjBsCyUIuTHdTz8IWmjVApJKqx1U7yU6NlVmnX3sKfkFAemcKiKpMlFSY
 L6dLdgZGuOqzMBTeEMro419YJfV2ommazCw28EAX7+D8aJ4bUDfuXuxnkQNWaUgXVSXkz3k5LD
 m/w=
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="85037929"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jun 2020 03:09:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Jun 2020 03:09:28 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 25 Jun 2020 03:09:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-kernel@vger.kernel.org>
CC:     <mturquette@linaro.org>, <bbrezillon@kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] clk: at91: main: do not continue if oscillators already prepared
Date:   Thu, 25 Jun 2020 13:09:28 +0300
Message-ID: <1593079768-9349-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593079768-9349-1-git-send-email-claudiu.beznea@microchip.com>
References: <1593079768-9349-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return in clk_main_osc_prepare()/clk_main_rc_osc_prepare() if
oscillators are already enabled.

Fixes: 27cb1c2083373 ("clk: at91: rework main clk implementation")
Fixes: 1bdf02326b71e ("clk: at91: make use of syscon/regmap internally")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 37c22667e831..46b4d2131989 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -74,13 +74,11 @@ static int clk_main_osc_prepare(struct clk_hw *hw)
 	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
 	tmp &= ~MOR_KEY_MASK;
 
-	if (tmp & AT91_PMC_OSCBYPASS)
+	if (tmp & (AT91_PMC_OSCBYPASS | AT91_PMC_MOSCEN))
 		return 0;
 
-	if (!(tmp & AT91_PMC_MOSCEN)) {
-		tmp |= AT91_PMC_MOSCEN | AT91_PMC_KEY;
-		regmap_write(regmap, AT91_CKGR_MOR, tmp);
-	}
+	tmp |= AT91_PMC_MOSCEN | AT91_PMC_KEY;
+	regmap_write(regmap, AT91_CKGR_MOR, tmp);
 
 	while (!clk_main_osc_ready(regmap))
 		cpu_relax();
@@ -186,10 +184,12 @@ static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 
 	regmap_read(regmap, AT91_CKGR_MOR, &mor);
 
-	if (!(mor & AT91_PMC_MOSCRCEN))
-		regmap_update_bits(regmap, AT91_CKGR_MOR,
-				   MOR_KEY_MASK | AT91_PMC_MOSCRCEN,
-				   AT91_PMC_MOSCRCEN | AT91_PMC_KEY);
+	if (mor & AT91_PMC_MOSCRCEN)
+		return 0;
+
+	regmap_update_bits(regmap, AT91_CKGR_MOR,
+			   MOR_KEY_MASK | AT91_PMC_MOSCRCEN,
+			   AT91_PMC_MOSCRCEN | AT91_PMC_KEY);
 
 	while (!clk_main_rc_osc_ready(regmap))
 		cpu_relax();
-- 
2.7.4

