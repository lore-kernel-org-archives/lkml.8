Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14873C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED57D208C7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgF0Ho4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:44:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbgF0Ho4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:44:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2FFD2E5E07A84A9C047;
        Sat, 27 Jun 2020 15:44:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 27 Jun 2020
 15:44:43 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <kuba@kernel.org>, <dsahern@gmail.com>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: ipv4: Fix wrong type conversion from hint to rt in ip_route_use_hint()
Date:   Sat, 27 Jun 2020 15:47:51 +0800
Message-ID: <1593244071-28291-1-git-send-email-linmiaohe@huawei.com>
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

We can't cast sk_buff to rtable by (struct rtable *)hint. Use skb_rtable().

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1d7076b78e63..a01efa062f6b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2027,7 +2027,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      const struct sk_buff *hint)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
-	struct rtable *rt = (struct rtable *)hint;
+	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
 	int err = -EINVAL;
 	u32 tag = 0;
-- 
2.19.1

