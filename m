Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0257FC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D046120787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DTSszN7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDVN1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDVN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:27:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B1C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gjLk9T8BGNqyiWa+uxHPrqixf8yW/93L5sAqBSW+8eY=; b=DTSszN7YNy78HwkU174Co33LCh
        USOWZZbZNI6GPYfBtVV0Wahyg+sXLcLRLlejgT6Dmt6kHWe8PZk1V0DluYIG9/XKdqLF7IWcZsE6y
        6tLsVwqckW4A360d+H6pt6LRbT2Gcb/HWE5eAOpV3SPKZBhpBgZNbefsvLuQNcOcvTvOMowDcH6d9
        obZJ0BsIVifM+2rD+dFxSyYJdoGiEhTu+WAu9YEsTlMBC8UcsbG5x5yTuWdVeQ6IrBWwO0Y0h0HiI
        s29M4uRRg5bO7VXDrFuJhrX4ZGPBpLwjfwOnaVujl0h2ZHjuPtiOWZa58SXEs1T4O+4dlpinSLly2
        Phx6ehLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRFOt-0007PS-NU; Wed, 22 Apr 2020 13:26:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E2B2306064;
        Wed, 22 Apr 2020 15:26:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7FF725E17E39; Wed, 22 Apr 2020 15:26:48 +0200 (CEST)
Date:   Wed, 22 Apr 2020 15:26:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200422132648.GJ20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.266499893@infradead.org>
 <20200422131138.GL17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422131138.GL17661@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:11:38AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 22, 2020 at 01:27:20PM +0200, Peter Zijlstra wrote:
> > SCHED_FIFO (or any static priority scheduler) is a broken scheduler
> > model; it is fundamentally incapable of resource management, the one
> > thing an OS is actually supposed to do.
> > 
> > It is impossible to compose static priority workloads. One cannot take
> > two well designed and functional static priority workloads and mash
> > them together and still expect them to work.
> > 
> > Therefore it doesn't make sense to expose the priority field; the
> > kernel is fundamentally incapable of setting a sensible value, it
> > needs systems knowledge that it doesn't have.
> > 
> > Take away sched_setschedule() / sched_setattr() from modules and
> > replace them with:
> > 
> >   - sched_set_fifo(p); create a FIFO task (at prio 50)
> >   - sched_set_fifo_low(p); create a task higher than NORMAL,
> > 	which ends up being a FIFO task at prio 1.
> >   - sched_set_normal(p, nice); (re)set the task to normal
> > 
> > This stops the proliferation of randomly chosen, and irrelevant, FIFO
> > priorities that dont't really mean anything anyway.
> > 
> > The system administrator/integrator, whoever has insight into the
> > actual system design and requirements (userspace) can set-up
> > appropriate priorities if and when needed.
> 
> The sched_setscheduler_nocheck() calls in rcu_spawn_gp_kthread(),
> rcu_cpu_kthread_setup(), and rcu_spawn_one_boost_kthread() all stay as
> is because they all use the rcutree.kthread_prio boot parameter, which is
> set at boot time by the system administrator (or {who,what}ever, correct?

Correct, also they are not modular afaict, so they escaped the dance ;-)


