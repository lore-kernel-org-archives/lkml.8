Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B23C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91BA222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgAPDRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:17:44 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50951 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgAPDRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:17:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TnrHyKa_1579144660;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnrHyKa_1579144660)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:17:41 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cputime: remove irqtime_account_idle_ticks
Date:   Thu, 16 Jan 2020 11:17:30 +0800
Message-Id: <1579144650-161327-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irqtime_account_idle_ticks just add longer call path w/o enough meaning.
We don't bother remove this function to simply code and reduce a
bit object size of kernel.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Juri Lelli <juri.lelli@redhat.com> 
Cc: Vincent Guittot <vincent.guittot@linaro.org> 
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com> 
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ben Segall <bsegall@google.com> 
Cc: Mel Gorman <mgorman@suse.de> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/sched/cputime.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cff3e656566d..17640d145e44 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -390,12 +390,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 	}
 }
 
-static void irqtime_account_idle_ticks(int ticks)
-{
-	irqtime_account_process_tick(current, 0, ticks);
-}
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
-static inline void irqtime_account_idle_ticks(int ticks) { }
 static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 						int nr_ticks) { }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
@@ -505,7 +500,7 @@ void account_idle_ticks(unsigned long ticks)
 	u64 cputime, steal;
 
 	if (sched_clock_irqtime) {
-		irqtime_account_idle_ticks(ticks);
+		irqtime_account_process_tick(current, 0, ticks);
 		return;
 	}
 
-- 
1.8.3.1

