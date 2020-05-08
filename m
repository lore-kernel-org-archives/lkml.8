Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD170C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E3724968
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941623;
	bh=JyzA/toJmobv8pqkl2AUuq7SFlI+lN0prBCKaoLlU7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0JMmIVaqW6OR5tL4BCt58kZQZaKb4KYAQ+mb9ImaNhy/B1XWJncbIyAryduaPDBTG
	 FSvl/nPCwGJfzC/9/nfKBnclO2Y6gTtZOgimxVIzOw1s22tqOBGAX92sE0CWGMY/jg
	 V3b/yLT8dmngx3OaE0Mc/Y2XSaVDy+eqhTsQJtfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgEHMkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgEHMjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:39:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7F320731;
        Fri,  8 May 2020 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941586;
        bh=JyzA/toJmobv8pqkl2AUuq7SFlI+lN0prBCKaoLlU7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRKULubaJuhuYjLWvB204hBM4nrNjHRH9d4DGx3EV0rkDuXwJBPmhcMOOA1gQeT7i
         m3C+cbCi6EdxddYPH/K7CUambYpeY8zKh3r2s1atnC7FnNlgYY3aj+uO0b4ynTEhCk
         xPjX4XYVvQDj/2eYWcXmh05//e2mX0ioVe5fSQe8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stas Nichiporovich <stasn77@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 090/312] sch_prio: update backlog as well
Date:   Fri,  8 May 2020 14:31:21 +0200
Message-Id: <20200508123130.868133546@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Cong <xiyou.wangcong@gmail.com>

commit 6529d75ad9228f4d8a8f6c5c5244ceb945ac9bc2 upstream.

We need to update backlog too when we update qlen.

Joint work with Stas.

Reported-by: Stas Nichiporovich <stasn77@gmail.com>
Tested-by: Stas Nichiporovich <stasn77@gmail.com>
Fixes: 2ccccf5fb43f ("net_sched: update hierarchical backlog too")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/sch_prio.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -85,6 +85,7 @@ prio_enqueue(struct sk_buff *skb, struct
 
 	ret = qdisc_enqueue(skb, qdisc);
 	if (ret == NET_XMIT_SUCCESS) {
+		qdisc_qstats_backlog_inc(sch, skb);
 		sch->q.qlen++;
 		return NET_XMIT_SUCCESS;
 	}
@@ -117,6 +118,7 @@ static struct sk_buff *prio_dequeue(stru
 		struct sk_buff *skb = qdisc_dequeue_peeked(qdisc);
 		if (skb) {
 			qdisc_bstats_update(sch, skb);
+			qdisc_qstats_backlog_dec(sch, skb);
 			sch->q.qlen--;
 			return skb;
 		}
@@ -135,6 +137,7 @@ static unsigned int prio_drop(struct Qdi
 	for (prio = q->bands-1; prio >= 0; prio--) {
 		qdisc = q->queues[prio];
 		if (qdisc->ops->drop && (len = qdisc->ops->drop(qdisc)) != 0) {
+			sch->qstats.backlog -= len;
 			sch->q.qlen--;
 			return len;
 		}
@@ -151,6 +154,7 @@ prio_reset(struct Qdisc *sch)
 
 	for (prio = 0; prio < q->bands; prio++)
 		qdisc_reset(q->queues[prio]);
+	sch->qstats.backlog = 0;
 	sch->q.qlen = 0;
 }
 


