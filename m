Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712A1C47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E41E2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q90WwHIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgECMSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:18:24 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:19681 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgECMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588508303; x=1620044303;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=c8lDNy1DN1+fUi3A0w27OVt8zaff8+LO9O5hnm7DgNM=;
  b=q90WwHIqJDuKqJcr+OZrYr+6EHK38IlRivCUKe0MIEe8bhjO/qOVb2R1
   3bVTwefch5g0li6ECXGZeUI9oJNFqtWFLrywbUPXVIqj+DUtYtdvYyr3t
   jKJgVXioSMckuE+OQlAZkqRgFKV/PuQhk9Cmc+C/7aAhpcyGMZVgnmFtK
   +uDBCnG4TLNAH0J7MOjxDuv4Hecjr++Mn8oS/c+VeXfCNjXMI0f2hFMWi
   k9YTz4UV9oBVIMLVF5PIITYzbGsm4UQ33jkFTU7LqLHr58BR7yL0FwvAV
   RCOAyef1qG6zXivbqCIJKRl4yy1JP/S0dorhc0wCJxOkgNKP+FwMFsw3/
   w==;
IronPort-SDR: DkyR9cKBfknKhzowufnIcNtdsXbkIo7Iw8szQVfEcCM6y7J9LyfIU7HWyWMdbwHkAmQgyaN78N
 nVTl6/txRq/dfCJpC7RiDdY6hbkpgFh0KirZG6acY6/5YSrIuuChre6Us8MP+zN13HWoNM8vkL
 V41yH53FxZpMIPNFtn7DN+6eSOg7gtzlJc/FtPUqOolbVXVtyO5ELDzRSRsyLa5ddHag0iLJ0i
 XzM7IlL878CRd2y8+r5Nfi83n6Dh8HjjI57a4aCSLhV1i0EM3OLga3ZA0dzo2oiCZjjbo7QTif
 jnQ=
X-IronPort-AV: E=Sophos;i="5.73,347,1583218800"; 
   d="scan'208";a="75334447"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2020 05:18:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 May 2020 05:18:23 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Sun, 3 May 2020 05:18:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] clk: at91: pmc: do not continue if compatible not located
Date:   Sun, 3 May 2020 15:18:08 +0300
Message-ID: <1588508289-10140-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmc_register_ops() is called for all AT91 devices. Return
-ENODEV in case of_find_matching_node() returns NULL.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index b71515acdec1..bf0570e66fc1 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -274,6 +274,8 @@ static int __init pmc_register_ops(void)
 	struct device_node *np;
 
 	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
+	if (!np)
+		return -ENODEV;
 
 	pmcreg = device_node_to_regmap(np);
 	if (IS_ERR(pmcreg))
-- 
2.7.4

