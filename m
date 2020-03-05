Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE68C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C962070E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xed3MIiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgCEPSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:18:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TS/k3e90NYvzgoF8mQe3++sKD6jNdRx+wfewqef/PsM=; b=Xed3MIiDOxzHAnItmGqN8/jcyO
        mIko1panxM2p7jztB3plr90xMuHbzSQLQYKmDD4+q+9QNXHG7psPKCdCh9ZxwP8z7MOcJxiRecDlR
        9ifAxa9nDJyBS5Cl9oO4pZHpg+uFM6vepbKI2JRXu0I9id5GhyAmjDBjMpmHJCUOVBLO+1x6j9kSK
        NBotL7aLYE7q4gc5czv/1NmmJNql5btw5wDwyCv1dmxhMUdq1XMtP1PkJ4P4ayp0KHaUVUd53uBDi
        l5TEfu8puWqUNwBigBAbcn/R5z9teeN/W6SqtWmRaPNtaD0/eSSvkft0RihCrw0o58TRwrEpgV+vr
        EHLaA2qA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9sGd-0000nu-5d; Thu, 05 Mar 2020 15:18:31 +0000
Date:   Thu, 5 Mar 2020 07:18:31 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200305151831.GM29971@bombadil.infradead.org>
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72>
 <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304141021.GY2935@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 06:10:21AM -0800, Paul E. McKenney wrote:
> On Tue, Mar 03, 2020 at 08:33:56PM -0800, Matthew Wilcox wrote:
> > On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> > > On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > > > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > > > could happen concurrently result in data races, but those operate only
> > > > > on a single bit that are pretty much harmless. For example,
> > > > 
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

Looking at the documentation link that Marco kindly provided, I don't
think ASSERT_EXCLUSIVE_BITS is the correct annotation to make.  The bits
in question are being accessed in parallel, it's just that we're willing
to accept a certain degree of inaccuracy.

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
> > 'slots' may be modified with the xa_lock
> > held, and simultaneously read by an RCU reader.  Ditto 'tags'/'marks'.
> 
> KCSAN expects that accesses to the ->parent field should be marked.
> But if ->parent is always accessed via things like rcu_dereference()
> and rcu_assign_pointer() (guessing based on the __rcu), then KCSAN
> won't complain.
[...]
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

I require the following properties from this array of bits:

 - If a bit was set before and after the modification, it must be seen to
   be set.
 - If a bit was clear before and after the modification, it must be seen to
   be clear.
 - If a bit is modified, it may be seen as set or clear.

I have found three locations where we use the ->marks array:

1.
                        unsigned long data = *addr & (~0UL << offset);
                        if (data)
                                return __ffs(data);

2.
        return find_next_bit(addr, XA_CHUNK_SIZE, offset);
3.
        return test_bit(offset, node_marks(node, mark));

The modifications -- all done with the spinlock held -- use the non-atomic
bitops:
        return __test_and_set_bit(offset, node_marks(node, mark));
        return __test_and_clear_bit(offset, node_marks(node, mark));
        bitmap_fill(node_marks(node, mark), XA_CHUNK_SIZE);
(that last one doesn't really count -- it's done prior to placing the node
in the tree)

The first read seems straightforward; I can place a READ_ONCE around
*addr.  The second & third reads are rather less straightforward.
find_next_bit() and test_bit() are common code and use plain loads today.

> Your mileage may vary, of course.  For one thing, your actuarial
> statistics are quite likley significantly more favorable than are mine.
> Not that mine are at all bad, particularly by the standards of a century
> or two ago.  ;-)

I don't know ... my preferred form of exercise takes me into the
harm's way of cars, so while I've significantly lowered my risk of
dying of cardiovascular disease, I'm much more likely to be killed by
an inattentive human being!  Bring on our robot cars ...
