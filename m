Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2404C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5262076A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHAJdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 05:33:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbgHAJdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:33:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0F1A1F17CBA4CBFA322;
        Sat,  1 Aug 2020 17:33:38 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 1 Aug 2020
 17:33:29 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pshelar@ovn.org>,
        <martin.varghese@nokia.com>, <fw@strlen.de>, <pabeni@redhat.com>,
        <edumazet@google.com>, <dcaratti@redhat.com>,
        <steffen.klassert@secunet.com>, <shmulik@metanetworks.com>,
        <kyk.segfault@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: Pass NULL to skb_network_protocol() when we don't care about vlan depth
Date:   Sat, 1 Aug 2020 17:36:05 +0800
Message-ID: <1596274565-24655-1-git-send-email-linmiaohe@huawei.com>
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

When we don't care about vlan depth, we could pass NULL instead of the
address of a unused local variable to skb_network_protocol() as a param.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/skbuff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3219c26ddfae..8a0c39e4ab0a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3758,7 +3758,6 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int err = -ENOMEM;
 	int i = 0;
 	int pos;
-	int dummy;
 
 	if (list_skb && !list_skb->head_frag && skb_headlen(list_skb) &&
 	    (skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY)) {
@@ -3780,7 +3779,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	}
 
 	__skb_push(head_skb, doffset);
-	proto = skb_network_protocol(head_skb, &dummy);
+	proto = skb_network_protocol(head_skb, NULL);
 	if (unlikely(!proto))
 		return ERR_PTR(-EINVAL);
 
-- 
2.19.1

