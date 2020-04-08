Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18711C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E2F206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nTNqL7ZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgDHNKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:10:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38557 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgDHNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:10:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so7575330ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HeDObZJxLV3Baeqk/9dArQNSiUzldFhMXAdfdoz3UVU=;
        b=nTNqL7ZGNrn6gUWwrJC1pZtcbV0TqdYBTWeApxSsfG6b73fSXTA6kNuCcKl0xKeVck
         YQkApC8olrtu2QQoUMlLN3xrBP/vZO61Jb/iqUFsWSo8EnKbPSe24f43UyhI/mzbrnNo
         vpxzrV2zX0WfTTBRop+3OjEgWq9MgUOP5Noj+lJkeyvLUMTFNrlMXI5lWOh3s2sODvdN
         LCexAWqE35hes7CrTYyXhXfHFYlPa34iXo1xXu78YzXznKaaXUXz6tl56UX33UfixWBr
         OuPhJtKTEhBVZaKlMkcG8ohFMR/272JG/UgHOR3Su0SluZYzUdDN0l0JV03p9ieNwH4y
         6TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HeDObZJxLV3Baeqk/9dArQNSiUzldFhMXAdfdoz3UVU=;
        b=uGAFRHPEd6Rq9tC0AEkUnzhEhg9/6pRseiwyYpOj8HmLqrsdt0Sac01bQcvnPTDwWZ
         ntcAY2UY5WTaeark1GwfZ1RMrRDqHYqfp9KURp2K6qS91iFEQJo1LtOdV0GwX8flKcIo
         vcBr+Pp8drm894bg/MJagOlPoCyvnaC2RlD4CSfnqMzCUUq05+p2a3r6MHo3ddn26z+/
         5pMUp/9gCVfLQ7MYBuHuGmp3F3WpdHysVMJAYRd/GOH+JPCRkEtAoXj97edl6LXza3IA
         OP68/Nlvbaqn7TUg+/kD3Ppb7pvCEpvWPJkgdeeEnfwTzQVCPmPV4QX10GBa3E0RLTcB
         1gLQ==
X-Gm-Message-State: AGi0PuaUCNmKshdB3MRrr7fKrKIojhJD2mwd6c1gldHCd3WDSgWNz5tS
        mHD+yse8Z/PHrSrPbU02ZVNoIQ==
X-Google-Smtp-Source: APiQypJPSrbG2Ixz/cE4+xztuwk2rMJ9aobAkR1ZshWniVSffrmzNbf8NLVxf2+u2KqN/5VIJU4LUQ==
X-Received: by 2002:a2e:8015:: with SMTP id j21mr4725392ljg.165.1586351441627;
        Wed, 08 Apr 2020 06:10:41 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z9sm13932102lfd.9.2020.04.08.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:10:40 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 75143101C47; Wed,  8 Apr 2020 16:10:44 +0300 (+03)
Date:   Wed, 8 Apr 2020 16:10:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across
 fork
Message-ID: <20200408131044.xzlheacvslrbwrja@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
 <b03643ba-8411-8486-737c-1bc29dd10a74@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03643ba-8411-8486-737c-1bc29dd10a74@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:50:56PM -0700, Yang Shi wrote:
> 
> 
> On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> > The page can be included into collapse as long as it doesn't have extra
> > pins (from GUP or otherwise).
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   mm/khugepaged.c | 25 ++++++++++++++-----------
> >   1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 57ff287caf6b..1e7e6543ebca 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -581,11 +581,18 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   		}
> >   		/*
> > -		 * cannot use mapcount: can't collapse if there's a gup pin.
> > -		 * The page must only be referenced by the scanned process
> > -		 * and page swap cache.
> > +		 * Check if the page has any GUP (or other external) pins.
> > +		 *
> > +		 * The page table that maps the page has been already unlinked
> > +		 * from the page table tree and this process cannot get
> > +		 * additinal pin on the page.
> > +		 *
> > +		 * New pins can come later if the page is shared across fork,
> > +		 * but not for the this process. It is fine. The other process
> > +		 * cannot write to the page, only trigger CoW.
> >   		 */
> > -		if (page_count(page) != 1 + PageSwapCache(page)) {
> > +		if (total_mapcount(page) + PageSwapCache(page) !=
> > +				page_count(page)) {
> 
> This check looks fine for base page, but what if the page is PTE-mapped THP?
> The following patch made this possible.
> 
> If it is PTE-mapped THP and the page is in swap cache, the refcount would be
> 512 + the number of PTE-mapped pages.
> 
> Shall we do the below change in the following patch?
> 
> extra_pins = PageSwapCache(page) ? nr_ccompound(page) - 1 : 0;
> if (total_mapcount(page) + PageSwapCache(page) != page_count(page) -
> extra_pins) {
> ...

Looks like you're right.

It would be nice to have a test case to demonstrate the issue.

Is there any way to trigger moving the page to swap cache? I don't see it
immediately.

-- 
 Kirill A. Shutemov
