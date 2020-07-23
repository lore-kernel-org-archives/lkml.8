Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B96C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6720792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QpRIGOuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGWS3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgGWS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:29:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849BC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PWqnt6y+7mu4scOGcNqySiIZf7ivqGUyaEr0vjpdMrA=; b=QpRIGOuvBmmtSItZKumutmn+AW
        2LofQaWw9LIXjEzge3jqO3BibX4hF73y2/QEWSzFSRWTcGr24Ek96OS9lwN+OwyNHa0a2hpBjmak+
        M/re+MM7k7WJcoxq33y1AuDLidyVgtm4Kb3a+Acm9c3hm2EOSNfZnWCWopBBE3igyh1a/A/116BTI
        i4zjz7nxKV4rXiniWF87BBo4tv+1bqxUXpvJoz9YCKeQQe4dkj7yBRCMnyQaSH9P4ELfytYTTCmzg
        +8TAnthEnMJDoiW0qEPxnsZn80jJRfjw1Tl1eSCEqRuA+VB46djcIG6W1N/1MKTLFI4lzF+HR02n1
        bjsY5ZPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyfxW-0003af-HN; Thu, 23 Jul 2020 18:28:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7FE33011C6;
        Thu, 23 Jul 2020 20:28:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 710CA200F77CC; Thu, 23 Jul 2020 20:28:41 +0200 (CEST)
Date:   Thu, 23 Jul 2020 20:28:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        torvalds@linux-foundation.org, hch@lst.de
Subject: Re: [PATCH -v2 1/5] sched: Fix ttwu() race
Message-ID: <20200723182841.GS10769@hirez.programming.kicks-ass.net>
References: <20200622100122.477087977@infradead.org>
 <20200622100825.726200103@infradead.org>
 <159532854586.15672.5123219635720172265@build.alporthouse.com>
 <20200721113719.GI119549@hirez.programming.kicks-ass.net>
 <159541187604.15672.2433896906671712337@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159541187604.15672.2433896906671712337@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:57:56AM +0100, Chris Wilson wrote:

> Perhaps more damning is that I can replace WF_ON_CPU with p->on_cpu to
> suppress the warning:

*argh*, I'm starting to go mad...

Chris, could you please try the below patch?

Can you also confirm that if you do:

$ echo NO_TTWU_QUEUE_ON_CPU > /debug/sched_features

or wherever else system-doofus mounts debugfs these days,
the issue no longer manifests? Because if I don't get a handle on this
soon we might have to disable this thing for now :/


---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2a244af9a537..8218779734288 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2430,13 +2430,15 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
-static inline bool ttwu_queue_cond(int cpu, int wake_flags)
+static inline bool ttwu_queue_cond(struct task_struct *p, int cpu, int wake_flags)
 {
+	int this_cpu = smp_processor_id();
+
 	/*
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
-	if (!cpus_share_cache(smp_processor_id(), cpu))
+	if (!cpus_share_cache(this_cpu, cpu))
 		return true;
 
 	/*
@@ -2445,15 +2447,30 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
 	 */
-	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
-		return true;
+	if (wake_flags & WF_ON_CPU) {
+
+		if (unlikely(cpu == this_cpu)) {
+			int on_cpu = READ_ONCE(p->on_cpu);
+			int cpu1 = task_cpu(p);
+
+			smp_rmb();
+			smp_cond_load_acquire(&p->on_cpu, !VAL);
+
+			pr_alert("ttwu-IPI-self: %d==%d, p->on_cpu=%d;0, task_cpu(p)=%d;%d\n",
+				 cpu, this_cpu, on_cpu, cpu1, task_cpu(p));
+
+			return false;
+		}
+
+		return cpu_rq(cpu)->nr_running <= 1;
+	}
 
 	return false;
 }
 
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
-	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
+	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(p, cpu, wake_flags)) {
 		if (WARN_ON_ONCE(cpu == smp_processor_id()))
 			return false;
 
@@ -2713,7 +2730,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * to ensure we observe the correct CPU on which the task is currently
 	 * scheduling.
 	 */
-	if (smp_load_acquire(&p->on_cpu) &&
+	if (sched_feat(TTWU_QUEUE_ON_CPU) && smp_load_acquire(&p->on_cpu) &&
 	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
 		goto unlock;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7481cd96f3915..b231a840c3eba 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -50,6 +50,7 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
  * using the scheduler IPI. Reduces rq->lock contention/bounces.
  */
 SCHED_FEAT(TTWU_QUEUE, true)
+SCHED_FEAT(TTWU_QUEUE_ON_CPU, true)
 
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
