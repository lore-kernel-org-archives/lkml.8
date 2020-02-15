Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44DCC4741C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 10:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC73E2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581764287;
	bh=8Vjv/lv2op4qINIa0AVJhDucTZu4NRTV0d1OgtzZmEM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FnJ7wMrolOuZBlLnfIaEtfFmj/N04AvqDDlJ2fKEt696dkCsWmnLKJrqwN4UuIdrM
	 NfZU+hUPriw0bdv+1KAic6DODKJ6vzn7ja6G7esZ7a2lAzA2XYqNn/bQQzo5ImkvmX
	 GAVDSr6nPBFztPFHFJeKam5nUgaaiTyrQ6TzNwKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgBOK6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 05:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgBOK6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 05:58:05 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB4C20726;
        Sat, 15 Feb 2020 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581764284;
        bh=8Vjv/lv2op4qINIa0AVJhDucTZu4NRTV0d1OgtzZmEM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ptCws8HtjKpK2tpsJ3AMQLf03GhR1BKeGrC2ISsKzG8QxU3fVhetQGNgHpi5rwQ7d
         gZ1GcYXOoH9jSQIDoK+0Esk40sDNOkptSitHND8ADkJNsUknIsbV7Vw3OSobQqhf9u
         8jwxjxE6KTypK9A332F/eqV38X+aBnLqdrTjp2ZY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2ABAE3520CAA; Sat, 15 Feb 2020 02:58:03 -0800 (PST)
Date:   Sat, 15 Feb 2020 02:58:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 06/30] rcu: Add WRITE_ONCE to rcu_node
 ->exp_seq_rq store
Message-ID: <20200215105803.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
 <20200214235607.13749-6-paulmck@kernel.org>
 <20200214224743.280772a7@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214224743.280772a7@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:47:43PM -0500, Steven Rostedt wrote:
> On Fri, 14 Feb 2020 15:55:43 -0800
> paulmck@kernel.org wrote:
> 
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The rcu_node structure's ->exp_seq_rq field is read locklessly, so
> > this commit adds the WRITE_ONCE() to a load in order to provide proper
> > documentation and READ_ONCE()/WRITE_ONCE() pairing.
> > 
> > This data race was reported by KCSAN.  Not appropriate for backporting
> > due to failure being unlikely.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree_exp.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index d7e0484..85b009e 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -314,7 +314,7 @@ static bool exp_funnel_lock(unsigned long s)
> >  				   sync_exp_work_done(s));
> >  			return true;
> >  		}
> > -		rnp->exp_seq_rq = s; /* Followers can wait on us. */
> > +		WRITE_ONCE(rnp->exp_seq_rq, s); /* Followers can wait on us. */
> 
> Didn't Linus say this is basically bogus?
> 
> Perhaps just using it as documenting that it's read locklessly, but is
> it really needed?

Yes, Linus explicitly stated that WRITE_ONCE() is not required in
this case, but he also said that he was OK with it being there for
documentation purposes.

And within RCU, I -do- need it because I absolutely need to see if a
given patch introduced new KCSAN reports.  So I need it for the same
reason that I need the build to proceed without warnings.

Others who are working with less concurrency-intensive code might quite
reasonably make other choices, of course.  And my setting certain KCSAN
config options in my own builds doesn't inconvenience them, so we should
all be happy, right?  :-)

							Thanx, Paul

> -- Steve
> 
> 
> 
> >  		spin_unlock(&rnp->exp_lock);
> >  		trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
> >  					  rnp->grplo, rnp->grphi, TPS("nxtlvl"));
> 
