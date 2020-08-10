Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44352C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A4F206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHJC7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:59:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgHJC7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:59:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79DD0994A08558BE1D02;
        Mon, 10 Aug 2020 10:59:05 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 10:59:01 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <timur@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net] net: qcom/emac: add missed clk_disable_unprepare in error path of emac_clks_phase1_init
Date:   Mon, 10 Aug 2020 10:57:05 +0800
Message-ID: <20200810025705.28756-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from emac_clks_phase1_init() in the error handling case.

Fixes: b9b17debc69d ("net: emac: emac gigabit ethernet controller driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Acked-by: Timur Tabi <timur@kernel.org>
---
 drivers/net/ethernet/qualcomm/emac/emac.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 20b1b43a0e39..1166b98d8bb2 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -474,13 +474,24 @@ static int emac_clks_phase1_init(struct platform_device *pdev,
 
 	ret = clk_prepare_enable(adpt->clk[EMAC_CLK_CFG_AHB]);
 	if (ret)
-		return ret;
+		goto disable_clk_axi;
 
 	ret = clk_set_rate(adpt->clk[EMAC_CLK_HIGH_SPEED], 19200000);
 	if (ret)
-		return ret;
+		goto disable_clk_cfg_ahb;
+
+	ret = clk_prepare_enable(adpt->clk[EMAC_CLK_HIGH_SPEED]);
+	if (ret)
+		goto disable_clk_cfg_ahb;
 
-	return clk_prepare_enable(adpt->clk[EMAC_CLK_HIGH_SPEED]);
+	return 0;
+
+disable_clk_cfg_ahb:
+	clk_disable_unprepare(adpt->clk[EMAC_CLK_CFG_AHB]);
+disable_clk_axi:
+	clk_disable_unprepare(adpt->clk[EMAC_CLK_AXI]);
+
+	return ret;
 }
 
 /* Enable clocks; needs emac_clks_phase1_init to be called before */
-- 
2.17.1

