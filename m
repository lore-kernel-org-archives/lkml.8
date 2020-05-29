Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E07EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4572074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgE2G7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:59:20 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:30857 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbgE2G7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:59:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tzy5TGx_1590735545;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzy5TGx_1590735545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 14:59:06 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/4] workqueue: don't check wq->rescuer in rescuer
Date:   Fri, 29 May 2020 06:59:00 +0000
Message-Id: <20200529065903.1758-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529065903.1758-1-laijs@linux.alibaba.com>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now rescuer checks pwq->nr_active before requeues the pwq,
it is a more robust check and the rescuer must be still valid.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b2b15f1f0c8d..8d017727bfbc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -248,7 +248,7 @@ struct workqueue_struct {
 	struct list_head	flusher_overflow; /* WQ: flush overflow list */
 
 	struct list_head	maydays;	/* MD: pwqs requesting rescue */
-	struct worker		*rescuer;	/* MD: rescue worker */
+	struct worker		*rescuer;	/* I: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
 	int			saved_max_active; /* WQ: saved pwq max_active */
@@ -2532,12 +2532,13 @@ static int rescuer_thread(void *__rescuer)
 			if (pwq->nr_active && need_to_create_worker(pool)) {
 				spin_lock(&wq_mayday_lock);
 				/*
-				 * Queue iff we aren't racing destruction
-				 * and somebody else hasn't queued it already.
+				 * Queue iff somebody else hasn't queued it
+				 * already.
 				 */
-				if (wq->rescuer && list_empty(&pwq->mayday_node)) {
+				if (list_empty(&pwq->mayday_node)) {
 					get_pwq(pwq);
-					list_add_tail(&pwq->mayday_node, &wq->maydays);
+					list_add_tail(&pwq->mayday_node,
+						      &wq->maydays);
 				}
 				spin_unlock(&wq_mayday_lock);
 			}
@@ -4356,16 +4357,10 @@ void destroy_workqueue(struct workqueue_struct *wq)
 
 	/* kill rescuer, if sanity checks fail, leave it w/o rescuer */
 	if (wq->rescuer) {
-		struct worker *rescuer = wq->rescuer;
-
-		/* this prevents new queueing */
-		spin_lock_irq(&wq_mayday_lock);
-		wq->rescuer = NULL;
-		spin_unlock_irq(&wq_mayday_lock);
-
 		/* rescuer will empty maydays list before exiting */
-		kthread_stop(rescuer->task);
-		kfree(rescuer);
+		kthread_stop(wq->rescuer->task);
+		kfree(wq->rescuer);
+		wq->rescuer = NULL;
 	}
 
 	/*
-- 
2.20.1

