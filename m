Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80BC2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC90206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="llEGJ9lB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgC3Viv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:38:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34032 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3Viv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:38:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id e7so15549019lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uCxy/V6956TjkzZDFahzb5xk0CquL6PGhHn2gPT6QRU=;
        b=llEGJ9lBbSNAzPFWre1EMYa5L5y95ZPiRM0CaJhpzY6pX8wzLDB8bhMqdpMFR+8m/4
         NM5ejm1kBNM0OX9A1Xo95aK++V0vfXbXmKYGssRUgf94CAlE5gTTUFTnYb1QQZdIBKFW
         tIcV0euZZY/IKJP7TTpAWjTEVyEbrUwcI5Se93AIBDL84kPi4eS1NuU9wXt0SWd2/leI
         J6/+QOB4NNPPEahfr0WGk26hRSz+BZrzej7OxlDTcmA8qNDZi7QK1AukPwD5XH5i8ttA
         4ea/nccyJLGQIQelaTWrP+8BVYOcd3QTiX2Ujdd2c5G9r4Iw6nyyJOryYHQrGkjVSpJG
         LGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uCxy/V6956TjkzZDFahzb5xk0CquL6PGhHn2gPT6QRU=;
        b=QgKlIKnTUgODHuM7tgSq3FN3Qx3p6lDwNgn8weXeRYO681knMeFa9Mw4zf5+i2mnCC
         hFIfIzMp/bjLLqTaD4kBirME6it9tZk9GBqr9yp0KjP0DkEfJ8JyQgSunLGcDuAWYq/H
         cRQM0MM8mKIbN8v0oPTTOueWRBJ2F7qS2jhvwoifqbstFB0I1yk5pEA/jF54GTZiz2zL
         gZJXJqXXz1YTSFMoRZJ+3v4YYXN3/22HbEmsfg4QPB6MNJ/NOcyswCDxjvd/2gQ7JAeG
         2r//LI1unyhqvmWI2fNaAT6p4qnc5cxoeeJA2ayYF+LE1Yb+sojHvUnCBF9aLAhyhHSO
         OyvQ==
X-Gm-Message-State: AGi0PuYge2q1ubQ+0wyGWm4iL1dBGSj4ZFF0H7iT2npSRRVGrbONm62Z
        ArcwFYyFEPPXVyW8Krrx+2a2hg==
X-Google-Smtp-Source: APiQypJChlBcMBAVZeVK7plWc78eRD6sZth/Ah1ckPyI5Hxgoy6OXUxyimasJLtFUCtdIQ+kVJQQNQ==
X-Received: by 2002:a19:4a50:: with SMTP id x77mr9258764lfa.159.1585604328816;
        Mon, 30 Mar 2020 14:38:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d6sm9644083lfn.72.2020.03.30.14.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:38:48 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6E055101DCA; Tue, 31 Mar 2020 00:38:48 +0300 (+03)
Date:   Tue, 31 Mar 2020 00:38:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/7] khugepaged: Drain LRU add pagevec to get rid of
 extra pins
Message-ID: <20200330213848.xmi3egioh7ygvfsz@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
 <CAHbLzkoe-07mxAuA18QUi=H21_Ts0JcbP2SUT=02ZTPhaQB6ug@mail.gmail.com>
 <20200328121829.kzmcmcshbwynjmqc@box>
 <CAHbLzkr8YQAG0GbdJn9=Ey7B2M11dxnGCc2nfN-G1fmFiv+BOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkr8YQAG0GbdJn9=Ey7B2M11dxnGCc2nfN-G1fmFiv+BOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:30:14AM -0700, Yang Shi wrote:
> On Sat, Mar 28, 2020 at 5:18 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Fri, Mar 27, 2020 at 11:10:40AM -0700, Yang Shi wrote:
> > > On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
> > > <kirill@shutemov.name> wrote:
> > > >
> > > > __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> > > > pagevec. It's petty common for swapin case: we swap in pages just to
> > > > fail due to the extra pin.
> > > >
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ---
> > > >  mm/khugepaged.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 14d7afc90786..39e0994abeb8 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -585,11 +585,19 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > > >                  * The page must only be referenced by the scanned process
> > > >                  * and page swap cache.
> > > >                  */
> > > > +               if (page_count(page) != 1 + PageSwapCache(page)) {
> > > > +                       /*
> > > > +                        * Drain pagevec and retry just in case we can get rid
> > > > +                        * of the extra pin, like in swapin case.
> > > > +                        */
> > > > +                       lru_add_drain();
> > >
> > > This is definitely correct.
> > >
> > > I'm wondering if we need one more lru_add_drain() before PageLRU check
> > > in khugepaged_scan_pmd() or not? The page might be in lru cache then
> > > get skipped. This would improve the success rate.
> >
> > Could you elaborate on the scenario, I don't follow.
> 
> I mean the below change:
> 
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1195,6 +1195,9 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>                         goto out_unmap;
>                 }
>                 khugepaged_node_load[node]++;
> +               if (!PageLRU(page))
> +                       /* Flush the page out of lru cache */
> +                       lru_add_drain();
>                 if (!PageLRU(page)) {
>                         result = SCAN_PAGE_LRU;
>                         goto out_unmap;
> 
> If the page is not on LRU we even can't reach collapse_huge_page(), right?

Yeah, I've archived the same by doing lru_add_drain_all() once per
khugepaged_do_scan(). It is more effective than lru_add_drain() inside
khugepaged_scan_pmd() and should have too much overhead.

The lru_add_drain() from this patch moved into swapin routine and called
only on success.

-- 
 Kirill A. Shutemov
