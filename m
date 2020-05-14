Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC50206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589476618;
	bh=fFnBlGAlMw+wP20EqKk+Oz6IVDzE2zDUpn8juggLf38=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ba1RKKz46D2f7pts6ZApNLMExpiqkkffk8k4jQ+VtOs91BDRw4ejABCDKw4r9YuIA
	 CEreh1rjLG6mAj8eyjNfvScQvb9TskkESlKMpJcmFR3+G3Sc1EytjccALeFVvel8hJ
	 dYcqKpaXdD1cDWt4QnxkoqLu5VtWbwibJqvd4nEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgENRQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgENRQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:16:57 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CE32065D;
        Thu, 14 May 2020 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589476616;
        bh=fFnBlGAlMw+wP20EqKk+Oz6IVDzE2zDUpn8juggLf38=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zNpksnBjYg93pGCAzKDGWckXwDHTkZoKnM5HbbwDQjCBbkZmzmi/oC0bZZJvrB3oL
         /FvQelsmUUlmXtoKseg0l0TrN5lUrZ9+5DEUzj9BNZ86JqJYE/pXwSvTuU/LHSrazk
         8v88CcrCoJyCCxQPCjsguQkyzK1cz9QbqKTb77Ss=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B5B1E35229C8; Thu, 14 May 2020 10:16:56 -0700 (PDT)
Date:   Thu, 14 May 2020 10:16:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Subject: Re: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's
 README into top-level one
Message-ID: <20200514171656.GR2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
 <6d162e69-5d2f-1fbf-1588-ab19c30e7311@gmail.com>
 <20200514004618.GA94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514004618.GA94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:46:18AM +0800, Boqun Feng wrote:
> On Wed, May 13, 2020 at 06:39:03AM +0900, Akira Yokosawa wrote:
> > From 96fa6680e3b990633ecbb6d11acf03a161b790bd Mon Sep 17 00:00:00 2001
> > From: Akira Yokosawa <akiyks@gmail.com>
> > Date: Sun, 10 May 2020 15:12:57 +0900
> > Subject: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's README into top-level one
> > 
> > Where Documentation/litmus-tests/README lists RCU litmus tests,
> > Documentation/litmus-tests/atomic/README lists atomic litmus tests.
> > For symmetry, merge the latter into former, with some context
> > adjustment in the introduction.
> > 
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > Acked-by: Andrea Parri <parri.andrea@gmail.com>
> > Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Thanks!

Applied, and thank you all!

I rebased, cancelling the revert with the original, resulting in an
updated lkmm branch on -rcu.  There was one minor conflict, so could
one of you please check to make sure that I resolved things appropriately?

							Thanx, Paul

> Regards,
> Boqun
> 
> > ---
> >  Documentation/litmus-tests/README        | 19 +++++++++++++++++++
> >  Documentation/litmus-tests/atomic/README | 16 ----------------
> >  2 files changed, 19 insertions(+), 16 deletions(-)
> >  delete mode 100644 Documentation/litmus-tests/atomic/README
> > 
> > diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> > index c4307ea9f996..ac0b270b456c 100644
> > --- a/Documentation/litmus-tests/README
> > +++ b/Documentation/litmus-tests/README
> > @@ -2,6 +2,25 @@
> >  LITMUS TESTS
> >  ============
> >  
> > +Each subdirectory contains litmus tests that are typical to describe the
> > +semantics of respective kernel APIs.
> > +For more information about how to "run" a litmus test or how to generate
> > +a kernel test module based on a litmus test, please see
> > +tools/memory-model/README.
> > +
> > +
> > +atomic (/atomic derectory)
> > +--------------------------
> > +
> > +Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> > +    Test that an atomic RMW followed by a smp_mb__after_atomic() is
> > +    stronger than a normal acquire: both the read and write parts of
> > +    the RMW are ordered before the subsequential memory accesses.
> > +
> > +Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> > +    Test that atomic_set() cannot break the atomicity of atomic RMWs.
> > +
> > +
> >  RCU (/rcu directory)
> >  --------------------
> >  
> > diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
> > deleted file mode 100644
> > index 714cf93816ea..000000000000
> > --- a/Documentation/litmus-tests/atomic/README
> > +++ /dev/null
> > @@ -1,16 +0,0 @@
> > -This directory contains litmus tests that are typical to describe the semantics
> > -of our atomic APIs. For more information about how to "run" a litmus test or
> > -how to generate a kernel test module based on a litmus test, please see
> > -tools/memory-model/README.
> > -
> > -============
> > -LITMUS TESTS
> > -============
> > -
> > -Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
> > -	Test that an atomic RMW followed by a smp_mb__after_atomic() is
> > -	stronger than a normal acquire: both the read and write parts of
> > -	the RMW are ordered before the subsequential memory accesses.
> > -
> > -Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> > -	Test that atomic_set() cannot break the atomicity of atomic RMWs.
> > -- 
> > 2.17.1
> > 
> > 
