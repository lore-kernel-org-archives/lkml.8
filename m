Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BECC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B1920717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RfvbSV2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgGVHio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:38:44 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:58066 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgGVHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403522; x=1626939522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EeH8+vmkcFfVdlMVQof3LjzpSNoX8XRcrm4kR8XL8ts=;
  b=RfvbSV2ZS0aA/EcUBwc0zCjyMC4H5nK7pdUNETPPi0w+7NPY+kYwS0pt
   dWYpBY0F1U393rLDb87t/cfxHVQCg+4lY9ob3vDyStkV6H45seMzZD966
   B+/PV2I0SPpVF4FmgNUPBLS9tAe+TyvW8K5l7LMvLRKDofrEyxbdDQkNW
   m8T4NdaMkZXXdP2GIMQk+8JqMNAIxD8Kbg7D6JHV2JLQrQ7bGbhY/Vzai
   kuaAHvifT5xp7JXGmq2G96vEVtXITyQmeNFARCA96zwRUOuNIRi1HPqWH
   ZEdExD6s6R0StnSBVfUS7BIrccmcS98o+E9+9YHMnNrFpiYXbQssa/wkj
   g==;
IronPort-SDR: ZyW1PEQqNyMQNFJ132EmG/subln8AfSwbBDnRsblCyuUw5oGlo0ScEE4Sn2kPquHSFEb6B5CY+
 KnneUfRQN4NduIiFu69crVJB/QJKRYkX2pQkWndLfLsWReX7baNIYc79BTlvH6qJ8XAr61Uw0j
 vlweep154WFVAtMQ1rQac/k11IBzSDvL+k3lXcg3FbkXPMtj/454t7kHQIcIid85DUhc/IY4j2
 Kc/yE1ZV4sTIEd7AxpZfglP1eJZb7wEfOMxtT/TlOJ9akw2vP/uuM3XZWmryhh6ueC/e6mfRfk
 4GU=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="80862068"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:38:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:00 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 02/18] clk: at91: clk-generated: check best_rate against ranges
Date:   Wed, 22 Jul 2020 10:38:10 +0300
Message-ID: <1595403506-8209-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check best_rate against available clock ranges.

Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-generated.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 995a13133cfb..f8e557e0e1b8 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -185,8 +185,8 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 		 __clk_get_name((req->best_parent_hw)->clk),
 		 req->best_parent_rate);
 
-	if (best_rate < 0)
-		return best_rate;
+	if (best_rate < 0 || (gck->range.max && best_rate > gck->range.max))
+		return -EINVAL;
 
 	req->rate = best_rate;
 	return 0;
-- 
2.7.4

