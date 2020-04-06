Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20C0C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FAC248E7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AnUm6pCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgDFP6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:58:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgDFP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ShWsL7pXWFWuGei4iTDZ8nde+Y2fk5HTQbOdKIP7vME=; b=AnUm6pCTgZaoKjuMKOiNX/B4cW
        XhuMR7JnJn4ShKN18HyehJYEjjJBnawp/R6XjC3WS91zIXRAw72LwADJF1xUZv55Yx5SBNrnA1kGz
        P5zjq6Ra2gb0qmFg3NN1AVSHZ6JO/hQv+zeFFqHw+n5BPA+9IvB4+0CP3HlukdomrvDsXKjkhU6zi
        MBLOeaU0Hw+i06FTZzafS4tMsCWa6Gn+ardIF723iAgyGgv3ZeXnGtMStjF7HS97lNGPLOYVlrPcr
        wfDeR8NihHLg5XcSnwHRYA0uxWU/RLhRx/5fJSx5vhSTPVXSH+++ur249pcL0SHURraRpxDl/EbWe
        RmZVkFQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLU8y-0007wl-Ry; Mon, 06 Apr 2020 15:58:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C779306102;
        Mon,  6 Apr 2020 17:58:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 821EC2BAC77C0; Mon,  6 Apr 2020 17:58:34 +0200 (CEST)
Date:   Mon, 6 Apr 2020 17:58:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 06/10] mmap locking API: convert nested write lock
 sites
Message-ID: <20200406155834.GR20730@hirez.programming.kicks-ass.net>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-7-walken@google.com>
 <20200401134234.GR20696@hirez.programming.kicks-ass.net>
 <CANN689H1VjW4aC8HuLEtb8YrVyAJ0t6OVM6w2_o1+P2=9Mt6Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689H1VjW4aC8HuLEtb8YrVyAJ0t6OVM6w2_o1+P2=9Mt6Gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:35:03AM -0700, Michel Lespinasse wrote:
> On Wed, Apr 1, 2020 at 6:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Mar 27, 2020 at 03:50:58PM -0700, Michel Lespinasse wrote:
> >
> > > @@ -26,6 +31,12 @@ static inline void mmap_write_unlock(struct mm_struct *mm)
> > >       up_write(&mm->mmap_sem);
> > >  }
> > >
> > > +/* Pairs with mmap_write_lock_nested() */
> > > +static inline void mmap_write_unlock_nested(struct mm_struct *mm)
> > > +{
> > > +     up_write(&mm->mmap_sem);
> > > +}
> > > +
> > >  static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
> > >  {
> > >       downgrade_write(&mm->mmap_sem);
> >
> > Why does unlock_nested() make sense ?
> 
> I thought it would make things more explicit to match the nested lock
> with the corresponding unlock site; however this information is not
> used at the moment (i.e. the nested unlock is implemented identically
> to the regular unlock).
> 
> Having the matching sites explicitly identified may help when
> implementing lock instrumentation, or when changing the lock type
> (another patchset I am working on needs to pass an explicit lock range
> to the nested lock and unlock sites).
> 
> I'll admit this is not a super strong argument, and can be deferred to
> when an actual need shows up in the future.

The thing is, lock-acquisition order matters _a_lot_, lock-release order
is irrelevant. ISTR there was a thread about this some 14 years ago, but
please don't ask me to go find it :/
