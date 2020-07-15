Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915CBC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6728A2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RgIowakl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgGOLYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:24:40 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62426 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGOLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812278; x=1626348278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7R0pQ7si/LBGC7HCv98obeajPRN2G3AQ5wVM3UPEBzA=;
  b=RgIowaklaQlGrMWW5JfP2Ge/YeVSJB48TMJTFWd5cui2PuaZu8tlRP0m
   ntWpFP2sj+f+nL76BjmOLcL6QjZFMAzCt1iTdsTGrkauh1godUv01amEI
   /kTbsNVH4br8ZNutmzG9+74jDf68uUHyFgM+C+MafkZKpSAns5Xwo5h36
   YXuOKu/3aQGYrjKNDdaLw1wLT2anVT8qw1x1ojEp4tab/rnKOf6h0Mb63
   NkZ3mTrzZiEG5agTewM4gjsJJWa8+rziNwfkUGlEZt55pjjaEmN6xGOJa
   e9SuPjr9l0e4uCF1sNDdw5v1Hbq0tCwwj+m44f3Fy4yYHw0WQPK7aLcBb
   w==;
IronPort-SDR: pYPktPbPEbpUybSKK3miu3zNbBIbkRbVnld4SME1+MyatmIMhD8/1FcfYZk10XsHKVs+gVhYHO
 w8+1Kh5pkU2AclRkKExHuaQbY81tsOgunZdQFAUHm2vSZ5VFn5K4/WEsB3awbsCDqML1BKLA/m
 WQoPrrpsAgMenIurMa0RZWP8LkxyNQrVwDMk9ReVZmp8+XlqOWVSxY8VSNZ9g17SQ2UfGlyCsm
 Gj2XPxgnscdJaAhOGFU6LjKChuUcCnLByUw8Z6FIy+u3im9iwBbFOAmZCqnl6sdkZFiCfNVqZ6
 eRc=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962763"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:24:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:37 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 01/19] clk: at91: clk-generated: continue if __clk_determine_rate() returns error
Date:   Wed, 15 Jul 2020 14:24:09 +0300
Message-ID: <1594812267-6697-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__clk_determine_rate() may return error. Skip the current step
in case of error.

Fixes: 1a1a36d72e3d3 ("clk: at91: clk-generated: make gclk determine audio_pll rate")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-generated.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 44a46dcc0518..995a13133cfb 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -170,7 +170,8 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 
 	for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
 		req_parent.rate = req->rate * div;
-		__clk_determine_rate(parent, &req_parent);
+		if (__clk_determine_rate(parent, &req_parent))
+			continue;
 		clk_generated_best_diff(req, parent, req_parent.rate, div,
 					&best_diff, &best_rate);
 
-- 
2.7.4

