Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784ABC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F57320792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgGUExy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:53:54 -0400
Received: from mail1.windriver.com ([147.11.146.13]:51338 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGUExy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:53:54 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 06L4rA1t017995
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 20 Jul 2020 21:53:11 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 21:52:52 -0700
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 538882E0451; Tue, 21 Jul 2020 00:52:52 -0400 (EDT)
Date:   Tue, 21 Jul 2020 00:52:52 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200721045251.GA28481@windriver.com>
References: <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
 <20200720142105.GR10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200720142105.GR10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917] On 20/07/2020 (Mon 16:21) Peter Zijlstra wrote:

> On Mon, Jul 20, 2020 at 04:02:24PM +0200, Oleg Nesterov wrote:
> > I have to admit, I do not understand the usage of prev_state in schedule(),
> > it looks really, really subtle...
> 
> Right, so commit dbfb089d360 solved a problem where schedule() re-read
> prev->state vs prev->on_rq = 0. That is, schedule()'s dequeue and
> ttwu()'s enqueue disagreed over sched_contributes_to_load. and as a
> result load-accounting went wobbly.
> 
> Now, looking at that commit again, I might've solved the problem twice
> :-P

[...]

> That said, in a crossed email, I just proposed we could simplify all
> this like so.. but now I need to go ask people to re-validate that
> loadavg muck again :-/

After a two hour "quick" sanity test I then gave it a full 7h run (which
always seemed to break before dbfb089d360) and I didn't see any stuck
load average with master from today + this change.

Paul.

root@t5610:/home/paul/git/linux-head#
[1]+  Done                    nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 24 --duration 420 --configs TREE03 --trust-make > /tmp/kvm.sh.out 2>&1
root@t5610:/home/paul/git/linux-head# cat /proc/version
Linux version 5.8.0-rc6-00001-g5714ee50bb43-dirty (paul@t5610) (gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #3 SMP Mon Jul 20 12:30:33 EDT 2020
root@t5610:/home/paul/git/linux-head# uptime
 00:49:18 up  7:41,  2 users,  load average: 0.01, 0.00, 0.63
root@t5610:/home/paul/git/linux-head# 

--

> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a2a244af9a53..437fc3b241f2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(bool preempt)
>  	local_irq_disable();
>  	rcu_note_context_switch(preempt);
>  
> -	/* See deactivate_task() below. */
> -	prev_state = prev->state;
> -
>  	/*
>  	 * Make sure that signal_pending_state()->signal_pending() below
>  	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
> @@ -4223,7 +4220,8 @@ static void __sched notrace __schedule(bool preempt)
>  	 * We must re-load prev->state in case ttwu_remote() changed it
>  	 * before we acquired rq->lock.
>  	 */
> -	if (!preempt && prev_state && prev_state == prev->state) {
> +	prev_state = prev->state;
> +	if (!preempt && prev_state) {
>  		if (signal_pending_state(prev_state, prev)) {
>  			prev->state = TASK_RUNNING;
>  		} else {
> @@ -4237,10 +4235,12 @@ static void __sched notrace __schedule(bool preempt)
>  
>  			/*
>  			 * __schedule()			ttwu()
> -			 *   prev_state = prev->state;	  if (READ_ONCE(p->on_rq) && ...)
> -			 *   LOCK rq->lock		    goto out;
> -			 *   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
> -			 *   p->on_rq = 0;		  p->state = TASK_WAKING;
> +			 *   if (prev_state)		  if (p->on_rq && ...)
> +			 *     p->on_rq = 0;		    goto out;
> +			 *				  smp_acquire__after_ctrl_dep();
> +			 *				  p->state = TASK_WAKING
> +			 *
> +			 * Where __schedule() and ttwu() have matching control dependencies.
>  			 *
>  			 * After this, schedule() must not care about p->state any more.
>  			 */
