Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E1AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A98920674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN2nzfwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGXObn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:31:42 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:31:42 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so4162689qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=623/gE+t/NAauC48CDPw5iNlUH9MVtSJpPc426h2K5M=;
        b=kN2nzfwuzsH+t/mKkGCZ6ygMIN/RvaebEl1PWSwAXMxnqa6f9DLQRpnr4OnjeVBN87
         8/HhCpuMuw+Dox9Q2uqS/XHHB3klUIU7zuwA20kO+oMUlY+XppcxPx1sbquLV+raa/JW
         7VPvolE+rKqRLYqyJKEuN5FKGIg7hOQr5IRdHGq39qN2h1JU6/07+MI4B1nQGBkOwAtA
         Ojg4I7avozPqahwPeEWugPQVI1DOpO888LCN9dItKMJo/GJiEakjlylcXc02RDto+5LY
         GIddrTeP0mcLteGk1ph978PwTrSC6/pPNmj10tWa5/RPxlkY9xJnFg2gUEdZ6HmWKy6C
         UizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=623/gE+t/NAauC48CDPw5iNlUH9MVtSJpPc426h2K5M=;
        b=lPV8kdNy2QafhmgahA2rPJd+BjNHSw0ZlgvghdoZQo3DHpd0PLV0X+bfkHE9Yjhf+P
         qxAmvDQgw0m4x0fnqsLWKOtbHf/iF+nDPuNZFU4a/4jy6Pb01dv7YoeQg6m6QP8rEMpA
         OieaMDSVRLGOo9brdeAZ3tfXFrYLkbOHC66hECwlTmijbVM+ORW6FRP/yFTUmknLOBqD
         ZBuibKP9gb96yCOahY6jqhbANve6lkkBF9HAu37kasT7yyzHtVfX3RVnGhKFRdTtJy4p
         va+BHHfPE6pQQyx+zd0CAadZZi/yQ+1AWp+qSZ9eluy+aamEfJIbQkP5bnuVH8tqcgLS
         fbcQ==
X-Gm-Message-State: AOAM531R6L+q4o7BwH5ksOupS67ggf6BCYaKKgXpjUEpV0zaSaNBSaBT
        dwoXA6tXqkXosZbM20tg/+A=
X-Google-Smtp-Source: ABdhPJxzEOhSzoijM/c8TNrFFKFv6FIvvv/SFKgfL+JgeJERXhB7GoLZ6FiXAd8Lt8w5gx8pvrATkg==
X-Received: by 2002:ad4:4869:: with SMTP id u9mr10018190qvy.98.1595601101763;
        Fri, 24 Jul 2020 07:31:41 -0700 (PDT)
Received: from dev.localdomain ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id y50sm1664233qtk.29.2020.07.24.07.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:31:41 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, laoar.shao@gmail.com,
        urezki@gmail.com, jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
Date:   Fri, 24 Jul 2020 10:31:23 -0400
Message-Id: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
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
 kernel/softirq.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f..d572ce4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,7 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/sched/clock.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -200,17 +201,15 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
- * certain cases, such as stop_machine(), jiffies may cease to
- * increment and so we need the MAX_SOFTIRQ_RESTART limit as
- * well to make sure we eventually return from this method.
+ * In the loop, if the processing time of the softirq has exceeded 2
+ * milliseconds, we also need to break the loop to wakeup the ksofirqd.
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
@@ -248,7 +247,7 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
 
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
+	u64 end = sched_clock() + MAX_SOFTIRQ_TIME_NS;
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
@@ -299,6 +298,19 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		}
 		h++;
 		pending >>= softirq_bit;
+
+		/*
+		 * the softirq's action has been running for too much time
+		 * so it may need to wakeup the ksoftirqd
+		 */
+		if (need_resched() && sched_clock() > end) {
+			/*
+			 * Ensure that the remaining pending bits are
+			 * handled.
+			 */
+			or_softirq_pending(pending << (vec_nr + 1));
+			break;
+		}
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)
@@ -307,8 +319,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
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

