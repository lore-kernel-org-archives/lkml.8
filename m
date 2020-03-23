Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4AEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1F20637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584989080;
	bh=Kzx3A5UWmIWovbncaX0AahHUgcZbrG2Nc461wCnKfwk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=VYQ3TCp8LGQrsi82MjJ4zl8/Ff+Yp4SSRd38dhG8nBW8uuUmBfbRjBif55n6SbZ+d
	 Lbr1mAzBw7s1nbWkFJWJ0XH9zXvVf0zCdSCGoRCl8GGwK0+flnlV6fCYipDYrgoFxQ
	 ziu7TpU+4ZxBIZiyn3xe2LU6ST4BLwSiZVcptDK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCWSoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgCWSoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:44:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BC5205ED;
        Mon, 23 Mar 2020 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584989077;
        bh=Kzx3A5UWmIWovbncaX0AahHUgcZbrG2Nc461wCnKfwk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HGcMxffRz9jEy8yWa3ctDUx7PtXxT2h3UVNjFIXuTSiqt140I75PoxluuIrtGUj1e
         h308ERwYz+HCtHeJtw2rfXVh0VX+652VziLLVk0/v3MkFO4Inhz1jZ+mMmCKCsouqY
         d1yrLOGHCXEl1ELT8QxCrjXpcnUuXdoDx0T6jhYw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3DE4A35226D5; Mon, 23 Mar 2020 11:44:37 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:44:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Hit WARN_ON() in rcutorture.c:1055
Message-ID: <20200323184437.GP3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323154309.nah44so2556ee56g@e107158-lin.cambridge.arm.com>
 <20200323155731.GK3199@paulmck-ThinkPad-P72>
 <20200323170609.w64xrfahd2snfz6h@e107158-lin.cambridge.arm.com>
 <20200323171751.GL3199@paulmck-ThinkPad-P72>
 <20200323174147.lneh4rp4tazhtm6x@e107158-lin.cambridge.arm.com>
 <20200323181010.GN3199@paulmck-ThinkPad-P72>
 <20200323182351.xr764b6wafzs6fse@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323182351.xr764b6wafzs6fse@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:23:51PM +0000, Qais Yousef wrote:
> On 03/23/20 11:10, Paul E. McKenney wrote:
> > On Mon, Mar 23, 2020 at 05:41:48PM +0000, Qais Yousef wrote:
> > > On 03/23/20 10:17, Paul E. McKenney wrote:
> > > > On Mon, Mar 23, 2020 at 05:06:10PM +0000, Qais Yousef wrote:
> > > > > On 03/23/20 08:57, Paul E. McKenney wrote:
> > > > > > On Mon, Mar 23, 2020 at 03:43:09PM +0000, Qais Yousef wrote:
> > > > > > > Hi
> > > > > > > 
> > > > > > > I hit the following warning while running rcutorture tests. It only happens
> > > > > > > when I try to hibernate the system (arm64 Juno-r2).
> > > > > > 
> > > > > > Hibernating the system during rcutorture tests.  Now that is gutsy!  ;-)
> > > > > 
> > > > > Hehe was just a side effect of testing the cpu hotplug stuff :-)
> > > > > 
> > > > > > 
> > > > > > > Let me know if you need additional info.
> > > > > > 
> > > > > > 1.	Do you need this to work?  If so, please tell me your use case.
> > > > > 
> > > > > Nope. It just happened while trying to stress the cpu hotplug series I just
> > > > > posted.
> > > > > 
> > > > > > 2.	What is line 1055 of your rcutorture.c?  Here is my guess:
> > > > > 
> > > > > It's 5.6-rc6, sorry should have mentioned in the report.
> > > > > 
> > > > > 		/* Cycle through nesting levels of rcu_expedite_gp() calls. */
> > > > > 		if (can_expedite &&
> > > > > 		    !(torture_random(&rand) & 0xff & (!!expediting - 1))) {
> > > > > 			WARN_ON_ONCE(expediting == 0 && rcu_gp_is_expedited());
> > > > > 			if (expediting >= 0)
> > > > > 				rcu_expedite_gp();
> > > > > 			else
> > > > > 				rcu_unexpedite_gp();
> > > > > 			if (++expediting > 3)
> > > > > 				expediting = -expediting;
> > > > > 		} else if (!can_expedite) { /* Disabled during boot, recheck. */
> > > > > 
> > > > > If it's something you don't care about, then I don't care about too. I just
> > > > > thought I'd report it in case it uncovered something worthwhile.
> > > > 
> > > > Well, my guess was wrong.  ;-)
> > > > 
> > > > This is instead rcutorture being surprised by the fact that RCU grace
> > > > periods are expedited during the hibernate process.  I could fix this
> > > > particular situation, but I bet that there are a number of others,
> > > > including my guess above.
> > > > 
> > > > One approach would be to halt rcutorture testing just before hibernating
> > > > and restart it just after resuming.
> > > > 
> > > > Thoughts?
> > > 
> > > {register, unregister}_pm_notifier() don't seem to be too hard to use.
> > 
> > That part is easy.  It would also be necessary to find all the affected
> > warnings in rcutorture and suppress them, not only during this time,
> > but also for some period of time afterwards.  Maybe this is the only one,
> > but that would be surprising.  ;-)
> 
> Wouldn't be easier to just deinit/init()? ie: treat it like unload/load module.
> 
> But you'll lose some info then that maybe you'd like to keep across
> suspend/resume cycles.

Hmmm...  Are you running rcutorture as a loadable module or built into
your kernel?  In the latter case, it starts up automatically shortly
after boot.

> > > But if it's not that simple, then it's not worthwhile I'd say. The report
> > > lives in LKML as a documentation of this missing support :-P
> > 
> > It might at some point be necessary for rcutorture to handle suspends
> > and hibernates in midstream, and yes, it could be done, but first I need
> > to see some reason why it provides significant help.
> 
> Sounds reasonable to me. I agree my use case isn't sensible in general. It just
> happened because I was testing an operation that affected both hibernation and
> rcutorture test and I tend to compile my kernels with everything built-in.

Don't get me wrong, I am very happy to see people making use of
rcutorture!  ;-)

								Thanx, Paul
