Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5735C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7481F206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582389218;
	bh=qRv0nKBYttUjMYj9cR4kA7M4ftISlLjLVSAvuTWkFPI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ulr2qDq70QDtW/qzdqdfe4RR3uh/4GHlppGygZjzdLtqgFrVkqVo9DE8qYGa6bZeS
	 g5H3QNaSvnESgFiNYgtpY2bm8yeyipxKXcq94HLHPGO96qrE04vzCJ7puYyG3lv/Ue
	 PgjpVkZgtZ6DaC9AlmhR968GecF32m9X5t1O8Ijc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBVQdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgBVQdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:33:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11667206ED;
        Sat, 22 Feb 2020 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582389216;
        bh=qRv0nKBYttUjMYj9cR4kA7M4ftISlLjLVSAvuTWkFPI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m/cFHv9Qu7u6SS0ERqwv/7bc53RxQQg+7m1k2yoMP5Km3GtQIwj0CWbU8ckMyxWFG
         5KUmHqWd9IOy/GIxSqOaWM7EfNPT+9+ak9uX6yDcix6zWJaVdrulhZlSvxaFxPa7XC
         1rspmZ0oQMFbmFsozOPftfUJdIvA0eGzpVlRy4pE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E1A8435226D5; Sat, 22 Feb 2020 08:33:35 -0800 (PST)
Date:   Sat, 22 Feb 2020 08:33:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/next 110/168] kernel/rcu/tree.c:3401:2: error: implicit
 declaration of function 'ASSERT_EXCLUSIVE_WRITER'
Message-ID: <20200222163335.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202002221501.6Iz5kP2U%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002221501.6Iz5kP2U%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 03:27:04PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   8aa63de65a79bd8c5c1c2b19452e35f58b043ac7
> commit: e70e4b3e69ce8d3fdfc1f4bfe6ed27187e1a9016 [110/168] rcu: Mark rcu_state.ncpus to detect concurrent writes
> config: arc-defconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e70e4b3e69ce8d3fdfc1f4bfe6ed27187e1a9016
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Note: the rcu/rcu/next HEAD 8aa63de65a79bd8c5c1c2b19452e35f58b043ac7 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/rcu/tree.c: In function 'rcu_cpu_starting':
> >> kernel/rcu/tree.c:3401:2: error: implicit declaration of function 'ASSERT_EXCLUSIVE_WRITER' [-Werror=implicit-function-declaration]
>     3401 |  ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
>          |  ^~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Good catch!  I will move this out of the set of commits intended for
v5.7, thank you!

							Thanx, Paul

> vim +/ASSERT_EXCLUSIVE_WRITER +3401 kernel/rcu/tree.c
> 
>   3364	
>   3365	/*
>   3366	 * Mark the specified CPU as being online so that subsequent grace periods
>   3367	 * (both expedited and normal) will wait on it.  Note that this means that
>   3368	 * incoming CPUs are not allowed to use RCU read-side critical sections
>   3369	 * until this function is called.  Failing to observe this restriction
>   3370	 * will result in lockdep splats.
>   3371	 *
>   3372	 * Note that this function is special in that it is invoked directly
>   3373	 * from the incoming CPU rather than from the cpuhp_step mechanism.
>   3374	 * This is because this function must be invoked at a precise location.
>   3375	 */
>   3376	void rcu_cpu_starting(unsigned int cpu)
>   3377	{
>   3378		unsigned long flags;
>   3379		unsigned long mask;
>   3380		int nbits;
>   3381		unsigned long oldmask;
>   3382		struct rcu_data *rdp;
>   3383		struct rcu_node *rnp;
>   3384	
>   3385		if (per_cpu(rcu_cpu_started, cpu))
>   3386			return;
>   3387	
>   3388		per_cpu(rcu_cpu_started, cpu) = 1;
>   3389	
>   3390		rdp = per_cpu_ptr(&rcu_data, cpu);
>   3391		rnp = rdp->mynode;
>   3392		mask = rdp->grpmask;
>   3393		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>   3394		WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
>   3395		oldmask = rnp->expmaskinitnext;
>   3396		rnp->expmaskinitnext |= mask;
>   3397		oldmask ^= rnp->expmaskinitnext;
>   3398		nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
>   3399		/* Allow lockless access for expedited grace periods. */
>   3400		smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
> > 3401		ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
>   3402		rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>   3403		rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>   3404		rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
>   3405		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
>   3406			rcu_disable_urgency_upon_qs(rdp);
>   3407			/* Report QS -after- changing ->qsmaskinitnext! */
>   3408			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>   3409		} else {
>   3410			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>   3411		}
>   3412		smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
>   3413	}
>   3414	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


