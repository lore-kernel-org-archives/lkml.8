Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE479C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A78206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="klU2LSQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgDHNFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:05:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36583 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgDHNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:05:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id b1so7563688ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GBM3DKqxjFqPBu7r80ee330RPi5SgUStiHzhsao8c00=;
        b=klU2LSQfMNQxZa8JpopxGXOGz/fsc/92q4T9qKbBumLy2uVhDltpjvQ3BKRmFPTLkL
         ZcCGr4Y/6m29LKkyRIAJD5lGHFwMGdCkn6qG89wDkOZ9GwF26GoX7T/pxsGNZ23GwQ+x
         5IWxd2fJOJPwF9NgERabUagw0XQTN5Z9fivRSkHBivGx5IgCkb4f12Rxm1l08pc2IOeK
         hx84RrIhfuinK7RzCxMpvDCmAGCof9zVI4toAA+lb3Uu4I1u5vDwQQGOdwWtjCbgs4h2
         a/p5/Rq93IpXYfFvTeC/rXhz6Jug8zxA9qa9/5BMiSP6W7NrjYU84r2QPx2124JuG/y/
         BwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBM3DKqxjFqPBu7r80ee330RPi5SgUStiHzhsao8c00=;
        b=p8GmWvIgni24lf2oASBjVjvNMjGbLHCmJOMjDBVM3rNVCOxJfpKMdkHaL1cXbDXQNi
         rflsROWn7DRNQG3pCG14aYdjYieGnVpzUfY0c63WjHzuhYclvxs1Pac+LS8l3UpfTX6S
         nAWnOspqiHJu8oJpJju0GDlxEH6rAhK6IqYDmoKWjifIf9+eIh5Fpv1kR7S8DMTWl+1l
         KKMPw1WMGcFgoB2wSvIvv7C6AFPZwrCS3iyL5h0gGEm4y52oSUo2zxXQ3z7bVs933Mi7
         +8aJ6VebohHhy2yvZOMe27RiVDAfeSTuNpY+botpgSKsR+F/R4pf5lYoeBo553kytV1x
         xItQ==
X-Gm-Message-State: AGi0PuaH1Eusu/x4gWREjbkIUCFRhYjx0kK14PCIfuuzkWZbHHNkB0SI
        OFFZh5k7E4IQBPOn5C1+rIWrfQ==
X-Google-Smtp-Source: APiQypKIUJ4/nEHxqc1YLvFqkFWgvb0Gg5OtNloizFa5PpOayv2HzxVYp+7Rd9m5wD40tzS3EjlLkA==
X-Received: by 2002:a2e:9c4:: with SMTP id 187mr4986069ljj.89.1586351130188;
        Wed, 08 Apr 2020 06:05:30 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j22sm15748998lfg.96.2020.04.08.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:05:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BA5ED101C47; Wed,  8 Apr 2020 16:05:32 +0300 (+03)
Date:   Wed, 8 Apr 2020 16:05:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 4/8] khugepaged: Drain LRU add pagevec after swapin
Message-ID: <20200408130532.ktztqf5fabo3x3cd@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-5-kirill.shutemov@linux.intel.com>
 <620a61ed-be87-f60e-f562-379cd3adbe08@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <620a61ed-be87-f60e-f562-379cd3adbe08@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:29:11AM -0700, Yang Shi wrote:
> 
> 
> On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> > __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> > pagevec. It's petty common for swapin case: we swap in pages just to
> > fail due to the extra pin.
> > 
> > Drain LRU add pagevec on sucessfull swapin.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   mm/khugepaged.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index fdc10ffde1ca..57ff287caf6b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -940,6 +940,11 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
> >   	}
> >   	vmf.pte--;
> >   	pte_unmap(vmf.pte);
> > +
> > +	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
> > +	if (swapped_in)
> > +		lru_add_drain();
> 
> There is already lru_add_drain() called in swap readahead path, please see
> swap_vma_readahead() and swap_cluster_readahead().

But not for synchronous case. See SWP_SYNCHRONOUS_IO branch in
do_swap_page().

Maybe we should drain it in swap_readpage() or in do_swap_page() after
swap_readpage()? I donno.

-- 
 Kirill A. Shutemov
