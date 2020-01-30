Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D13C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4812F20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgA3RrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:47:22 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64288 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgA3RrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:47:22 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: s2VDPHFfGuMXOig7o5ja9fBcXXcvyrtoJe3AMIqIif4VAQeJl5Giq6YeBh9vRhT1t5JN1aDZQ+
 hUOz3yH7lmFh0jL1D7UK2cTIu/5e1u1wStom7n5kyAXjK/FbMpP2REKqWRdRApnEffI6pWwsGb
 Z9ec6bgVMXHzHl5N63rbcckiRyVSUyKE7X+6EY13N3PjxCX/v8xXbpEwx2+WJv/pGTJPaLqz/q
 UQi+vLcktsysV2o0uZlmjFMUjOjV3t22FeYGNO1Cbltf3rTNnQOgWvjpjANWqEq5RsD6XWsybS
 cAM=
X-IronPort-AV: E=Sophos;i="5.70,382,1574146800"; 
   d="scan'208";a="62659285"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2020 10:47:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jan 2020 10:47:21 -0700
Received: from rob-ult-m19940.microchip.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 30 Jan 2020 10:47:18 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] clk: at91: sam9x60: Don't use audio PLL
Date:   Thu, 30 Jan 2020 19:47:08 +0200
Message-ID: <20200130174708.12448-1-codrin.ciubotariu@microchip.com>
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
 drivers/clk/at91/sam9x60.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 77398aefeb6d..0aeb44fed9de 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -144,11 +144,9 @@ static const struct {
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
-- 
2.20.1

