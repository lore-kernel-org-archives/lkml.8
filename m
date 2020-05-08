Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ACFC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C492D24968
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941626;
	bh=IewKq2XCgLpEBcwa79IgRkVpFGE9iKu2hgpyii2DLA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhwD1HSRajEJ+98JAxQgfSRPTE9iR4F84QOaUU34DRIrU7YOTIEQbwNU2AWA4sMB2
	 eHgLGh6N4WE0o45O9ae49tEB4yhkjVFyJKmtIzS4D8Jjt4N3IdnXPfT7iTdM8wqdGS
	 TMOhFYi4yn5cRU36QkgS2VUEKcLak469+nL+P4Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgEHMkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbgEHMju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:39:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C0C21835;
        Fri,  8 May 2020 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941588;
        bh=IewKq2XCgLpEBcwa79IgRkVpFGE9iKu2hgpyii2DLA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQYndT6W1GifXLtdA1yQZCOlDAmplTxt6AcMXDiSwMcyc7UjMYiXMrAZ+PTAg5nyQ
         OmRr3atBXXSV/9wr4opAtN9/Ece7QVxT+Jji2SiGfG7iEZq+bhgnN4D4R2iXLEyklP
         VzmG1ZCILlmaIWvxrO0zXEwBsiixVVrDLRYMUdJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stas Nichiporovich <stasn77@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 091/312] sch_qfq: keep backlog updated with qlen
Date:   Fri,  8 May 2020 14:31:22 +0200
Message-Id: <20200508123130.936340045@linuxfoundation.org>
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

commit 2ed5c3f09627f72a2e0e407a86b2ac05494190f9 upstream.

Reported-by: Stas Nichiporovich <stasn77@gmail.com>
Fixes: 2ccccf5fb43f ("net_sched: update hierarchical backlog too")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/sch_qfq.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1150,6 +1150,7 @@ static struct sk_buff *qfq_dequeue(struc
 	if (!skb)
 		return NULL;
 
+	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
 	qdisc_bstats_update(sch, skb);
 
@@ -1250,6 +1251,7 @@ static int qfq_enqueue(struct sk_buff *s
 	}
 
 	bstats_update(&cl->bstats, skb);
+	qdisc_qstats_backlog_inc(sch, skb);
 	++sch->q.qlen;
 
 	agg = cl->agg;
@@ -1516,6 +1518,7 @@ static void qfq_reset_qdisc(struct Qdisc
 			qdisc_reset(cl->qdisc);
 		}
 	}
+	sch->qstats.backlog = 0;
 	sch->q.qlen = 0;
 }
 


