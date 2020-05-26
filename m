Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URG_BIZ,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A05C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64379208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520458;
	bh=nEsdctgoBHpl4HUz6UKxnPRnw8aRpNQAiRd1il2EC4k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YGlpia7UIPgZNG1L5PPDJXV9h1k9ROcC1Ku8t/Dqp7GVHk+I0n+xptTHqreoXowbV
	 FRsAmhdAnhv9pDN0LZ6j0E5v1W8kI3rnkgvdqgm2ajVszsZ3sdHTeaV3udofIZp7wv
	 XpDGV4Lqe3NB5rabkMmU8wWCUCg1g7MsB2Pr7N3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404346AbgEZTOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392143AbgEZTOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:14:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B9A20776;
        Tue, 26 May 2020 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520448;
        bh=nEsdctgoBHpl4HUz6UKxnPRnw8aRpNQAiRd1il2EC4k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bIqbO9Tqwv9fc7v819nhEw6MWuw6lBcXUbnnkH5hG4VAln3xQsmaek5sA6M7oAYPO
         btNX5BN4JFnyU6u2kjO24WL67YH5LtZ8s4J1OPwAxsqz9p+UNT84K3LxktL2JkO7jn
         VKW0n5H2DZoX6JPSA1Fl5ePDSMeAghhb5DcsGxn8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7ACC23522A8B; Tue, 26 May 2020 12:14:08 -0700 (PDT)
Date:   Tue, 26 May 2020 12:14:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>
Subject: Re: [PATCH] rcu/performance: Fix kfree_perf_init() build warning on
 32-bit kernels
Message-ID: <20200526191408.GN2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
 <20200526182744.GA3722128@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526182744.GA3722128@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:27:44PM +0200, Ingo Molnar wrote:
> 
> * tip-bot2 for Joel Fernandes (Google) <tip-bot2@linutronix.de> wrote:
> 
> > The following commit has been merged into the core/rcu branch of tip:
> > 
> > Commit-ID:     f87dc808009ac86c790031627698ef1a34c31e25
> > Gitweb:        https://git.kernel.org/tip/f87dc808009ac86c790031627698ef1a34c31e25
> > Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
> > AuthorDate:    Mon, 16 Mar 2020 12:32:26 -04:00
> > Committer:     Paul E. McKenney <paulmck@kernel.org>
> > CommitterDate: Mon, 27 Apr 2020 11:02:50 -07:00
> > 
> > rcuperf: Add ability to increase object allocation size
> > 
> > This allows us to increase memory pressure dynamically using a new
> > rcuperf boot command line parameter called 'rcumult'.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/rcuperf.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index a4a8d09..16dd1e6 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -88,6 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
> >  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
> >  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
> >  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> > +torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
> >  
> >  static char *perf_type = "rcu";
> >  module_param(perf_type, charp, 0444);
> > @@ -635,7 +636,7 @@ kfree_perf_thread(void *arg)
> >  		}
> >  
> >  		for (i = 0; i < kfree_alloc_num; i++) {
> > -			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > +			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> >  			if (!alloc_ptr)
> >  				return -ENOMEM;
> >  
> > @@ -722,6 +723,8 @@ kfree_perf_init(void)
> >  		schedule_timeout_uninterruptible(1);
> >  	}
> >  
> > +	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> 
> There's a new build warning on certain 32-bit kernel builds due to 
> this commit:
> 
> In file included from ./include/linux/printk.h:7,
>                  from ./include/linux/kernel.h:15,
>                  from kernel/rcu/rcuperf.c:13:
> kernel/rcu/rcuperf.c: In function ‘kfree_perf_init’:
> ./include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Wformat=]
>     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>       |                  ^~~~~~
> ./include/linux/kern_levels.h:9:20: note: in expansion of macro ‘KERN_SOH’
>     9 | #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
>       |                    ^~~~~~~~
> ./include/linux/printk.h:295:9: note: in expansion of macro ‘KERN_ALERT’
>   295 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~~~~~
> kernel/rcu/rcuperf.c:726:2: note: in expansion of macro ‘pr_alert’
>   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
>       |  ^~~~~~~~
> kernel/rcu/rcuperf.c:726:32: note: format string is defined here
>   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
>       |                              ~~^
>       |                                |
>       |                                long unsigned int
>       |                              %u
> 
> 
> The reason for the warning is that both kfree_mult and sizeof() are 
> 'int' types on 32-bit kernels, while the format string expects a long.
> 
> Instead of casting the type to long or tweaking the format string, the 
> most straightforward solution is to upgrade kfree_mult to a long. 
> Since this depends on CONFIG_RCU_PERF_TEST

Makes sense, and I have queued the patch below, which I am assuming
that you want in the upcoming merge window.  If you don't tell me
otherwise, I will send you an urgent pull request later today.
Or, if you just put it directly into -tip yourself:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Either way, please let me know.

> BTW., could we please also rename this code from 'PERF_TEST'/'perf test'
> to 'PERFORMANCE_TEST'/'performance test'? At first glance I always
> mistakenly believe that it's somehow related to perf, while it isn't. =B-)

Fair enough, especially given that perf was there first and is also way
more heavily used.  ;-)

But I am guessing that this one is OK for the v5.9 merge window.
Either way, I will update as you say.

							Thanx, Paul

------------------------------------------------------------------------

commit 2fbc7d67a2ed108e3ac63296670fecb3a42fddd0
Author: Ingo Molnar <mingo@kernel.org>
Date:   Tue May 26 12:10:01 2020 -0700

    rcuperf: Fix kfree_mult to match printk() format
    
    This commit changes the type of kfree_mult from int to long in order
    to match the printk() format on 32-bit systems.
    
    Reported-by: kbuild test robot <lkp@intel.com>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index d906ca9..fb3a1f0 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -93,7 +93,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
-torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(long, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
