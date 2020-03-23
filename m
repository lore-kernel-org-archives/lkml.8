Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B28C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B332A2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584987832;
	bh=mlE8VEtbRk1rY0VU1U5aC3z8vaKuGruu8oHZzxlnagw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FzrdRD7FPbputSKAyQNJpho91LmK2oIig2ZyUWPeu1T0ih/Uwg/rz/8gedK1lXlZd
	 SuHv9LMQch55K3Kb7ytKg9ZjzN7Bjw5t9wAonxRwnkD0QG5dPgiwZl5IkycvnJvkMS
	 HiJJp4Ber+ZcpKstez6N0g68LogZOSNoIo9Tm+eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCWSXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgCWSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:23:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55922051A;
        Mon, 23 Mar 2020 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584987827;
        bh=mlE8VEtbRk1rY0VU1U5aC3z8vaKuGruu8oHZzxlnagw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gM98WPtn5Wnyh4pjwYdoqnSR2JPozMiuN4UW0Tkmui108gR6TulBH3uawDn2sMjU6
         9lxq+oXuE5VlHGgXcvBosi0+047s5EmzXcfo+GzMKQLy3wARI9OfSbDPTaqPLjOPkb
         koT71mBYEfYPAnfL61/Nue83ia84z0nmYE5yIm08=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A80B035226E4; Mon, 23 Mar 2020 11:23:47 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:23:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/next 78/83] kernel/rcu/tasks.h:740:8: error: type
 defaults to 'int' in declaration of 'DEFINE_IRQ_WORK'
Message-ID: <20200323182347.GO3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202003231330.ZXugoEjF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003231330.ZXugoEjF%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:26:49PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   72f26c3be409e0ccd52a48e7f5ffbdbb5cd0a960
> commit: f7f9f5b97a87a31d90fe254f6e685b67e0b378a9 [78/83] rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f7f9f5b97a87a31d90fe254f6e685b67e0b378a9
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

I believe I have this fixed via a #include of linux/irq_work.h, which I
will fold into the original patch.

Thank you for finding this!

							Thanx, Paul

> All error/warnings (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:562:
> >> kernel/rcu/tasks.h:736:39: warning: 'struct irq_work' declared inside parameter list will not be visible outside of this definition or declaration
>      736 | static void rcu_read_unlock_iw(struct irq_work *iwp)
>          |                                       ^~~~~~~~
> >> kernel/rcu/tasks.h:740:8: error: type defaults to 'int' in declaration of 'DEFINE_IRQ_WORK' [-Werror=implicit-int]
>      740 | static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
>          |        ^~~~~~~~~~~~~~~
> >> kernel/rcu/tasks.h:740:1: warning: parameter names (without types) in function declaration
>      740 | static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
>          | ^~~~~~
>    kernel/rcu/tasks.h: In function 'rcu_read_unlock_trace_special':
> >> kernel/rcu/tasks.h:751:3: error: implicit declaration of function 'irq_work_queue'; did you mean 'drain_workqueue'? [-Werror=implicit-function-declaration]
>      751 |   irq_work_queue(&rcu_tasks_trace_iw);
>          |   ^~~~~~~~~~~~~~
>          |   drain_workqueue
> >> kernel/rcu/tasks.h:751:19: error: 'rcu_tasks_trace_iw' undeclared (first use in this function); did you mean 'rcu_tasks_trace_qs'?
>      751 |   irq_work_queue(&rcu_tasks_trace_iw);
>          |                   ^~~~~~~~~~~~~~~~~~
>          |                   rcu_tasks_trace_qs
>    kernel/rcu/tasks.h:751:19: note: each undeclared identifier is reported only once for each function it appears in
>    kernel/rcu/update.c: At top level:
>    kernel/rcu/tasks.h:740:8: warning: 'DEFINE_IRQ_WORK' declared 'static' but never defined [-Wunused-function]
>      740 | static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
>          |        ^~~~~~~~~~~~~~~
>    kernel/rcu/tasks.h:736:13: warning: 'rcu_read_unlock_iw' defined but not used [-Wunused-function]
>      736 | static void rcu_read_unlock_iw(struct irq_work *iwp)
>          |             ^~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +740 kernel/rcu/tasks.h
> 
>    727	
>    728	void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
>    729	DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
>    730			 "RCU Tasks Trace");
>    731	
>    732	/*
>    733	 * This irq_work handler allows rcu_read_unlock_trace() to be invoked
>    734	 * while the scheduler locks are held.
>    735	 */
>  > 736	static void rcu_read_unlock_iw(struct irq_work *iwp)
>    737	{
>    738		wake_up(&trc_wait);
>    739	}
>  > 740	static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
>    741	
>    742	/* If we are the last reader, wake up the grace-period kthread. */
>    743	void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
>    744	{
>    745		if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
>    746		    t->trc_reader_special.b.need_mb)
>    747			smp_mb(); // Pairs with update-side barriers.
>    748		WRITE_ONCE(t->trc_reader_nesting, nesting);
>    749		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
>    750		if (atomic_dec_and_test(&trc_n_readers_need_end))
>  > 751			irq_work_queue(&rcu_tasks_trace_iw);
>    752	}
>    753	EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
>    754	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


