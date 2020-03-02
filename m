Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8677B21739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HpScS+tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgCBNIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:08:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38785 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgCBNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:08:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id h22so4482140qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Exs3w+rTuzfG/N+nzVBlnN15vTvcBn9ovGBjfNtUlfg=;
        b=HpScS+tMr3PBXcYDh7E3drwKUefm/BVbmBBgSanHvjgPH7vujAcVMiMg4Wh4Q5wmnI
         g5cQHPSutObpSuyPAyajNaslzAGsIAS3j9GLvDktX/Lbhf+Ln0odxSdGZNCQt4fkduRW
         XZz96cFQpmlTAPTPZo+KEIIvXKb+NgErD42KdCsEzi6WtUUqIwflsPIBrvfkbG+ZwVBX
         9ftovfMHuyXsZUrup3P/qwFjwcWfF5cDyVilClYXlzIYZAbXGi95WGt8DiosNJ/onrzt
         6YyJXo0UMC9vV8qL6IjK3psqSgvNFAiaOb7g8hxw19tpWAnF5og3YMEhgxX4IqmsZCEw
         YgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Exs3w+rTuzfG/N+nzVBlnN15vTvcBn9ovGBjfNtUlfg=;
        b=JrwqbukznyDD+PvENUFeQ2Yll1nzcpOfarK6b8NvBkmWkoDU6CHRT74DF5xIMQ4yCn
         3VXy46FOTpYN6+ZJ8HOCa8QUW1vZoBMaxq/rk2JZBwhE1IWAjKoFVlS7ekm3Z+Ynqm9y
         x+PQfclqny4LwbXsVhSWYzyS8vlFH+i4wk9tmM7FBN5fdDRtVAe2v9tWIrM4EvKF6UeY
         HufImQYEtEpJRhs3znbrSygjlousYlcoL0mgOrGklW/Y0tZUg0/EOqM0BOCC97e/Z68b
         96eQuYyG41YlvEZqWp0fErhODA/Q7vY7SkabCVqVTEGuB2zKM18GzplJwf98sHZP4wkc
         R+zQ==
X-Gm-Message-State: ANhLgQ0Bem61efAgUAfaMbOST+zx8ITSGNbVfsm5u7pXFGid84ElFp7x
        ltzR61JrXss/1SySsS6yrMv8yg==
X-Google-Smtp-Source: ADFU+vvjNi2YSd4yT408IejJeAF2wjqWVcyc6tZ2B+sE3v7k9AqEZ+wK27ltoUOli5hvEcPv0djrWA==
X-Received: by 2002:a05:620a:22c3:: with SMTP id o3mr1775670qki.315.1583154511171;
        Mon, 02 Mar 2020 05:08:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j18sm9786093qka.95.2020.03.02.05.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 05:08:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j8ko9-00049D-Pf; Mon, 02 Mar 2020 09:08:29 -0400
Date:   Mon, 2 Mar 2020 09:08:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
Message-ID: <20200302130829.GW31668@ziepe.ca>
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
 <1582889550-9101-3-git-send-email-kernelfans@gmail.com>
 <20200228134436.GP31668@ziepe.ca>
 <CAFgQCTvLpKeLEks-NTJUqR-RhBZ10EscH=9xMF9dLhhUBNM29w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvLpKeLEks-NTJUqR-RhBZ10EscH=9xMF9dLhhUBNM29w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 10:25:52AM +0800, Pingfan Liu wrote:
> On Fri, Feb 28, 2020 at 9:44 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Feb 28, 2020 at 07:32:29PM +0800, Pingfan Liu wrote:
> > > FOLL_LONGTERM suggests a pin which is going to be given to hardware and
> > > can't move. It would truncate CMA permanently and should be excluded.
> > >
> > > FOLL_LONGTERM has already been checked in the slow path, but not checked in
> > > the fast path, which means a possible leak of CMA page to longterm pinned
> > > requirement through this crack.
> > >
> > > Place a check in try_get_compound_head() in the fast path.
> > >
> > > Some note about the check:
> > > Huge page's subpages have the same migrate type due to either
> > > allocation from a free_list[] or alloc_contig_range() with param
> > > MIGRATE_MOVABLE. So it is enough to check on a single subpage
> > > by is_migrate_cma_page(subpage)
> > >
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > To: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > >  mm/gup.c | 26 +++++++++++++++++++-------
> > >  1 file changed, 19 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index cd8075e..f0d6804 100644
> > > +++ b/mm/gup.c
> > > @@ -33,9 +33,21 @@ struct follow_page_context {
> > >   * Return the compound head page with ref appropriately incremented,
> > >   * or NULL if that failed.
> > >   */
> > > -static inline struct page *try_get_compound_head(struct page *page, int refs)
> > > +static inline struct page *try_get_compound_head(struct page *page, int refs,
> > > +     unsigned int flags)
> > >  {
> > > -     struct page *head = compound_head(page);
> > > +     struct page *head;
> > > +
> > > +     /*
> > > +      * Huge page's subpages have the same migrate type due to either
> > > +      * allocation from a free_list[] or alloc_contig_range() with param
> > > +      * MIGRATE_MOVABLE. So it is enough to check on a single subpage.
> > > +      */
> > > +     if (unlikely(flags & FOLL_LONGTERM) &&
> > > +             is_migrate_cma_page(page))
> > > +             return NULL;
> >
> > This doesn't seem very good actually.
> >
> > If I understand properly, if the system has randomly decided to place,
> > say, an anonymous page in a CMA region when an application did mmap(),
> > then when the application tries to use this page with a LONGTERM pin
> > it gets an immediate failure because of the above.
> No, actually, it will fall back to slow path, which migrates and sever
> the LONGTERM pin.
> 
> This patch just aims to fix the leakage in gup fast path, while in gup
> slow path, there is already logic to guard CMA against  LONGTERM pin.
> >
> > This not OK - the application should not be subject to random failures
> > related to long term pins beyond its direct control.
> >
> > Essentially, failures should only originate from the application using
> > specific mmap scenarios, not randomly based on something the MM did,
> > and certainly never for anonymous memory.
> >
> > I think the correct action here is to trigger migration of the page so
> > it is not in CMA.
> In fact, it does this. The failure in gup fast path will fall back to
> slow path, where __gup_longterm_locked->check_and_migrate_cma_pages()
> does the migration.

It is probably worth revising the commit message so this flow is clear

Jason
