Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAADC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402F7207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHUPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:48:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgHUPr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:47:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FE7DAC12;
        Fri, 21 Aug 2020 15:48:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F02CB1E1312; Fri, 21 Aug 2020 17:47:56 +0200 (CEST)
Date:   Fri, 21 Aug 2020 17:47:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200821154756.GC3432@quack2.suse.cz>
References: <20200811183950.10603-1-peterx@redhat.com>
 <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1>
 <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1>
 <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz>
 <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-08-20 05:27:40, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 3:13 AM Jan Kara <jack@suse.cz> wrote:
> >
> > > +             if (page_mapcount(page) != 1 && page_count(page) != 1) {
> >
> > So this condition looks strange to me... Did you mean:
> >
> >                 if (page_mapcount(page) != 1 || page_count(page) != 1)
> 
> Duh. Yes.
> 
> > > -             if (PageKsm(vmf->page)) {
> >
> > Also I know nothing about KSM but looking at reuse_ksm_page() I can see it
> > plays some tricks with page index & mapping even for pages with page_count
> > == 1 so you cannot just drop those bits AFAICT.
> 
> Yeah, I wasn't really sure what we want to do.
> 
> In an optimal world, I was thinking that we'd actually do exactly what
> we do at munmap time.
> 
> Which is not to get the page lock at all. Just look at what
> zap_pte_range() does for an a page when it unmaps it:
> 
>                         page_remove_rmap(page, false);
> 
> and that's it. No games.
> 
> And guess what? That "'page_remove_rmap()" is what wp_page_copy() already
> does.

I was more concerned about the case where you decide to writeably map (i.e.
wp_page_reuse() path) a PageKsm() page. That path does not touch
page->mapping in your code AFAICS. And AFAIU the code in mm/ksm.c you are
not supposed to writeably map PageKsm() pages without changing
page->mapping (which also effectively makes PageKsm() return false) but I
don't see anything in your code that would achieve that because KSM code
references a page without being accounted in page_count() for $reasons (see
comment before get_ksm_page()) and instead plays tricks with validating
cookies in page->mapping...

> So I really think *all* of these games we play are complete garbage
> and completely wrong.
> 
> Because the zap_page_range() path is a *lot* more common than the WP
> path, and triggers for every single page when we do munmap or exit or
> whatever.
> 
> So why would WP need to do anything else for correctness? Absolutely
> no reason I can see.
> 
> > Also I'm not sure if dropping this is safe for THP - reuse_swap_page()
> > seems to be a misnomer and seems to do also some THP handling.
> 
> Again, I think that's a bogus argument.
> 
> Because this all is actually not the common path at all, and the thing
> is, the common path does none of these odd games.
> 
> I really think this COW handling magic is just legacy garbage because
> people have carried it along forever and everybody is worried about
> it. The fact is, the "copy" case is always safe, because all it does
> is basically the same as zap_page_range() does, with just adding a new
> page instead.

And also here I was more concerned that page_mapcount != 1 || page_count !=
1 check could be actually a weaker check than what reuse_swap_page() does.
So the old code could decide to copy while your new code would decide to go
the wp_page_reuse() path. And for this case I don't see how your "but unmap
path is simple" argument would apply...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
