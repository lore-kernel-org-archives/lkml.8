Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7287C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88F02082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAQLhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:37:10 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:31118 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQLhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:37:08 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: +THYlIReojd2pTnrIYp9EOu43ABvjuupJHa+0w78XIj8iY5EBHtut0iOP59pklRu/Zl8VB9Duv
 TqLJnEB4TCoCbfWOYS3yRvYb0+hQt47PZwM3aUfSjZS/UuxgGIBdYHIKs5gkM3xmmCAUDmzaCf
 gdG2A1072r8Y1Kty3Zl2Zxnn4yR7a/7RaiVESmsc01Sxj6KCw6Q32LG00KvPkuD2qUhRU7yOVg
 QEekcaF2dZtjNS4KJwX4XCmyjcy5zVrsbFEA6MOJgiWJRo4CCbf50e/wx7G24SU9LDrt4JlwsY
 Sz8=
X-IronPort-AV: E=Sophos;i="5.70,330,1574146800"; 
   d="scan'208";a="65083787"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 04:37:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 04:37:08 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 17 Jan 2020 04:37:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/4] clk: at91: sam9x60: fix usb clock parents
Date:   Fri, 17 Jan 2020 13:36:47 +0200
Message-ID: <1579261009-4573-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAM9X60's USB clock has 3 parents: plla, upll and main_osc.

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sam9x60.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 77398aefeb6d..7338a3bc71eb 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -237,9 +237,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "pllack";
 	parent_names[1] = "upllck";
-	parent_names[2] = "mainck";
-	parent_names[3] = "mainck";
-	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 4);
+	parent_names[2] = "main_osc";
+	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.7.4

