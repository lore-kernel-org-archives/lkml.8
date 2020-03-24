Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F6EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3DD2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SVvirGnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgCXStv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:49:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37230 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgCXStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:49:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id x3so8900760qki.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xovp2IRENC1ieKOWc2uYOS9mTeP7hB0qq6rWQBQMySs=;
        b=SVvirGnr/T0FjI3nqFgreHYMr6mc+UZL8Z+s+VddsQqi21EjHWPd+E+HSTEHFk4cE+
         tHb3us5ZnYiZl+qpHxndAv8D0pKH1iTMQJtZvxCX0rigKt7V3DwIY+t8gVFSAsdkDTgE
         64FiZOMvPnAt58rLWCUvaqgL3JxMYlnkEHzAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xovp2IRENC1ieKOWc2uYOS9mTeP7hB0qq6rWQBQMySs=;
        b=nO36qHAarpY5M2dDSzC5ZpSxXfLeTciUSm39h0mgVhMbYL1NSVDUeNvRoqgCqQez+3
         4DVUUg5o/oBwwk2iLKV56IBq5QUsP0L4P0XOZzi6lWKUBawrkle9FXNSpxIGQmkPdUws
         zrnuelOcsxkNZotWwjmYalmMWMEPJkxVFKhRR3KsU1mqBrCUSB+8wI6YnEWwgXwPYXw+
         o1KdwAFsN3Up/0TKpoy4N5F/t4hwzGWB3pPKzh/F/aFTg0Dkn1cERLa4dODuZkUQ3Ufe
         a/AU4UXQcyeswvqtn6DNFHHSr+O91IIVaFkpOTXVa3zRRPyAARWNNuFsK7rTiiKKWEIR
         4/og==
X-Gm-Message-State: ANhLgQ3PYQqvE3A+pUEmDTDPPXtZL9FkDBIPArkUkaAgbUeKyh0qH35P
        cDFseFx/H01ftXHagfx8Wzn6U3v/VSk=
X-Google-Smtp-Source: ADFU+vsiRuAlbd07QNKzn+VGN6AikvbGVgeX8NfMdZ/wYqbhAecooDsHPZ7lUxQHdacydy37UEjNeg==
X-Received: by 2002:a37:49cc:: with SMTP id w195mr27682802qka.42.1585075787451;
        Tue, 24 Mar 2020 11:49:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 4sm9693732qkl.51.2020.03.24.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:49:46 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:49:46 -0400
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
Message-ID: <20200324184946.GD257597@google.com>
References: <20200313232918.62303-1-joel@joelfernandes.org>
 <20200314003004.GI3199@paulmck-ThinkPad-P72>
 <f77b9432-933c-a9fe-5541-437cf0094a65@linux.intel.com>
 <20200323152126.GA141027@google.com>
 <6d933ce2-75e3-6469-4bb0-08ce9df29139@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d933ce2-75e3-6469-4bb0-08ce9df29139@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:01:27AM +0800, Li, Aubrey wrote:
> On 2020/3/23 23:21, Joel Fernandes wrote:
> > On Mon, Mar 23, 2020 at 02:58:18PM +0800, Li, Aubrey wrote:
> >> On 2020/3/14 8:30, Paul E. McKenney wrote:
> >>> On Fri, Mar 13, 2020 at 07:29:18PM -0400, Joel Fernandes (Google) wrote:
> >>>> rcu_read_unlock() can incur an infrequent deadlock in
> >>>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> >>>>
> >>>> This fixes the following spinlock recursion observed when testing the
> >>>> core scheduling patches on PREEMPT=y kernel on ChromeOS:
> >>>>
> >>>> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
> >>>>
> >>>
> >>> The original could indeed deadlock, and this would avoid that deadlock.
> >>> (The commit to solve this deadlock is sadly not yet in mainline.)
> >>>
> >>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> >>
> >> I saw this in dmesg with this patch, is it expected?
> >>
> >> [  117.000905] =============================
> >> [  117.000907] WARNING: suspicious RCU usage
> >> [  117.000911] 5.5.7+ #160 Not tainted
> >> [  117.000913] -----------------------------
> >> [  117.000916] kernel/sched/core.c:4747 suspicious rcu_dereference_check() usage!
> >> [  117.000918] 
> >>                other info that might help us debug this:
> > 
> > Sigh, this is because for_each_domain() expects rcu_read_lock(). From an RCU
> > PoV, the code is correct (warning doesn't cause any issue).
> > 
> > To silence warning, we could replace the rcu_read_lock_sched() in my patch with:
> > preempt_disable();
> > rcu_read_lock();
> > 
> > and replace the unlock with:
> > 
> > rcu_read_unlock();
> > preempt_enable();
> > 
> > That should both take care of both the warning and the scheduler-related
> > deadlock. Thoughts?
> > 
> 
> How about this?
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a01df3e..7ff694e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4743,7 +4743,6 @@ static void sched_core_balance(struct rq *rq)
>  	int cpu = cpu_of(rq);
>  
>  	rcu_read_lock();
> -	raw_spin_unlock_irq(rq_lockp(rq));
>  	for_each_domain(cpu, sd) {
>  		if (!(sd->flags & SD_LOAD_BALANCE))
>  			break;
> @@ -4754,7 +4753,6 @@ static void sched_core_balance(struct rq *rq)
>  		if (steal_cookie_task(cpu, sd))
>  			break;
>  	}
> -	raw_spin_lock_irq(rq_lockp(rq));

try_steal_cookie() does a double_rq_lock(). Would this change not deadlock
with that?

thanks,

 - Joel

