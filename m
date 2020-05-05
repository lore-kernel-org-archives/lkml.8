Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E89C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD2A20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEEIto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:49:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3847 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbgEEIto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:49:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F0D851A13A2973BB00FE;
        Tue,  5 May 2020 16:49:40 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 16:49:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sched: choke: Remove unused inline function choke_set_classid
Date:   Tue, 5 May 2020 16:47:36 +0800
Message-ID: <20200505084736.49692-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore since commit 5952fde10c35 ("net:
sched: choke: remove dead filter classify code")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/sched/sch_choke.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index a36974e9c601..2d350c734375 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -142,11 +142,6 @@ static inline struct choke_skb_cb *choke_skb_cb(const struct sk_buff *skb)
 	return (struct choke_skb_cb *)qdisc_skb_cb(skb)->data;
 }
 
-static inline void choke_set_classid(struct sk_buff *skb, u16 classid)
-{
-	choke_skb_cb(skb)->classid = classid;
-}
-
 /*
  * Compare flow of two packets
  *  Returns true only if source and destination address and port match.
-- 
2.17.1


