Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41036C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF4F2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgE2G7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:59:12 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34350 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgE2G7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:59:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tzy55Or_1590735546;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzy55Or_1590735546)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 14:59:06 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/4] workqueue: free wq->unbound_attrs earlier
Date:   Fri, 29 May 2020 06:59:01 +0000
Message-Id: <20200529065903.1758-4-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529065903.1758-1-laijs@linux.alibaba.com>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wq->unbound_attrs is never accessed in rcu read site, so that
it can be freed earlier and relieves memory pressure earlier,
although slightly.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8d017727bfbc..c0cbe0de95d0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3489,8 +3489,6 @@ static void rcu_free_wq(struct rcu_head *rcu)
 
 	if (!(wq->flags & WQ_UNBOUND))
 		free_percpu(wq->cpu_pwqs);
-	else
-		free_workqueue_attrs(wq->unbound_attrs);
 
 	kfree(wq);
 }
@@ -3678,6 +3676,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
 	 */
 	if (is_last) {
 		wq_unregister_lockdep(wq);
+		free_workqueue_attrs(wq->unbound_attrs);
 		call_rcu(&wq->rcu, rcu_free_wq);
 	}
 }
-- 
2.20.1

