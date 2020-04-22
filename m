Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CF0C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE34A2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587570609;
	bh=ez7+ZsWjDbKtPTHLw+h/ZrnG00It65erPt+3scOnxEI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aISpwQVcq1N113rGFFr+ahOV2azWT1HnIGYcOR9ZLWpGJgiV1oO3KAT+fnYzpAZYx
	 C4nGuY5rU59BUIIy/4qFJRphPznBuRLr3PgtThT9gINdy/hKEXnXLuVsyyiuua0ren
	 LznEeAykocfxEO3jdyA5JYOSdVCll3EPO/0Cs7D4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDVPuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgDVPuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:50:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1CB20767;
        Wed, 22 Apr 2020 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587570608;
        bh=ez7+ZsWjDbKtPTHLw+h/ZrnG00It65erPt+3scOnxEI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N319B63a8bPYR1tPct/qnNKws4vGPRf7xGiJPSfc5mpsTEdUfvKZZ0svx6z4r/7ha
         UncFjsX/iCEj+1bpXMVvqQirWXHX1XPIIqD95XzMVmsOj9yqrQ/zgBJWucHXnVU2An
         TdnzeGHQtp+e9NqC810NhqaKAUBIIoOxNr8JSBCw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9A3FC35203BC; Wed, 22 Apr 2020 08:50:06 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:50:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, airlied@redhat.com,
        alexander.deucher@amd.com, awalls@md.metrocast.net,
        axboe@kernel.dk, broonie@kernel.org, daniel.lezcano@linaro.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        herbert@gondor.apana.org.au, hverkuil@xs4all.nl,
        john.stultz@linaro.org, nico@fluxnic.net,
        rafael.j.wysocki@intel.com, rmk+kernel@arm.linux.org.uk,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH 01/23] sched: Provide sched_set_fifo()
Message-ID: <20200422155006.GR17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112831.266499893@infradead.org>
 <20200422131138.GL17661@paulmck-ThinkPad-P72>
 <20200422132648.GJ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422132648.GJ20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:26:48PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 22, 2020 at 06:11:38AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 22, 2020 at 01:27:20PM +0200, Peter Zijlstra wrote:
> > > SCHED_FIFO (or any static priority scheduler) is a broken scheduler
> > > model; it is fundamentally incapable of resource management, the one
> > > thing an OS is actually supposed to do.
> > > 
> > > It is impossible to compose static priority workloads. One cannot take
> > > two well designed and functional static priority workloads and mash
> > > them together and still expect them to work.
> > > 
> > > Therefore it doesn't make sense to expose the priority field; the
> > > kernel is fundamentally incapable of setting a sensible value, it
> > > needs systems knowledge that it doesn't have.
> > > 
> > > Take away sched_setschedule() / sched_setattr() from modules and
> > > replace them with:
> > > 
> > >   - sched_set_fifo(p); create a FIFO task (at prio 50)
> > >   - sched_set_fifo_low(p); create a task higher than NORMAL,
> > > 	which ends up being a FIFO task at prio 1.
> > >   - sched_set_normal(p, nice); (re)set the task to normal
> > > 
> > > This stops the proliferation of randomly chosen, and irrelevant, FIFO
> > > priorities that dont't really mean anything anyway.
> > > 
> > > The system administrator/integrator, whoever has insight into the
> > > actual system design and requirements (userspace) can set-up
> > > appropriate priorities if and when needed.
> > 
> > The sched_setscheduler_nocheck() calls in rcu_spawn_gp_kthread(),
> > rcu_cpu_kthread_setup(), and rcu_spawn_one_boost_kthread() all stay as
> > is because they all use the rcutree.kthread_prio boot parameter, which is
> > set at boot time by the system administrator (or {who,what}ever, correct?
> 
> Correct, also they are not modular afaict, so they escaped the dance ;-)

Indeed, an extreme form of insanity would be required to try to make core
RCU be a module.  Not that such a form of insanity is a bad thing in and
of itself, but it might best be directed towards less futile ventures.  ;-)

							Thanx, Paul
