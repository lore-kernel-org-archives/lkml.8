Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACDFC4741C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 13:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056362067D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581772639;
	bh=293N8vZpbSbYXZ17NvMuA4aOglrONcIcPlum3v+3Avk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=11ChGu5S7/2s23Yn969mlHoHC2sUALufgfeM07n/L67PpFG95V8+U0h01Tkv6/Cvh
	 StFqMxK/c+SDgyMAi903MKpaXDylfbBs0RE5eVj/CUcHlCcPVfi5o/iPtON51MJrBx
	 XGKXM02zloUGS1qmUzzGrDb9M3dcU7L25YslVglk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgBONPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 08:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgBONPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 08:15:03 -0500
Received: from paulmck-ThinkPad-P72.home (206-137-99-82.bluetone.cz [82.99.137.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3C52067D;
        Sat, 15 Feb 2020 13:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581772503;
        bh=293N8vZpbSbYXZ17NvMuA4aOglrONcIcPlum3v+3Avk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yVw0k5eHSgXke8HW6Pru7ePzNWnNCM/S22KqM0pKYt+rRLOCyKYxWib5fc171sfwQ
         s+x03rtBsyUuGOQ5oTxEFIXD4ALLJkJC2KH1+ABZ5SbfIczmzB43oKO9wgeIwudTkA
         8ad4BK2FfGOkauUfYoQUYaL25YgE5RzM0NMBfxdA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 65C623520CAB; Sat, 15 Feb 2020 05:15:00 -0800 (PST)
Date:   Sat, 15 Feb 2020 05:15:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.02.12a 109/124] kernel/torture.c:239:3: error:
 implicit declaration of function 'rcutorture_sched_setaffinity'; did you
 mean '__NR_ia32_sched_setaffinity'?
Message-ID: <20200215131500.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202002151524.4UGF8vEo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002151524.4UGF8vEo%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 03:55:27PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.12a
> head:   35a305226917a71de1c060db96fed0520cf644d9
> commit: bc3db9afb8492662a1108616342f288de66baa8f [109/124] EXP: rcutorture hack to force CPU hotplug onto CPU 0
> config: x86_64-randconfig-s0-20200215 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-4) 7.5.0
> reproduce:
>         git checkout bc3db9afb8492662a1108616342f288de66baa8f
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/torture.c: In function 'torture_onoff':
> >> kernel/torture.c:239:3: error: implicit declaration of function 'rcutorture_sched_setaffinity'; did you mean '__NR_ia32_sched_setaffinity'? [-Werror=implicit-function-declaration]
>       rcutorture_sched_setaffinity(current->pid, cpumask_of(0));
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       __NR_ia32_sched_setaffinity
>    cc1: some warnings being treated as errors

And this experimental commit is now gone from current -rcu, though you
might well have a few more branches containing it in your queue.

							Thanx, Paul

> vim +239 kernel/torture.c
> 
>    195	
>    196	/*
>    197	 * Execute random CPU-hotplug operations at the interval specified
>    198	 * by the onoff_interval.
>    199	 */
>    200	static int
>    201	torture_onoff(void *arg)
>    202	{
>    203		int cpu;
>    204		int maxcpu = -1;
>    205		DEFINE_TORTURE_RANDOM(rand);
>    206		int ret;
>    207	
>    208		VERBOSE_TOROUT_STRING("torture_onoff task started");
>    209		for_each_online_cpu(cpu)
>    210			maxcpu = cpu;
>    211		WARN_ON(maxcpu < 0);
>    212		if (!IS_MODULE(CONFIG_TORTURE_TEST))
>    213			for_each_possible_cpu(cpu) {
>    214				if (cpu_online(cpu))
>    215					continue;
>    216				ret = cpu_up(cpu);
>    217				if (ret && verbose) {
>    218					pr_alert("%s" TORTURE_FLAG
>    219						 "%s: Initial online %d: errno %d\n",
>    220						 __func__, torture_type, cpu, ret);
>    221				}
>    222			}
>    223	
>    224		if (maxcpu == 0) {
>    225			VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");
>    226			goto stop;
>    227		}
>    228	
>    229		if (onoff_holdoff > 0) {
>    230			VERBOSE_TOROUT_STRING("torture_onoff begin holdoff");
>    231			schedule_timeout_interruptible(onoff_holdoff);
>    232			VERBOSE_TOROUT_STRING("torture_onoff end holdoff");
>    233		}
>    234		while (!torture_must_stop()) {
>    235			if (disable_onoff_at_boot && !rcu_inkernel_boot_has_ended()) {
>    236				schedule_timeout_interruptible(HZ / 10);
>    237				continue;
>    238			}
>  > 239			rcutorture_sched_setaffinity(current->pid, cpumask_of(0));
>    240			cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
>    241			if (!torture_offline(cpu,
>    242					     &n_offline_attempts, &n_offline_successes,
>    243					     &sum_offline, &min_offline, &max_offline))
>    244				torture_online(cpu,
>    245					       &n_online_attempts, &n_online_successes,
>    246					       &sum_online, &min_online, &max_online);
>    247			schedule_timeout_interruptible(onoff_interval);
>    248		}
>    249	
>    250	stop:
>    251		torture_kthread_stopping("torture_onoff");
>    252		return 0;
>    253	}
>    254	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


