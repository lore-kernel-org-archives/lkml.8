Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E90C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7E0207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgIIQOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:14:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730598AbgIIQJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:09:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FCAB752330418B7CE20;
        Wed,  9 Sep 2020 22:10:05 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 9 Sep 2020 22:10:01 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <mcoquelin.stm32@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: stmmac: dwmac-intel-plat: remove redundant null check before clk_disable_unprepare()
Date:   Wed, 9 Sep 2020 22:09:00 +0800
Message-ID: <1599660540-25295-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter, so the additional checks are unnecessary, just
remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index ccac7bf..b1323d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -149,9 +149,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret) {
-		if (dwmac->tx_clk)
-			clk_disable_unprepare(dwmac->tx_clk);
-
+		clk_disable_unprepare(dwmac->tx_clk);
 		goto err_remove_config_dt;
 	}
 
@@ -169,9 +167,7 @@ static int intel_eth_plat_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = stmmac_pltfr_remove(pdev);
-
-	if (dwmac->tx_clk)
-		clk_disable_unprepare(dwmac->tx_clk);
+	clk_disable_unprepare(dwmac->tx_clk);
 
 	return ret;
 }
-- 
2.9.5

