Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3F6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322C42065F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593030628;
	bh=NhWQFESKuqFhh+KTduGAkopqp5zKjlwSv1YGzDYv/Mg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=d6OolJ4SOOdTGUxndDsyforOCpHO3DQPKi6zK2Tc45/q7OunVwP1CPBNtV2aEWCQH
	 4+FmCL250QqDHpMapolZyf6kEes3iRyjMbBXB+SrPd39WtVEx1R/xDTiSiihbwrVAL
	 CkAx8Pxp7Hb7KqLz2He6SjI27E1rFtxY67WAjybs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391438AbgFXUa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391042AbgFXUa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:30:26 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4442065F;
        Wed, 24 Jun 2020 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593030625;
        bh=NhWQFESKuqFhh+KTduGAkopqp5zKjlwSv1YGzDYv/Mg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XUp1Z/K237eWbw+f/BU00/yhT2EstnLvoEn9m7foDNpEH66+0vZesqUo0bWWnzuzp
         TxuHuBP4QirCsIkW3noPmEG8fc8SZXdy2qBCPGjnQHCuBGqoxJ3f9hUg6djoApptcf
         mrbwXPlRuzahmU6ChlhlhLYwDWcRMafHGfEqX0b0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 26AA835228BC; Wed, 24 Jun 2020 13:30:25 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:30:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, elver@google.com
Subject: Re: [rcu:rcu/next 35/35] kernel/rcu/tree.c:251:8: error: implicit
 declaration of function 'arch_atomic_add_return'; did you mean
Message-ID: <20200624203025.GJ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202006250300.ic32FsdY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006250300.ic32FsdY%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 03:38:03AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   347acb93a34a6e4f312f8b9ec1afdb86d27858d2
> commit: 347acb93a34a6e4f312f8b9ec1afdb86d27858d2 [35/35] rcu: Fixup noinstr warnings
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 347acb93a34a6e4f312f8b9ec1afdb86d27858d2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_enter':
> >> kernel/rcu/tree.c:251:8: error: implicit declaration of function 'arch_atomic_add_return'; did you mean 'atomic_add_return'? [-Werror=implicit-function-declaration]
>      251 |  seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>          |        ^~~~~~~~~~~~~~~~~~~~~~
>          |        atomic_add_return
>    kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_exit':
> >> kernel/rcu/tree.c:281:3: error: implicit declaration of function 'arch_atomic_andnot'; did you mean 'atomic_andnot'? [-Werror=implicit-function-declaration]
>      281 |   arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
>          |   ^~~~~~~~~~~~~~~~~~
>          |   atomic_andnot
>    kernel/rcu/tree.c: In function 'rcu_dynticks_curr_cpu_in_eqs':
> >> kernel/rcu/tree.c:314:11: error: implicit declaration of function 'arch_atomic_read'; did you mean 'atomic_read'? [-Werror=implicit-function-declaration]
>      314 |  return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
>          |           ^~~~~~~~~~~~~~~~
>          |           atomic_read
>    cc1: some warnings being treated as errors

And architectures using the definitions in include/linux/atomic-fallback.h
don't like this patch much.  MIPS defines everything in terms of
atomic_add_return_relaxed(), for which it provides inline assembly for
SMP-capable builds and a C-language code sequence otherwise.

One way of handling this is as follows:

------------------------------------------------------------------------

diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index 2c4927b..b7935857 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -133,6 +133,7 @@ atomic_add_return(int i, atomic_t *v)
 	return ret;
 }
 #define atomic_add_return atomic_add_return
+#define arch_atomic_add_return atomic_add_return
 #endif
 
 #endif /* atomic_add_return_relaxed */

------------------------------------------------------------------------

And of course similar for arch_atomic_andnot() and arch_atomic_read().

Another way would be to define a noinstr_atomic_add_return() that
was defined something like this:

------------------------------------------------------------------------

#ifdef CONFIG_HAVE_ARCH_KCSAN
# define noinstr_atomic_add_return arch_atomic_add_return
#else
# define noinstr_atomic_add_return atomic_add_return
#endif

------------------------------------------------------------------------

And again similarly for the others.

Left to myself, I would take the second option just because it provably
leaves unaltered anything that isn't using the new API.  That said,
there has to be a better Kconfig option to key this off of.

Thoughts?

							Thanx, Paul

> vim +251 kernel/rcu/tree.c
> 
>    233	
>    234	/*
>    235	 * Record entry into an extended quiescent state.  This is only to be
>    236	 * called when not already in an extended quiescent state, that is,
>    237	 * RCU is watching prior to the call to this function and is no longer
>    238	 * watching upon return.
>    239	 */
>    240	static noinstr void rcu_dynticks_eqs_enter(void)
>    241	{
>    242		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>    243		int seq;
>    244	
>    245		/*
>    246		 * CPUs seeing atomic_add_return() must see prior RCU read-side
>    247		 * critical sections, and we also must force ordering with the
>    248		 * next idle sojourn.
>    249		 */
>    250		rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
>  > 251		seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>    252		// RCU is no longer watching.  Better be in extended quiescent state!
>    253		WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>    254			     (seq & RCU_DYNTICK_CTRL_CTR));
>    255		/* Better not have special action (TLB flush) pending! */
>    256		WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>    257			     (seq & RCU_DYNTICK_CTRL_MASK));
>    258	}
>    259	
>    260	/*
>    261	 * Record exit from an extended quiescent state.  This is only to be
>    262	 * called from an extended quiescent state, that is, RCU is not watching
>    263	 * prior to the call to this function and is watching upon return.
>    264	 */
>    265	static noinstr void rcu_dynticks_eqs_exit(void)
>    266	{
>    267		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>    268		int seq;
>    269	
>    270		/*
>    271		 * CPUs seeing atomic_add_return() must see prior idle sojourns,
>    272		 * and we also must force ordering with the next RCU read-side
>    273		 * critical section.
>    274		 */
>    275		seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>    276		// RCU is now watching.  Better not be in an extended quiescent state!
>    277		rcu_dynticks_task_trace_exit();  // After ->dynticks update!
>    278		WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>    279			     !(seq & RCU_DYNTICK_CTRL_CTR));
>    280		if (seq & RCU_DYNTICK_CTRL_MASK) {
>  > 281			arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
>    282			smp_mb__after_atomic(); /* _exit after clearing mask. */
>    283		}
>    284	}
>    285	
>    286	/*
>    287	 * Reset the current CPU's ->dynticks counter to indicate that the
>    288	 * newly onlined CPU is no longer in an extended quiescent state.
>    289	 * This will either leave the counter unchanged, or increment it
>    290	 * to the next non-quiescent value.
>    291	 *
>    292	 * The non-atomic test/increment sequence works because the upper bits
>    293	 * of the ->dynticks counter are manipulated only by the corresponding CPU,
>    294	 * or when the corresponding CPU is offline.
>    295	 */
>    296	static void rcu_dynticks_eqs_online(void)
>    297	{
>    298		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>    299	
>    300		if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
>    301			return;
>    302		atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>    303	}
>    304	
>    305	/*
>    306	 * Is the current CPU in an extended quiescent state?
>    307	 *
>    308	 * No ordering, as we are sampling CPU-local information.
>    309	 */
>    310	static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
>    311	{
>    312		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>    313	
>  > 314		return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
>    315	}
>    316	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


