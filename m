Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47315C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD66207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597760398;
	bh=fzSN0fq5huLkIkVyV71Jx0sw5/SvHr6T3szr0w/NnGU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hbyP8j0zc1cMpe5uxZQnnbfC1YvY1nu/6zTzjDhjMnnegr80toS6KA3GCuB8h32yY
	 7ygHqKlxGKqLgBBx0nSOozoMtJ8ruhFwHLEiSN5X9qiNx+fGXrl0G1uNQLmuF/U6of
	 L4JFPsCnf3fbLYKajw0NgvYK8xkNZGMjcEUEnhic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHROT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgHROTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:19:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 567F120786;
        Tue, 18 Aug 2020 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597760394;
        bh=fzSN0fq5huLkIkVyV71Jx0sw5/SvHr6T3szr0w/NnGU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ii1qAWIkt3NElA3e9xsBfdTpAssDxwyUisB2eDLQkORfjcNQUKyPIsmmsNWNsOlCq
         iBiFTE/y0QS+gL+KoO18hEgedTRTyjd7aXXYkbJpi4tpsPbB/FL4X6IZr63FLV7QnV
         SbFy2JDsXBnrKPk1Kxe/ylQUoGm8LpHWifyytkVw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2B5CA35228F5; Tue, 18 Aug 2020 07:19:54 -0700 (PDT)
Date:   Tue, 18 Aug 2020 07:19:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/next 125/128] kernel/rcu/rcuscale.c:430:6: error:
 'perf_type' undeclared; did you mean
Message-ID: <20200818141954.GD27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202008181430.1a7NHznO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008181430.1a7NHznO%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:44:34PM +0800, kernel test robot wrote:
> Hi Paul,
> 
> First bad commit (maybe != root cause):

Stephen Rothwell beat you to this one, but yes, it is a real bug.
I have queued a fix and will rebase it in later today.

Thank you for your testing efforts!

							Thanx, Paul

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   398b53b5b3751726c05f14a4331b0de258c0453a
> commit: a20b5bd09813bc981ab0bb01cfd7672017f8d74e [125/128] rcuperf: Change rcuperf to rcuscale
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout a20b5bd09813bc981ab0bb01cfd7672017f8d74e
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:15,
>                     from kernel/rcu/rcuscale.c:13:
>    kernel/rcu/rcuscale.c: In function 'rcu_scale_writer':
> >> kernel/rcu/rcuscale.c:430:6: error: 'perf_type' undeclared (first use in this function); did you mean 'kernfs_type'?
>      430 |      perf_type, PERF_FLAG, me, MIN_MEAS);
>          |      ^~~~~~~~~
>    include/linux/printk.h:319:35: note: in definition of macro 'pr_alert'
>      319 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>          |                                   ^~~~~~~~~~~
>    kernel/rcu/rcuscale.c:430:6: note: each undeclared identifier is reported only once for each function it appears in
>      430 |      perf_type, PERF_FLAG, me, MIN_MEAS);
>          |      ^~~~~~~~~
>    include/linux/printk.h:319:35: note: in definition of macro 'pr_alert'
>      319 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>          |                                   ^~~~~~~~~~~
> >> kernel/rcu/rcuscale.c:430:17: error: 'PERF_FLAG' undeclared (first use in this function)
>      430 |      perf_type, PERF_FLAG, me, MIN_MEAS);
>          |                 ^~~~~~~~~
>    include/linux/printk.h:319:35: note: in definition of macro 'pr_alert'
>      319 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>          |                                   ^~~~~~~~~~~
> >> kernel/rcu/rcuscale.c:431:27: error: 'n_rcu_perf_writer_finished' undeclared (first use in this function); did you mean 'n_rcu_scale_writer_finished'?
>      431 |    if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                           n_rcu_scale_writer_finished
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=a20b5bd09813bc981ab0bb01cfd7672017f8d74e
> git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git fetch --no-tags rcu rcu/next
> git checkout a20b5bd09813bc981ab0bb01cfd7672017f8d74e
> vim +430 kernel/rcu/rcuscale.c
> 
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  353  
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  354  /*
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  355   * RCU scale writer kthread.  Repeatedly does a grace period.
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  356   */
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  357  static int
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  358  rcu_scale_writer(void *arg)
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  359  {
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  360  	int i = 0;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  361  	int i_max;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  362  	long me = (long)arg;
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  363  	struct rcu_head *rhp = NULL;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  364  	bool started = false, done = false, alldone = false;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  365  	u64 t;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  366  	u64 *wdp;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  367  	u64 *wdpp = writer_durations[me];
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  368  
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  369  	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  370  	WARN_ON(!wdpp);
> 6b558c4c7a4ba4 kernel/rcu/rcuperf.c  Paul E. McKenney        2016-01-12  371  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> b1433395c4cc07 kernel/rcu/rcuperf.c  Peter Zijlstra          2020-04-21  372  	sched_set_fifo_low(current);
> df37e66bfdbb57 kernel/rcu/rcuperf.c  Paul E. McKenney        2016-01-30  373  
> df37e66bfdbb57 kernel/rcu/rcuperf.c  Paul E. McKenney        2016-01-30  374  	if (holdoff)
> df37e66bfdbb57 kernel/rcu/rcuperf.c  Paul E. McKenney        2016-01-30  375  		schedule_timeout_uninterruptible(holdoff * HZ);
> df37e66bfdbb57 kernel/rcu/rcuperf.c  Paul E. McKenney        2016-01-30  376  
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  377) 	/*
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  378) 	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  379) 	 * so that RCU is not always expedited for normal GP tests.
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  380) 	 * The system_state test is approximate, but works well in practice.
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  381) 	 */
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  382) 	while (!gp_exp && system_state != SYSTEM_RUNNING)
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  383) 		schedule_timeout_uninterruptible(1);
> 77e9752ce69f36 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-07-04  384) 
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  385  	t = ktime_get_mono_fast_ns();
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  386  	if (atomic_inc_return(&n_rcu_scale_writer_started) >= nrealwriters) {
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  387  		t_rcu_scale_writer_started = t;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  388  		if (gp_exp) {
> e6e78b004fa7e0 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-08-30  389) 			b_rcu_gp_test_started =
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  390  				cur_ops->exp_completed() / 2;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  391  		} else {
> e6e78b004fa7e0 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-08-30  392) 			b_rcu_gp_test_started = cur_ops->get_gp_seq();
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  393  		}
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  394  	}
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  395  
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  396  	do {
> 820687a7b98a50 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-25  397  		if (writer_holdoff)
> 820687a7b98a50 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-25  398  			udelay(writer_holdoff);
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  399  		wdp = &wdpp[i];
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  400  		*wdp = ktime_get_mono_fast_ns();
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  401  		if (gp_async) {
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  402  retry:
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  403  			if (!rhp)
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  404  				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  405  			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  406  				atomic_inc(this_cpu_ptr(&n_async_inflight));
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  407  				cur_ops->async(rhp, rcu_scale_async_cb);
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  408  				rhp = NULL;
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  409  			} else if (!kthread_should_stop()) {
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  410  				cur_ops->gp_barrier();
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  411  				goto retry;
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  412  			} else {
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  413  				kfree(rhp); /* Because we are stopping. */
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  414  			}
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  415  		} else if (gp_exp) {
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  416  			cur_ops->exp_sync();
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  417  		} else {
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  418  			cur_ops->sync();
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  419  		}
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  420  		t = ktime_get_mono_fast_ns();
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  421  		*wdp = t - *wdp;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  422  		i_max = i;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  423  		if (!started &&
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  424  		    atomic_read(&n_rcu_scale_writer_started) >= nrealwriters)
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  425  			started = true;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  426  		if (!done && i >= MIN_MEAS) {
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  427  			done = true;
> b1433395c4cc07 kernel/rcu/rcuperf.c  Peter Zijlstra          2020-04-21  428  			sched_set_normal(current, 0);
> a56fefa2605cf8 kernel/rcu/rcuperf.c  SeongJae Park           2016-08-21  429  			pr_alert("%s%s rcu_perf_writer %ld has %d measurements\n",
> a56fefa2605cf8 kernel/rcu/rcuperf.c  SeongJae Park           2016-08-21 @430  				 perf_type, PERF_FLAG, me, MIN_MEAS);
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31 @431  			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  432  			    nrealwriters) {
> 620316e52a9238 kernel/rcu/rcuperf.c  Paul E. McKenney        2016-01-30  433  				schedule_timeout_interruptible(10);
> ac2bb275e8e5ab kernel/rcu/rcuperf.c  Paul E. McKenney        2016-01-29  434  				rcu_ftrace_dump(DUMP_ALL);
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  435  				SCALEOUT_STRING("Test complete");
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  436  				t_rcu_scale_writer_finished = t;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  437  				if (gp_exp) {
> e6e78b004fa7e0 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-08-30  438) 					b_rcu_gp_test_finished =
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  439  						cur_ops->exp_completed() / 2;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  440  				} else {
> e6e78b004fa7e0 kernel/rcu/rcuperf.c  Joel Fernandes (Google  2019-08-30  441) 					b_rcu_gp_test_finished =
> 17ef2fe97c8c8e kernel/rcu/rcuperf.c  Paul E. McKenney        2018-04-27  442  						cur_ops->get_gp_seq();
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  443  				}
> e6fb1fc1085e5b kernel/rcu/rcuperf.c  Artem Savkov            2016-02-07  444  				if (shutdown) {
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  445  					smp_mb(); /* Assign before wake. */
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  446  					wake_up(&shutdown_wq);
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  447  				}
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  448  			}
> e6fb1fc1085e5b kernel/rcu/rcuperf.c  Artem Savkov            2016-02-07  449  		}
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  450  		if (done && !alldone &&
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  451  		    atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters)
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  452  			alldone = true;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  453  		if (started && !alldone && i < MAX_MEAS - 1)
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  454  			i++;
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  455  		rcu_scale_wait_shutdown();
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  456  	} while (!torture_must_stop());
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  457  	if (gp_async) {
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  458  		cur_ops->gp_barrier();
> 881ed593a323c8 kernel/rcu/rcuperf.c  Paul E. McKenney        2017-04-17  459  	}
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  460  	writer_n_durations[me] = i_max;
> a20b5bd09813bc kernel/rcu/rcuscale.c Paul E. McKenney        2020-08-11  461  	torture_kthread_stopping("rcu_scale_writer");
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  462  	return 0;
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  463  }
> 8704baab9bc848 kernel/rcu/rcuperf.c  Paul E. McKenney        2015-12-31  464  
> 
> :::::: The code at line 430 was first introduced by commit
> :::::: a56fefa2605cf8e125ef09451487f30336128028 rcuperf: Consistently insert space between flag and message
> 
> :::::: TO: SeongJae Park <sj38.park@gmail.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


