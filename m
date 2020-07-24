Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF965C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A286F206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595613344;
	bh=abI4X26iEEWTuAT3rk/GC6BYj68hu/Mf/vonXod3ZX8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LRSL3vyXYFtdgIcfepCKdUSdOnJTr1vUt/NnFIMRbolecATOHyrj6/htWlRHMjvv3
	 gOBYBbUaTT8gzfjt/1H6v2DFK9ZS470U9ymVgBw6N02N9TC4ITmvaGBZ0HJh6Pa2Uf
	 9yZTOXt6AOInbNszZEaK2ALpCNZiSSBp3wHy8vIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGXRzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgGXRzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:55:43 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB412067D;
        Fri, 24 Jul 2020 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595613342;
        bh=abI4X26iEEWTuAT3rk/GC6BYj68hu/Mf/vonXod3ZX8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xQlMO60SBY639JcTLwHYXZeM5+/IYps1cTQWGBWp1Xihee50QYuHXYxBk7WS4bYq3
         xfzH4SFK8H4SHjeLFa0XcyX5a8SAFu345orVNMPwee0XBTGT8GDK/hW9I6rLT/oGZo
         Pzy7KIhZtJyZ1YaFlHu7aDWnLLaWfaCoeoE1jNus=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8A38C3520BD1; Fri, 24 Jul 2020 10:55:42 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:55:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org,
        torvalds@linux-foundation.org, hch@lst.de
Subject: Re: [PATCH -v2 1/5] sched: Fix ttwu() race
Message-ID: <20200724175542.GR9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200622100122.477087977@infradead.org>
 <20200622100825.726200103@infradead.org>
 <159532854586.15672.5123219635720172265@build.alporthouse.com>
 <20200721113719.GI119549@hirez.programming.kicks-ass.net>
 <159541187604.15672.2433896906671712337@build.alporthouse.com>
 <20200723182841.GS10769@hirez.programming.kicks-ass.net>
 <159553326368.21069.3167204000119437062@build.alporthouse.com>
 <20200723201128.GT10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723201128.GT10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:11:28PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 23, 2020 at 08:41:03PM +0100, Chris Wilson wrote:
> 
> > I am very sorry for the wild goose chase.
> 
> *phew*... all good then. I was starting to go a little ga-ga trying to
> make sense of things.
> 
> Arguably we should probably do something like:
> 
> 
> @@ -4555,7 +4572,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
>  int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
>  			  void *key)
>  {
> -	return try_to_wake_up(curr->private, mode, wake_flags);
> +	return try_to_wake_up(curr->private, mode, wake_flags & WF_SYNC);
>  }
>  EXPORT_SYMBOL(default_wake_function);

If you do:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

This was about nine hours of each of the default rcutorture scenarios.

							Thanx, Paul

> Since I don't think anybody uses anything other than WF_SYNC, ever. And
> the rest of the WF_flags are used internally.
> 
> Thanks Chris!
