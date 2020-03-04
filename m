Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9C4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7949821739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583331023;
	bh=TRFczWN/cEY4pww4MAXnTdz49Uxpdoqapq6KXtvWTw8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ATigvV1aik+EQfjMkoWkGMBgbtAgbx4XED+jHneHQ00cZOdmhFX/qjv1AwxJUTjIU
	 SeJG4zDzY+ENkNrzqJElGXwSs8uksTaDWlOmvbWUWBYfHgjQnhVvnwpZAfg7TnMWF2
	 OYiZKsn/Y0k/2sAeS7gSqeSe72kcyD8V/peMFXSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgCDOKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgCDOKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:10:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472C020848;
        Wed,  4 Mar 2020 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583331021;
        bh=TRFczWN/cEY4pww4MAXnTdz49Uxpdoqapq6KXtvWTw8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aU/YUQpgiyZcTm/Mb0pCyJtNuaBZjZT3lfML2cCjBSiju6S16HHdV8duZAAmzE9gD
         sqcvLuOAd3OErnRl6QnrKRyVAkRJfoPDRpnP6TpVRW4R10apv6356N6NojHTyAhIhG
         l6H6G7K8q57VzpTIgCXR2eZ3hKHHv39p80d5MXoY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 18EFB35226CB; Wed,  4 Mar 2020 06:10:21 -0800 (PST)
Date:   Wed, 4 Mar 2020 06:10:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200304141021.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72>
 <20200304043356.GC29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304043356.GC29971@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 08:33:56PM -0800, Matthew Wilcox wrote:
> On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> > On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > > could happen concurrently result in data races, but those operate only
> > > > on a single bit that are pretty much harmless. For example,
> > > 
> > > Those aren't data races.  The writes are protected by a spinlock and the
> > > reads by the RCU read lock.  If the tool can't handle RCU protection,
> > > it's not going to be much use.
> > 
> > Would KCSAN's ASSERT_EXCLUSIVE_BITS() help here?
> 
> I'm quite lost in the sea of new macros that have been added to help
> with KCSAN.  It doesn't help that they're in -next somewhere that I
> can't find, and not in mainline yet.  Is there documentation somewhere?

Yes, there is documentation.  In -next somewhere.  :-/

Early days, apologies for the construction!

> > RCU readers -do- exclude pre-insertion initialization on the one hand,
> > and those post-removal accesses that follow a grace period, but only
> > if that grace period starts after the removal.  In addition, the
> > accesses due to rcu_dereference(), rcu_assign_pointer(), and similar
> > are guaranteed to work even if they are concurrent.
> > 
> > Or am I missing something subtle here?
> 
> I probably am.  An XArray is composed of a tree of xa_nodes:
> 
> struct xa_node {
>         unsigned char   shift;          /* Bits remaining in each slot */
>         unsigned char   offset;         /* Slot offset in parent */
>         unsigned char   count;          /* Total entry count */
>         unsigned char   nr_values;      /* Value entry count */
>         struct xa_node __rcu *parent;   /* NULL at top of tree */
>         struct xarray   *array;         /* The array we belong to */
>         union {
>                 struct list_head private_list;  /* For tree user */
>                 struct rcu_head rcu_head;       /* Used when freeing node */
>         };
>         void __rcu      *slots[XA_CHUNK_SIZE];
>         union {
>                 unsigned long   tags[XA_MAX_MARKS][XA_MARK_LONGS];
>                 unsigned long   marks[XA_MAX_MARKS][XA_MARK_LONGS];
>         };
> };
> 
> 'shift' is initialised before the node is inserted into the tree.
> Ditto 'offset'.

Very good, then both ->shift and ->offset can be accessed using normal
C-language loads and stores even by most strict definition of data race.

>                  'count' and 'nr_values' should only be touched with the
> xa_lock held.  'parent' might be modified with the lock held and an RCU
> reader expecting to see either the previous or new value.  'array' should
> not change once the node is inserted.  private_list is, I believe, only
> modified with the lock held.  'slots' may be modified with the xa_lock
> held, and simultaneously read by an RCU reader.  Ditto 'tags'/'marks'.

If ->count and ->nr_values are never accessed by readers, they can also
use plain C-language loads and stores.

KCSAN expects that accesses to the ->parent field should be marked.
But if ->parent is always accessed via things like rcu_dereference()
and rcu_assign_pointer() (guessing based on the __rcu), then KCSAN
won't complain.

The ->array can be accessed using plain C-language loads and stores.

If ->private_list is never accessed without holding the lock, then
plain C-language loads and stores work for it without KCSAN complaints.

The situation with ->slots is the same as that for ->parent.

KCSAN expects accesses to the ->tags[] and ->marks[] arrays to be marked.
However, the default configuration of KCSAN asks only that the reads
be marked.  (Within RCU, I instead configure KCSAN so that it asks that
both be marked, but it is of course your choice within your code.)

> The RCU readers are prepared for what they see to be inconsistent --
> a fact of life when dealing with RCU!  So in a sense, yes, there is a
> race there.  But it's a known, accepted race, and that acceptance is
> indicated by the fact that the RCU lock is held.  Does there need to be
> more annotation here?  Or is there an un-noticed bug that the tool is
> legitimately pointing out?

The answer to both questions is "maybe", depending on the code using
the values read.  Yes, it would be nice if KCSAN could figure out the
difference, but there are limits to what a tool can do.  And things
are sometimes no-obvious, for example:

	switch (foo) {
	case 1:  do_something_1();  break;
	case 3:  do_something_3();  break;
	case 7:  do_something_7();  break;
	case 19: do_something_19(); break;
	case 23: do_something_23(); break;
	}

Only one access to "foo", so all is well, right?

Sadly, wrong.  Compilers can create jump tables, and will often emit two
loads from "foo", one to check against the table size, and the other to
index the table.

Other potential traps may be found in https://lwn.net/Articles/793253/
("Who's afraid of a big bad optimizing compiler?").

One approach is to use READ_ONCE() on the reads in the RCU read-side
critical section that are subject to concurrent update.  Another is to
use the data_race() macro (as in data_race(foo) in the switch statement
above) to tell KCSAN that you have analyzed the compiler's response.
These first two can be mixed, if you like.  And yet another is the patch
proposed by Qian if you want KCSAN to get out of your code altogether.

Within RCU, I mark the accesses rather aggressively.  RCU is quite
concurrent, and the implied documentation is very worthwhile.

Your mileage may vary, of course.  For one thing, your actuarial
statistics are quite likley significantly more favorable than are mine.
Not that mine are at all bad, particularly by the standards of a century
or two ago.  ;-)

							Thanx, Paul
