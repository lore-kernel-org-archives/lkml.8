Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00803C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182921D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgAQW7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:59:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43924 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgAQW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:59:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so19577754lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8t5sesjNU4GLzY8Ju+3vDc9euUX5JJDxPn6PxTGKqI=;
        b=LrX0GVfvApBDiFPAKXsTC6ZXEq3wFPVScIxV2pKP4/NrhX2lMLybDqv3vuTYX+t0pI
         Lhktehq0OHOl73zq5jUdqinKKO4kz3KQ3CZCVTDb5mkGD2BZorxLp3pRvlovZcT5kPao
         hXv9mgqLNSerZ6Yy8bvmwbYF2gUbPNEQYF2FwEDhqYIc+bbrC3ayEtaHsX6RWNyZrSlO
         xot1UbPgeRa8MwLKAruM4tLOK8pUOO9DYba0U/D6wbiB2vLDcZz2Z+ZznciDT0mlYZl5
         BAVa0Srgj4Ez+qLuGb+ADsgQZuG0NS1Hb6Ux5YuLQ03U3MMNFp4DgrQDe0WAbTwN5rc0
         bOgw==
X-Gm-Message-State: APjAAAWSTvB4hX85Ujt/MfzFAN2G095qbo1zgctpaGVjbOAU/HM1ugiz
        K64MjEr7Nzc6wV6i1IvCUO4=
X-Google-Smtp-Source: APXvYqwX3L4R8D8T2NdF04Cs/1BkxcMDoTxUEmh2LA4q6dBU5Sdsy0CjfB3zvrENKQcaYzogV7h5fA==
X-Received: by 2002:ac2:43af:: with SMTP id t15mr6790438lfl.154.1579301953025;
        Fri, 17 Jan 2020 14:59:13 -0800 (PST)
Received: from hackbase.lan (128-68-70-109.broadband.corbina.ru. [128.68.70.109])
        by smtp.gmail.com with ESMTPSA id n3sm12769556lfk.61.2020.01.17.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:59:12 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Alexander Popov <alex.popov@linux.com>,
        linux-kernel@vger.kernel.org
Cc:     notify@kernel.org
Subject: [PATCH 1/1] timer: Improve the comment describing schedule_timeout()
Date:   Sat, 18 Jan 2020 01:59:00 +0300
Message-Id: <20200117225900.16340-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we were preparing the patch 6dcd5d7a7a29c1e, we made a mistake noticed
by Linus: schedule_timeout() was called without setting the task state to
anything particular. It calls the scheduler, but doesn't delay anything,
because the task stays runnable. That happens because sched_submit_work()
does nothing for tasks in TASK_RUNNING state.

That turned out to be the intended behavior. Adding a WARN() is not useful.
Let's improve the comment about schedule_timeout() and describe that
more explicitly.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 kernel/time/timer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823515e9..cb34fac9d9f7 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1828,21 +1828,23 @@ static void process_timeout(struct timer_list *t)
  * schedule_timeout - sleep until timeout
  * @timeout: timeout value in jiffies
  *
- * Make the current task sleep until @timeout jiffies have
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
+ * Make the current task sleep until @timeout jiffies have elapsed.
+ * The function behavior depends on the current task state
+ * (see also set_current_state() description):
  *
- * You can set the task state as follows -
+ * %TASK_RUNNING - the scheduler is called, but the task does not sleep
+ * at all. That happens because sched_submit_work() does nothing for
+ * tasks in %TASK_RUNNING state.
  *
  * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
  * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process())".
+ * woken up, (e.g. by wake_up_process()).
  *
  * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
  * delivered to the current task or the current task is explicitly woken
  * up.
  *
- * The current task state is guaranteed to be TASK_RUNNING when this
+ * The current task state is guaranteed to be %TASK_RUNNING when this
  * routine returns.
  *
  * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
@@ -1850,7 +1852,7 @@ static void process_timeout(struct timer_list *t)
  * value will be %MAX_SCHEDULE_TIMEOUT.
  *
  * Returns 0 when the timer has expired otherwise the remaining time in
- * jiffies will be returned.  In all cases the return value is guaranteed
+ * jiffies will be returned. In all cases the return value is guaranteed
  * to be non-negative.
  */
 signed long __sched schedule_timeout(signed long timeout)
-- 
2.24.1

