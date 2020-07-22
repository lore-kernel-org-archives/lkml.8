Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D281C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B4F207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zlxlQ0/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgGVHik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:38:40 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23373 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGVHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403518; x=1626939518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=R8glgrEZzhLNxmkr+9/gw/Qi8m2Oyd4biI9RRPUc9B4=;
  b=zlxlQ0/kYFPX42duaYiuqd3GM18uWoDx/y+Bh5sY1e4tl4uHZwfkxaS/
   ZNkKiB58TmanQxeC7J/OmSU4g69YCJBEFDYPUqJt2u5H/lgkiCe3+COid
   iVqUh6mqPubzR/XxGDNs8ZLxtybYS3DDxcMszcLAd8CH2x3CCSK8LE2j4
   G/pF3bq5T8qRFJB87Pni8i15LZf+wYNPjmDMq+5zcFrCd7qDkEPxrW4tZ
   4VCKF046GpVj/kJsjSP5QL7kmYLUUdfpkbPELWlM2syYYmXU/PoIxLz/I
   njtzwFIBjEJu5ie7e0Afk4tRiyAfkXhPq6OSO8RCGIwdeYjiZkxbrPd4W
   w==;
IronPort-SDR: fAYvumPAJB9qAcge08SZj38Jx+dvXfLr1pQvriTPz6LCc2rjE/3mw1vSHr/fLeVDNNFQ/AOdm1
 nPIjq9Cb6a/FTT7LRz/eGigR3k34i4H4IFxWk5mAaF5Cle4tYhC+PknDU56Enb5QPSjHMjmWQw
 keBu//fFHqqzrLUSdNeOZ8LC661rSBk9RGqU33WW+hf5jfm50W5iVjEikmmGBCfctFOJvfU3Wb
 kxoWIlpYG/tsbtS/B0K8qAT6QH9VMgiy5UX/xcGdQTjwVW2BgQeI/ADJta5IuKX6USEWj7C+K+
 CT0=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="82772024"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:38:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:36 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 01/18] clk: at91: clk-generated: continue if __clk_determine_rate() returns error
Date:   Wed, 22 Jul 2020 10:38:09 +0300
Message-ID: <1595403506-8209-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
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
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

