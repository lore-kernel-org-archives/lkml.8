Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A26C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D6E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623737;
	bh=wvqD7rgwFusMJIqaPtOnYUgUIANAKYUee6Yxt4ifw9A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=m9Qsx4Cm86ckocGq7bZ2Y++UTkkLbRfK3/PY6A9dBgKHVjKb7tLnDUQC9UWPNrbpa
	 owMw6pXPExufZ3dNYz7uEaw1jXCDl+t33iO95rWoONiUuRgIttJ/aUke1b4DZWWLbP
	 p7jjfd02MIpMh/9cDSyJYTTaIw1TI1rpyXowzAnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgCSNPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgCSNPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:15:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AF420724;
        Thu, 19 Mar 2020 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623732;
        bh=wvqD7rgwFusMJIqaPtOnYUgUIANAKYUee6Yxt4ifw9A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HVixYOylJ1qJ3Wi428rgaPC1XwRb2R/HIRyQwvaDFDTtm/teRklxVedSMVdKz9P5t
         gdmH4L6a5vk2ryS6eXLCQYcHw4G35H6hi6MLzL9jiLU1JmGUqWorFtz6LY8yk2YxV/
         sTriOXNIFULtVstfX/DrM8Cz8Xkst55e+/zI2Buk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C147A35227C6; Thu, 19 Mar 2020 06:15:32 -0700 (PDT)
Date:   Thu, 19 Mar 2020 06:15:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.03.17a 61/80] kernel/rcu/tasks.h:1000:37: error:
 'rcu_tasks_rude' undeclared; did you mean 'rcu_tasks_qs'?
Message-ID: <20200319131532.GC3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202003191926.FloXO0MA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003191926.FloXO0MA%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 07:01:29PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.17a
> head:   0b42559abf67253005cca061233987ae9a2849a4
> commit: 589081348a37ec02d9b067aa08d4a771ae590e1e [61/80] rcu-tasks: Add RCU tasks to rcutorture writer stall output
> config: nds32-defconfig (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 589081348a37ec02d9b067aa08d4a771ae590e1e
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=nds32 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Note: the rcu/dev.2020.03.17a HEAD 0b42559abf67253005cca061233987ae9a2849a4 builds fine.
>       It only hurts bisectibility.

FYI, fixed by c6ef38e4d595 ("rcu-tasks: Add RCU tasks to rcutorture writer
stall output").

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:562:
>    kernel/rcu/tasks.h: In function 'show_rcu_tasks_gp_kthreads':
> >> kernel/rcu/tasks.h:1000:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
>     1000 |  show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
>          |                                     ^~~~~~~~~~~~~~
>          |                                     rcu_tasks_qs
>    kernel/rcu/tasks.h:1000:37: note: each undeclared identifier is reported only once for each function it appears in
> 
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


