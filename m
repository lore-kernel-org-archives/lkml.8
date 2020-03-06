Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA52C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6202072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9SRri6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFNix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:38:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40938 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:38:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so2421216otp.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyxnMZoynoTR9N0Al4wp7iVuUJFhka7ySWjpV9x8udE=;
        b=K9SRri6Pr0y2s+jKSWlqW410XZQXmf9ExF2CP30ftWKDVMYdGEjwH4AJzH2oq/xvnx
         hnWQgSbGY27mxGXj96gmg0neICIuR28m6JEVf7C6k8qFEVCRWHaE8KZqHaR0WzkzDhb0
         MpMqcQMV8pxcVzpxkIxJZ3aDR+3o9g0fI8+c7++mqdOjC13B0vpW/dHZVQFCUpV8cFVg
         DP86kWH8Hnct1mLLd+s25IsSyxAsdZPmE7eiDg9SGwxKgaE5P9OxHl5pHbNZkwBXF+H9
         inunAQ+vXA2PgR2Z+fNQOgTadmbUhzbicXHEReVNfJwGGBWMEyfvYD5I6nPaFADx/QyF
         uo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyxnMZoynoTR9N0Al4wp7iVuUJFhka7ySWjpV9x8udE=;
        b=c8fT3dZ+14xBiFYRdoHi3Aca5kDukgW0KTQ9uMpsICXOBlN0k4TzHKqpPm3bB7fHd7
         N2n6sab9hQqoKNI1CH61OXdkN/2YhnOVYhfa7xbMlxGwsjHgBnFiTShSPyl+jvCP9e0O
         PT8LbQiFl9V5ZO000hyh7z9TFTvzXovlip9tRPQDw7kQtjJG/AQzkdFjm9MJ8skEuXoD
         yVbvfNOdU0wgcPXQ8tKpyjpsfoMnYZkWyJ18ly2691o1cm5OMVWR3kzMnlaWW43uGG7D
         GwWhcOQv17KMZsTj2DrJarv623W0I0tSMiG0XdbsQZ9PUsguoJAOraiRdhHs5TmqC+RL
         KdNQ==
X-Gm-Message-State: ANhLgQ1B/wR+SZPelK2TV0wYElQCYI6DkFpZaI5As3vRJOyyW/kX18/b
        5hNy+0JaOuntVm8oGCB6F7FQ+7JWAliL9E9mL5qw6Q==
X-Google-Smtp-Source: ADFU+vuQXLtR5pZkV+6/dtalRceSpk/ZnUFpxIjy8+og4RCPkEXkxXagUFR4uF3ESv4afryvBENTbHw7hS3bJBIb2/w=
X-Received: by 2002:a9d:c65:: with SMTP id 92mr2015106otr.23.1583501931592;
 Fri, 06 Mar 2020 05:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20200304031551.1326-1-cai@lca.pw> <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72> <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72> <20200305151831.GM29971@bombadil.infradead.org>
 <20200305213946.GL2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200305213946.GL2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Mar 2020 14:38:39 +0100
Message-ID: <CANpmjNOtsdxh3YLcF-pUMua9afWfhg5P_2ziRGSMuT8Gi0c5TA@mail.gmail.com>
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 22:39, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Mar 05, 2020 at 07:18:31AM -0800, Matthew Wilcox wrote:
> > On Wed, Mar 04, 2020 at 06:10:21AM -0800, Paul E. McKenney wrote:
> > > On Tue, Mar 03, 2020 at 08:33:56PM -0800, Matthew Wilcox wrote:
> > > > On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > > > > > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > > > > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > > > > > could happen concurrently result in data races, but those operate only
> > > > > > > on a single bit that are pretty much harmless. For example,
> > > > > >
> > > > > > Those aren't data races.  The writes are protected by a spinlock and the
> > > > > > reads by the RCU read lock.  If the tool can't handle RCU protection,
> > > > > > it's not going to be much use.
> > > > >
> > > > > Would KCSAN's ASSERT_EXCLUSIVE_BITS() help here?
> > > >
> > > > I'm quite lost in the sea of new macros that have been added to help
> > > > with KCSAN.  It doesn't help that they're in -next somewhere that I
> > > > can't find, and not in mainline yet.  Is there documentation somewhere?
> > >
> > > Yes, there is documentation.  In -next somewhere.  :-/
> >
> > Looking at the documentation link that Marco kindly provided, I don't
> > think ASSERT_EXCLUSIVE_BITS is the correct annotation to make.  The bits
> > in question are being accessed in parallel, it's just that we're willing
> > to accept a certain degree of inaccuracy.
> >
> > > > struct xa_node {
> > > >         unsigned char   shift;          /* Bits remaining in each slot */
> > > >         unsigned char   offset;         /* Slot offset in parent */
> > > >         unsigned char   count;          /* Total entry count */
> > > >         unsigned char   nr_values;      /* Value entry count */
> > > >         struct xa_node __rcu *parent;   /* NULL at top of tree */
> > > >         struct xarray   *array;         /* The array we belong to */
> > > >         union {
> > > >                 struct list_head private_list;  /* For tree user */
> > > >                 struct rcu_head rcu_head;       /* Used when freeing node */
> > > >         };
> > > >         void __rcu      *slots[XA_CHUNK_SIZE];
> > > >         union {
> > > >                 unsigned long   tags[XA_MAX_MARKS][XA_MARK_LONGS];
> > > >                 unsigned long   marks[XA_MAX_MARKS][XA_MARK_LONGS];
> > > >         };
> > > > };
> > > >
> > > > 'slots' may be modified with the xa_lock
> > > > held, and simultaneously read by an RCU reader.  Ditto 'tags'/'marks'.
> > >
> > > KCSAN expects that accesses to the ->parent field should be marked.
> > > But if ->parent is always accessed via things like rcu_dereference()
> > > and rcu_assign_pointer() (guessing based on the __rcu), then KCSAN
> > > won't complain.
> > [...]
> > > The situation with ->slots is the same as that for ->parent.
> > >
> > > KCSAN expects accesses to the ->tags[] and ->marks[] arrays to be marked.
> > > However, the default configuration of KCSAN asks only that the reads
> > > be marked.  (Within RCU, I instead configure KCSAN so that it asks that
> > > both be marked, but it is of course your choice within your code.)
> > >
> > > > The RCU readers are prepared for what they see to be inconsistent --
> > > > a fact of life when dealing with RCU!  So in a sense, yes, there is a
> > > > race there.  But it's a known, accepted race, and that acceptance is
> > > > indicated by the fact that the RCU lock is held.  Does there need to be
> > > > more annotation here?  Or is there an un-noticed bug that the tool is
> > > > legitimately pointing out?
> > >
> > > The answer to both questions is "maybe", depending on the code using
> > > the values read.  Yes, it would be nice if KCSAN could figure out the
> > > difference, but there are limits to what a tool can do.  And things
> > > are sometimes no-obvious, for example:
> >
> > I require the following properties from this array of bits:
> >
> >  - If a bit was set before and after the modification, it must be seen to
> >    be set.
> >  - If a bit was clear before and after the modification, it must be seen to
> >    be clear.
> >  - If a bit is modified, it may be seen as set or clear.
> >
> > I have found three locations where we use the ->marks array:
> >
> > 1.
> >                         unsigned long data = *addr & (~0UL << offset);
> >                         if (data)
> >                                 return __ffs(data);
> >
> > 2.
> >         return find_next_bit(addr, XA_CHUNK_SIZE, offset);
> > 3.
> >         return test_bit(offset, node_marks(node, mark));
> >
> > The modifications -- all done with the spinlock held -- use the non-atomic
> > bitops:
> >         return __test_and_set_bit(offset, node_marks(node, mark));
> >         return __test_and_clear_bit(offset, node_marks(node, mark));
> >         bitmap_fill(node_marks(node, mark), XA_CHUNK_SIZE);
> > (that last one doesn't really count -- it's done prior to placing the node
> > in the tree)
> >
> > The first read seems straightforward; I can place a READ_ONCE around
> > *addr.  The second & third reads are rather less straightforward.
> > find_next_bit() and test_bit() are common code and use plain loads today.
>
> Yes, those last two are a bit annoying, aren't they?  I guess the first
> thing would be placing READ_ONCE() inside them, and if that results in
> regressions, have an alternative API for concurrent access?

FWIW test_bit() is an "atomic" bitop (per atomic_bitops.txt), and
KCSAN treats it as such. On x86 arch_test_bit() is not instrumented,
and then in asm-generic/bitops/instrumented-non-atomic.h test_bit() is
instrumented with instrument_atomic_read(). So on x86, things should
already be fine for test_bit(). Not sure about other architectures.

Thanks,
-- Marco



> > > Your mileage may vary, of course.  For one thing, your actuarial
> > > statistics are quite likley significantly more favorable than are mine.
> > > Not that mine are at all bad, particularly by the standards of a century
> > > or two ago.  ;-)
> >
> > I don't know ... my preferred form of exercise takes me into the
> > harm's way of cars, so while I've significantly lowered my risk of
> > dying of cardiovascular disease, I'm much more likely to be killed by
> > an inattentive human being!  Bring on our robot cars ...
>
> I did my 40 years using that mode of transport.  But my reflexes are
> no longer up to the task.  So I have no advice for you on that one!
> Other than to question your trust in robot cars whose code was produced
> by human developers!  ;-)
>
>                                                         Thanx, Paul
