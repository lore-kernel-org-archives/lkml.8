Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E1C24699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJHRWfeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgCBC0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 21:26:09 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39374 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCBC0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:26:08 -0500
Received: by mail-il1-f194.google.com with SMTP id w69so7981266ilk.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 18:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4qMUbngHU0JjUQMSTsOk2cYBS6dppyjH0RtlnGG11g=;
        b=NJHRWfehqRMtZFiO090VtWnqvM2HUpfsq9RP2Pd4nEcecHtnwqN0INK12NILkk5S5N
         ZMCq3Qpd3gOjOdv+RRQg6udkYVXM+mMxwJRaBv+CxUXXx+DoAb1eXK7URMBUibZ3mB0b
         ZcpQ/8DalYgarvb2O/oV6n+f4CTMaa6JcApciExGI4ChXr7m2QdVV4W9aQi32rxISS4J
         oAGUEvlvF01HpG8vzAF/eWL6GDFjod5j3i5wHUWbSYiwfEXultPPoH7SksZqOkON5z2f
         MF5gxmWkMyxSteXwGFHsjszqKt0rDcqmhArHP+PYap6C4Oj7MlpR5ZxoydVwSQyxHSP8
         NgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4qMUbngHU0JjUQMSTsOk2cYBS6dppyjH0RtlnGG11g=;
        b=UT/vrugjRg6xWJLqtTWOQRH/X4OB/4NWxHzHXTNwMgnaCVTEuqZMfadTROJRWy4O7p
         /ZBlsVGxI/5JAXTbxCsDV/m/KFQQS4bNChW+yQurkftG5dvHE9VgrTLWbtIVKUx89FW2
         7yRj5vEFt3YYtejnUFzqjB1t1TNfrDyZ0YinaqxdnBcg84Y/tHKNT5MmyIVAvJCFkgon
         ZRAdbUrJDyhYH4ToR352tr/s+TnXNxchfm+YMRZ+rrRYLSJ0vzbDr/SXq3Neb62wWPVe
         goXkm0mhaEG3GPnMszvf2fhnOGZ0aYh3++I+YkpWCYBakKRPDE6+ZcL3aXNyYxySjeJT
         D0Zg==
X-Gm-Message-State: APjAAAUJrMHnUBOW0NJl955JyK1KUOle/pU4p4Ed6MfpJjj0o6LsjxjI
        nEkpGJ/IyFO/dkmU4Xf5VE7CF119xAQlLkmg/9Dc8TY=
X-Google-Smtp-Source: APXvYqwSQC21otYbbvTNA4Fx84pG0p1i4QlVd6wCX1RnOrC6Iskv8G9LRbH0IDYERcOvWTb4FGEqXTWs7Es3mQLaBqQ=
X-Received: by 2002:a92:8cca:: with SMTP id s71mr6002884ill.179.1583115968314;
 Sun, 01 Mar 2020 18:26:08 -0800 (PST)
MIME-Version: 1.0
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
 <1582889550-9101-3-git-send-email-kernelfans@gmail.com> <20200228134436.GP31668@ziepe.ca>
In-Reply-To: <20200228134436.GP31668@ziepe.ca>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 2 Mar 2020 10:25:52 +0800
Message-ID: <CAFgQCTvLpKeLEks-NTJUqR-RhBZ10EscH=9xMF9dLhhUBNM29w@mail.gmail.com>
Subject: Re: [PATCHv5 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 9:44 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Feb 28, 2020 at 07:32:29PM +0800, Pingfan Liu wrote:
> > FOLL_LONGTERM suggests a pin which is going to be given to hardware and
> > can't move. It would truncate CMA permanently and should be excluded.
> >
> > FOLL_LONGTERM has already been checked in the slow path, but not checked in
> > the fast path, which means a possible leak of CMA page to longterm pinned
> > requirement through this crack.
> >
> > Place a check in try_get_compound_head() in the fast path.
> >
> > Some note about the check:
> > Huge page's subpages have the same migrate type due to either
> > allocation from a free_list[] or alloc_contig_range() with param
> > MIGRATE_MOVABLE. So it is enough to check on a single subpage
> > by is_migrate_cma_page(subpage)
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > To: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> >  mm/gup.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index cd8075e..f0d6804 100644
> > +++ b/mm/gup.c
> > @@ -33,9 +33,21 @@ struct follow_page_context {
> >   * Return the compound head page with ref appropriately incremented,
> >   * or NULL if that failed.
> >   */
> > -static inline struct page *try_get_compound_head(struct page *page, int refs)
> > +static inline struct page *try_get_compound_head(struct page *page, int refs,
> > +     unsigned int flags)
> >  {
> > -     struct page *head = compound_head(page);
> > +     struct page *head;
> > +
> > +     /*
> > +      * Huge page's subpages have the same migrate type due to either
> > +      * allocation from a free_list[] or alloc_contig_range() with param
> > +      * MIGRATE_MOVABLE. So it is enough to check on a single subpage.
> > +      */
> > +     if (unlikely(flags & FOLL_LONGTERM) &&
> > +             is_migrate_cma_page(page))
> > +             return NULL;
>
> This doesn't seem very good actually.
>
> If I understand properly, if the system has randomly decided to place,
> say, an anonymous page in a CMA region when an application did mmap(),
> then when the application tries to use this page with a LONGTERM pin
> it gets an immediate failure because of the above.
No, actually, it will fall back to slow path, which migrates and sever
the LONGTERM pin.

This patch just aims to fix the leakage in gup fast path, while in gup
slow path, there is already logic to guard CMA against  LONGTERM pin.
>
> This not OK - the application should not be subject to random failures
> related to long term pins beyond its direct control.
>
> Essentially, failures should only originate from the application using
> specific mmap scenarios, not randomly based on something the MM did,
> and certainly never for anonymous memory.
>
> I think the correct action here is to trigger migration of the page so
> it is not in CMA.
In fact, it does this. The failure in gup fast path will fall back to
slow path, where __gup_longterm_locked->check_and_migrate_cma_pages()
does the migration.

Thanks,
Pingfan
