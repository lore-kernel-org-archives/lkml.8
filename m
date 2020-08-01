Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D900C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EF0206F6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgHAJ2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 05:28:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbgHAJ17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:27:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 261123654803EDEC5C17;
        Sat,  1 Aug 2020 17:27:57 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 1 Aug 2020
 17:27:48 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <fw@strlen.de>,
        <pshelar@ovn.org>, <martin.varghese@nokia.com>,
        <pabeni@redhat.com>, <edumazet@google.com>, <dcaratti@redhat.com>,
        <steffen.klassert@secunet.com>, <shmulik@metanetworks.com>,
        <kyk.segfault@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: Use __skb_pagelen() directly in skb_cow_data()
Date:   Sat, 1 Aug 2020 17:30:23 +0800
Message-ID: <1596274223-24555-1-git-send-email-linmiaohe@huawei.com>
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

In fact, skb_pagelen() - skb_headlen() is equal to __skb_pagelen(), use it
directly to avoid unnecessary skb_headlen() call.

Also fix the CHECK note of checkpatch.pl:
    Comparison to NULL could be written "!__pskb_pull_tail"

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b8afefe6f6b6..3219c26ddfae 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4413,7 +4413,7 @@ int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer)
 	 * at the moment even if they are anonymous).
 	 */
 	if ((skb_cloned(skb) || skb_shinfo(skb)->nr_frags) &&
-	    __pskb_pull_tail(skb, skb_pagelen(skb)-skb_headlen(skb)) == NULL)
+	    !__pskb_pull_tail(skb, __skb_pagelen(skb)))
 		return -ENOMEM;
 
 	/* Easy case. Most of packets will go this way. */
-- 
2.19.1

