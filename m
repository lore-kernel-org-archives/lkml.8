Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43107C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEAC2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAQLhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:37:25 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55294 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAQLhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:37:23 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Ar/Uh1AKX+S7I+8FoBT0VDPfF3fi+zLtVHMeX4UWJyHGp9Gqu9ifdw7aXJWr+EWP+Y3Tu6QaZb
 JAN7qbaiHkfhWX6/dhgLywpSPKt0tLElvuJ2q9hU99sUyrL8SBS4qnCcEIkoj6LaH833tfr3yF
 GgvZ1UmNV/8m9WYhBgF5ngkpVzlcydfVb6RWNGK+ZQNEByvYrBPyKy1GTUvbz8kJX8EKkOid+W
 FEEWSwi+8IB5nN0gb1w+5NnzV/f6qJH2tYbuFkY+OL5tNS5UIIG/Ax3QwI+i/cd9kxZY9nHeUh
 GaY=
X-IronPort-AV: E=Sophos;i="5.70,330,1574146800"; 
   d="scan'208";a="63631936"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 04:37:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 04:37:14 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 17 Jan 2020 04:37:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/4] clk: at91: usb: introduce num_parents in driver's structure
Date:   Fri, 17 Jan 2020 13:36:49 +0200
Message-ID: <1579261009-4573-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAM9X60 USB clock may have up to 3 parents. Save the number of parents in
driver's data structure and validate against it when setting parent.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index c0895c993cce..31d5c45e30d7 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -25,6 +25,7 @@ struct at91sam9x5_clk_usb {
 	struct clk_hw hw;
 	struct regmap *regmap;
 	u32 usbs_mask;
+	u8 num_parents;
 };
 
 #define to_at91sam9x5_clk_usb(hw) \
@@ -110,7 +111,7 @@ static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
 
-	if (index > 1)
+	if (index >= usb->num_parents)
 		return -EINVAL;
 
 	regmap_update_bits(usb->regmap, AT91_PMC_USB, usb->usbs_mask, index);
@@ -215,6 +216,7 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 	usb->hw.init = &init;
 	usb->regmap = regmap;
 	usb->usbs_mask = usbs_mask;
+	usb->num_parents = num_parents;
 
 	hw = &usb->hw;
 	ret = clk_hw_register(NULL, &usb->hw);
-- 
2.7.4

