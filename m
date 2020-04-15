Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB9CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA9F20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586991301;
	bh=bXxQU6IuZNZL59Z8TCcquyoG8MiLRK3KYG2b8JN4hjc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2PDvkIHF0pO4YnEBolZ3laXLcVHAxfr3mNpai0ga+O72wm75mcBIbZwzzV97q8mW3
	 FXj91qBjlyeYNYl5f3IypLOQY4uZKr7gz+zi7E4N12sdeufEfKwjuZcK/NRaLFX64n
	 cpNRjPEgt78DmR8gS9NXcfAKGPhy69dpPlitNwWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgDOWy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387549AbgDOWyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:54:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C87C2076D;
        Wed, 15 Apr 2020 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586991290;
        bh=bXxQU6IuZNZL59Z8TCcquyoG8MiLRK3KYG2b8JN4hjc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dIJcSHLmvB5yKUo0B5lQeYGT61/ZN9ijsAB+Y/UZD3/M+KrXIKKjSKpia9vh87kFF
         MHO7bJ5CIPlytUu9XCHi0WKx0c2VxYl4JCn+ySQx3RqpecZaOhmrpWXqt2fq9jrzhR
         X04+S4VYiffWR04aLvOWq+UXKeQwRDL31oO0SvQ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 46A893522AD1; Wed, 15 Apr 2020 15:54:50 -0700 (PDT)
Date:   Wed, 15 Apr 2020 15:54:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415225450.GG17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home>
 <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home>
 <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
 <20200415164116.40564f2c@gandalf.local.home>
 <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
 <20200415174918.154a86d0@gandalf.local.home>
 <20200415220459.GE17661@paulmck-ThinkPad-P72>
 <20200415185121.381a4bc3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415185121.381a4bc3@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:51:21PM -0400, Steven Rostedt wrote:
> On Wed, 15 Apr 2020 15:04:59 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Wed, Apr 15, 2020 at 05:49:18PM -0400, Steven Rostedt wrote:
> > > On Wed, 15 Apr 2020 14:02:04 -0700
> > > John Stultz <john.stultz@linaro.org> wrote:
> > >   
> > > > 
> > > > So in my case your concerns may not be a problem, but I guess
> > > > generally it might. Though I'd hope the callback would be unregistered
> > > > (and whatever waiting for the grace period to complete be done) before
> > > > the module removal is complete. But maybe I'm still missing your
> > > > point?  
> > > 
> > > Hmm, you may have just brought up a problem here...
> > > 
> > > You're saying that cpu_pm_register_notifier() callers are called from non
> > > RCU watching context? If that's the case, we have this:
> > > 
> > > int cpu_pm_unregister_notifier(struct notifier_block *nb)
> > > {
> > > 	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
> > > }
> > > 
> > > And this:
> > > 
> > > int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
> > > 		struct notifier_block *n)
> > > {
> > > 	unsigned long flags;
> > > 	int ret;
> > > 
> > > 	spin_lock_irqsave(&nh->lock, flags);
> > > 	ret = notifier_chain_unregister(&nh->head, n);
> > > 	spin_unlock_irqrestore(&nh->lock, flags);
> > > 	synchronize_rcu();
> > > 	return ret;
> > > }
> > > 
> > > Which means that if something registered a cpu_pm notifier, then
> > > unregistered it, and freed whatever the notifier accesses, then there's a
> > > chance that the synchronize_rcu() can return before the called notifier
> > > finishes, and anything that notifier accesses could have been freed.
> > > 
> > > I believe that module code should not be able to be run in RCU non watching
> > > context, and neither should notifiers. I think we just stumbled on a bug.
> > > 
> > > Paul?  
> > 
> > Or we say that such modules cannot be unloaded.  Or that such modules'
> > exit handlers, after disentangling themselves from the idle loop, must
> > invoke synchronize_rcu_rude() or similar, just as modules that use
> > call_rcu() are currently required to invoke rcu_barrier().
> > 
> > Or is it possible to upgrade the protection that modules use?
> > 
> > My guess is that invoking rcu_irq_enter() and rcu_irq_exit() around every
> > potential call into module code out of the PM code is a non-starter,
> > but I cannot prove that either way.
> >
> 
> No this has nothing to do with modules. This is a bug right now with the
> cpu_pm notifier (after looking at the code, it's not a bug right now, see
> below).
> 
> Say you have something that allocates some data and registers a
> callback to the cpu_pm notifier that access that data. Then for some
> reason, you want to remove that notifier and free the data. Usually you
> would do:
> 
> 	cpu_pm_unregister_notifier(my_notifier);
> 	kfree(my_data);
> 
> But the problem is that the callback of that my_notifier could be executing
> in a RCU non-watching space, and the cpu_pm_unregister_notifier() can
> return before the my_notifier is done, and the my_data is freed. Then the
> callback for the my_notifier could still be accessing the my_data.
> 
> 
> /me goes and reads the code and sees this is not an issue, and you can
> ignore the above concern.
> 
> I was about to suggest a patch, but that has already been written...
> 
> 313c8c16ee62b ("PM / CPU: replace raw_notifier with atomic_notifier")
> 
> Which surrounds the notifier callbacks with rcu_irq_enter_irqson()
> 
> Which means that if John moves the code to use the notifier, then he could
> also remove the _rcuidle(), because RCU will be watching.

Whew!!!  ;-)

							Thanx, Paul
