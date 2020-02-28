Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EFC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4418246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GlaZZ6YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgB1MyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:54:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46905 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgB1MyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:54:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id v6so1991915lfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Muv72YP2IyLq1W5BhIStFTH4ZvryXOf+fLWCoC9qpYQ=;
        b=GlaZZ6YVAEbZFHeWJ7HE/XB2QcOxTMZAalnfiEzxpYIgJO8w+ULiOB+xpiGf+8F/jY
         sRXUb55TJPb8m2LkyGPEl4f1evjISFaFNde7Q+8kBK3dIWf3blckzU6z94dDyYCS/729
         HiP1f8JckGqHh5L5pJvik21lNCv+rDcXuM3lC+YRxU0IO2vCcPbqo029h+dbt+bBnO89
         fpxxAZJDIen6JGltrxE22I3CUEJT17n50CXsEELbd+nHR9w+nh+RzyB5MvOEwd/hLn6d
         Zf5OgnzxbhwOPv/pzF59sIK/7UUReM1EWPWhcPhC9BoheP4kL1w85/lgaOIZaXjPTSnK
         QvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Muv72YP2IyLq1W5BhIStFTH4ZvryXOf+fLWCoC9qpYQ=;
        b=bMHGPCf3IcJiA7Fgm+jqEHg9paWw9LyMVQVKaFg64Ysu1rqEIdowOTVsYnb5U46bop
         qd7DHGwhJWZ4FQJOCnRTVTeDvcA4cXYxWaMDZsp2aVMa4F25zHHBeiq3BSCpeShhTeeN
         MiGVHqOgECLAXjjXQqT1Koz5/0E4pymUr4SIi0FOj62GXQ79AtVYtcpu6hH0WWeFpYrA
         gfm3MsoMSz/s+CzzoCWCDemoVp2BnUTtR+MF4WwAgj2fq1ephTgFzUWe6nHPKp1mGx+F
         hhm204yujiqI2VA9hbEus7ljQ4DBKbV7b6oLIOpdPHfzYQDRfmfKpDFzISG5uU+9l3sF
         piBQ==
X-Gm-Message-State: ANhLgQ2cL2eqw74zxwbKymEfmlNqDDcHwtxMG1EfpXAgd0TAGnH/iqX5
        0Sg45CzPLSOzSDld8W+px+0Obal9BGI=
X-Google-Smtp-Source: ADFU+vtNpUtRiOa5v7IhuGlCeOXKN3v7F2cRr+EBvSDMXgh7nGyjZ+h7iBG/GFHBfKYBFeG9tS3gBA==
X-Received: by 2002:a19:2d53:: with SMTP id t19mr2569895lft.206.1582894449304;
        Fri, 28 Feb 2020 04:54:09 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t21sm5594429ljh.14.2020.02.28.04.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 04:54:08 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5CA68101297; Fri, 28 Feb 2020 15:54:07 +0300 (+03)
Date:   Fri, 28 Feb 2020 15:54:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] huge tmpfs: try to split_huge_page() when punching hole
Message-ID: <20200228125407.5lnmjtnvlcnniokt@box>
References: <alpine.LSU.2.11.2002261959020.10801@eggly.anvils>
 <20200227084704.aolem5nktpricrzo@box>
 <alpine.LSU.2.11.2002271909250.2026@eggly.anvils>
 <20200228042646.GF29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228042646.GF29971@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 08:26:46PM -0800, Matthew Wilcox wrote:
> On Thu, Feb 27, 2020 at 08:04:21PM -0800, Hugh Dickins wrote:
> > It's good to consider the implications for hole-punch on a persistent
> > filesystem cached with THPs (or lower order compound pages); but I
> > disagree that they should behave differently from this patch.
> > 
> > The hole-punch is fundamentally directed at freeing up the storage, yes;
> > but its page cache must also be removed, otherwise you have the user
> > writing into cache which is not backed by storage, and potentially losing
> > the data later.  So a hole must be punched in the compound page in that
> > case too: in fact, it's then much more important that split_huge_page()
> > succeeds - not obvious what the fallback should be if it fails (perhaps
> > in that case the compound page must be kept, but all its pmds removed,
> > and info on holes kept in spare fields of the compound page, to prevent
> > writes and write faults without calling back into the filesystem:
> > soluble, but more work than tmpfs needs today)(and perhaps when that
> > extra work is done, we would choose to rely on it rather than
> > immediately splitting; but it will involve discounting the holes).
> 
> Ooh, a topic that reasonable people can disagree on!

Hugh wins me over on this.

Removing PMDs will not do much as we track dirty status on compound page
level.

I see two reasonable options for persistent filesystem to handle the
punch hole:

  - Keep the page and PMD mappings intact, but trigger writeback if page
    is dirty. After the page is clean we can safely punch hole in the
    storage. Following write access to the area would trigger
    page_mkwrite() which would allocate storage accordingly.

    This is reasonable behaviour if we allow to allocate THPs not fully
    covered by space allocated on disk.

  - Try to split the page or drop it completely from the page cache (after
    write back if need) before punching the hole. Fallback to the first
    scenario if we cannot split or get rid of the page.

I cannot say I strongly prefer one approach over another. The first one
fits better with THP attitude: pay for performance with memory (and
storage I guess). The second may work better if resources is limited.

> The current prototype I have will allocate (huge) pages and then
> ask the filesystem to fill them.  The filesystem may well find that
> the extent is a hole, and if it is, it will fill the page with zeroes.
> Then, the application may write to those pages, and if it does, the
> filesystem will be notified to create an on-disk extent for that write.
> 
> I haven't looked at the hole-punch path in detail, but presumably it
> notifies the filesystem to create a hole extent and zeroes out the
> pagecache for that range (possibly by removing entire pages, and with
> memset for partial pages).  Then a subsequent write to the hole will
> cause the filesystem to allocate a new non-hole extent, just like the
> previous case.
> 
> I think it's reasonable for the page cache to interpret a hole-punch
> request as being a hint that the hole is unlikely to be accessed again,
> so allocating new smaller pages for that region of the file (or just
> writing back & dropping the covering page altogether) would seem like
> a reasonable implementation decision.
> 
> However, it also seems reasonable that just memset() of the affected
> region and leaving the page intact would also be an acceptable
> implementation.  As long as writes to the newly-created hole cause the
> page to become dirtied and thus writeback to be in effect.  It probably
> wouldn't be as good an implementation, but it shouldn't lose writes as
> you suggest above.
> 
> I'm not sure I'd choose to split a large page into smaller pages.  I think
> I'd prefer to allocate lower-order pages and memcpy() the data over.
> Again, that's an implementation choice, and not something that should
> be visible outside the implementation.

Copying over the data has the same limitation as split: you need to get
refcounts to the well-known state (no extra pins) before you can proceed.
So it will not be never-fail operation.

> 
> [1] http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-pagecache

-- 
 Kirill A. Shutemov
