Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8626EC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B80214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgAaL63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:58:29 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:15797 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgAaL62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:58:28 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: yZTKSBkc3InGyKlpPWjPwSlFiFEo6AQdsanKlgJmbso6ZrjrscNBb0JR9WKWW+WLFV3zlUSEOW
 Ud4tl/jculWR7MZZ14KRjPde56QkgRJpUBMyv/0w9K2ChZpUdZV6ib3/g1P7caz7fTkL3UI9OM
 vkYtHaqH03P02IAaSf9L3Z6z2dI/bflrr2FoZ2wxbkABPwByAcgVNqsArHj8grqDDumqxZKXiE
 zblfYB4DMVAhJeSSH8NE/7SLEAZjEsW9cYqSYxCZWB6BfAkBNP8wt7NZHzMsNDjKs/uxY5KUmC
 tDM=
X-IronPort-AV: E=Sophos;i="5.70,385,1574146800"; 
   d="scan'208";a="65127845"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2020 04:58:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 Jan 2020 04:58:27 -0700
Received: from rob-ult-m19940.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 31 Jan 2020 04:58:23 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <Claudiu.Beznea@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2] clk: at91: sam9x60: Don't use audio PLL
Date:   Fri, 31 Jan 2020 13:58:16 +0200
Message-ID: <20200131115816.12483-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sam9x60, there is not audio PLL and so I2S and classD have to use one
of the best matching parents for their generated clock.

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - removed pll member entirely;

 drivers/clk/at91/sam9x60.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 77398aefeb6d..bacb32c15b26 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -124,7 +124,6 @@ static const struct {
 	char *n;
 	u8 id;
 	struct clk_range r;
-	bool pll;
 } sam9x60_gck[] = {
 	{ .n = "flex0_gclk",  .id = 5, },
 	{ .n = "flex1_gclk",  .id = 6, },
@@ -144,11 +143,9 @@ static const struct {
 	{ .n = "sdmmc1_gclk", .id = 26, .r = { .min = 0, .max = 105000000 }, },
 	{ .n = "flex11_gclk", .id = 32, },
 	{ .n = "flex12_gclk", .id = 33, },
-	{ .n = "i2s_gclk",    .id = 34, .r = { .min = 0, .max = 105000000 },
-		.pll = true, },
+	{ .n = "i2s_gclk",    .id = 34, .r = { .min = 0, .max = 105000000 }, },
 	{ .n = "pit64b_gclk", .id = 37, },
-	{ .n = "classd_gclk", .id = 42, .r = { .min = 0, .max = 100000000 },
-		.pll = true, },
+	{ .n = "classd_gclk", .id = 42, .r = { .min = 0, .max = 100000000 }, },
 	{ .n = "tcb1_gclk",   .id = 45, },
 	{ .n = "dbgu_gclk",   .id = 47, },
 };
@@ -290,7 +287,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 						 sam9x60_gck[i].n,
 						 parent_names, 6,
 						 sam9x60_gck[i].id,
-						 sam9x60_gck[i].pll,
+						 false,
 						 &sam9x60_gck[i].r);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.20.1

