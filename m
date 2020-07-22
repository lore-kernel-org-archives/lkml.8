Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80289C433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6C520717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZPFeMx1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgGVHjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:04 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35036 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgGVHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403542; x=1626939542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=R+uFFyYA7jlvJSdHYMkGV8OUFOabhODqF7Yvyb39l44=;
  b=ZPFeMx1zxH3drG+r2cHudXG/qrvsPZEGDejlSy8aYxnQgknG7RpAcw1j
   rOBw9oVm4MD0lhfHX1dO5hekU1u9/Dut5dSBsfJFvjbbTz7lnRjEc18EC
   D+yXbUNvjRh80dmj/cLTo7aFuh2I5MDFsT9shRB0jnsMpL7ClKPfId1YB
   4UaM5mYMTjH23Dqd2CxkX9NhYvXkx3phbTdjggY8CVAWDzaAEDhAjMPl9
   GhOiuYRPa9kbvklnbnpEt2tKZNHABn7CkVjQXkSUFsPQsGW1Rf8S3Mypt
   a37g0TNfZABbu6h8lQOVkdEU28YDFoy6chVg0GR06fHOjwvReEA/TSMQK
   w==;
IronPort-SDR: bphNlZQWXoljoD0TKXO3B/cr+yO3qcdVFBWe07iuLAQ+tJefaEtvx9Wx3rwQZOBnMZdCDpJ4mi
 EsklkZFN0B1rGX91XvTpOMdUAdc8q4GV/6vWGGvSPIm+KlOhzsfj5470KYNaftN+CiO8FBb8I5
 Do/7u4kG/7EnMOFlVFidiUpz874q0RGlHCWERVO8Ic1lf5bdqkPiZXZB32HJdVb67AfD4HMySR
 c80/cZiJZK0Ybf7KPFgasRelDFPr9N6tLg7ksxtolFRuXD2W8kptu3Ek9YlHSwO2eM9Uw9GZ1n
 Ivo=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="20120823"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:22 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 08/18] clk: at91: sckc: register slow_rc with accuracy option
Date:   Wed, 22 Jul 2020 10:38:16 +0300
Message-ID: <1595403506-8209-9-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chapter 57.7.5 of SAM9X60 datasheet specifies that the maximum drift of
this oscillator is +- 3KHz. Use that value and the formula at [1]
or the calculator at [2] to compute the PPB value.

[1] https://www.everythingrf.com/rf-calculators/ppm-to-hz-calculator
[2] https://www.changpuak.ch/electronics/ppm_to_Hz_converter.php

Fixes: 04bcc4275e601 ("clk: at91: sckc: add support for SAM9X60")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 15dc4cd86d76..2d65770d8665 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -471,8 +471,9 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 	if (!regbase)
 		return;
 
-	slow_rc = clk_hw_register_fixed_rate(NULL, parent_names[0], NULL, 0,
-					     32768);
+	slow_rc = clk_hw_register_fixed_rate_with_accuracy(NULL, parent_names[0],
+							   NULL, 0, 32768,
+							   93750000);
 	if (IS_ERR(slow_rc))
 		return;
 
-- 
2.7.4

