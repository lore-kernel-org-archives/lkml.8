Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47DFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E33206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgHPAgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:36:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgHPAgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 20:36:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D279E73AC0F064E5C21;
        Sat, 15 Aug 2020 16:47:55 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 16:47:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>,
        <martin.varghese@nokia.com>, <fw@strlen.de>, <pshelar@ovn.org>,
        <dcaratti@redhat.com>, <edumazet@google.com>,
        <steffen.klassert@secunet.com>, <pabeni@redhat.com>,
        <shmulik@metanetworks.com>, <kyk.segfault@gmail.com>,
        <sowmini.varadhan@oracle.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: handle the return value of pskb_carve_frag_list() correctly
Date:   Sat, 15 Aug 2020 04:46:41 -0400
Message-ID: <20200815084641.18417-1-linmiaohe@huawei.com>
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

pskb_carve_frag_list() may return -ENOMEM in pskb_carve_inside_nonlinear().
we should handle this correctly or we would get wrong sk_buff.

Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bca0d3c7f114..afbc1a79dc8a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5987,9 +5987,13 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	if (skb_has_frag_list(skb))
 		skb_clone_fraglist(skb);
 
-	if (k == 0) {
-		/* split line is in frag list */
-		pskb_carve_frag_list(skb, shinfo, off - pos, gfp_mask);
+	/* split line is in frag list */
+	if (k == 0 && pskb_carve_frag_list(skb, shinfo, off - pos, gfp_mask)) {
+		/* skb_frag_unref() is not needed here as shinfo->nr_frags = 0. */
+		if (skb_has_frag_list(skb))
+			kfree_skb_list(skb_shinfo(skb)->frag_list);
+		kfree(data);
+		return -ENOMEM;
 	}
 	skb_release_data(skb);
 
-- 
2.19.1

