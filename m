Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF0CC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72CB206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589301024;
	bh=L0eqP019kfTR7Qo6y9u3ABN+4bZ/SikM2ncqFMOCaVs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=W64QMPghykTDtZmBxJ2DuOulQQQmDVOsZybOdiGfAMVTuyJ5MMncs8jL7gPpp7jJS
	 k3FPIOCjylJHNa7WgYlAejf2ZomQ2yVvoDCZQ/KWMtejUWFUPLWtmkzxUd78ooYqha
	 l2cNf4UIu+zHoWAi8W2tCWz/C7fZpkn4it+iZ0Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgELQaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgELQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:30:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5534C206CC;
        Tue, 12 May 2020 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589301022;
        bh=L0eqP019kfTR7Qo6y9u3ABN+4bZ/SikM2ncqFMOCaVs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fwhsVWVfk3xqaRF3bpXfTOBPzpPyi2tNKUq8dGG7LiiZfhs+Z2fNzUfGDbD5UQODR
         0J2M7fygTdUMozj8k6JjJdhK4+01gdvg12NZB3LrJfMECB5GauSGDZU9ciGNXtMkMI
         j1NHGHgN29KaUwLjz1ZljFIzMef1yWehBQmHgRb8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3D6473522FA4; Tue, 12 May 2020 09:30:22 -0700 (PDT)
Date:   Tue, 12 May 2020 09:30:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
Message-ID: <20200512163022.GI2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:41:01AM -0400, Joel Fernandes wrote:
> On Tue, May 12, 2020 at 11:07 AM Akira Yokosawa <akiyks@gmail.com> wrote:
> >
> > From 7bb979aacd8788d174df8a56e9803ba9e5b7a381 Mon Sep 17 00:00:00 2001
> > From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Date: Mon, 11 May 2020 22:06:46 -0400
> > Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU pre-initialization test
> >
> > Since this test returned to tools/memory-model/, make sure that it is
> > at least referenced from Documentation/litmus-tests/'s README.
> >
> > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
> > [Alan: grammar nit]
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > ---
> > I said in the earlier message:
> >
> > > The explanation under tools/memory-model/litmus-tests/README also need the same
> > > rewording.
> >
> > , but obviously I was confused. It is good as is.
> >
> > This is on top of my earlier patch series.
> >
> > Joel, Alan, does this work with you?
> 
> Yes, thanks a lot for doing it. Paul are you Ok with it too?

Looks good to me!

Could one of you please send a patch series and instructions, which I
-think- will be of the form:

o	Revert a5cca3485d92 ("Documentation: LKMM: Move
	MP+onceassign+derefonce to new litmus-tests/rcu/")

o	Apply a series of patches.

(My head is deep within some ring-buffer code that I am reviewing, so I
guarantee that if I try to piece this together from the current set of
patches, I will end up producing a spectacular display of destructive
creativity.)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> >
> >         Thanks, Akira
> > --
> >  Documentation/litmus-tests/README | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> > index ac0b270b456c..b79e640214b9 100644
> > --- a/Documentation/litmus-tests/README
> > +++ b/Documentation/litmus-tests/README
> > @@ -24,6 +24,10 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> >  RCU (/rcu directory)
> >  --------------------
> >
> > +MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
> > +    Demonstrates the use of rcu_assign_pointer() and rcu_dereference() to
> > +    ensure that an RCU reader will not see pre-initialization garbage.
> > +
> >  RCU+sync+read.litmus
> >  RCU+sync+free.litmus
> >      Both the above litmus tests demonstrate the RCU grace period guarantee
> > --
> > 2.17.1
> >
> >
