Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B712C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A882065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591395094;
	bh=JgLAQEZeMuKiux4VYrBs55ktaFroRxZ7lqVabP+0S5c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tvHk4UQr7hUEYia5vzYeCnXjrlnLj0GLIQNQkPsVsFLrjzH7FNcoXqvEF5y5Cs/cl
	 grFkjUEHLyD4Yl7FdmRjBwKm+kjTGO52GnK6NCAESMFiURlMGwk18jo6WVkypS/2hF
	 0ScOID7UUC6uw++TWspIsO8fGoUY0DNe4Ef/Wwqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgFEWLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgFEWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:11:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6242065C;
        Fri,  5 Jun 2020 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591395092;
        bh=JgLAQEZeMuKiux4VYrBs55ktaFroRxZ7lqVabP+0S5c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lsDNUZ4CsHsUeETv2FKZxIkc0zHRLM+9/AQY1uQFai8e4LbH9kg8NS7HdF2pL9MwA
         L5FdFiKqaSWUfztJlc3vC93L6RV5zS9/6IQIuavl1fCWD01Vj10I1MBiVjqDlIgqqG
         fj4oDxj7q2seLwqMLk/yQKVE+xrB6WkNBMnn8PQ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0F3563522B47; Fri,  5 Jun 2020 15:11:32 -0700 (PDT)
Date:   Fri, 5 Jun 2020 15:11:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.06.02a 85/90] kernel/smp.c:122: undefined
 reference to `__udivdi3'
Message-ID: <20200605221132.GD4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202006060528.SmyaIPRq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006060528.SmyaIPRq%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 05:38:31AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.06.02a
> head:   5216948905dd07a84cef8a7dc72c2ec076802efd
> commit: 92ebbb71443dced2019cd24b737ce60b03a29e10 [85/90] EXP kernel/smp: Provide CSD lock timeout diagnostics
> config: i386-randconfig-c001-20200605 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ld: kernel/smp.o: in function `csd_lock_wait':
> >> kernel/smp.c:122: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> ld: kernel/smp.c:136: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:122: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> ld: kernel/smp.c:136: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:122: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> ld: kernel/smp.c:136: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:122: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> >> ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> ld: kernel/smp.c:136: undefined reference to `__udivdi3'

Good catch, thank you, fixup patch applied.

							Thanx, Paul

> vim +122 kernel/smp.c
> 
>    107	
>    108	/*
>    109	 * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
>    110	 *
>    111	 * For non-synchronous ipi calls the csd can still be in use by the
>    112	 * previous function call. For multi-cpu calls its even more interesting
>    113	 * as we'll have to ensure no other cpu is observing our csd.
>    114	 */
>    115	static __always_inline void csd_lock_wait(call_single_data_t *csd)
>    116	{
>    117		int bug_id = 0;
>    118		int cpu;
>    119		call_single_data_t *cpu_cur_csd;
>    120		u64 ts0, ts1, ts2, ts_delta;
>    121	
>  > 122		ts1 = ts0 = sched_clock() / 1000 / 1000;
>    123		for (;;) {
>    124			unsigned long flags = READ_ONCE(csd->flags);
>    125	
>    126			if (!(flags & CSD_FLAG_LOCK))
>    127				break;
>  > 128			ts2 = sched_clock() / 1000 / 1000;
>    129			ts_delta = ts2 - ts1;
>    130			if (unlikely(ts_delta > CSD_LOCK_TIMEOUT)) {
>    131				bug_id = atomic_inc_return(&csd_bug_count);
>    132				cpu = csd->cpu;
>    133				smp_mb(); // No stale cur_csd values!
>    134				cpu_cur_csd = per_cpu(cur_csd, cpu);
>    135				smp_mb(); // No refetching cur_csd values!
>  > 136				printk("csd: Detected non-responsive CSD lock (#%d) on CPU#%d, waiting %Ld.%03Ld secs for CPU#%02d %pf(%ps), currently %s.\n",
>    137				       bug_id, raw_smp_processor_id(),
>    138				       ts_delta/1000ULL, ts_delta % 1000ULL, cpu,
>    139				       csd->func, csd->info,
>    140				       !cpu_cur_csd ? "unresponsive"
>    141						: csd == cpu_cur_csd
>    142							? "handling this request"
>    143							: "handling prior request");
>    144				if (!trigger_single_cpu_backtrace(cpu))
>    145					dump_cpu_task(cpu);
>    146				if (!cpu_cur_csd) {
>    147					printk("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", bug_id, raw_smp_processor_id(), cpu);
>    148					arch_send_call_function_single_ipi(cpu);
>    149				}
>    150				dump_stack();
>    151				ts1 = ts2;
>    152			}
>    153			cpu_relax();
>    154		}
>    155		smp_acquire__after_ctrl_dep();
>    156		if (unlikely(bug_id))
>    157			printk("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock after all. Phew!\n", bug_id, raw_smp_processor_id(), cpu);
>    158	}
>    159	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


