Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAADCC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4A52075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SQmh7B9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgECMS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:18:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:19681 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgECMS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588508308; x=1620044308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pi9dyMRbnlcW2sUMQWe9DzJs+ld1yk+KsP1Dq8HADTE=;
  b=SQmh7B9GIhF7XjK9gwiuVcZWckYfUBTn4c/1Emye3CPvMNdhb+7pWD7u
   kojAVpYIJXaIFoJ0O8EStJlwjcWCKQq4pq7rV17I4KwlTtZHRkOZUIj/U
   dmjS0oqU7iNiuXJc3uaScr6KEefXxir1pL9DVPSiPq48OMITkQAQc4tAz
   74iv655MoR+80fpP/T20IZEAuoZuzrEyTY50V7n9yMjOP1zmVN8NH8gI2
   tmE+AIKfi9MB9/Ovj3ZrfBqh66gP7XcDDnXvTPhgoxhi9slVnocdwPYDo
   29tLLgBXT8H1zv556jTKmec5xYs5CXzD041EGPObQCQzmOU3l5sOJagjB
   g==;
IronPort-SDR: hhyLO3xXo8v+nj+BQPxEGwUpzUViMS5cR3raVxwSLXFAcxKSOx0+FI0BfmcwDmDZXut84EZY9d
 ILtQfc5HUaH1VxeN4W8e2r93wPRqwf0ablLihWTJwsgQU3r3H60KnIubWT9qJ9zb1RpXV7S+OM
 biwsoYp0ixKAehhcU3FeoXgOmD9PdoqZT+AQ3jAou4sWtlAviAnIu2LUNwHSTAYz0NrbdUa2ZW
 W7YX2eqmNkaVIPni3tPQsDNpkF1xh5JW6ztBGVrpZd0mXtacOuSHd9W3yM+nNLUJFHSVrmPIdx
 yHk=
X-IronPort-AV: E=Sophos;i="5.73,347,1583218800"; 
   d="scan'208";a="75334452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2020 05:18:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 May 2020 05:18:28 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Sun, 3 May 2020 05:18:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] clk: at91: pmc: decrement node's refcount
Date:   Sun, 3 May 2020 15:18:09 +0300
Message-ID: <1588508289-10140-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588508289-10140-1-git-send-email-claudiu.beznea@microchip.com>
References: <1588508289-10140-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node() increment node's refcount. Call
of_node_put() to decrement it after it was used.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index bf0570e66fc1..e164069c81bd 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -278,6 +278,7 @@ static int __init pmc_register_ops(void)
 		return -ENODEV;
 
 	pmcreg = device_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(pmcreg))
 		return PTR_ERR(pmcreg);
 
-- 
2.7.4

