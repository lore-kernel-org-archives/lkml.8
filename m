Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A12C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFEB2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHJMaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:30:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgHJMaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:30:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5224D82BFD0073A8DD2D;
        Mon, 10 Aug 2020 20:30:07 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 20:29:57 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pshelar@ovn.org>,
        <martin.varghese@nokia.com>, <fw@strlen.de>, <dcaratti@redhat.com>,
        <edumazet@google.com>, <steffen.klassert@secunet.com>,
        <pabeni@redhat.com>, <shmulik@metanetworks.com>,
        <kyk.segfault@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: eliminate meaningless memcpy to data in pskb_carve_inside_nonlinear()
Date:   Mon, 10 Aug 2020 08:28:56 -0400
Message-ID: <20200810122856.5423-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skb_shared_info part of the data is assigned in the following loop. It
is meaningless to do a memcpy here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/skbuff.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7e2e502ef519..5b983c9472f5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5952,9 +5952,6 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 
 	size = SKB_WITH_OVERHEAD(ksize(data));
 
-	memcpy((struct skb_shared_info *)(data + size),
-	       skb_shinfo(skb), offsetof(struct skb_shared_info,
-					 frags[skb_shinfo(skb)->nr_frags]));
 	if (skb_orphan_frags(skb, gfp_mask)) {
 		kfree(data);
 		return -ENOMEM;
-- 
2.19.1

