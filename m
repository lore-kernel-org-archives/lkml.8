Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F5DC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD80520786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgICCQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:16:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgICCQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:16:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 089678ABB483EEA723D2;
        Thu,  3 Sep 2020 10:16:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Sep 2020
 10:16:11 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <krzk@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] memory: tegra: Delete duplicated argument to '|' in function tegra210_emc_r21021_periodic_compensation
Date:   Thu, 3 Sep 2020 10:15:42 +0800
Message-ID: <20200903021542.315195-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In funtion tegra210_emc_r21021_periodic_compensation when calculate emc_cfg
EMC_CFG_DRAM_CLKSTOP_PD is duplicated

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/memory/tegra/tegra210-emc-cc-r21021.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210-emc-cc-r21021.c b/drivers/memory/tegra/tegra210-emc-cc-r21021.c
index d60bdea3af3f..0ebfa8eccf0c 100644
--- a/drivers/memory/tegra/tegra210-emc-cc-r21021.c
+++ b/drivers/memory/tegra/tegra210-emc-cc-r21021.c
@@ -501,7 +501,6 @@ static u32 tegra210_emc_r21021_periodic_compensation(struct tegra210_emc *emc)
 		emc_cfg_o = emc_readl(emc, EMC_CFG);
 		emc_cfg = emc_cfg_o & ~(EMC_CFG_DYN_SELF_REF |
 					EMC_CFG_DRAM_ACPD |
-					EMC_CFG_DRAM_CLKSTOP_PD |
 					EMC_CFG_DRAM_CLKSTOP_PD);
 
 
-- 
2.25.4

