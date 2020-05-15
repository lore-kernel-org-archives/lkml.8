Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6908820709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589502878;
	bh=ZzPNZ0jfzkb1RkXGDECFVat/tsyptCJm2/viO4UM5wE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QuPVULh9utxoOZzVaw8w2kq6HZ5OcnFHF+Wue96g+th0MGNjXxWQQ0ZInsbJvk+VS
	 kZxECkiAbz00L7dN0cy1PmWKqwjpu4mE3QgGw0H43PeFhuk4WOQ9mYVcPxdd8Mg56/
	 g4vY6XB+A/3mjOwKzhYicyzqlEcUrFoI6rQ2UoRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgEOAeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEOAeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:34:37 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5D9206D8;
        Fri, 15 May 2020 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589502876;
        bh=ZzPNZ0jfzkb1RkXGDECFVat/tsyptCJm2/viO4UM5wE=;
        h=From:To:Cc:Subject:Date:From;
        b=FPjvwH8xGMwAPI0Uw4dcZq87U6kArLCvZ0RIxx697Zpn3iRUijT1xOcr9mnvXOP/b
         xPOZLajdHemn8ERfmDhpvQ8aV7sGB2BNo7Y9GmyOvS/fWqCu9hDT763T1Kx3sd0ien
         490AiuFZ5iClFErMoyJ4jISsqW51eVSKRmzk78iM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, stable@kernel.org
Subject: [PATCH] tick/nohz: Narrow down noise while setting current task's tick dependency
Date:   Fri, 15 May 2020 02:34:29 +0200
Message-Id: <20200515003429.4317-1-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far setting a tick dependency on any task, including current, used to
trigger an IPI to all CPUs. That's of course suboptimal but it wasn't
an issue as long as it was only used by posix-cpu-timers on nohz_full,
a combo that nobody seemed to use in real life.

But RCU started to use task tick dependency on current task to fix
stall issues on callbacks processing. These trigger regular and
undesired system wide IPIs on nohz_full.

The fix is very easy while setting a tick dependency on the current
task, only its CPU needs an IPI.

Fixes: 6a949b7af82d (rcu: Force on tick when invoking lots of callbacks)
Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@kernel.org
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/tick-sched.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b8858c..f0199a4ba1ad 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -351,16 +351,24 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
- * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
- * per task timers.
+ * Set a per-task tick dependency. RCU need this. Also posix CPU timers
+ * in order to elapse per task timers.
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
-	/*
-	 * We could optimize this with just kicking the target running the task
-	 * if that noise matters for nohz full users.
-	 */
-	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
+	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
+		if (tsk == current) {
+			preempt_disable();
+			tick_nohz_full_kick();
+			preempt_enable();
+		} else {
+			/*
+			 * Some future tick_nohz_full_kick_task()
+			 * should optimize this.
+			 */
+			tick_nohz_full_kick_all();
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 
-- 
2.26.2

