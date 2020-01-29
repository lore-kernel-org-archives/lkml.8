Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B0AC35246
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227A020716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgA2Qir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:38:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44706 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgA2Qik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:38:40 -0500
Received: from p508fd499.dip0.t-ipconnect.de ([80.143.212.153] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iwqMO-0006rE-HG; Wed, 29 Jan 2020 17:38:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        robin.murphy@arm.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v3 2/3] clk: rockchip: convert basic pll lock_wait to use regmap_read_poll_timeout
Date:   Wed, 29 Jan 2020 17:38:20 +0100
Message-Id: <20200129163821.1547295-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129163821.1547295-1-heiko@sntech.de>
References: <20200129163821.1547295-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Instead of open coding the polling of the lock status, use the
handy regmap_read_poll_timeout for this. As the pll locking is
normally blazingly fast and we don't want to incur additional
delays, we're not doing any sleeps similar to for example the imx
clk-pllv4 and define a very safe but still short timeout of 1ms.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
changes in v3:
- none
changes in v2:
- add patch to keep generic grf wait_lock similar to the rest
  and use regmap_read_poll_timeout for this

 drivers/clk/rockchip/clk-pll.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 6fd52895e7b6..c7c3848d68e8 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -86,23 +86,14 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
 {
 	struct regmap *grf = pll->ctx->grf;
 	unsigned int val;
-	int delay = 24000000, ret;
-
-	while (delay > 0) {
-		ret = regmap_read(grf, pll->lock_offset, &val);
-		if (ret) {
-			pr_err("%s: failed to read pll lock status: %d\n",
-			       __func__, ret);
-			return ret;
-		}
+	int ret;
 
-		if (val & BIT(pll->lock_shift))
-			return 0;
-		delay--;
-	}
+	ret = regmap_read_poll_timeout(grf, pll->lock_offset, val,
+				       val & BIT(pll->lock_shift), 0, 1000);
+	if (ret)
+		pr_err("%s: timeout waiting for pll to lock\n", __func__);
 
-	pr_err("%s: timeout waiting for pll to lock\n", __func__);
-	return -ETIMEDOUT;
+	return ret;
 }
 
 /**
-- 
2.24.1

