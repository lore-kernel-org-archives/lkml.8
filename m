Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D938EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABABB206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ilzWpzh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIADip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIADip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:38:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61DBC0612FE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:38:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w186so8316508qkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mw8NlkFfB6GU4gKSMkvhDkhv6Y/J4c2nMmzLpuW7yWY=;
        b=ilzWpzh4bZFtnraPpKilbu4YrEPSZ4dvqt8xPdnx0o/LkVTT7Jk/CYCjvFu5Czd2bH
         AnZaZhO9rzp+/CymQWy6PTKPj7P0I9PR4uYYSbsEA9E4gVbqAKnFq4nGe1n4oDK9mNNp
         sgcevFw+5kakaTVgWMm1JeVuJ9pWAfE4HqCUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mw8NlkFfB6GU4gKSMkvhDkhv6Y/J4c2nMmzLpuW7yWY=;
        b=jgiV4mVTl8gMpcaedH2hGfIvKLVFOmUZUfrhtxG7LFNftuvcz5+o5MYKx8X1v+FEXR
         e6BycgC8alEBGgTRpzDnbAVE6J4xJNbuMMgQ1ieVXQyVKl9H4rd0dnhxAFuRvpUO+AIk
         yB/uZlpfOynhi6x96QUymDdJJJgU2WpzsER2PS5NVYpaCDwOLKROZwQfC/97tnZGXzbw
         C6IS6Xuq7WIR3AEy6jMLd2BwepHYLptjFliPQy38vNmNq9mMmUgnHQbCJS6WDn8gy+Vi
         9sa85Hq2fuP3xGpA0+AnuwBRhpETkpCHcHvMU8sufwPKWcU2uws557sXj9EKoDCfrDQA
         2PWA==
X-Gm-Message-State: AOAM531TwB7kiZ6/NbZbrFsgMI2tMoY1f1yUTO8emO9WP+x/hHTneBWp
        DAUzekivxZ0mi4hou6TyHPPt4g==
X-Google-Smtp-Source: ABdhPJyWIwd9FS1NRsKkdziSQAYLyU3RsWDmA9/IlWgozQip9E446eMAihRu7HDQUxHTcSwPDTlGjg==
X-Received: by 2002:a05:620a:22ea:: with SMTP id p10mr4866228qki.408.1598931523988;
        Mon, 31 Aug 2020 20:38:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id y24sm12250338qtv.71.2020.08.31.20.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 20:38:43 -0700 (PDT)
Date:   Mon, 31 Aug 2020 23:38:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     peterz@infradead.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200901033842.GA1952605@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 09:47:19AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 06:02:25PM -0400, Vineeth Pillai wrote:
> > On 8/28/20 4:51 PM, Peter Zijlstra wrote:
> 
> > > So where do things go side-ways?
> 
> > During hotplug stress test, we have noticed that while a sibling is in
> > pick_next_task, another sibling can go offline or come online. What
> > we have observed is smt_mask get updated underneath us even if
> > we hold the lock. From reading the code, looks like we don't hold the
> > rq lock when the mask is updated. This extra logic was to take care of that.
> 
> Sure, the mask is updated async, but _where_ is the actual problem with
> that?
> 
> On Fri, Aug 28, 2020 at 06:23:55PM -0400, Joel Fernandes wrote:
> > Thanks Vineeth. Peter, also the "v6+" series (which were some addons on v6)
> > detail the individual hotplug changes squashed into this patch:
> > https://lore.kernel.org/lkml/20200815031908.1015049-9-joel@joelfernandes.org/
> > https://lore.kernel.org/lkml/20200815031908.1015049-11-joel@joelfernandes.org/
> 
> That one looks fishy, the pick is core wide, making that pick_seq per rq
> just doesn't make sense.
> 
> > https://lore.kernel.org/lkml/20200815031908.1015049-12-joel@joelfernandes.org/
> 
> This one reads like tinkering, there is no description of the actual
> problem just some code that makes a symptom go away.
> 
> Sure, on hotplug the smt mask can change, but only for a CPU that isn't
> actually scheduling, so who cares.
> 
> /me re-reads the hotplug code...
> 
> ..ooOO is the problem that we clear the cpumasks on take_cpu_down()
> instead of play_dead() ?! That should be fixable.

That is indeed the problem.

I was wondering, is there any harm in just selecting idle task if the CPU
calling schedule() is missing from cpu_smt_mask? Does it need to do a
core-wide selection?

That would be best, and avoid any unnecessary surgery of the already
complicated function. This is sort of what Tim was doing in v4 and v5.

Also what do we do if cpu_smt_mask changing while this function is running? I
tried something like the following and it solves the issues but the overhead
probably really sucks. I was thinking of doing a variation of the below that
just stored the cpu_smt_mask's rq pointers in an array of size SMTS_PER_CORE
on the stack, instead of a cpumask but I am not sure if that will keep the
code clean while still having similar storage overhead.

---8<-----------------------

From 5e905e7e620177075a9bcf78fb0dc89a136434bb Mon Sep 17 00:00:00 2001
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 30 Jun 2020 19:39:45 -0400
Subject: [PATCH] Fix CPU hotplug causing crashes in task selection logic

Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/sched/core.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0362102fa3d2..47a21013ba0d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4464,7 +4464,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
-	const struct cpumask *smt_mask;
+	struct cpumask select_mask;
 	int i, j, cpu, occ = 0;
 	bool need_sync;
 
@@ -4499,7 +4499,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	finish_prev_task(rq, prev, rf);
 
 	cpu = cpu_of(rq);
-	smt_mask = cpu_smt_mask(cpu);
+	cpumask_copy(&select_mask, cpu_smt_mask(cpu));
+
+	/*
+	 * Always make sure current CPU is added to smt_mask so that below
+	 * selection logic runs on it.
+	 */
+	cpumask_set_cpu(cpu, &select_mask);
 
 	/*
 	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
@@ -4516,7 +4522,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
-	for_each_cpu(i, smt_mask) {
+	for_each_cpu(i, &select_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
 		rq_i->core_pick = NULL;
@@ -4536,7 +4542,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 */
 	for_each_class(class) {
 again:
-		for_each_cpu_wrap(i, smt_mask, cpu) {
+		for_each_cpu_wrap(i, &select_mask, cpu) {
 			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
 
@@ -4600,7 +4608,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
 
 				if (old_max) {
-					for_each_cpu(j, smt_mask) {
+					for_each_cpu(j, &select_mask) {
 						if (j == i)
 							continue;
 
@@ -4625,6 +4633,10 @@ next_class:;
 
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
+
+	/* Something should have been selected for current CPU*/
+	WARN_ON_ONCE(!next);
+
 	rq->core_sched_seq = rq->core->core_pick_seq;
 	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
@@ -4636,7 +4648,7 @@ next_class:;
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_cpu(i, &select_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
 		WARN_ON_ONCE(!rq_i->core_pick);
-- 
2.28.0.402.g5ffc5be6b7-goog

