Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A57C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB9E2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EkOga70b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgFONSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbgFONSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:18:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9IS5WVJ2phjtEPTaOLlk10bfugsOLl/vZKy3zNyERqY=; b=EkOga70bahOfJk9dvxQwccs31j
        Zk6NIUqUONGAhPlu/y2+e//vuqjvGZy8/H8lJG+bPS2nn2HqyQ/Y0XHOEJKMwdGUpS7OrhlH358Wf
        iKNlYCg7mop5FrOVqGYBvDvFzwYI3yHga1OdUkjB5NY1J2g4ZwF5OXtElNGx3KwPr/2FFojFsrTaH
        Wvnqc360isiZi4vxYEJGqbNZ9ih7wR0Y688A3s9+PndghP9CjN6FWcRWxUaN6aW8TXR6f6EZ1y7mH
        XnRX6RKjRzCRZgUnRWfJCSwZGESIqJnZEF3j1Cl8LkYy+l9MDl0aby0SEiez49iB4Ckl33e9sCJpr
        MF6WiWYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkp0F-0003Xk-4j; Mon, 15 Jun 2020 13:18:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4E8F30604B;
        Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9F495203C3762; Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Message-ID: <20200615131143.191539791@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Jun 2020 14:56:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org
Subject: [PATCH 2/6] sched: Verify some SMP assumptions
References: <20200615125654.678940605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate that:
 - __smp_call_single_queue() is only used on remote CPUs
 - task and rq CPUs match on activate_task()

(and always use activate_task() where we should)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    8 ++++----
 kernel/smp.c        |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1311,6 +1311,8 @@ static inline void dequeue_task(struct r
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	SCHED_WARN_ON(task_cpu(p) != cpu_of(rq));
+
 	if (task_contributes_to_load(p))
 		rq->nr_uninterruptible--;
 
@@ -1474,8 +1476,7 @@ static struct rq *move_queued_task(struc
 {
 	lockdep_assert_held(&rq->lock);
 
-	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
-	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
+	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
 
@@ -1483,8 +1484,7 @@ static struct rq *move_queued_task(struc
 
 	rq_lock(rq, rf);
 	BUG_ON(task_cpu(p) != new_cpu);
-	enqueue_task(rq, p, 0);
-	p->on_rq = TASK_ON_RQ_QUEUED;
+	activate_task(rq, p, 0);
 	check_preempt_curr(rq, p, 0);
 
 	return rq;
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -135,6 +135,8 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(cal
 
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
+	WARN_ON_ONCE(cpu == smp_processor_id());
+
 	/*
 	 * The list addition should be visible before sending the IPI
 	 * handler locks the list to pull the entry off it because of


