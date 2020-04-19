Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5195C5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7FA21927
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgDSR1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:27:54 -0400
Received: from v6.sk ([167.172.42.174]:44470 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDSR1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:27:53 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id F09BD610C1;
        Sun, 19 Apr 2020 17:27:51 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 02/10] clk: mmp: frac: Allow setting bits other than the numerator/denominator
Date:   Sun, 19 Apr 2020 19:27:34 +0200
Message-Id: <20200419172742.674717-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419172742.674717-1-lkundrak@v3.sk>
References: <20200419172742.674717-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the I2S fractional clocks, there are more bits that need to be set
for the clock to run. Their actual meaning is unknown.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-frac.c | 3 +++
 drivers/clk/mmp/clk.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index ed9928f5bdc7f..48f592bd633df 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -148,7 +148,10 @@ static int clk_factor_init(struct clk_hw *hw)
 		val &= ~(masks->den_mask << masks->den_shift);
 		val |= (factor->ftbl[0].den & masks->den_mask) <<
 			masks->den_shift;
+	}
 
+	if (!(val & masks->enable_mask) || i >= factor->ftbl_cnt) {
+		val |= masks->enable_mask;
 		writel(val, factor->base);
 	}
 
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 971b4d6d992fb..0efd5b0b2f01b 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -16,6 +16,7 @@ struct mmp_clk_factor_masks {
 	unsigned int den_mask;
 	unsigned int num_shift;
 	unsigned int den_shift;
+	unsigned int enable_mask;
 };
 
 struct mmp_clk_factor_tbl {
-- 
2.26.0

