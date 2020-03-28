Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35D7C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DEF20723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SmmEE0YZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1M1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:27:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44588 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgC1M1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:27:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so12925589lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ZefhR0E03euYQPplWgD/MUqgsa6Q0Ji04STFlWdgEg=;
        b=SmmEE0YZ9QIPA1i1pTx1mo30QLVV0objMkhszcqncFCexP7nncxpgMgGnDfUdx8kCv
         f0B+w2oFRISBJCGCr+SVj0JGc/caxnIS73dhvz2W1zNF457USDmnmPnuiK3ubCeKNrxv
         7z2rmPK7I67ZZf2Op923oFsB7ff2GX0/jnIHB7HDxyQOi9wd64VV0rGt/kaNp9qzCpb/
         NKFu31NQuKHp0cXjW5TZTroWn/J6JH5AF1WnXl2IQ7CmKpjCk33uBoT+/u1Bvazut1XI
         /7sZg37kfRIYIizcnNfW5/8T3ThcEOwtGBpWvoP0mu4iujU21fpn5XwuKYGBmLci2HTn
         h1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZefhR0E03euYQPplWgD/MUqgsa6Q0Ji04STFlWdgEg=;
        b=B/8d3vgahKHrr9kdcAWVUc/RdQX3G00rc6Rx4Cadq/+TkeMNYipmBPs/B8se6Z5369
         vell4Eynsnq98MM7rzgP7Cxj7mgjtb+v68GEGf037IqV/N2UpG4armu72blvDiP6aUIh
         lJvh7M+qyX8USO8LCDq1fu6SWspF3R+GruE9w8RnDycQWj+d9yUcows336w8YTIPzMZ8
         /1KTxMgOnrH01Oy9kCiULjCVnlOLBL3zpqNzMROoDkq33gtlP/BGm9+VZSpZvbAkHwvb
         A2u28jW9bZSKaRku+ushGT5sHGkkkeF/UehC3jCUTkLGEaWANgVtsMBbDSWpC9amMyhi
         dohg==
X-Gm-Message-State: AGi0PuZhrMmuDRrV5vKCEasmtPyT0SRiWK2GVKWjs5SjINDpnovBy2c4
        bBQqBHmLhtwuiY/R/473OBI0rQ==
X-Google-Smtp-Source: APiQypJdQnrTjffrG+IC37I+WDVy0NdER7UvNDXjFJ+siv9fUqXeXm5eXa+QVZYByhst3TrtEPzDqw==
X-Received: by 2002:a2e:9c9:: with SMTP id 192mr1956710ljj.77.1585398451693;
        Sat, 28 Mar 2020 05:27:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i11sm4337022lfo.84.2020.03.28.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 05:27:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 16BD0100D25; Sat, 28 Mar 2020 15:27:35 +0300 (+03)
Date:   Sat, 28 Mar 2020 15:27:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Message-ID: <20200328122735.nzius2ikvnyvpf2f@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
 <CAHbLzkoVq-ssduiPwdzcsL2bVhPwmw4X9ktAO0CYOVAi8H84oA@mail.gmail.com>
 <20200328003424.kusu2xnhnlbmnfzl@box>
 <CAHbLzkpV7=EGQVeEEZ_jhpWa-nnVkiZ4_Qa=0KoZCRntprWhgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpV7=EGQVeEEZ_jhpWa-nnVkiZ4_Qa=0KoZCRntprWhgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 06:09:38PM -0700, Yang Shi wrote:
> On Fri, Mar 27, 2020 at 5:34 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Fri, Mar 27, 2020 at 11:53:57AM -0700, Yang Shi wrote:
> > > On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
> > > <kirill@shutemov.name> wrote:
> > > >
> > > > We can collapse PTE-mapped compound pages. We only need to avoid
> > > > handling them more than once: lock/unlock page only once if it's present
> > > > in the PMD range multiple times as it handled on compound level. The
> > > > same goes for LRU isolation and putpack.
> > > >
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ---
> > > >  mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
> > > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index b47edfe57f7b..c8c2c463095c 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
> > > >
> > > >  static void release_pte_page(struct page *page)
> > > >  {
> > > > +       /*
> > > > +        * We need to unlock and put compound page on LRU only once.
> > > > +        * The rest of the pages have to be locked and not on LRU here.
> > > > +        */
> > > > +       VM_BUG_ON_PAGE(!PageCompound(page) &&
> > > > +                       (!PageLocked(page) && PageLRU(page)), page);
> > > > +
> > > > +       if (!PageLocked(page))
> > > > +               return;
> > > > +
> > > > +       page = compound_head(page);
> > > >         dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> > >
> > > We need count in the number of base pages. The same counter is
> > > modified by vmscan in base page unit.
> >
> > Is it though? Where?
> 
> __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken) in
> vmscan.c, here nr_taken is nr_compound(page), so if it is THP the
> number would be 512.

Could you point a particular codepath?

> So in both inc and dec path of collapse PTE mapped THP, we should mod
> nr_compound(page) too.

I disagree. Compound page is represented by single entry on LRU, so it has
to be counted once.

-- 
 Kirill A. Shutemov
