Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E80C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C295A20717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGRBZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:25:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59677 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726710AbgGRBZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:25:56 -0400
Received: (qmail 1169335 invoked by uid 1000); 17 Jul 2020 21:25:55 -0400
Date:   Fri, 17 Jul 2020 21:25:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718012555.GA1168834@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717205340.GR7625@magnolia>
 <20200718005857.GB2183@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718005857.GB2183@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 05:58:57PM -0700, Eric Biggers wrote:
> On Fri, Jul 17, 2020 at 01:53:40PM -0700, Darrick J. Wong wrote:
> > > +There are also cases in which the smp_load_acquire() can be replaced by
> > > +the more lightweight READ_ONCE().  (smp_store_release() is still
> > > +required.)  Specifically, if all initialized memory is transitively
> > > +reachable from the pointer itself, then there is no control dependency
> > 
> > I don't quite understand what "transitively reachable from the pointer
> > itself" means?  Does that describe the situation where all the objects
> > reachable through the object that the global struct foo pointer points
> > at are /only/ reachable via that global pointer?
> > 
> 
> The intent is that "transitively reachable" means that all initialized memory
> can be reached by dereferencing the pointer in some way, e.g. p->a->b[5]->c.
> 
> It could also be the case that allocating the object initializes some global or
> static data, which isn't reachable in that way.  Access to that data would then
> be a control dependency, which a data dependency barrier wouldn't work for.
> 
> It's possible I misunderstood something.  (Note the next paragraph does say that
> using READ_ONCE() is discouraged, exactly for this reason -- it can be hard to
> tell whether it's correct.)  Suggestions of what to write here are appreciated.

Perhaps something like this:

	Specifically, if the only way to reach the initialized memory 
	involves dereferencing the pointer itself then READ_ONCE() is 
	sufficient.  This is because there will be an address dependency 
	between reading the pointer and accessing the memory, which will 
	ensure proper ordering.  But if some of the initialized memory 
	is reachable some other way (for example, if it is global or 
	static data) then there need not be an address dependency, 
	merely a control dependency (checking whether the pointer is 
	non-NULL).  Control dependencies do not always ensure ordering 
	-- certainly not for reads, and depending on the compiler, 
	possibly not for some writes -- and therefore a load-acquire is 
	necessary.

Perhaps this is more wordy than you want, but it does get the important 
ideas across.

Alan Stern
