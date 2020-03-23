Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22241C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081E52072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCWRlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:41:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCWRlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:41:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33CF41FB;
        Mon, 23 Mar 2020 10:41:51 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8505A3F7C3;
        Mon, 23 Mar 2020 10:41:50 -0700 (PDT)
Date:   Mon, 23 Mar 2020 17:41:48 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Hit WARN_ON() in rcutorture.c:1055
Message-ID: <20200323174147.lneh4rp4tazhtm6x@e107158-lin.cambridge.arm.com>
References: <20200323154309.nah44so2556ee56g@e107158-lin.cambridge.arm.com>
 <20200323155731.GK3199@paulmck-ThinkPad-P72>
 <20200323170609.w64xrfahd2snfz6h@e107158-lin.cambridge.arm.com>
 <20200323171751.GL3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323171751.GL3199@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 10:17, Paul E. McKenney wrote:
> On Mon, Mar 23, 2020 at 05:06:10PM +0000, Qais Yousef wrote:
> > On 03/23/20 08:57, Paul E. McKenney wrote:
> > > On Mon, Mar 23, 2020 at 03:43:09PM +0000, Qais Yousef wrote:
> > > > Hi
> > > > 
> > > > I hit the following warning while running rcutorture tests. It only happens
> > > > when I try to hibernate the system (arm64 Juno-r2).
> > > 
> > > Hibernating the system during rcutorture tests.  Now that is gutsy!  ;-)
> > 
> > Hehe was just a side effect of testing the cpu hotplug stuff :-)
> > 
> > > 
> > > > Let me know if you need additional info.
> > > 
> > > 1.	Do you need this to work?  If so, please tell me your use case.
> > 
> > Nope. It just happened while trying to stress the cpu hotplug series I just
> > posted.
> > 
> > > 2.	What is line 1055 of your rcutorture.c?  Here is my guess:
> > 
> > It's 5.6-rc6, sorry should have mentioned in the report.
> > 
> > 		/* Cycle through nesting levels of rcu_expedite_gp() calls. */
> > 		if (can_expedite &&
> > 		    !(torture_random(&rand) & 0xff & (!!expediting - 1))) {
> > 			WARN_ON_ONCE(expediting == 0 && rcu_gp_is_expedited());
> > 			if (expediting >= 0)
> > 				rcu_expedite_gp();
> > 			else
> > 				rcu_unexpedite_gp();
> > 			if (++expediting > 3)
> > 				expediting = -expediting;
> > 		} else if (!can_expedite) { /* Disabled during boot, recheck. */
> > 
> > If it's something you don't care about, then I don't care about too. I just
> > thought I'd report it in case it uncovered something worthwhile.
> 
> Well, my guess was wrong.  ;-)
> 
> This is instead rcutorture being surprised by the fact that RCU grace
> periods are expedited during the hibernate process.  I could fix this
> particular situation, but I bet that there are a number of others,
> including my guess above.
> 
> One approach would be to halt rcutorture testing just before hibernating
> and restart it just after resuming.
> 
> Thoughts?

{register, unregister}_pm_notifier() don't seem to be too hard to use.

But if it's not that simple, then it's not worthwhile I'd say. The report
lives in LKML as a documentation of this missing support :-P

Thanks

--
Qais Yousef
