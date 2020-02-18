Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031B6C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68DB20722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgBRGWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 01:22:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgBRGWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:22:10 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AF77AB8EC705F70E373E;
        Tue, 18 Feb 2020 14:22:06 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Feb 2020
 14:22:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <netanel@amazon.com>, <akiyano@amazon.com>, <gtzalik@amazon.com>,
        <saeedb@amazon.com>, <zorik@amazon.com>, <davem@davemloft.net>,
        <sameehj@amazon.com>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ena: remove set but not used variable 'hash_key'
Date:   Tue, 18 Feb 2020 14:21:54 +0800
Message-ID: <20200218062154.3724-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/ethernet/amazon/ena/ena_com.c: In function ena_com_hash_key_allocate:
drivers/net/ethernet/amazon/ena/ena_com.c:1070:50:
 warning: variable hash_key set but not used [-Wunused-but-set-variable]

commit 6a4f7dc82d1e ("net: ena: rss: do not allocate key when not supported")
introduced this, but not used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 1fb58f9..a250046 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1067,18 +1067,14 @@ static void ena_com_hash_key_fill_default_key(struct ena_com_dev *ena_dev)
 static int ena_com_hash_key_allocate(struct ena_com_dev *ena_dev)
 {
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_feature_rss_flow_hash_control *hash_key;
 	struct ena_admin_get_feat_resp get_resp;
 	int rc;
 
-	hash_key = (ena_dev->rss).hash_key;
-
 	rc = ena_com_get_feature_ex(ena_dev, &get_resp,
 				    ENA_ADMIN_RSS_HASH_FUNCTION,
 				    ena_dev->rss.hash_key_dma_addr,
 				    sizeof(ena_dev->rss.hash_key), 0);
 	if (unlikely(rc)) {
-		hash_key = NULL;
 		return -EOPNOTSUPP;
 	}
 
-- 
2.7.4


