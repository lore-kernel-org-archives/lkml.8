Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4D6206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGWLLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:11:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8367 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbgGWLLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:11:14 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A5ED7CC41F5894503DA3;
        Thu, 23 Jul 2020 19:11:08 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 19:10:58 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <sam@mendozajonas.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net/ncsi: use eth_zero_addr() to clear mac address
Date:   Thu, 23 Jul 2020 19:13:43 +0800
Message-ID: <1595502823-9672-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Use eth_zero_addr() to clear mac address insetad of memset().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/ncsi/ncsi-rsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index a94bb59793f0..5b1f4ec66dd9 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -471,7 +471,7 @@ static int ncsi_rsp_handler_sma(struct ncsi_request *nr)
 		memcpy(&ncf->addrs[index], cmd->mac, ETH_ALEN);
 	} else {
 		clear_bit(cmd->index - 1, bitmap);
-		memset(&ncf->addrs[index], 0, ETH_ALEN);
+		eth_zero_addr(&ncf->addrs[index]);
 	}
 	spin_unlock_irqrestore(&nc->lock, flags);
 
-- 
2.19.1

