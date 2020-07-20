Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E05C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF96208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGTCyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:54:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTCyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:54:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 81E9F1D4A2635D05AA35;
        Mon, 20 Jul 2020 10:54:38 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 10:54:36 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <joe@perches.com>, <gtzalik@amazon.com>, <saeedb@amazon.com>,
        <zorik@amazon.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <sameehj@amazon.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] net: ena: Fix using plain integer as NULL pointer in ena_init_napi_in_range
Date:   Mon, 20 Jul 2020 10:53:09 +0800
Message-ID: <20200720025309.18597-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse build warning:

drivers/net/ethernet/amazon/ena/ena_netdev.c:2193:34: warning:
 Using plain integer as NULL pointer

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Suggested-by: Joe Perches <joe@perches.com>
Acked-by: Shay Agroskin <shayagr@amazon.com>
---
v1->v2:
 Improve code readability based on Joe Perches's suggestion 
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 91be3ffa1c5c..470d8f38b824 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2190,11 +2190,10 @@ static void ena_del_napi_in_range(struct ena_adapter *adapter,
 static void ena_init_napi_in_range(struct ena_adapter *adapter,
 				   int first_index, int count)
 {
-	struct ena_napi *napi = {0};
 	int i;
 
 	for (i = first_index; i < first_index + count; i++) {
-		napi = &adapter->ena_napi[i];
+		struct ena_napi *napi = &adapter->ena_napi[i];
 
 		netif_napi_add(adapter->netdev,
 			       &adapter->ena_napi[i].napi,
-- 
2.17.1

