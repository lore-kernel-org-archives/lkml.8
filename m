Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B68C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF58020771
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bOkEv+1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504693AbgDNT02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504656AbgDNTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:24:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D48C061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:06:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x66so14535596qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kecgSrOyjcStfXPghMK6SzkzEVdVsqes3tfF9y2jXlE=;
        b=bOkEv+1t1+HuXCMyXbGYxfFtEqJ+NbCQPE3goSDOBRgg4hNu8GdpT9EiB/WRao0s7M
         fJk16f85uhlJcB/K0hcO9PcMH/simleg+MmPQLGYQxR7ZFz5175w7NuhkowUZlmKu9wd
         nKil+jfbGKS870CAMNSY1PKFajTBU3jhtdpIPbiJhCZSxJn5QwUBVqnUc3oYof4GwJNP
         UZiXsUoB2WvUmT4X/yNl2rVLLmpW3P6b5p8FibbTSstrGi04hcItezleuquTK6gGkE9S
         9xgTPzXDqDKdWrBlzGMJ675u/VhKrfuoKfi359fWV+Nd5Nn75AS82XOM6v+nRa2gQOHD
         mIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kecgSrOyjcStfXPghMK6SzkzEVdVsqes3tfF9y2jXlE=;
        b=XjqfIan0Ku9P3NLrTWsL6KjhvyLK/HuRurYz6tnaQtt0jjPf5KpECJvqcX9oM6mqXd
         rKdPBcjSZvOJwafxmmXsXXaIuwrZOpQ/ZbB9o+t/hPvA0ZY3sSRdltQEAEQcHt/FHkUt
         T2NKN+IjY9YmL1Uqg3O5vQPuX6SvEtTE/d6Fves806wE60sSaShkawye92BuZuTP0lju
         oN4ssrOdG+coOl5u1SwqqO2cl/PsSHRZCd7dNqfzBcb6mF0b1WIQh+dMPEKphoznnQU/
         bsmIgJKSTOY7OfEvKKKgQstK13VqkjvYOjwGgepH44tREYdFaP2F4UQ4bfCxIxZIJAoF
         LANg==
X-Gm-Message-State: AGi0PubFnw8BbubQA22zZnsId3sRNkcE4+6yB+XjWxb+5WtKibjgwUP0
        eRz1gEhU/a73fD1Z09Sgh1zZ+w==
X-Google-Smtp-Source: APiQypL6Ne3BjkNL4lVw6NUh1f09yNPoMm1MnMTn/Ay/nhenSPl5AKVKuYPxt/K6ZsWnq9cFnfeqxg==
X-Received: by 2002:a37:a407:: with SMTP id n7mr10784701qke.235.1586891182628;
        Tue, 14 Apr 2020 12:06:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x16sm10267975qts.0.2020.04.14.12.06.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:06:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQt2-0003LQ-PT; Tue, 14 Apr 2020 16:06:20 -0300
Date:   Tue, 14 Apr 2020 16:06:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/gup: dereference page table entry using helper
Message-ID: <20200414190620.GJ5100@ziepe.ca>
References: <1586877001-19138-1-git-send-email-agordeev@linux.ibm.com>
 <20200414163234.GG5100@ziepe.ca>
 <20200414185829.GB1853609@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414185829.GB1853609@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:58:29AM -0700, Ira Weiny wrote:
> On Tue, Apr 14, 2020 at 01:32:34PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 14, 2020 at 05:10:01PM +0200, Alexander Gordeev wrote:
> > > Commit 0005d20 ("mm/gup: Move page table entry dereference
> > > into helper function") wrapped access to page table entries
> > > larger than sizeof(long) into a race-aware accessor. One of
> > > the two dereferences in gup_fast path was however overlooked.
> > > 
> > > CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > CC: linux-mm@kvack.org
> > > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > >  mm/gup.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index d53f7dd..eceb98b 100644
> > > +++ b/mm/gup.c
> > > @@ -2208,7 +2208,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > >  		if (!head)
> > >  			goto pte_unmap;
> > >  
> > > -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > > +		if (unlikely(pte_val(pte) != pte_val(gup_get_pte(ptep)))) {
> > 
> > It doesn't seem like this needs the special helper as it is just
> > checking that the pte hasn't changed, it doesn't need to be read
> > exactly.
> > 
> > But it probably should technically still be a READ_ONCE. Although I
> > think the atomic inside try_grab_compound_head prevents any real
> > problems.
> 
> I think we should go for consistency here and use the helper function.

It seems quite expensive to do two more unncessary barriers..

Jason
