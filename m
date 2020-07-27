Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8FC20672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgG0M1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:27:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726890AbgG0M1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:27:03 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6BC9AC316369470C401;
        Mon, 27 Jul 2020 20:26:58 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 20:26:48 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] workqueue: Use wake_up_worker() to wake up first idle worker
Date:   Mon, 27 Jul 2020 20:29:29 +0800
Message-ID: <1595852969-21049-1-git-send-email-linmiaohe@huawei.com>
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

Use wrapper function wake_up_worker() to wake up first idle worker.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/workqueue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c17b86a..5302f227f38f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -864,7 +864,7 @@ void wq_worker_running(struct task_struct *task)
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *next, *worker = kthread_data(task);
+	struct worker *worker = kthread_data(task);
 	struct worker_pool *pool;
 
 	/*
@@ -896,11 +896,9 @@ void wq_worker_sleeping(struct task_struct *task)
 	 * lock is safe.
 	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
-	    !list_empty(&pool->worklist)) {
-		next = first_idle_worker(pool);
-		if (next)
-			wake_up_process(next->task);
-	}
+	    !list_empty(&pool->worklist))
+		wake_up_worker(pool);
+
 	raw_spin_unlock_irq(&pool->lock);
 }
 
-- 
2.19.1

