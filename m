Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16678C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E458C206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589293185;
	bh=Gjm45Rqn3VEbRl0jgQIeOb5BdynO5iWb0uAqsggLPow=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lyBzzjFnoRK49cx9G5Sa6L2VPigZvXITm71ZHAtITpvdaUcarlp6DP7qsKdV5l1ce
	 eD4ZiHo9RpB93vTRk1CNsIPlbqRqLqrdWBlED4RSdMpEvw2Zl8PJ5CCCLYQyvZNumC
	 tL8RWo4PDMlKleIHWBbf2BNSooFwov69O7ODTb78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgELOTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgELOTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:19:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF20206D3;
        Tue, 12 May 2020 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589293184;
        bh=Gjm45Rqn3VEbRl0jgQIeOb5BdynO5iWb0uAqsggLPow=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l5HgKGzsvXwvFqLtyJu9XTQqJgF7hoxkpEGT/blvlYIoROwJweOkBxTAknabEBMcq
         vosoGVKPjnZGz6L49H8iRgHGn1COtgf1+zYjygxqzyoLCKMARVVfW8517PtcS5rOge
         iD/agKM71MJh7IkoH99mp3QGwLZfOXPUPoGOgZZ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 234E23522FA4; Tue, 12 May 2020 07:19:44 -0700 (PDT)
Date:   Tue, 12 May 2020 07:19:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, vpillai@digitalocean.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
Message-ID: <20200512141944.GC2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <20200511173348.GX2869@paulmck-ThinkPad-P72>
 <20200512021309.GA197229@google.com>
 <bff04d71-1666-a5a8-54bf-d0c9f8737b47@gmail.com>
 <20200512121936.GA228684@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512121936.GA228684@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 08:19:36AM -0400, Joel Fernandes wrote:
> On Tue, May 12, 2020 at 08:50:45PM +0900, Akira Yokosawa wrote:
> [...]
> > > I think on top of this patch, I'd like to add a reference to the to the
> > > litmus test in tools/memory-model/ from Documentation/rcu/.
> > 
> > Sounds reasonable to me. But for most people, it never changes its location.
> > Please find inline comments below.
> > 
> > > 
> > > Just to mention my rationale for Documentation/litmus-tests/rcu/, I was
> > > basically looking for a central place for RCU related litmus tests in the
> > > kernel sources and the idea of this new directory came up.
> > > 
> > > For Akira's series,
> > > Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Thank you!
> > 
> > > 
> > > And could we add the following patch on top of Akira's series so we still
> > > maintain a reference to the moved RCU test?> 
> > > ---8<-----------------------
> > > 
> > > From 52fdb57551cc769d8bd690f4f2b22de36ddece99 Mon Sep 17 00:00:00 2001
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > Date: Mon, 11 May 2020 22:06:46 -0400
> > > Subject: [PATCH] docs: litmus-tests: Clarify about the RCU pre-initialization
> > >  test
> > > 
> > > Since this test was moved to tools/memory-model/, make sure that it is
> > > at least referenced from Documentation/litmus-tests/'s README.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  Documentation/litmus-tests/README | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> > > index ac0b270b456c1..53f09e74734a4 100644
> > > --- a/Documentation/litmus-tests/README
> > > +++ b/Documentation/litmus-tests/README
> > > @@ -11,7 +11,6 @@ tools/memory-model/README.
> > >  
> > >  atomic (/atomic derectory)
> > >  --------------------------
> > > -
> > >  Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> > >      Test that an atomic RMW followed by a smp_mb__after_atomic() is
> > >      stronger than a normal acquire: both the read and write parts of
> > > @@ -23,8 +22,11 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> > >  
> > >  RCU (/rcu directory)
> > >  --------------------
> > > -
> > 
> > I loosely followed the convention of ReST documents in putting these empty
> > lines.  But I don't mind if they are removed.
> > 
> > >  RCU+sync+read.litmus
> > >  RCU+sync+free.litmus
> > >      Both the above litmus tests demonstrate the RCU grace period guarantee
> > >      that an RCU read-side critical section can never span a grace period.
> > > +
> > > +MP+onceassign+derefonce.litmus (moved to tools/memory-model/litmus-tests/)
> > 
> > As I said above, for those who don't follow developments in the lkmm branch, 
> > MP+onceassign+derefonce.litmus stays in tools/memory-model/litmus-tests/.
> > So,
> > 
> > +MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
> > 
> > looks better to me.
> 
> Yes it stays under tools/.. but is referenced here. Sounds like you agree and
> the only change from my follow-up patch that you want is to change "moved to"
> to "under".
> 
> If so, Paul do you mind applying my patch and fixing this up? Or do you want
> to apply Akira's 3-patch series first and then have me send you another one
> on top?

Let's get something that you, Akira, and Alan are good with, then I will
apply that, either on top of or in place of the current commits (just
tell me which).

							Thanx, Paul
