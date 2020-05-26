Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19470C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CB1208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590532141;
	bh=8GHrdZXRVOoD1gF4tgVG0XshmastkOobedaTmUEsRag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Z3rmrgdZP1Zo6O8mf8muhL3VNgozuofKOipvRq25iqmYbeFz8DyxVKYpcj6JiVhuU
	 mxLc0l4bIGjSquggfzddit8RrPoFoWSgMs4Zlvrt/dv8Gwf+zIKsAKC7XFNNmoryj8
	 FhFQKRJWpUbpmZLpRf697wrfN7i8bA1fDzDTxFBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391974AbgEZW3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389889AbgEZW3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:29:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487A62088E;
        Tue, 26 May 2020 22:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590532140;
        bh=8GHrdZXRVOoD1gF4tgVG0XshmastkOobedaTmUEsRag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Iz6UWmVC4Vy3h2NzRiIfnh+L+CSF6bB1kU+LxfqSsRTVYlvdHuiEaH2nuSBqGb15R
         tNza6HIh+grxJeQ5eMO7OFbY3Xkjlu4BQztHc/hLTz/gTvZPl9HN1uI0n580HEwNUS
         jZMWrYXVDr34+ryJgUbzr9p4Q3P6oQNYp9CmXPbA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2F64A3522C79; Tue, 26 May 2020 15:29:00 -0700 (PDT)
Date:   Tue, 26 May 2020 15:29:00 -0700
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
Message-ID: <20200526222900.GQ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200526152137.GB76276@google.com>
 <20200526162946.GK2869@paulmck-ThinkPad-P72>
 <20200526201840.GC76276@google.com>
 <20200526210947.GP2869@paulmck-ThinkPad-P72>
 <20200526212756.GF76276@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526212756.GF76276@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:27:56PM -0400, Joel Fernandes wrote:
> On Tue, May 26, 2020 at 02:09:47PM -0700, Paul E. McKenney wrote:
> [...]
> > > > > BTW, I'm really itching to give it a try to make the scheduler more deadlock
> > > > > resilient (that is, if the scheduler wake up path detects a deadlock, then it
> > > > > defers the wake up using timers, or irq_work on its own instead of passing
> > > > > the burden of doing so to the callers). Thoughts?
> > > > 
> > > > I have used similar approaches within RCU, but on the other hand the
> > > > scheduler often has tighter latency constraints than RCU does.	So I
> > > > think that is a better question for the scheduler maintainers than it
> > > > is for me.  ;-)
> > > 
> > > Ok, it definitely keeps coming up in my radar first with the
> > > rcu_read_unlock_special() stuff, and now the nocb ;-). Perhaps it could also
> > > be good for a conference discussion!
> > 
> > Again, please understand that RCU has way looser latency constraints
> > than the scheduler does.  Adding half a jiffy to wakeup latency might
> > not go over well, especially in the real-time application area.
> 
> Yeah, agreed that the "deadlock detection" code should be pretty light weight
> if/when it is written.

In addition, to even stand a chance, you would need to use hrtimers.
The half-jiffy (at a minimum) delay from any other deferral mechanism
that I know of would be the kiss of death, especially from the viewpoint
of the real-time guys.

> > But what did the scheduler maintainers say about this idea?
> 
> Last I remember when it came up during the rcu_read_unlock_special() deadlock
> discussions, there's no way to know for infra like RCU to know that it was
> invoked from the scheduler.
> 
> The idea I am bringing up now (about the scheduler itself detecting a
> recursion) was never brought up (not yet) with the sched maintainers (at
> least not by me).

It might be good to bounce if off of them sooner rather than later.

							Thanx, Paul
