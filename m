Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5822EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FEB2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589471277;
	bh=x6s1E+XROP/HiuUxOMycOoCvxjDKnPS1UbGWfOMKnCA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OKb48BWsH6kgFruoy6sFKaxfIHNqIn+1ORKEuI96/gAO5o7QbRZvdzaJja+tOHZZ9
	 XqBMwfYpPbzJ1S8Sd+K2P9p50K/poAdpkgn0w2v5/i3XPFKdpHWVxSe5K8Ia5m4Y+j
	 KT8ha0LwGUldfKrpE1tlKBbFqNMq6PutA6pLi7Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgENPr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgENPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:47:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1542420657;
        Thu, 14 May 2020 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589471275;
        bh=x6s1E+XROP/HiuUxOMycOoCvxjDKnPS1UbGWfOMKnCA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b6Pi2ErAe9bOmJkaLrmAPcJV/MEsaEge68OojgxVidZNqp3v6d941ttkf9V/N+DnL
         9mx2J0Ar/r5sW+TqTaJmPuJ20qDq7e3FFx1Mx/aiuydUxT/W3hK94xQVKAqWIkt4oz
         X8NV94wCAjwP+7P6W0IKQUcuHp0CaYpB2t4LNHFk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1BF335229C5; Thu, 14 May 2020 08:47:54 -0700 (PDT)
Date:   Thu, 14 May 2020 08:47:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 04/10] rcu: Implement rcu_segcblist_is_offloaded() config
 dependent
Message-ID: <20200514154754.GM2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-5-frederic@kernel.org>
 <20200513182029.GT2869@paulmck-ThinkPad-P72>
 <20200513230330.GB18303@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513230330.GB18303@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:03:31AM +0200, Frederic Weisbecker wrote:
> On Wed, May 13, 2020 at 11:20:29AM -0700, Paul E. McKenney wrote:
> > On Wed, May 13, 2020 at 06:47:08PM +0200, Frederic Weisbecker wrote:
> > > This simplify the usage of this API and avoid checking the kernel
> > > config from the callers.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > ---
> > >  include/linux/rcu_segcblist.h |  2 ++
> > >  kernel/rcu/rcu_segcblist.c    |  2 ++
> > >  kernel/rcu/rcu_segcblist.h    |  6 ++++++
> > >  kernel/rcu/tree.c             | 21 +++++++--------------
> > >  4 files changed, 17 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > > index b36afe7b22c9..0ced0a0ecbcf 100644
> > > --- a/include/linux/rcu_segcblist.h
> > > +++ b/include/linux/rcu_segcblist.h
> > > @@ -73,7 +73,9 @@ struct rcu_segcblist {
> > >  	long len;
> > >  #endif
> > >  	u8 enabled;
> > > +#ifdef CONFIG_RCU_NOCB_CPU
> > >  	u8 offloaded;
> > > +#endif
> > 
> > Given that this is only one byte and that removing it won't actually
> > save any memory on most architectures, why not just leave it and
> > adjust as shown below?
> 
> Right, the point was to make it private to that config and trigger
> a build error otherwise. But if we have an off case that's fine.
> 
> > 
> > >  };
> > >  
> > >  #define RCU_SEGCBLIST_INITIALIZER(n) \
> > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > index 9a0f66133b4b..d8ea2bef5574 100644
> > > --- a/kernel/rcu/rcu_segcblist.c
> > > +++ b/kernel/rcu/rcu_segcblist.c
> > > @@ -166,6 +166,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
> > >  	rsclp->enabled = 0;
> > >  }
> > >  
> > > +#ifdef CONFIG_RCU_NOCB_CPU
> > >  /*
> > >   * Mark the specified rcu_segcblist structure as offloaded.  This
> > >   * structure must be empty.
> > > @@ -174,6 +175,7 @@ void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
> > >  {
> > >  	rsclp->offloaded = 1;
> > >  }
> > > +#endif
> > 
> > Leave this unconditional, as it is nowhere near a fastpath.
> 
> The point was to not raise false hopes to those who want to
> offload when it's not supported.
> 
> Let's perhaps have at least a WARN_ON_ONCE(1) if it is called
> when !CONFIG_RCU_NOCB_CPU ?

Sounds like a good choice to me!

> > >  /*
> > >   * Does the specified rcu_segcblist structure contain callbacks that
> > > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > > index 5c293afc07b8..4c1503a82492 100644
> > > --- a/kernel/rcu/rcu_segcblist.h
> > > +++ b/kernel/rcu/rcu_segcblist.h
> > > @@ -62,7 +62,11 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
> > >  /* Is the specified rcu_segcblist offloaded?  */
> > >  static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
> > >  {
> > > +#ifdef CONFIG_RCU_NOCB_CPU
> > >  	return rsclp->offloaded;
> > > +#else
> > > +	return false;
> > > +#endif
> > >  }
> > 
> > Then this can just be:
> > 
> > 	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
> 
> Ok.
> 
> > > @@ -1401,8 +1401,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
> > >  {
> > >  	bool ret = false;
> > >  	bool need_qs;
> > > -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> > > -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> > > +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
> > 
> > The adjustment to rcu_segcblist_is_offloaded() allows this (welcome!)
> > simplification to remain.
> 
> Ok thanks!
> 
> > > @@ -3243,8 +3237,7 @@ static int rcu_pending(int user)
> > >  
> > >  	/* Has RCU gone idle with this CPU needing another grace period? */
> > >  	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
> > > -	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
> > > -	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
> > > +	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
> > 
> > Ditto.
> > 
> > As in "Why didn't I do it that way to start with???"  ;-)
> 
> You say that to someone who's too lazy to script short commands typed
> 100 times a day ;-)

;-) ;-) ;-)

							Thanx, Paul
