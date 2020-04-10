Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA45C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C279B20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uS8y2cKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJPzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:55:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33756 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:55:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id h6so1677886lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wu3QFPy2u02irBlE9rfNz4x/NqhgeVrVQTYnGJ11NYo=;
        b=uS8y2cKR1FfXqahoaPTcszOGRTwbPpTELgbZQoR3u9B7Lvyac8wFhWrptev/dAJMiw
         53OCXKiazqb+yZob4y0e9GoKGvdfP3GL5wTS4Rux8cvLKFEKoMcO0JdQuf8Zc3DWCZDQ
         ruu1L/FSPpqTT4+TjcyWnaZYAKvyEkJtjyRvEh47at78e20FWiFn8GB56b3IuZ4aAjIF
         BDj2L/LTNuCbjJAXxPH4O6B60kmKca6zwASadExwJTNZeN/YqcUSyR+hlUPp3e0JMVYn
         rd1qvhjvh75W7MIHhdXR7Lf4JKrRs5RgsnR4bF6NZslbOIbULzx8/+CLEPG4982Oqknn
         O50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wu3QFPy2u02irBlE9rfNz4x/NqhgeVrVQTYnGJ11NYo=;
        b=GWVy4ik4C+yUvmOUy5NquOUQ2rA7j4hMU0OzxLd+3g5iv4EezKA+1pyH2XbT47VK2s
         sgJEvAESwxU3E2Ly7cUMKqBnV2teEspGxz4n8o+8UYdTd18jVENtbfmEvg8jW3pdsUpQ
         N9FbQI3XVm8hpk8rFSGqK9jdQG9Sa3dpfJJ07aXAazqn2TXjforMIBp6+WGIQDPGI+AK
         m2H+SN+WOBhxdbI//9u+bWlmuuivH+lZRb60wazblEtJ94LqfCckRg3n5vOtwX/wVHa1
         GE18Kbn8/1vJWVzgZWEv5Ibmi2JfEJILnXD4/IZjaVnXxTTdWz0P5MyJwZZkYU9LrTsQ
         Y9Nw==
X-Gm-Message-State: AGi0PuZL+7Huz35UonmTa4l+awHFvWZVtJvKK5SCjdcqRmHOvYTInUOk
        vjpKsKSEl27Cs2JCF9Y4mDwhoQ==
X-Google-Smtp-Source: APiQypKqhD0biYJV7Fu66NPT1AkQUwiqPCbO74jBZ9Rt7b+f2jDah+wGcy+H7J0rwD1hhJH2g1ANsw==
X-Received: by 2002:ac2:5611:: with SMTP id v17mr2990420lfd.137.1586534144915;
        Fri, 10 Apr 2020 08:55:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c22sm1285409ljh.66.2020.04.10.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 08:55:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4C005102110; Fri, 10 Apr 2020 18:55:43 +0300 (+03)
Date:   Fri, 10 Apr 2020 18:55:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across
 fork
Message-ID: <20200410155543.i66uz6pbynfvkhak@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
 <5a57635b-ed75-8f09-6f0c-5623f557fc55@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a57635b-ed75-8f09-6f0c-5623f557fc55@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:30:07PM -0700, John Hubbard wrote:
> On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> > The page can be included into collapse as long as it doesn't have extra
> > pins (from GUP or otherwise).
> 
> Hi Kirill,
> 
> s/callapse/collapse/ in the Subject line.
> 
> The commit message should mention that you're also removing a
> VM_BUG_ON_PAGE().
> 
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
> 
> 
> I'd recommend this wording instead, for the last two lines:
> 
> 		 * from the page table tree. Therefore, this page will not
> 		 * normally receive any additional pins.

I guess I'm not clear enough.

The point is that the page cannot get any new pins from this process. It
can get new pin from other process after the check. But it is fine because
if the page is mapped multiple times it has to be write-protected (CoW
after fork()) and we can rely that page's content will not change under
us.

Does it make sense? Wording suggestions are welcome.

> > +		 *
> > +		 * New pins can come later if the page is shared across fork,
> > +		 * but not for the this process. It is fine. The other process
> > +		 * cannot write to the page, only trigger CoW.
> >   		 */
> > -		if (page_count(page) != 1 + PageSwapCache(page)) {
> > +		if (total_mapcount(page) + PageSwapCache(page) !=
> > +				page_count(page)) {
> 
> 
> I think it's time to put that logic ( "does this page have any extra references")
> into a small function. It's already duplicated once below. And the documentation is
> duplicated as well.

Fair enough.

But comments have to stay where they are. Because the context is
different. The first time we check speculatively, before the page table is
unlinked from the page table tree and this check is inherintly racy.
Unlike the second one.

> I took a quick peek at this patch because, after adding pin_user_pages*() APIs earlier
> to complement get_user_pages*(), I had a moment of doubt here: what if I'd done  it in
> a way that required additional logic here? Fortunately, that's not the case: all
> pin_user_pages() calls on huge pages take a "primary/real" refcount, in addition
> to scribbling into the compound_pincount_ptr() area. whew. :)
> 
> 
> 
> >   			unlock_page(page);
> >   			result = SCAN_PAGE_COUNT;
> >   			goto out;
> > @@ -672,7 +679,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
> >   		} else {
> >   			src_page = pte_page(pteval);
> >   			copy_user_highpage(page, src_page, address, vma);
> > -			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
> >   			release_pte_page(src_page);
> >   			/*
> >   			 * ptl mostly unnecessary, but preempt has to
> > @@ -1206,12 +1212,9 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
> >   			goto out_unmap;
> >   		}
> > -		/*
> > -		 * cannot use mapcount: can't collapse if there's a gup pin.
> > -		 * The page must only be referenced by the scanned process
> > -		 * and page swap cache.
> > -		 */
> > -		if (page_count(page) != 1 + PageSwapCache(page)) {
> > +		/* Check if the page has any GUP (or other external) pins */
> > +		if (total_mapcount(page) + PageSwapCache(page) !=
> > +				page_count(page)) {>   			result = SCAN_PAGE_COUNT;
> >   			goto out_unmap;
> >   		}
> > 
> 
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA

-- 
 Kirill A. Shutemov
