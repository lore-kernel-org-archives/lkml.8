Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E4C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E092923340
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586180232;
	bh=EnXcXJoGOU6oAQ1312E6Rzx9X9i+Tzki0SYjt9wGfXM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dnJJm4haetsFtNUaYdiTJOwOawz+uf4gSS0nce+oFyV7EQJax/XdHgW3sZ0oYLkyc
	 qwG6X0nhKgiQKVzB50g/ILmZxZheXrobGxF7RHF+71zRQPRl1HwrZjUv9se7YW4pp7
	 yAT7vS/eeNur14s2JnHXfotwFDSYhyj4DetUa2S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgDFNhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgDFNhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:37:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D763B23340;
        Mon,  6 Apr 2020 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586180229;
        bh=EnXcXJoGOU6oAQ1312E6Rzx9X9i+Tzki0SYjt9wGfXM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pLwBqyWaU70ci/KayrliME1IVyscovhHhC87ntxDApEFhkj/h1JPLGa2f+pwlGaVQ
         gOa7NvOgwkyGA8yiwc9xu58MfBXi0WfJtolzUW0OK3tuih0b6RGiDrCbGgItY9P4w9
         ZEmIPYTiWO+Rg6mNFgBHNDjqwxNiHcwuIGXOjLvU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B187A3522726; Mon,  6 Apr 2020 06:37:09 -0700 (PDT)
Date:   Mon, 6 Apr 2020 06:37:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.04.03a 101/101] kernel/rcu/tasks.h:251:9: error:
 'struct task_struct' has no member named 'rcu_tasks_idx'
Message-ID: <20200406133709.GC19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202004060857.ejsibNxr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004060857.ejsibNxr%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:09:14AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.04.03a
> head:   8c64539e2d8fbd96ad4bb60a96c5d9c1ef823572
> commit: 8c64539e2d8fbd96ad4bb60a96c5d9c1ef823572 [101/101] squash! ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 8c64539e2d8fbd96ad4bb60a96c5d9c1ef823572
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.3.0 make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>

Messed up the Kconfig, and I have an alleged fix in -rcu which will be
squashed into the offending commit with attribution.

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:563:
>    kernel/rcu/tasks.h: In function 'exit_tasks_rcu_start':
> >> kernel/rcu/tasks.h:251:9: error: 'struct task_struct' has no member named 'rcu_tasks_idx'
>      251 |  current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
>          |         ^~
>    kernel/rcu/tasks.h: In function 'exit_tasks_rcu_finish':
>    kernel/rcu/tasks.h:263:44: error: 'struct task_struct' has no member named 'rcu_tasks_idx'
>      263 |  __srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
>          |                                            ^~
> 
> vim +251 kernel/rcu/tasks.h
> 
> dfdddf06801dcb Paul E. McKenney 2020-03-03  246  
> dfdddf06801dcb Paul E. McKenney 2020-03-03  247  /* Do the srcu_read_lock() for the above synchronize_srcu().  */
> dfdddf06801dcb Paul E. McKenney 2020-03-03  248  void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> dfdddf06801dcb Paul E. McKenney 2020-03-03  249  {
> dfdddf06801dcb Paul E. McKenney 2020-03-03  250  	preempt_disable();
> dfdddf06801dcb Paul E. McKenney 2020-03-03 @251  	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> dfdddf06801dcb Paul E. McKenney 2020-03-03  252  	preempt_enable();
> 4dbad397293c85 Paul E. McKenney 2020-03-02  253  }
> dfdddf06801dcb Paul E. McKenney 2020-03-03  254  
> 
> :::::: The code at line 251 was first introduced by commit
> :::::: dfdddf06801dcbee9f3ab515aad75421b3e3e75f rcu-tasks: Refactor RCU-tasks to allow variants to be added
> 
> :::::: TO: Paul E. McKenney <paulmck@kernel.org>
> :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


