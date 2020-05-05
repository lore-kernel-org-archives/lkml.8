Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D52FC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574052068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgEEIlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:41:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbgEEIlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:41:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E71692C16312CA87E6E;
        Tue,  5 May 2020 16:41:50 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 16:41:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sebastian.hesselbarth@gmail.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: mv643xx_eth: Remove unused inline function sum16_as_be
Date:   Tue, 5 May 2020 16:40:37 +0800
Message-ID: <20200505084037.1604-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 84411f73b884 ("net: mv643xx_eth: Avoid setting the initial TCP checksum")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 81d24481b22c..4d4b6243318a 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -666,11 +666,6 @@ static inline unsigned int has_tiny_unaligned_frags(struct sk_buff *skb)
 	return 0;
 }
 
-static inline __be16 sum16_as_be(__sum16 sum)
-{
-	return (__force __be16)sum;
-}
-
 static int skb_tx_csum(struct mv643xx_eth_private *mp, struct sk_buff *skb,
 		       u16 *l4i_chk, u32 *command, int length)
 {
-- 
2.17.1


