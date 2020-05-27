Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACF3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2223620899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590541089;
	bh=s1vKcZ8fL6cirhrfsNXQiB0jbuV/0UBSm4x3lyaMVpU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=b/rUkNkkt0aK83Xld6ZcGHhO0pUdvVxb8ZBdS/8SLdyOewnXCrB/1/Wm1oTYvHib7
	 oXN4fdK2dKxlHBjQ23D18AD/a5R7shYxPNGaRbqYl0oib3x5RPki7bYzQrYYJ10Aeb
	 qBds4xRLLWrwlQOflHMjfNQ8v7UyBxvxghLKaprQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgE0A6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 20:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgE0A6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:58:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2BAB20888;
        Wed, 27 May 2020 00:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541087;
        bh=s1vKcZ8fL6cirhrfsNXQiB0jbuV/0UBSm4x3lyaMVpU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xQexO1Xu7MnTwC5t7Qq/LGbxB0cRzDR2ocDd6LPL+Ihto0koV9M6CltRsZeIjVjAk
         pZLKkqTyqYxxDWqQvm5Pf+WniiI25h+PUdyLPvX5fBvleeS4FT8YoZF8eXKGhez/MK
         5M1/4+Fb8/daG9rOUJSW8jsfsUYw9LGAY0cVRM2c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D5D86352283D; Tue, 26 May 2020 17:58:06 -0700 (PDT)
Date:   Tue, 26 May 2020 17:58:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200527005806.GR2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200526152137.GB76276@google.com>
 <20200526162946.GK2869@paulmck-ThinkPad-P72>
 <20200526201840.GC76276@google.com>
 <20200526210947.GP2869@paulmck-ThinkPad-P72>
 <20200526212756.GF76276@google.com>
 <20200526222900.GQ2869@paulmck-ThinkPad-P72>
 <CAEXW_YSvdJYGL2fKwsMK3nL+AHVzip8g+GMEPjM69ARBq=+8TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSvdJYGL2fKwsMK3nL+AHVzip8g+GMEPjM69ARBq=+8TQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:45:42PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Tue, May 26, 2020 at 6:29 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, May 26, 2020 at 05:27:56PM -0400, Joel Fernandes wrote:
> > > On Tue, May 26, 2020 at 02:09:47PM -0700, Paul E. McKenney wrote:
> > > [...]
> > > > > > > BTW, I'm really itching to give it a try to make the scheduler more deadlock
> > > > > > > resilient (that is, if the scheduler wake up path detects a deadlock, then it
> > > > > > > defers the wake up using timers, or irq_work on its own instead of passing
> > > > > > > the burden of doing so to the callers). Thoughts?
> > > > > >
> > > > > > I have used similar approaches within RCU, but on the other hand the
> > > > > > scheduler often has tighter latency constraints than RCU does.  So I
> > > > > > think that is a better question for the scheduler maintainers than it
> > > > > > is for me.  ;-)
> > > > >
> > > > > Ok, it definitely keeps coming up in my radar first with the
> > > > > rcu_read_unlock_special() stuff, and now the nocb ;-). Perhaps it could also
> > > > > be good for a conference discussion!
> > > >
> > > > Again, please understand that RCU has way looser latency constraints
> > > > than the scheduler does.  Adding half a jiffy to wakeup latency might
> > > > not go over well, especially in the real-time application area.
> > >
> > > Yeah, agreed that the "deadlock detection" code should be pretty light weight
> > > if/when it is written.
> >
> > In addition, to even stand a chance, you would need to use hrtimers.
> > The half-jiffy (at a minimum) delay from any other deferral mechanism
> > that I know of would be the kiss of death, especially from the viewpoint
> > of the real-time guys.
> 
> Just to make sure we are talking about the same kind of overhead - the
> deferring is only needed if the rq lock is already held (detected by
> trylocking). So there's no overhead in the common case other than the
> trylock possibly being slightly more expensive than the regular
> locking. Also, once the scheduler defers it, it uses the same kind of
> mechanism that other deferral mechanisms use to overcome this deadlock
> (timers, irq_work etc), so the overhead then would be no different
> than what he have now - the RT users would already have the wake up
> latency in current kernels without this idea implemented. Did I miss
> something?

Aggressive real-time applications care deeply about the uncommon case.

							Thanx, Paul

> > > > But what did the scheduler maintainers say about this idea?
> > >
> > > Last I remember when it came up during the rcu_read_unlock_special() deadlock
> > > discussions, there's no way to know for infra like RCU to know that it was
> > > invoked from the scheduler.
> > >
> > > The idea I am bringing up now (about the scheduler itself detecting a
> > > recursion) was never brought up (not yet) with the sched maintainers (at
> > > least not by me).
> >
> > It might be good to bounce if off of them sooner rather than later.
> 
> Ok, I did that now over IRC. Thank you!
> 
>  - Joel
