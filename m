Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A0C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 09:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F3E2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 09:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgH2JDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 05:03:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbgH2JDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 05:03:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CFC64CC2069505D02394;
        Sat, 29 Aug 2020 17:03:24 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 29 Aug 2020
 17:03:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: ipv4: remove unused arg exact_dif in compute_score
Date:   Sat, 29 Aug 2020 05:01:51 -0400
Message-ID: <20200829090151.61891-1-linmiaohe@huawei.com>
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

The arg exact_dif is not used anymore, remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/ipv4/inet_hashtables.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 239e54474b65..8cbe74313f38 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -228,7 +228,7 @@ static void inet_unhash2(struct inet_hashinfo *h, struct sock *sk)
 
 static inline int compute_score(struct sock *sk, struct net *net,
 				const unsigned short hnum, const __be32 daddr,
-				const int dif, const int sdif, bool exact_dif)
+				const int dif, const int sdif)
 {
 	int score = -1;
 
@@ -277,15 +277,13 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 				const __be32 daddr, const unsigned short hnum,
 				const int dif, const int sdif)
 {
-	bool exact_dif = inet_exact_dif_match(net, skb);
 	struct inet_connection_sock *icsk;
 	struct sock *sk, *result = NULL;
 	int score, hiscore = 0;
 
 	inet_lhash2_for_each_icsk_rcu(icsk, &ilb2->head) {
 		sk = (struct sock *)icsk;
-		score = compute_score(sk, net, hnum, daddr,
-				      dif, sdif, exact_dif);
+		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = lookup_reuseport(net, sk, skb, doff,
 						  saddr, sport, daddr, hnum);
-- 
2.19.1

