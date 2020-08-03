Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7972C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEDF206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHCBwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 21:52:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgHCBwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 21:52:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15D9BCA8A58F974EFC13;
        Mon,  3 Aug 2020 09:52:36 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 09:52:30 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <jmaloy@redhat.com>, <ying.xue@windriver.com>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] tipc: Use is_broadcast_ether_addr() instead of memcmp()
Date:   Sun, 2 Aug 2020 22:00:55 -0400
Message-ID: <20200803020055.26822-1-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using is_broadcast_ether_addr() instead of directly use
memcmp() to determine if the ethernet address is broadcast
address.

spatch with a semantic match is used to found this problem.
(http://coccinelle.lip6.fr/)

Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 net/tipc/eth_media.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/tipc/eth_media.c b/net/tipc/eth_media.c
index 8b0bb600602d..c68019697cfe 100644
--- a/net/tipc/eth_media.c
+++ b/net/tipc/eth_media.c
@@ -62,12 +62,10 @@ static int tipc_eth_raw2addr(struct tipc_bearer *b,
 			     struct tipc_media_addr *addr,
 			     char *msg)
 {
-	char bcast_mac[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-
 	memset(addr, 0, sizeof(*addr));
 	ether_addr_copy(addr->value, msg);
 	addr->media_id = TIPC_MEDIA_TYPE_ETH;
-	addr->broadcast = !memcmp(addr->value, bcast_mac, ETH_ALEN);
+	addr->broadcast = is_broadcast_ether_addr(addr->value);
 	return 0;
 }
 
-- 
2.17.1

