Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DF0204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597528421;
	bh=gyCRAQF2a+ybik80JMrczxlpHMClObMv4HhA59v11Zc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sYG/w2Lt2MopZ/fX/O9pWBGBBDVnpGDhpy7/zc/sRD1SB7ELdEq1q0jmYdxk65Be5
	 32aCu5El6aOH2KwYU9w7kakmvSlJU4YCI2R6hw+AVTvrdWIuqfVTSH0a334g4BBcrB
	 pHQ3RROJtwVlRKYlsn8jW1X0taurCfbTjAPi9wdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgHOVxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgHOVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD08C02B8DF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:27:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so12544837ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qRrByY4KQxuOV2hnGF55zmpXvU8kOLgnoIcCb3ofQdQ=;
        b=nUKfr6VM1vns/UpUyKrR5maLwqjR8W2qVBFFhKLXlFIhJZ+RiRm8jeU5dTtz0sfze4
         Leco3IN7frWM8tbH/G6gPtkcpNjfJzpA0hsZfS/vO80msqo03G53KBuLxi8NtRC+/H5X
         vD4nyis8Ce0QbUtp2xuxtk64W89fKpb+LP37JOJAELhm4YxMT338xeDyVe4AF0sAm6Uz
         HWu6TUkmS38h5UVs761jUCTg+oNpLwFTKVVHh/V9UsqoUBmOg1H+e35oRkmT/9EHXH7o
         jxY9lfQ4SJ7W5uXC2PA26katdQniWCubeP4xwvyC1HYGUugUBo+QW8NBjClypJIrAWuI
         4eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=qRrByY4KQxuOV2hnGF55zmpXvU8kOLgnoIcCb3ofQdQ=;
        b=lGQLWey5Vl2uGnCu/+FfJFBmrvID3fOSNKC/T3Ca3KigCeBFMX81UiOUqcMThMKmV4
         AsxIQvi+wLZGmEFgDZ2pGbN+7chBSErxBRIlB1z4s7m8mAPprh1RCPQeOHTyratE0Zjy
         wUi0PsTMLzhA3ZCGxFbrO/YZCLvgwRLevZa69WIckgsRVRlG10Ozxcj3McBUfr/vWaDs
         Gu0GOy2ZAbICTD4dNBD94Kyo4YfxPyEJegdSPyiYKi+Kuv3dAay62BCp4vvTmsYQ2LMr
         1T06NlgP+XMXajs6qMpLxv8zhXalijAayjZ03KFCLdq4KK4WKmNlP6xG3uciqBCJU0fk
         UKIg==
X-Gm-Message-State: AOAM531ATiDIXjZx1AUe5IHTHe2vvEkOJAv1QixS+RM9VgTh7/BD3GrN
        XjpbX254l5E8Kz8as0uUTsc=
X-Google-Smtp-Source: ABdhPJyhfnt5XZY/TjiCXIMaD3ynauIJkPGAT3eTXP080NGumSjvrbZGbMxS27xqITEHPUhazFoAcw==
X-Received: by 2002:a17:906:2e0c:: with SMTP id n12mr6411505eji.35.1597490853433;
        Sat, 15 Aug 2020 04:27:33 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d16sm8995885ejb.8.2020.08.15.04.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:27:32 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:27:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20200815112731.GA2640991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-08-15

   # HEAD: cc172ff301d8079e941a6eb31758951a6d764084 sched/debug: Fix the alignment of the show-state debug output

Two fixes: fix a new tracepoint's output value, and fix the formatting 
of show-state syslog printouts.

 Thanks,

	Ingo

------------------>
Libing Zhou (1):
      sched/debug: Fix the alignment of the show-state debug output

Phil Auld (1):
      sched: Fix use of count for nr_running tracepoint


 kernel/sched/core.c  | 15 ++++-----------
 kernel/sched/sched.h |  2 +-
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4a0e7b449b88..09fd62568ba9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6387,10 +6387,10 @@ void sched_show_task(struct task_struct *p)
 	if (!try_get_task_stack(p))
 		return;
 
-	printk(KERN_INFO "%-15.15s %c", p->comm, task_state_to_char(p));
+	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
 
 	if (p->state == TASK_RUNNING)
-		printk(KERN_CONT "  running task    ");
+		pr_cont("  running task    ");
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
 #endif
@@ -6399,8 +6399,8 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	printk(KERN_CONT "%5lu %5d %6d 0x%08lx\n", free,
-		task_pid_nr(p), ppid,
+	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
+		free, task_pid_nr(p), ppid,
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
@@ -6435,13 +6435,6 @@ void show_state_filter(unsigned long state_filter)
 {
 	struct task_struct *g, *p;
 
-#if BITS_PER_LONG == 32
-	printk(KERN_INFO
-		"  task                PC stack   pid father\n");
-#else
-	printk(KERN_INFO
-		"  task                        PC stack   pid father\n");
-#endif
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3fd283892761..28709f6b0975 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1999,7 +1999,7 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
 	rq->nr_running -= count;
 	if (trace_sched_update_nr_running_tp_enabled()) {
-		call_trace_sched_update_nr_running(rq, count);
+		call_trace_sched_update_nr_running(rq, -count);
 	}
 
 	/* Check if we still need preemption */
