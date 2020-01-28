Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDD9C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B041124686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgA1KCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:02:18 -0500
Received: from gloria.sntech.de ([185.11.138.130]:34236 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgA1KCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:02:17 -0500
Received: from p57b77a13.dip0.t-ipconnect.de ([87.183.122.19] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iwNhE-0008Lk-1T; Tue, 28 Jan 2020 11:02:12 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/3] clk: rockchip: convert rk3399 pll type to use readl_poll_timeout
Date:   Tue, 28 Jan 2020 11:02:01 +0100
Message-Id: <20200128100204.1318450-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Instead of open coding the polling of the lock status, use the
handy readl_poll_timeout for this. As the pll locking is normally
blazingly fast and we don't want to incur additional delays, we're
not doing any sleeps similar to for example the imx clk-pllv4
and define a very safe but still short timeout of 1ms.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/clk/rockchip/clk-pll.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 198417d56300..43c9fd0086a2 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -585,19 +585,18 @@ static const struct clk_ops rockchip_rk3066_pll_clk_ops = {
 static int rockchip_rk3399_pll_wait_lock(struct rockchip_clk_pll *pll)
 {
 	u32 pllcon;
-	int delay = 24000000;
+	int ret;
 
-	/* poll check the lock status in rk3399 xPLLCON2 */
-	while (delay > 0) {
-		pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(2));
-		if (pllcon & RK3399_PLLCON2_LOCK_STATUS)
-			return 0;
+	/*
+	 * Lock time typical 250, max 500 input clock cycles @24MHz
+	 * So define a very safe maximum of 1000us, meaning 24000 cycles.
+	 */
+	ret = readl_poll_timeout(pll->reg_base + RK3399_PLLCON(2), pllcon,
+				 pllcon & RK3399_PLLCON2_LOCK_STATUS, 0, 1000);
+	if (ret)
+		pr_err("%s: timeout waiting for pll to lock\n", __func__);
 
-		delay--;
-	}
-
-	pr_err("%s: timeout waiting for pll to lock\n", __func__);
-	return -ETIMEDOUT;
+	return ret;
 }
 
 static void rockchip_rk3399_pll_get_params(struct rockchip_clk_pll *pll,
-- 
2.24.1

