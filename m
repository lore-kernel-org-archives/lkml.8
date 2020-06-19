Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C89C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BFC20663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XeX5C7Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgFSBAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgFSBAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:00:16 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5CC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:00:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so6036280qtr.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9LXCKpP66qwXI671DYA6UPeNjnt6Enj2C4p4ett9VYY=;
        b=XeX5C7RbLpLfj/NF/9QQ5oE0/gq5Qb35Hx/00pT6xrl5zj9FIVTPRbnPZnEPHolwBg
         xXxbPZs6htDEE0uAYB9uEn04NludFSK+0P47Ivy2ewRMj1KSr9Cqn0ugJJD21EV+3Fq2
         ASGyYjHICwld1BuQLivZSeNJT6PoKSx81r+uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9LXCKpP66qwXI671DYA6UPeNjnt6Enj2C4p4ett9VYY=;
        b=E8Q18nHfz74f1AN9gTzDGeIuuDD0M8BYSfqhnaUjrzf0Xg4aPlWGjZfbTHwZEpidMv
         zRMqqTkbaXV1SeDiGQCpF0sB9L6Iy0IRjV1ytOIj7UfflEUE8W+bfDh0al19NsFhpzIL
         +rvmI5zvC9Gyrigw2Qh6m0fhekMoxK4WN3Z25Z1iznAU6XfX7rNJvVm4fY4+mueIqnGg
         Ie2wYiJJ00kllW9eionaxc8XyjT8AFGXsKRM17y2MEHI9hq/G/Pdb67c46V6Q+hb6jSP
         /3zMU8VfGnTkylv6qYK9118a5OKP4qWNyjWPmlOVLubKMCPEFPY5QS675YiUxR6y2L7q
         wHXw==
X-Gm-Message-State: AOAM532tbGY4+cbH5UwOlNj3YS4SHqUNOnyjhaqpADN6CEJuy/Y738l/
        GB2XN3uqPJ3KmYlMi/HmsFgecA==
X-Google-Smtp-Source: ABdhPJyBm7D/L2lLOfy7cMe0EhLYIT57Ijg3RJKsnij9BoFHVWh5SBoqXwkfj/5oBaDLUel4TjIu8Q==
X-Received: by 2002:ac8:31f9:: with SMTP id i54mr943075qte.209.1592528413446;
        Thu, 18 Jun 2020 18:00:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i19sm4652426qkh.71.2020.06.18.18.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:00:12 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:00:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 6/7] rcutorture: Add support to get the number of wakeups
 of main GP kthread
Message-ID: <20200619010012.GG40119@google.com>
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-6-joel@joelfernandes.org>
 <20200618224058.GD2723@paulmck-ThinkPad-P72>
 <20200619000156.GD40119@google.com>
 <20200619001244.GG2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619001244.GG2723@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:12:44PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 08:01:56PM -0400, Joel Fernandes wrote:
> > On Thu, Jun 18, 2020 at 03:40:58PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 18, 2020 at 04:29:54PM -0400, Joel Fernandes (Google) wrote:
> > > > This is useful to check for any improvements or degradation related to
> > > > number of GP kthread wakeups during testing.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > This was a good way to collect the data for your testing, but
> > > we can expect rcutorture to only do so much.  ;-)
> > 
> > np, I will push this one into a git tag for the next time I need it ;)
> 
> Sounds like a plan!

In case it is at all an option, I could put this as a statistic under
rcu_torture_stats_print(), that way it all is on the same line. But I take it
you are not too thrilled to have it for now.

thanks,

 - Joel



> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 							Thanx, Paul
> > > 
> > > > ---
> > > >  kernel/rcu/Kconfig.debug |  1 +
> > > >  kernel/rcu/rcu.h         |  2 ++
> > > >  kernel/rcu/rcutorture.c  | 23 ++++++++++++++++++++++-
> > > >  kernel/rcu/tree.c        |  7 +++++++
> > > >  4 files changed, 32 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > > > index 3cf6132a4bb9f..3323e3378af5a 100644
> > > > --- a/kernel/rcu/Kconfig.debug
> > > > +++ b/kernel/rcu/Kconfig.debug
> > > > @@ -50,6 +50,7 @@ config RCU_TORTURE_TEST
> > > >  	select TASKS_RCU
> > > >  	select TASKS_RUDE_RCU
> > > >  	select TASKS_TRACE_RCU
> > > > +	select SCHEDSTATS
> > > >  	default n
> > > >  	help
> > > >  	  This option provides a kernel module that runs torture tests
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index cf66a3ccd7573..7e867e81d9738 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -511,6 +511,7 @@ srcu_batches_completed(struct srcu_struct *sp) { return 0; }
> > > >  static inline void rcu_force_quiescent_state(void) { }
> > > >  static inline void show_rcu_gp_kthreads(void) { }
> > > >  static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
> > > > +static inline struct task_struct *rcu_get_main_gp_kthread(void) { return 0; }
> > > >  static inline void rcu_fwd_progress_check(unsigned long j) { }
> > > >  #else /* #ifdef CONFIG_TINY_RCU */
> > > >  bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
> > > > @@ -519,6 +520,7 @@ unsigned long rcu_exp_batches_completed(void);
> > > >  unsigned long srcu_batches_completed(struct srcu_struct *sp);
> > > >  void show_rcu_gp_kthreads(void);
> > > >  int rcu_get_gp_kthreads_prio(void);
> > > > +struct task_struct *rcu_get_main_gp_kthread(void);
> > > >  void rcu_fwd_progress_check(unsigned long j);
> > > >  void rcu_force_quiescent_state(void);
> > > >  extern struct workqueue_struct *rcu_gp_wq;
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index d0d265304d147..959a1f84d6904 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include <linux/rcupdate_wait.h>
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/sched/signal.h>
> > > > +#include <linux/sched/stat.h>
> > > >  #include <uapi/linux/sched/types.h>
> > > >  #include <linux/atomic.h>
> > > >  #include <linux/bitops.h>
> > > > @@ -460,9 +461,29 @@ static void rcu_sync_torture_init(void)
> > > >  	INIT_LIST_HEAD(&rcu_torture_removed);
> > > >  }
> > > >  
> > > > +unsigned long rcu_gp_nr_wakeups;
> > > > +
> > > > +static void rcu_flavor_init(void)
> > > > +{
> > > > +	rcu_sync_torture_init();
> > > > +
> > > > +	/* Make sure schedstat is enabled for GP thread wakeup count. */
> > > > +	force_schedstat_enabled();
> > > > +	rcu_gp_nr_wakeups = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
> > > > +}
> > > > +
> > > > +static void rcu_flavor_cleanup(void)
> > > > +{
> > > > +	unsigned long now_nr = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
> > > > +
> > > > +	pr_alert("End-test: Cleanup: Total GP-kthread wakeups: %lu\n",
> > > > +		now_nr - rcu_gp_nr_wakeups);
> > > > +}
> > > > +
> > > >  static struct rcu_torture_ops rcu_ops = {
> > > >  	.ttype		= RCU_FLAVOR,
> > > > -	.init		= rcu_sync_torture_init,
> > > > +	.init		= rcu_flavor_init,
> > > > +	.cleanup	= rcu_flavor_cleanup,
> > > >  	.readlock	= rcu_torture_read_lock,
> > > >  	.read_delay	= rcu_read_delay,
> > > >  	.readunlock	= rcu_torture_read_unlock,
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index c3bae7a83d792..a3a175feb310a 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -175,6 +175,13 @@ int rcu_get_gp_kthreads_prio(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
> > > >  
> > > > +/* Retrieve RCU's main GP kthread task_struct */
> > > > +struct task_struct *rcu_get_main_gp_kthread(void)
> > > > +{
> > > > +	return rcu_state.gp_kthread;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rcu_get_main_gp_kthread);
> > > > +
> > > >  /*
> > > >   * Number of grace periods between delays, normalized by the duration of
> > > >   * the delay.  The longer the delay, the more the grace periods between
> > > > -- 
> > > > 2.27.0.111.gc72c7da667-goog
> > > > 
