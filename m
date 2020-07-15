Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A62C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400352071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MmJs84Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgGOLZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:25:09 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62473 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgGOLZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812305; x=1626348305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=q0QHavN+4u4pBE7FBk+0bFtl4QwLcu8qUHdEouMfQVw=;
  b=MmJs84JetQJNdKhGj4F3TlfeQ46qB+nMVGPJ2e4wM+6TXERTzNKXXDUd
   6qFDMH3FQrW0gU/x+spqUkPUgsw+Tvkfc1VWxly1WGgplNfAJzifJv59h
   5hCI6bB2sn4kFWwZcdYkPbFKOxfxFKnubyKedD0nTOO4lHzgGsJMpB+5j
   wBTCUDYurK4GYvv+XP3DcDOR8CnvtySsHTypnnoGy9OUCCMO28OYkqbga
   hULQ96KQF4gqeDL4s2w2hxOeWzA+hFW50i0cmLV5iy8qS3JSYdeDwBz9V
   7Rvb0EMAdv3KznGwGKlpmzq6q5V9m4B1N2DpqiYo/QQIq3EwXtrkE1VGy
   w==;
IronPort-SDR: 6EOZa4HQg7p6Cq+e2uK7h6GG2kPJEh8yS8WAW5F3di9UMfM+7vIfktI5v0LTH43tpi3YN3TBJQ
 qCAxCroEzsunNCaZQWak0JNaFatXz6rKpomNZ4vyNz1Nl7YuhuFUmz+aYSlAVYFjRqKRPoWApX
 M9RqRNJmoVvjUDjxIOMM88wBL1HLihaEVfTnuCS8u4ixtOe8isEVwH/wRYFhunZG5UyjqAl2kW
 vyfL3JWL64+oaI5rJ158KEoWBu0KUeNhtJuRm4/uHOhzCFsNWdaajSWpKcQAf+zgU6wj2JYK8n
 D4o=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962834"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:25:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:33 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 08/19] clk: at91: sam9x60: fix main rc oscillator frequency
Date:   Wed, 15 Jul 2020 14:24:16 +0300
Message-ID: <1594812267-6697-9-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
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

