Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7C62078B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502381AbgDNMza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:55:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502340AbgDNMzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:55:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60611DDDC13CCE64BB7D;
        Tue, 14 Apr 2020 20:55:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 20:55:20 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH resend v2] sched/debug: fix trival print task format
Date:   Tue, 14 Apr 2020 20:57:21 +0800
Message-ID: <20200414125721.195801-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure leave one space between state and task name.

w/o patch:
runnable tasks:
 S           task   PID         tree-key  switches  prio     wait
-----------------------------------------------------------------
 I    kworker/0:2   656     87693.884557      8255   120
 Sirq/10-ACPI:Ged   829         0.000000         3    49
 Sirq/11-ACPI:Ged   830         0.000000         3    49
 Sirq/50-arm-smmu   945         0.000000         3    49

with patch:
runnable tasks:
 S            task   PID         tree-key  switches  prio     wait
------------------------------------------------------------------
 I     kworker/0:2   656     87693.884557      8255   120
 S irq/10-ACPI:Ged   829         0.000000         3    49
 S irq/11-ACPI:Ged   830         0.000000         3    49
 S irq/50-arm-smmu   945         0.000000         3    49

v2:
 - fix a typo
 - simpler to add one space before print format

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 kernel/sched/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 879d3ccf3806..626d6c19c94b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -438,7 +438,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, " %15s %5d %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		(long long)(p->nvcsw + p->nivcsw),
@@ -465,10 +465,10 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S           task   PID         tree-key  switches  prio"
+	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
 		   "     wait-time             sum-exec        sum-sleep\n");
 	SEQ_printf(m, "-------------------------------------------------------"
-		   "----------------------------------------------------\n");
+		   "------------------------------------------------------\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
-- 
2.20.1

