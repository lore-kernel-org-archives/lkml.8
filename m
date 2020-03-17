Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F30C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73161206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584483947;
	bh=OiHevbk3bmBxyxPbqaJ83O8jsVIPqM8xvnuAVwvdE0E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KHAVEVsMS9zY6ImQLgdAu68ua3u3RCg+FbXT5Fs74IVg75O/hnDOoP6ktQHsPsNsL
	 mzr6FIaWXYZq12x7Nu0rwMaMZ8g5nfQUXawZtGIdx9kK5+Ua8oSFlVyGjrxe2CPNUF
	 1/gIa630iMgBIhyip3mVcoMZ7gQGL99m2COx443E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCQWZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQWZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:25:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C9E206EC;
        Tue, 17 Mar 2020 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584483945;
        bh=OiHevbk3bmBxyxPbqaJ83O8jsVIPqM8xvnuAVwvdE0E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sfxDGEi/saW9CAJBqjckkf66Ev9DcSMKx1jXZo5bMrVUrVHjecGE4Qi46t2NDpcud
         jX+x5X5GBcAPBD7CvzLJIWeciX0QsOaxqgL20araA/SEoiJ7bNncVMFQHcylTME6wX
         7Qa9iPPvZ0CvQKneEEDwaGrKWJmTpeEN9XpBpMoU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7B4AC352272E; Tue, 17 Mar 2020 15:25:45 -0700 (PDT)
Date:   Tue, 17 Mar 2020 15:25:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.03.16a 60/68] kernel/rcu/tasks.h:1000:37: error:
 'rcu_tasks_rude' undeclared; did you mean 'rcu_tasks_qs'?
Message-ID: <20200317222545.GO3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202003180521.jou9H4n6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003180521.jou9H4n6%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:28:25AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.16a
> head:   ad7a7c12b09555e7c488ee3be512d549cd78a2c0
> commit: 277258c315b7c732948e47718de02c6908d1745e [60/68] rcu-tasks: Add RCU tasks to rcutorture writer stall output
> config: arc-defconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 277258c315b7c732948e47718de02c6908d1745e
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:562:
>    kernel/rcu/tasks.h: In function 'show_rcu_tasks_gp_kthreads':
> >> kernel/rcu/tasks.h:1000:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
>     1000 |  show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
>          |                                     ^~~~~~~~~~~~~~
>          |                                     rcu_tasks_qs
>    kernel/rcu/tasks.h:1000:37: note: each undeclared identifier is reported only once for each function it appears in

Good catch!  Will fix!!!

							Thanx, Paul

> vim +1000 kernel/rcu/tasks.h
> 
>    996	
>    997	void show_rcu_tasks_gp_kthreads(void)
>    998	{
>    999		show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
> > 1000		show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
>   1001		show_rcu_tasks_trace_gp_kthread();
>   1002	}
>   1003	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


