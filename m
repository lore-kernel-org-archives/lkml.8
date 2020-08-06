Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C719E221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFWTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:19:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgHFWTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:19:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 731AB3CBB8624B1C4D7D;
        Thu,  6 Aug 2020 22:08:42 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 22:08:37 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <timur@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net] net: qcom/emac: Fix missing clk_disable_unprepare() in error path of emac_probe
Date:   Thu, 6 Aug 2020 22:06:47 +0800
Message-ID: <20200806140647.43099-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In emac_clks_phase1_init() of emac_probe(), there may be a situation
in which some clk_prepare_enable() succeed and others fail.
If emac_clks_phase1_init() fails, goto err_undo_clocks to clean up
the clk that was successfully clk_prepare_enable().

Fixes: b9b17debc69d ("net: emac: emac gigabit ethernet controller driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/qualcomm/emac/emac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 20b1b43a0e39..7520c02eec12 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -628,7 +628,7 @@ static int emac_probe(struct platform_device *pdev)
 	ret = emac_clks_phase1_init(pdev, adpt);
 	if (ret) {
 		dev_err(&pdev->dev, "could not initialize clocks\n");
-		goto err_undo_netdev;
+		goto err_undo_clocks;
 	}
 
 	netdev->watchdog_timeo = EMAC_WATCHDOG_TIME;
-- 
2.17.1

