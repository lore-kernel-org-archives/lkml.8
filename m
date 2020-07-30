Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB649C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8740420838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596124636;
	bh=a+XRZzS6rrMIkr38wJB/EC5C4sRmUQfanFozeAfX0vQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=R1xOGg25BwOdyxy3pFAN2pciPDLtJteqM0cNZk3v8pZzmy5erjRWRlz9bw0iuVNN9
	 k99SpC1cu/mbTtGwQ5DX3hiKLx74ajbqeNxwz2dVReR7GfhABE6hx+IffxYZiH1ypD
	 G3urVbSQ86EB7Xk0dYWTPmWqM4rJczThTnVsMXW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgG3P5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3P5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:57:14 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38DA6206F5;
        Thu, 30 Jul 2020 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596124634;
        bh=a+XRZzS6rrMIkr38wJB/EC5C4sRmUQfanFozeAfX0vQ=;
        h=Date:From:To:Cc:Subject:From;
        b=H/kxHh48WGg0FTSyL74IiufzWRc2eQVqkfa9aRIoobLrzByN3fIANjHmz161II4iy
         AvK5CKDkTjjqvarD/VG2YIBzzyzUznAJf1RaSRinVAxU7tAvQyvbsoNggRUz5UlFEM
         SYbflYo5UqgXPmd9m1lo5blK6HcYX44BKjEVVvxA=
Date:   Thu, 30 Jul 2020 11:03:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] net/sched: cls_u32: Use struct_size() helper
Message-ID: <20200730160314.GA30990@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper, in multiple places, instead
of an open-coded version in order to avoid any potential type
mistakes and protect against potential integer overflows.

Also, remove unnecessary object identifier size.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/sched/cls_u32.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 771b068f8254..7b69ab1993ba 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -852,9 +852,6 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	u32 htid, flags = 0;
 	size_t sel_size;
 	int err;
-#ifdef CONFIG_CLS_U32_PERF
-	size_t size;
-#endif
 
 	if (!opt) {
 		if (handle) {
@@ -1022,15 +1019,15 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		goto erridr;
 	}
 
-	n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);
+	n = kzalloc(struct_size(n, sel.keys, s->nkeys), GFP_KERNEL);
 	if (n == NULL) {
 		err = -ENOBUFS;
 		goto erridr;
 	}
 
 #ifdef CONFIG_CLS_U32_PERF
-	size = sizeof(struct tc_u32_pcnt) + s->nkeys * sizeof(u64);
-	n->pf = __alloc_percpu(size, __alignof__(struct tc_u32_pcnt));
+	n->pf = __alloc_percpu(struct_size(n->pf, kcnts, s->nkeys),
+			       __alignof__(struct tc_u32_pcnt));
 	if (!n->pf) {
 		err = -ENOBUFS;
 		goto errfree;
@@ -1294,8 +1291,7 @@ static int u32_dump(struct net *net, struct tcf_proto *tp, void *fh,
 		int cpu;
 #endif
 
-		if (nla_put(skb, TCA_U32_SEL,
-			    sizeof(n->sel) + n->sel.nkeys*sizeof(struct tc_u32_key),
+		if (nla_put(skb, TCA_U32_SEL, struct_size(&n->sel, keys, n->sel.nkeys),
 			    &n->sel))
 			goto nla_put_failure;
 
@@ -1345,9 +1341,7 @@ static int u32_dump(struct net *net, struct tcf_proto *tp, void *fh,
 				goto nla_put_failure;
 		}
 #ifdef CONFIG_CLS_U32_PERF
-		gpf = kzalloc(sizeof(struct tc_u32_pcnt) +
-			      n->sel.nkeys * sizeof(u64),
-			      GFP_KERNEL);
+		gpf = kzalloc(struct_size(gpf, kcnts, n->sel.nkeys), GFP_KERNEL);
 		if (!gpf)
 			goto nla_put_failure;
 
@@ -1361,9 +1355,7 @@ static int u32_dump(struct net *net, struct tcf_proto *tp, void *fh,
 				gpf->kcnts[i] += pf->kcnts[i];
 		}
 
-		if (nla_put_64bit(skb, TCA_U32_PCNT,
-				  sizeof(struct tc_u32_pcnt) +
-				  n->sel.nkeys * sizeof(u64),
+		if (nla_put_64bit(skb, TCA_U32_PCNT, struct_size(gpf, kcnts, n->sel.nkeys),
 				  gpf, TCA_U32_PAD)) {
 			kfree(gpf);
 			goto nla_put_failure;
-- 
2.27.0

