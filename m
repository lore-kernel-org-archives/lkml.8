Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC720206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HY0mMgyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCWPV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:21:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44544 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCWPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:21:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id x16so2805040qts.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9iRc34m+wkvrhhnwLca1bamcRxBstg4xuvan3JpyPc8=;
        b=HY0mMgyPDwTfqKH8+ayd0wXmkWyt5NPIPLW8l3kfP3POTc0Wn3TIMDdk6tTq7rSzJF
         PnF3X2TmibQxi/hk1pA/lbwTTbFtsiQ958u1C7FcsM5n3hmgnwpH1tSW8tH8FNxFG5fc
         uI7JAjXEVV3qZ5MZB5BIZ6tjwud2HeoflBEz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9iRc34m+wkvrhhnwLca1bamcRxBstg4xuvan3JpyPc8=;
        b=fRltgIJYzqvac2+v94qlCikcrmw+roRWDI+/1EdY8Xjldt7GgMgIU2Q39BL4LkI1z3
         caMQ3r6vAIB1YdHf3Mji48a1gfBxLzOJ6JxEf5wCY1xfOfk3vQbiSmDk0vJzK+GoyI0R
         Hbp+rSHGI3q015K/KNtaOrXeFqQGtXEFZFBDmCYsSCvQoSd7X8W+KkkDwWt1m3hAEnlk
         5qO0v4RB9fbgvb+lvRGdeFPI9BTvBI1msi/jSaOc54KWJowcI/vtbex5XzLLdAjldvk2
         4LDNxhZdTiLYdirSU3634hrQBMG8ObUyeCesXfjQWkNXZLYkmQM3nKMpgfhaTY97olcL
         OdtA==
X-Gm-Message-State: ANhLgQ0bRoCsI0Jw2XLztczpJ5jPGdxS9/Rof9KJBZmLT1+TOhXKIPRJ
        ws9bzlM+Uh+gj7uAphUQMf0Irw==
X-Google-Smtp-Source: ADFU+vtSQO9/Cqw9OVXe1TlNBX35Qkrs7dvsz+zBmlEtHM257XQBwnKXVixTLKzcByAK/3O+JXNWTA==
X-Received: by 2002:ac8:6d01:: with SMTP id o1mr22281770qtt.246.1584976888190;
        Mon, 23 Mar 2020 08:21:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l13sm12087117qtu.66.2020.03.23.08.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:21:27 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:21:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        vpillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, peterz@infradead.org,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Use RCU-sched in core-scheduling balancing logic
Message-ID: <20200323152126.GA141027@google.com>
References: <20200313232918.62303-1-joel@joelfernandes.org>
 <20200314003004.GI3199@paulmck-ThinkPad-P72>
 <f77b9432-933c-a9fe-5541-437cf0094a65@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77b9432-933c-a9fe-5541-437cf0094a65@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:58:18PM +0800, Li, Aubrey wrote:
> On 2020/3/14 8:30, Paul E. McKenney wrote:
> > On Fri, Mar 13, 2020 at 07:29:18PM -0400, Joel Fernandes (Google) wrote:
> >> rcu_read_unlock() can incur an infrequent deadlock in
> >> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> >>
> >> This fixes the following spinlock recursion observed when testing the
> >> core scheduling patches on PREEMPT=y kernel on ChromeOS:
> >>
> >> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
> >>
> > 
> > The original could indeed deadlock, and this would avoid that deadlock.
> > (The commit to solve this deadlock is sadly not yet in mainline.)
> > 
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> I saw this in dmesg with this patch, is it expected?
> 
> [  117.000905] =============================
> [  117.000907] WARNING: suspicious RCU usage
> [  117.000911] 5.5.7+ #160 Not tainted
> [  117.000913] -----------------------------
> [  117.000916] kernel/sched/core.c:4747 suspicious rcu_dereference_check() usage!
> [  117.000918] 
>                other info that might help us debug this:

Sigh, this is because for_each_domain() expects rcu_read_lock(). From an RCU
PoV, the code is correct (warning doesn't cause any issue).

To silence warning, we could replace the rcu_read_lock_sched() in my patch with:
preempt_disable();
rcu_read_lock();

and replace the unlock with:

rcu_read_unlock();
preempt_enable();

That should both take care of both the warning and the scheduler-related
deadlock. Thoughts?

Does that fix the warning for you? 

thanks,

 - Joel

> 
> [  117.000921] 
>                rcu_scheduler_active = 2, debug_locks = 1
> [  117.000923] 1 lock held by swapper/52/0:
> [  117.000925]  #0: ffffffff82670960 (rcu_read_lock_sched){....}, at: sched_core_balance+0x5/0x700
> [  117.000937] 
>                stack backtrace:
> [  117.000940] CPU: 52 PID: 0 Comm: swapper/52 Kdump: loaded Not tainted 5.5.7+ #160
> [  117.000943] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0412.020920172159 02/09/2017
> [  117.000945] Call Trace:
> [  117.000955]  dump_stack+0x86/0xcb
> [  117.000962]  sched_core_balance+0x634/0x700
> [  117.000982]  __balance_callback+0x49/0xa0
> [  117.000990]  __schedule+0x1416/0x1620
> [  117.001000]  ? lockdep_hardirqs_off+0xa0/0xe0
> [  117.001005]  ? _raw_spin_unlock_irqrestore+0x41/0x70
> [  117.001024]  schedule_idle+0x28/0x40
> [  117.001030]  do_idle+0x17e/0x2a0
> [  117.001041]  cpu_startup_entry+0x19/0x20
> [  117.001048]  start_secondary+0x16c/0x1c0
> [  117.001055]  secondary_startup_64+0xa4/0xb0
> 
> > 
> >> ---
> >>  kernel/sched/core.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 3045bd50e249..037e8f2e2686 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -4735,7 +4735,7 @@ static void sched_core_balance(struct rq *rq)
> >>  	struct sched_domain *sd;
> >>  	int cpu = cpu_of(rq);
> >>  
> >> -	rcu_read_lock();
> >> +	rcu_read_lock_sched();
> >>  	raw_spin_unlock_irq(rq_lockp(rq));
> >>  	for_each_domain(cpu, sd) {
> >>  		if (!(sd->flags & SD_LOAD_BALANCE))
> >> @@ -4748,7 +4748,7 @@ static void sched_core_balance(struct rq *rq)
> >>  			break;
> >>  	}
> >>  	raw_spin_lock_irq(rq_lockp(rq));
> >> -	rcu_read_unlock();
> >> +	rcu_read_unlock_sched();
> >>  }
> >>  
> >>  static DEFINE_PER_CPU(struct callback_head, core_balance_head);
> >> -- 
> >> 2.25.1.481.gfbce0eb801-goog
> >>
> 
