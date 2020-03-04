Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E1C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189F922B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2owA0PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgCDQke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:40:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38700 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgCDQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:40:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id i14so2648632otp.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvrEvD+7opql/JJxEjmiYA8aCM4NclmuHbRnspthzOQ=;
        b=L2owA0PXi7PzoM+3h/nzHuuXgk1zbzhEGtVGOA4bQCwug/mMMXHJccNxFPxih+xQt/
         ryLN/Y4lNRKBXmG4qFjviZejnmh+2amvXH2RRLwEAg2D6MCM0RD+JC2WEM+NeHCIWO98
         CcGOjFV03LVLF2O7sWH92P9M/BbcVd+Ps3nnomI4JhVD3fHJfeNube3YCVi+aKwRLB7p
         NAXvZzCASro4QZlCyryKOx4LGFX+gSx0ldJS4uacl2vQ4AMKtE4oIlornXxQcBjJnbCg
         quOJFhbGOQznZPSevfO+36c1dRLGNRfI6Rwq6mLvLirshaXa3CyJqIwfKU42G12rlu5A
         QX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvrEvD+7opql/JJxEjmiYA8aCM4NclmuHbRnspthzOQ=;
        b=iGWhpwyfD5g7b1i14mQ7t14fBSIMh6+69ZbalIMgW3aD46JIQFLH9yXU0+eYN/UC8T
         Y9v3ZgpJ/5lbOW0elHpgV9sM2GcSOeM/hhlsQ+SP90y+3nhp9hfX+EEJxRuNbOZruQ+0
         cDqR6NITj/SmOgkEyw6CvWgkQSF392eZ+XiQIw2UipAKUDRjH/T3UP3i/juuQyVwb3pj
         wAT2BcTQjadgI/f5wZn6GsEK2Ng8oq5SyBMcwo5s9Jt2HIqyfcofJotj1rCERGO78KMu
         FCcF9coUGHjJU4YRIL0jdprRNgxhgglKE3bT9BP7Z/efJcTVIKANWABSz/SyYU2vnCnr
         QJCQ==
X-Gm-Message-State: ANhLgQ3VzFp1n+CuFfPP3L7xfi5UCnhKAj1hFEoOM+6g+TeaGZ55cQIo
        +X5UnojSTTew1pIMbV7QRAMV0zMzs1hkGGSJ2hYUFA==
X-Google-Smtp-Source: ADFU+vvrlJx6PLIcul9RHfGoDedrG1C3IDvnr8XoJZbOdzUqyBgiu1B5zeIgKyCba2M8FgVjU2rDnOi/a/kDkZ7k0EA=
X-Received: by 2002:a05:6830:16c8:: with SMTP id l8mr3013088otr.2.1583340032952;
 Wed, 04 Mar 2020 08:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20200304031551.1326-1-cai@lca.pw> <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72> <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200304141021.GY2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Wed, 4 Mar 2020 17:40:21 +0100
Message-ID: <CANpmjNOotdBa_7EhA75f2Y59HfEVsGsquv1cvQ=OjtA784poRA@mail.gmail.com>
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 15:10, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 08:33:56PM -0800, Matthew Wilcox wrote:
> > On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> > > On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > > > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > > > could happen concurrently result in data races, but those operate only
> > > > > on a single bit that are pretty much harmless. For example,

I currently do not see those as justification to blacklist the whole
file. Wouldn't __no_kcsan be better? That is, in case there is no
other solution that emerges from the remainder of the discussion here.

> > > > Those aren't data races.  The writes are protected by a spinlock and the
> > > > reads by the RCU read lock.  If the tool can't handle RCU protection,
> > > > it's not going to be much use.
> > >
> > > Would KCSAN's ASSERT_EXCLUSIVE_BITS() help here?
> >
> > I'm quite lost in the sea of new macros that have been added to help
> > with KCSAN.  It doesn't help that they're in -next somewhere that I
> > can't find, and not in mainline yet.  Is there documentation somewhere?
>
> Yes, there is documentation.  In -next somewhere.  :-/
>
> Early days, apologies for the construction!

I just sent a patch updating documentation, just to make sure we have
something up-to-date we can refer to in the meantime.

A preview of generated documentation for ASSERT_EXCLUSIVE_BITS (and
others) is here:
https://htmlpreview.github.io/?https://github.com/google/ktsan/blob/kcsan-kerneldoc/output/dev-tools/kcsan.html#race-detection-beyond-data-races

Hope that helps somewhat.


> > > RCU readers -do- exclude pre-insertion initialization on the one hand,
> > > and those post-removal accesses that follow a grace period, but only
> > > if that grace period starts after the removal.  In addition, the
> > > accesses due to rcu_dereference(), rcu_assign_pointer(), and similar
> > > are guaranteed to work even if they are concurrent.
> > >
> > > Or am I missing something subtle here?
> >
> > I probably am.  An XArray is composed of a tree of xa_nodes:
> >
> > struct xa_node {
> >         unsigned char   shift;          /* Bits remaining in each slot */
> >         unsigned char   offset;         /* Slot offset in parent */
> >         unsigned char   count;          /* Total entry count */
> >         unsigned char   nr_values;      /* Value entry count */
> >         struct xa_node __rcu *parent;   /* NULL at top of tree */
> >         struct xarray   *array;         /* The array we belong to */
> >         union {
> >                 struct list_head private_list;  /* For tree user */
> >                 struct rcu_head rcu_head;       /* Used when freeing node */
> >         };
> >         void __rcu      *slots[XA_CHUNK_SIZE];
> >         union {
> >                 unsigned long   tags[XA_MAX_MARKS][XA_MARK_LONGS];
> >                 unsigned long   marks[XA_MAX_MARKS][XA_MARK_LONGS];
> >         };
> > };
> >
> > 'shift' is initialised before the node is inserted into the tree.
> > Ditto 'offset'.
>
> Very good, then both ->shift and ->offset can be accessed using normal
> C-language loads and stores even by most strict definition of data race.
>
> >                  'count' and 'nr_values' should only be touched with the
> > xa_lock held.  'parent' might be modified with the lock held and an RCU
> > reader expecting to see either the previous or new value.  'array' should
> > not change once the node is inserted.  private_list is, I believe, only
> > modified with the lock held.  'slots' may be modified with the xa_lock
> > held, and simultaneously read by an RCU reader.  Ditto 'tags'/'marks'.
>
> If ->count and ->nr_values are never accessed by readers, they can also
> use plain C-language loads and stores.
>
> KCSAN expects that accesses to the ->parent field should be marked.
> But if ->parent is always accessed via things like rcu_dereference()
> and rcu_assign_pointer() (guessing based on the __rcu), then KCSAN
> won't complain.
>
> The ->array can be accessed using plain C-language loads and stores.
>
> If ->private_list is never accessed without holding the lock, then
> plain C-language loads and stores work for it without KCSAN complaints.
>
> The situation with ->slots is the same as that for ->parent.
>
> KCSAN expects accesses to the ->tags[] and ->marks[] arrays to be marked.
> However, the default configuration of KCSAN asks only that the reads
> be marked.  (Within RCU, I instead configure KCSAN so that it asks that
> both be marked, but it is of course your choice within your code.)
>
> > The RCU readers are prepared for what they see to be inconsistent --
> > a fact of life when dealing with RCU!  So in a sense, yes, there is a
> > race there.  But it's a known, accepted race, and that acceptance is
> > indicated by the fact that the RCU lock is held.  Does there need to be
> > more annotation here?  Or is there an un-noticed bug that the tool is
> > legitimately pointing out?
>
> The answer to both questions is "maybe", depending on the code using
> the values read.  Yes, it would be nice if KCSAN could figure out the
> difference, but there are limits to what a tool can do.  And things
> are sometimes no-obvious, for example:
>
>         switch (foo) {
>         case 1:  do_something_1();  break;
>         case 3:  do_something_3();  break;
>         case 7:  do_something_7();  break;
>         case 19: do_something_19(); break;
>         case 23: do_something_23(); break;
>         }
>
> Only one access to "foo", so all is well, right?
>
> Sadly, wrong.  Compilers can create jump tables, and will often emit two
> loads from "foo", one to check against the table size, and the other to
> index the table.
>
> Other potential traps may be found in https://lwn.net/Articles/793253/
> ("Who's afraid of a big bad optimizing compiler?").
>
> One approach is to use READ_ONCE() on the reads in the RCU read-side
> critical section that are subject to concurrent update.  Another is to
> use the data_race() macro (as in data_race(foo) in the switch statement
> above) to tell KCSAN that you have analyzed the compiler's response.
> These first two can be mixed, if you like.  And yet another is the patch
> proposed by Qian if you want KCSAN to get out of your code altogether.
>
> Within RCU, I mark the accesses rather aggressively.  RCU is quite
> concurrent, and the implied documentation is very worthwhile.
>
> Your mileage may vary, of course.  For one thing, your actuarial
> statistics are quite likley significantly more favorable than are mine.
> Not that mine are at all bad, particularly by the standards of a century
> or two ago.  ;-)
>
>                                                         Thanx, Paul
