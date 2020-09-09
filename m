Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691FBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A052145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8bZqPNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgIIJJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgIIJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:09:46 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716CC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:09:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i17so1630063oig.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lp4vuPsvFxDFpD3RPxxQA9GDt79f5fSUFEakGXQllkE=;
        b=X8bZqPNpcH6+/UUTOlrjCUxpBIHRpxYnhOVxM9oVc76gpNUIHtMobQJxnLGp2RHGb4
         Ag+2MVXMcEdEA5t+cj1rLZk0Loc4qT1G9mve+/e3J57GPskWXfTbKzlUAspPm1JYQSV/
         8xdRiRdynXSrUFPoqwxTCuuPf2R5OVVoYvbt1xSfcQ4urDIBFVnF9H6kmQnrjb3bZOyO
         2y1f9ogfYDKHVe1Fg/AckWNNvnU8JFinD76QEsugAs6t7Qavjw8fFb6SnfZVdzwKTI9l
         /CTKR4aq+vjinFMOaI1/hFpbqqSEsAgOOlBvbHYTYgit2N1FeQnGeWkpHsw10i0o12vY
         2PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lp4vuPsvFxDFpD3RPxxQA9GDt79f5fSUFEakGXQllkE=;
        b=G6s03++dpaWIIbTa2JXIaDukJGQL0UioOdG3mfOgu5B2zGACicJTWU6uIbB/lpmBGe
         SaHnu9iTX9DoBJAqCd+PZrCji74KOXSp1U8XWaHEI1SBs4+ummkbSyUGaVpFFWP1MTfn
         KLGXnnNiqXao00LlfMjwD2nMyAHl4VhfuvH8r3IzFqKtWDLmhei2bPfEhKiUT34eDnHJ
         xG0O3gJFkcwbDJNrBMDzprHmARr66CdWpzW6jUb+VVIcxcwcX78mD6Ux45WxRMBYR5Hk
         PN61XdSzHe9Mdc91gViJTMo9dJ/C51d2+ddAF3trZao2kM0V5YnwoQpAirWEPUfZXOGG
         bWDg==
X-Gm-Message-State: AOAM5331i9jwk+GWCMgalyDgnANOdUJb4oRCEpi+86c0RxOv0vESdz2x
        bd+Lp0fLeJ0ICOauNvcfNrc=
X-Google-Smtp-Source: ABdhPJyP27LE1UC7njpXncKDhJawWmQ1Ejpu8fVvV8tdd7fcZld6Lvd9Z4q2EY3q8EfEC6geCr9Ofg==
X-Received: by 2002:aca:e144:: with SMTP id y65mr24383oig.101.1599642584322;
        Wed, 09 Sep 2020 02:09:44 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id 187sm342993oie.42.2020.09.09.02.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:09:43 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending softirqs
Date:   Wed,  9 Sep 2020 17:09:31 +0800
Message-Id: <20200909090931.8836-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

When get the pending softirqs, it need to process all the pending
softirqs in the while loop. If the processing time of each pending
softirq is need more than 2 msec in this loop, or one of the softirq
will running a long time, according to the original code logic, it
will process all the pending softirqs without wakeuping ksoftirqd,
which will cause a relatively large scheduling delay on the
corresponding CPU, which we do not wish to see. The patch will check
the total time to process pending softirq, if the time exceeds 2 ms
we need to wakeup the ksofirqd to aviod large sched delay.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/softirq.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 14 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f..1f696c8 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,7 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/sched/clock.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -199,18 +200,17 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
- * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
- * certain cases, such as stop_machine(), jiffies may cease to
- * increment and so we need the MAX_SOFTIRQ_RESTART limit as
- * well to make sure we eventually return from this method.
+ * but break the loop if need_resched() is set or after MAX_SOFTIRQ_TIME_NS
+ * ns. In the loop, if the processing time of the softirq has exceeded
+ * MAX_SOFTIRQ_TIME_NS ns, we also need to break the loop to wakeup the
+ * ksofirqd.
  *
  * These limits have been established via experimentation.
  * The two things to balance is latency against fairness -
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
+#define MAX_SOFTIRQ_TIME_NS 2000000
 #define MAX_SOFTIRQ_RESTART 10
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -246,15 +246,20 @@ static inline void lockdep_softirq_end(bool in_hardirq)
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+DEFINE_PER_CPU(__u32, pending_new_flag);
+DEFINE_PER_CPU(__u32, pending_next_bit);
+#define SOFTIRQ_PENDING_MASK ((1UL << NR_SOFTIRQS) - 1)
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
+	u64 end = sched_clock() + MAX_SOFTIRQ_TIME_NS;
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	bool in_hardirq;
-	__u32 pending;
-	int softirq_bit;
+	__u32 pending, pending_left, pending_new;
+	int softirq_bit, next_bit;
+	unsigned long flags;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -277,10 +282,33 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	h = softirq_vec;
 
-	while ((softirq_bit = ffs(pending))) {
-		unsigned int vec_nr;
+	next_bit = per_cpu(pending_next_bit, smp_processor_id());
+	per_cpu(pending_new_flag, smp_processor_id()) = 0;
+
+	pending_left = pending &
+		(SOFTIRQ_PENDING_MASK << next_bit);
+	pending_new = pending &
+		(SOFTIRQ_PENDING_MASK >> (NR_SOFTIRQS - next_bit));
+
+	/*
+	 * In order to be fair, we shold process the pengding bits by the
+	 * last processing order.
+	 */
+	while ((softirq_bit = ffs(pending_left)) ||
+		(softirq_bit = ffs(pending_new))) {
 		int prev_count;
+		unsigned int vec_nr = 0;
 
+		/*
+		 * when the left pengding bits have been handled, we should
+		 * to reset the h to softirq_vec.
+		 */
+		if (!ffs(pending_left)) {
+			if (per_cpu(pending_new_flag, smp_processor_id()) == 0) {
+				h = softirq_vec;
+				per_cpu(pending_new_flag, smp_processor_id()) = 1;
+			}
+		}
 		h += softirq_bit - 1;
 
 		vec_nr = h - softirq_vec;
@@ -298,17 +326,44 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 			preempt_count_set(prev_count);
 		}
 		h++;
-		pending >>= softirq_bit;
+
+		if (ffs(pending_left))
+			pending_left >>= softirq_bit;
+		else
+			pending_new >>= softirq_bit;
+
+		/*
+		 * the softirq's action has been run too much time,
+		 * so it may need to wakeup the ksoftirqd
+		 */
+		if (need_resched() && sched_clock() > end) {
+			/*
+			 * Ensure that the remaining pending bits will be
+			 * handled.
+			 */
+			local_irq_save(flags);
+			if (ffs(pending_left))
+				or_softirq_pending((pending_left << (vec_nr + 1)) |
+							pending_new);
+			else
+				or_softirq_pending(pending_new << (vec_nr + 1));
+			local_irq_restore(flags);
+			per_cpu(pending_next_bit, smp_processor_id()) = vec_nr + 1;
+			break;
+		}
 	}
 
+	/* reset the pending_next_bit */
+	per_cpu(pending_next_bit, smp_processor_id()) = 0;
+
 	if (__this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
 	local_irq_disable();
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (time_before(jiffies, end) && !need_resched() &&
-		    --max_restart)
+		if (!need_resched() && --max_restart &&
+		    sched_clock() <= end)
 			goto restart;
 
 		wakeup_softirqd();
-- 
1.8.3.1

