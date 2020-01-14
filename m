Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A96EC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14292467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZxZ8nJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgANOOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:14:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52879 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgANOOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:14:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so13985133wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 06:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dQLNpWLGlZntblD8Vo0H/wvH1TQ6QT4Dns9lFKlqz40=;
        b=LZxZ8nJsB9nlPqYwpe05m8yIOGGz3U7FORuzL9jPFR8DnrEDYhhEJVL3mxwoZTv8Uk
         2+G3OpwK1la2GB49LF546G3Xf6PprTbmPuyydQCOFS8/17QQPwkVrC7hPMEqSASwPFNc
         1C5ElEZr4mGHdUeyJ6B/V2e8xcAw8R045/kEKvB10viUPvW8vleUNafyxLoiS4EJC9SP
         9nNdJK5ylbqfiZ1rznYCKPH5g7P1+3mBMZRtaKEPL5h8TllrCStP2Xki0icbxQS95vgy
         fV9dMgeBOZ1onCWbimsy4dzKOA3FFcMdQyfwV9ax6fTgOUoyzfI98/xnf5UiXO+X5bZ3
         0kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dQLNpWLGlZntblD8Vo0H/wvH1TQ6QT4Dns9lFKlqz40=;
        b=MTNw+EHjR20BNbSSE8SAnHbTJ4Vu5d6JFhUSIUIvGglao59rwaKLy8u/N9ZcVzaBxy
         q5rkeHQOXZvkshu/ezG6DUzBSbq9MLGXSgxhvivjIOHwIL9SSKp5WAgFcaUlGye1+OwU
         LoYG5ECddPUAab6jt9iB76x2PHWpm4lgR1WMz/odKpA2VB9R+pq5fTifyDasoYKLB6ZQ
         hudvQ+p8dLNRNUNbPlbDkiQ6aNBC030+3t+7MGJ08z82npL0AV3yhfV/8W/Nxyu37Q6A
         bTzDSPp/pmi+ly2NHWL7GTrycclzZ8FadFKEB2tmN4HD3HSZEsvjTAK7iT3RAUhpHdKo
         Rebw==
X-Gm-Message-State: APjAAAVeL26hqBDbpMki/8dH8sBTNAgSt06CrE4Ag3hwD9nmtkQEL3dq
        lO7fF1vSkMjZQ+fLUZ2haWlPeA==
X-Google-Smtp-Source: APXvYqyFMifaUXiCLIJuPP4BSfLAKNc+mu4d237cGpGKZQKElYr20LsKMnyRBEnvg5KwkotZfRMrGQ==
X-Received: by 2002:a1c:de09:: with SMTP id v9mr26876030wmg.170.1579011245694;
        Tue, 14 Jan 2020 06:14:05 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:51a2:f361:d0e2:7ea6])
        by smtp.gmail.com with ESMTPSA id l15sm18978128wrv.39.2020.01.14.06.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 06:14:00 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair : prevent unlimited runtime on throttled group
Date:   Tue, 14 Jan 2020 15:13:56 +0100
Message-Id: <1579011236-31256-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a running task is moved on a throttled task group and there is no
other task enqueued on the CPU, the task can keep running using 100% CPU
whatever the allocated bandwidth for the group and although its cfs rq is
throttled. Furthermore, the group entity of the cfs_rq and its parents are
not enqueued but only set as curr on their respective cfs_rqs.

We have the following sequence:

sched_move_task
  -dequeue_task: dequeue task and group_entities.
  -put_prev_task: put task and group entities.
  -sched_change_group: move task to new group.
  -enqueue_task: enqueue only task but not group entities because cfs_rq is
    throttled.
  -set_next_task : set task and group_entities as current sched_entity of
    their cfs_rq.

Another impact is that the root cfs_rq runnable_load_avg at root rq stays
null because the group_entities are not enqueued. This situation will stay
the same until an "external" event triggers a reschedule. Let trigger it
immediately instead.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7b08d52db93..d0acc67336c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7062,8 +7062,15 @@ void sched_move_task(struct task_struct *tsk)
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
-	if (running)
+	if (running) {
 		set_next_task(rq, tsk);
+		/*
+		 * After changing group, the running task may have joined a
+		 * throttled one but it's still the running task. Trigger a
+		 * resched to make sure that task can still run.
+		 */
+		resched_curr(rq);
+	}
 
 	task_rq_unlock(rq, tsk, &rf);
 }
-- 
2.7.4

