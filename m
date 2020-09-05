Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB2C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 09:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B72074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 09:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgIEJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 05:28:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728430AbgIEJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 05:28:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40BF594029903E1A9AF8;
        Sat,  5 Sep 2020 17:28:48 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 17:28:40 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] sched: Fix some comments
Date:   Sat, 5 Sep 2020 05:27:27 -0400
Message-ID: <20200905092727.57471-1-linmiaohe@huawei.com>
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

Since commit dfa50b605c2a ("sched: Make finish_task_switch() return 'struct
rq *'"), prev == current is incorrect in finish_task_switch(). Also fix a
typo in the comment of struct dl_bandwidth.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/sched.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f7eb32..725ccab230da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3571,8 +3571,8 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  *
  * The context switch have flipped the stack from under us and restored the
  * local variables which were saved when this task called schedule() in the
- * past. prev == current is still correct but we need to recalculate this_rq
- * because prev may have moved to another CPU.
+ * past. We need to recalculate this_rq because prev may have moved to
+ * another CPU.
  */
 static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..1d7e45f7fbb9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -278,7 +278,7 @@ void __dl_clear_params(struct task_struct *p);
  * consume bandwidth on the CPU they're running on.
  * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
  * that will be shown the next time the proc or cgroup controls will
- * be red. It on its turn can be changed by writing on its own
+ * be read. It on its turn can be changed by writing on its own
  * control.
  */
 struct dl_bandwidth {
-- 
2.19.1

