Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F6BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63E020848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583458636;
	bh=p3/7tgqs+hnfYi26LozMKMAYmbPplvz+zQxSII3INFE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zg8xJAKxVCjrjf5kBr30SY1qYUexowdzmbcrOHOyMnnDwbF/QndCuTWg9PI+Z/S2r
	 FEP+TYsrW4tyvVE4lgKtlk/IrYoX4N/YagChkPDC+dWaUzyBrWAN14cy7GRVdIE0S4
	 iQbWsuSK+6dkOzV8zy/dzj2Mh2ba+1wW5ojTq53Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCFBhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFBhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:37:15 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6630C2073B;
        Fri,  6 Mar 2020 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583458634;
        bh=p3/7tgqs+hnfYi26LozMKMAYmbPplvz+zQxSII3INFE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SlvnlXWm3LTNcmmsq23p6CPJ98OgghdfcXNL7+I2xJmr19gNpPJZz2XPINxLxzAhv
         8+gtU7msTJGHRzWk0Gdw5BEV+oR7mHHF8mC0egCcmbP8bTe96yfu1ZcxctYsOTWDiZ
         ztMFhlxhEe/ycSZW2wbhIueP6HJrTbsEhUqZZSzo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3E2AE3522806; Thu,  5 Mar 2020 17:37:14 -0800 (PST)
Date:   Thu, 5 Mar 2020 17:37:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        urezki@gmail.com
Subject: Re: [PATCH rcu-dev 1/2] rcuperf: Add ability to increase object
 allocation size
Message-ID: <20200306013714.GR2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200306011626.97616-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306011626.97616-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 08:16:25PM -0500, Joel Fernandes (Google) wrote:
> This allows us to increase memory pressure dynamically using a new
> rcuperf boot command line parameter called 'rcumult'.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks plausible to me at a very quick first glance.  Uladzislau, thoughts?

							Thanx, Paul

> ---
>  kernel/rcu/rcuperf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index a4a8d097d84d9..16dd1e6b7c09f 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -88,6 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> +torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
> @@ -635,7 +636,7 @@ kfree_perf_thread(void *arg)
>  		}
>  
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> +			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> @@ -722,6 +723,8 @@ kfree_perf_init(void)
>  		schedule_timeout_uninterruptible(1);
>  	}
>  
> +	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> +
>  	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
>  			       GFP_KERNEL);
>  	if (kfree_reader_tasks == NULL) {
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
