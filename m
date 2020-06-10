Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0213C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9EB20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797734;
	bh=m7fwL2s3oo3ksb2uIqUu7XXyQ5rFyLDlOvrHcGsZF/o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SsD572CikqfjELrzafHyyNUi3zbh+BJjKaUSul1UM2ZXWJEZg1mrQNFfQbXjLCQj5
	 2dYpyn7mpcf1lLD5hInPo390G3X1p/0wqAw9BQKuzVPYrbsGqrwAoutB8h7mYuoKGG
	 5WDnShqbxFDdlqEodCHZtgdIrYZuguFxWvnQ7z1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgFJOCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgFJOCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:02:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4722078C;
        Wed, 10 Jun 2020 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591797731;
        bh=m7fwL2s3oo3ksb2uIqUu7XXyQ5rFyLDlOvrHcGsZF/o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FdMOd8XvtdGKDQUmOxPLPzcySK9mKpOernId4CifPFoLoUZSwDqxTaYLV65JjkaCD
         zkIWTJOurym3796yQyUWORGgnitWTztypIdT5ecsX1tRSgRdkn1vG3tHNwNmzwKBiq
         kbLq8A2WoQ5cbTr6NCTxZTzMFn3YFnJpVxej2jMk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D950A352265A; Wed, 10 Jun 2020 07:02:10 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:02:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200610140210.GT4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200604114121.GA26398@lenoir>
 <20200604163655.GC29598@paulmck-ThinkPad-P72>
 <20200608125715.GA30920@lenoir>
 <20200609180227.GR4455@paulmck-ThinkPad-P72>
 <20200610131238.GA26639@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610131238.GA26639@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 03:12:39PM +0200, Frederic Weisbecker wrote:
> On Tue, Jun 09, 2020 at 11:02:27AM -0700, Paul E. McKenney wrote:
> > > > > And anyway we still want to unconditionally lock on many places,
> > > > > regardless of the offloaded state. I don't know how we could have
> > > > > a magic helper do the unconditional lock on some places and the
> > > > > conditional on others.
> > > > 
> > > > I was assuming (perhaps incorrectly) that an intermediate phase between
> > > > not-offloaded and offloaded would take care of all of those cases.
> > > 
> > > Perhaps partly but I fear that won't be enough.
> > 
> > One approach is to rely on RCU read-side critical sections surrounding
> > the lock acquisition and to stay in the intermediate phase until a grace
> > period completes, preferably call_rcu() instead of synchronize_rcu().
> > 
> > This of course means refusing to do a transition if the CPU is still
> > in the intermediate state from a prior transition.
> 
> That sounds good. But using synchronize_rcu() would be far easier. We
> need to keep the hotplug and rcu barrier locked during the transition.
> 
> > > Also I've been thinking that rcu_nocb_lock() should meet any of these
> > > requirements:
> > > 
> > > * hotplug is locked
> > > * rcu barrier is locked
> > > * rnp is locked
> > > 
> > > Because checking the offloaded state (when nocb isn't locked yet) of
> > > an rdp without any of the above locks held is racy. And that should
> > > be easy to check and prevent from copy-pasta accidents.
> > > 
> > > What do you think?
> > 
> > An RCU read-side critical section might be simpler.
> 
> Ok I think I can manage that.

And just to argue against myself...

Another approach is to maintain explicit multiple states for each
->cblist, perhaps something like this:

1.	In softirq.  Transition code advances to next.
2.	To no-CB 1.  Either GP or CB kthread for the transitioning
	CPU advances to next.  Note that the fact that the
	transition code runs on the transitioning CPU means that
	the RCU softirq handler doesn't need to be involved.
3.	To no-CB 2.  Either GP or CB kthread for the transitioning
	CPU advances to next.
4.	To no-CB 3.  Transitioning code advances to next.
	At this point, the no-CBs setup is fully functional.
5.	No-CB.  Transitioning code advances to next.
	Again, the fact that the transitioning code is running
	on the transitioning CPU with interrupts disabled means
	that the RCU softirq handler need not be explicitly
	involved.
6.	To softirq 1.  The RCU softirq handler for the transitioning
	CPU advances to next.
	At this point, the RCU softirq handler is processing callbacks.
7.	To softirq 2.  Either GP or CB kthread for the transitioning
	CPU advances to next.
	At this point, the softirq handler is processing callbacks.
8.	To softirq 3.  Either GP or CB kthread for the transitioning
	CPU advances to next.
	At this point, the no-CBs setup is fully shut down.
9.	To softirq 4.  Transitioning code advances to next,
	which is the first, "In softirq".
	(This one -might- be unnecessary, but...)

All transitions are of course with the ->nocb_lock held.

When there is only one CPU during early boot near rcu_init() time,
the transition from "In softirq" to "No-CB" can remain be instantaneous.

This has the advantage of not slowing things down just because there
is an RCU callback flood in progress.  It also uses an explicit
protocol that should (give or take bugs) maintain full safety both
in protection of ->cblist and in dealing with RCU callback floods.

Thoughts?

							Thanx, Paul
