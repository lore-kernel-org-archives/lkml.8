Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EB2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E358208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583514199;
	bh=1Yte6UkWxsbNdREhiZiPbohyajzUvT2/4rsnl6dsz1Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PEjbPdjJ9SXcsnLBDNoZP3rdU50Ju3gDWDTwfYHy99LKoYK1++gUEPXtt4c4aCYxR
	 aVV4fKf6Mwta4aDyY3TKAgz/zVLX9T34BKlVaQaZ4yOU58Rhe/OXEnBH01D4/crpmh
	 efF/ctmo0itp04QXBQlE/OUhvBtW3lprG1mxmZ+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFRDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFRDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:03:17 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED957206E2;
        Fri,  6 Mar 2020 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583514197;
        bh=1Yte6UkWxsbNdREhiZiPbohyajzUvT2/4rsnl6dsz1Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mYeSYKg31vdljHcXbKlFIy3YdbtnKEG4+Tb7u5PDzHV9AJZ6oKo0Y5zCbY+DXznej
         HG16mI/cwhqjSeTqoh6lWsWLvZ70AzkeurqhmXfIkaeUL2lIgKjBS7eyPTETcLcezQ
         6y9bFghK6KiRqmhEw7Hbw2W7XM3yncLpLA143M3U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CEB6735226BF; Fri,  6 Mar 2020 09:03:16 -0800 (PST)
Date:   Fri, 6 Mar 2020 09:03:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200306170316.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72>
 <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72>
 <20200305151831.GM29971@bombadil.infradead.org>
 <20200305213946.GL2935@paulmck-ThinkPad-P72>
 <CANpmjNOtsdxh3YLcF-pUMua9afWfhg5P_2ziRGSMuT8Gi0c5TA@mail.gmail.com>
 <20200306165300.GC25710@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306165300.GC25710@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:53:00AM -0800, Matthew Wilcox wrote:
> On Fri, Mar 06, 2020 at 02:38:39PM +0100, Marco Elver wrote:
> > On Thu, 5 Mar 2020 at 22:39, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Thu, Mar 05, 2020 at 07:18:31AM -0800, Matthew Wilcox wrote:
> > > > I have found three locations where we use the ->marks array:
> > > >
> > > > 1.
> > > >                         unsigned long data = *addr & (~0UL << offset);
> > > >                         if (data)
> > > >                                 return __ffs(data);
> > > >
> > > > 2.
> > > >         return find_next_bit(addr, XA_CHUNK_SIZE, offset);
> > > > 3.
> > > >         return test_bit(offset, node_marks(node, mark));
> > > >
> > > > The modifications -- all done with the spinlock held -- use the non-atomic
> > > > bitops:
> > > >         return __test_and_set_bit(offset, node_marks(node, mark));
> > > >         return __test_and_clear_bit(offset, node_marks(node, mark));
> > > >         bitmap_fill(node_marks(node, mark), XA_CHUNK_SIZE);
> > > > (that last one doesn't really count -- it's done prior to placing the node
> > > > in the tree)
> > > >
> > > > The first read seems straightforward; I can place a READ_ONCE around
> > > > *addr.  The second & third reads are rather less straightforward.
> > > > find_next_bit() and test_bit() are common code and use plain loads today.
> > >
> > > Yes, those last two are a bit annoying, aren't they?  I guess the first
> > > thing would be placing READ_ONCE() inside them, and if that results in
> > > regressions, have an alternative API for concurrent access?
> > 
> > FWIW test_bit() is an "atomic" bitop (per atomic_bitops.txt), and
> > KCSAN treats it as such. On x86 arch_test_bit() is not instrumented,
> > and then in asm-generic/bitops/instrumented-non-atomic.h test_bit() is
> > instrumented with instrument_atomic_read(). So on x86, things should
> > already be fine for test_bit(). Not sure about other architectures.
> 
> Hum.  It may well be documented as atomic, but is it?  Here's the
> generic implementation:
> 
> static inline int test_bit(int nr, const volatile unsigned long *addr)
> {
>         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> }
> 
> arch_test_bit is only used by the instrumented variants:
> 
> $ git grep arch_test_bit include
> include/asm-generic/bitops/instrumented-non-atomic.h:   return arch_test_bit(nr, addr);
> 
> As far as I can tell, the generic version is what's used on x86.  Does
> the 'volatile' qualifier save us here?
> 
> find_next_bit() doesn't have the 'volatile' qualifier, so may still be
> a problem?

One approach would be to add the needed READ_ONCE().

Another, if someone is crazy enough to do the work, would be to verify
that the code output is as if there was a READ_ONCE().

Thoughts?

							Thanx, Paul
