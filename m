Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89981C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE5F208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583444389;
	bh=khAjJ61F7SrEaxmXnzUzLpC+tKXgp6djp6p6ki1r96c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ugUpTTYf3xou9i2eQwgBTJR+y9GXmCKHMRg1iEc7PQHAzcvQci5ybBHig3X6tdNXV
	 ifo/1zBUUzYBTN9zwji4ydShp//dEygu6qUd63flBnYvaPooKFsROQ3QcjZZotS0Y5
	 XwupJPmB+oWG35M4+lVNLPlsoTH5j4ZXiSBV6S9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCEVjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:39:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgCEVjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:39:47 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4DC2072A;
        Thu,  5 Mar 2020 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583444386;
        bh=khAjJ61F7SrEaxmXnzUzLpC+tKXgp6djp6p6ki1r96c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OWQL3/8Pxmp/wQsQVqWqJBxYuat1ZMHqlQVrVKykbGZX+bO2TlMFADNIpOkDPavSd
         MlkfiGIJ1ywvGQ2C5v04/cwJZWqDovxlr2SaDLaUf0d6fyCYX4lrfkov0keYTdG+Wz
         O8i2H0cVm5xwU8gjwVi/dNfec4EkeGWyH5HkhoeQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 69FDC3522806; Thu,  5 Mar 2020 13:39:46 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:39:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200305213946.GL2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72>
 <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72>
 <20200305151831.GM29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305151831.GM29971@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:18:31AM -0800, Matthew Wilcox wrote:
> On Wed, Mar 04, 2020 at 06:10:21AM -0800, Paul E. McKenney wrote:
> > On Tue, Mar 03, 2020 at 08:33:56PM -0800, Matthew Wilcox wrote:
> > > On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> > > > On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > > > > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > > > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > > > > could happen concurrently result in data races, but those operate only
> > > > > > on a single bit that are pretty much harmless. For example,
> > > > > 
> > > > > Those aren't data races.  The writes are protected by a spinlock and the
> > > > > reads by the RCU read lock.  If the tool can't handle RCU protection,
> > > > > it's not going to be much use.
> > > > 
> > > > Would KCSAN's ASSERT_EXCLUSIVE_BITS() help here?
> > > 
> > > I'm quite lost in the sea of new macros that have been added to help
> > > with KCSAN.  It doesn't help that they're in -next somewhere that I
> > > can't find, and not in mainline yet.  Is there documentation somewhere?
> > 
> > Yes, there is documentation.  In -next somewhere.  :-/
> 
> Looking at the documentation link that Marco kindly provided, I don't
> think ASSERT_EXCLUSIVE_BITS is the correct annotation to make.  The bits
> in question are being accessed in parallel, it's just that we're willing
> to accept a certain degree of inaccuracy.
> 
> > > struct xa_node {
> > >         unsigned char   shift;          /* Bits remaining in each slot */
> > >         unsigned char   offset;         /* Slot offset in parent */
> > >         unsigned char   count;          /* Total entry count */
> > >         unsigned char   nr_values;      /* Value entry count */
> > >         struct xa_node __rcu *parent;   /* NULL at top of tree */
> > >         struct xarray   *array;         /* The array we belong to */
> > >         union {
> > >                 struct list_head private_list;  /* For tree user */
> > >                 struct rcu_head rcu_head;       /* Used when freeing node */
> > >         };
> > >         void __rcu      *slots[XA_CHUNK_SIZE];
> > >         union {
> > >                 unsigned long   tags[XA_MAX_MARKS][XA_MARK_LONGS];
> > >                 unsigned long   marks[XA_MAX_MARKS][XA_MARK_LONGS];
> > >         };
> > > };
> > > 
> > > 'slots' may be modified with the xa_lock
> > > held, and simultaneously read by an RCU reader.  Ditto 'tags'/'marks'.
> > 
> > KCSAN expects that accesses to the ->parent field should be marked.
> > But if ->parent is always accessed via things like rcu_dereference()
> > and rcu_assign_pointer() (guessing based on the __rcu), then KCSAN
> > won't complain.
> [...]
> > The situation with ->slots is the same as that for ->parent.
> > 
> > KCSAN expects accesses to the ->tags[] and ->marks[] arrays to be marked.
> > However, the default configuration of KCSAN asks only that the reads
> > be marked.  (Within RCU, I instead configure KCSAN so that it asks that
> > both be marked, but it is of course your choice within your code.)
> > 
> > > The RCU readers are prepared for what they see to be inconsistent --
> > > a fact of life when dealing with RCU!  So in a sense, yes, there is a
> > > race there.  But it's a known, accepted race, and that acceptance is
> > > indicated by the fact that the RCU lock is held.  Does there need to be
> > > more annotation here?  Or is there an un-noticed bug that the tool is
> > > legitimately pointing out?
> > 
> > The answer to both questions is "maybe", depending on the code using
> > the values read.  Yes, it would be nice if KCSAN could figure out the
> > difference, but there are limits to what a tool can do.  And things
> > are sometimes no-obvious, for example:
> 
> I require the following properties from this array of bits:
> 
>  - If a bit was set before and after the modification, it must be seen to
>    be set.
>  - If a bit was clear before and after the modification, it must be seen to
>    be clear.
>  - If a bit is modified, it may be seen as set or clear.
> 
> I have found three locations where we use the ->marks array:
> 
> 1.
>                         unsigned long data = *addr & (~0UL << offset);
>                         if (data)
>                                 return __ffs(data);
> 
> 2.
>         return find_next_bit(addr, XA_CHUNK_SIZE, offset);
> 3.
>         return test_bit(offset, node_marks(node, mark));
> 
> The modifications -- all done with the spinlock held -- use the non-atomic
> bitops:
>         return __test_and_set_bit(offset, node_marks(node, mark));
>         return __test_and_clear_bit(offset, node_marks(node, mark));
>         bitmap_fill(node_marks(node, mark), XA_CHUNK_SIZE);
> (that last one doesn't really count -- it's done prior to placing the node
> in the tree)
> 
> The first read seems straightforward; I can place a READ_ONCE around
> *addr.  The second & third reads are rather less straightforward.
> find_next_bit() and test_bit() are common code and use plain loads today.

Yes, those last two are a bit annoying, aren't they?  I guess the first
thing would be placing READ_ONCE() inside them, and if that results in
regressions, have an alternative API for concurrent access?

> > Your mileage may vary, of course.  For one thing, your actuarial
> > statistics are quite likley significantly more favorable than are mine.
> > Not that mine are at all bad, particularly by the standards of a century
> > or two ago.  ;-)
> 
> I don't know ... my preferred form of exercise takes me into the
> harm's way of cars, so while I've significantly lowered my risk of
> dying of cardiovascular disease, I'm much more likely to be killed by
> an inattentive human being!  Bring on our robot cars ...

I did my 40 years using that mode of transport.  But my reflexes are
no longer up to the task.  So I have no advice for you on that one!
Other than to question your trust in robot cars whose code was produced
by human developers!  ;-)

							Thanx, Paul
