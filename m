Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FD8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3458221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="tVV5cEmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHGOfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgHGOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:35:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A529C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 07:35:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w25so2412573ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=inTZQ+SWYKPqvxN97kdR63lIdHSrqzj2OXPwaYUerNM=;
        b=tVV5cEmOsoVkpic+RAt7gGQ+6JZO47nkHVfqCnOdbRwyV+HZoVQegKtt7Ub5RK9fDH
         X9vNcNIYpD+oPtRJNls9f/f27kdfZmkHtAtXug+62bxrpe/Yc0ObZm2xdhRgmeXipTJp
         OqotTxnQM+jyRSboTMHSq8oLthxd+yiMZlSnA3ozJmgB71LzU9mux6WVLLXX2YJPEaAN
         FPdBMw17/evHRJef0BCO+5xLbc8kqkJIf6A11fNMsujV4BDKK6CRhzApYm+AmfhKer7U
         TKcBBFAzGzpj8Gq4KHVcdcIpEMieDkDOp5meRL0mabUFOYzfrTPYOk2Vfpn1iJGpZ2kM
         2R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=inTZQ+SWYKPqvxN97kdR63lIdHSrqzj2OXPwaYUerNM=;
        b=g46/OrQILoeSs64qbGRzxpEF0zoAwofgKNJItZIkWUhWVnMXNaZXOI7/W43w9I7n92
         ss6NZJd4bJytQuFhU+Psl9PXrMqehv0CNPgGjLoxAUygEuuAQjxOyifidO+7b9qhsymN
         O6hQLRya2gVfZYR2YK3zy+F2tzHF5aaUX7AHse8YUv4OfdAlAgTuiL4fnMsZvw432ZZ9
         YrXNzvv62/w+0KreUqFxU1RWn8PXLoYeubvY0UdBP3UdyLczgMefNgR3loMgwVvqpgaY
         FMS5YpesH+QmU602YyJ2e3NcrM4XjSMRbt+N3EjzwRdQdUHRUQKFq2BlDhIO/vfFPKbF
         lrWA==
X-Gm-Message-State: AOAM5303OYQaHxgidGlAXubyN31unoYYKDmKR9V++kGM1JGthl4OSS2t
        M2hUlOCcBrzFKEl2cbCSg6aDqQ==
X-Google-Smtp-Source: ABdhPJzTmAu7Iyyk65CRjuUmbecqmhTDzTeLgYkm6VB8eNGZRAFj9Wl9uswFxVz1GbAkjNWqxEAadQ==
X-Received: by 2002:a2e:898d:: with SMTP id c13mr5842062lji.236.1596810906217;
        Fri, 07 Aug 2020 07:35:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u10sm3923054lju.113.2020.08.07.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 07:35:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 280E5102FA7; Fri,  7 Aug 2020 17:35:04 +0300 (+03)
Date:   Fri, 7 Aug 2020 17:35:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        willy@infradead.org, cai@lca.pw, rppt@linux.ibm.com,
        vbabka@suse.cz, william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
Message-ID: <20200807143504.4kudtd4xeoqaroqg@box>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804214807.169256-1-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 02:48:07PM -0700, John Hubbard wrote:
> If a compound page is being split while dump_page() is being run on that
> page, we can end up calling compound_mapcount() on a page that is no
> longer compound. This leads to a crash (already seen at least once in
> the field), due to the VM_BUG_ON_PAGE() assertion inside
> compound_mapcount().
> 
> (The above is from Matthew Wilcox's analysis of Qian Cai's bug report.)
> 
> A similar problem is possible, via compound_pincount() instead of
> compound_mapcount().
> 
> In order to avoid this kind of crash, make dump_page() slightly more
> robust, by providing a pair of simpler routines that don't contain
> assertions: head_mapcount() and head_pincount().

I find naming misleading. head_mapcount() and head_pincount() sounds like
a mapcount/pincount of the head page, but it's not. It's mapcount and
pincount of the compound page.

Maybe compound_mapcount_head() and compound_pincoun_head()? Or
__compound_mapcount() and __compound_pincount().

> For debug tools, we don't want to go *too* far in this direction, but
> this is a simple small fix, and the crash has already been seen, so it's
> a good trade-off.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> Hi,
> 
> I'm assuming that a fix is not required for -stable, but let me know if
> others feel differently. The dump_page() code has changed a lot in that
> area.
> 
> Changes since v1 [1]:
> 
> 1) Rebased onto mmotm
> 
> 2) Used a simpler head_*count() approach.
> 
> 3) Added Matthew's Suggested-by: tag
> 
> 4) Support pincount as well as mapcount.
> 
> [1] https://lore.kernel.org/linux-mm/20200804183943.1244828-1-jhubbard@nvidia.com/
> 
> thanks,
> John Hubbard
> 
>  include/linux/mm.h | 14 ++++++++++++--
>  mm/debug.c         |  6 +++---
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4f12b2465e80..8ab941cf73f4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -776,6 +776,11 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>  extern void kvfree(const void *addr);
>  extern void kvfree_sensitive(const void *addr, size_t len);
>  
> +static inline int head_mapcount(struct page *head)
> +{

Do we want VM_BUG_ON_PAGE(!PageHead(head), head) here?

> +	return atomic_read(compound_mapcount_ptr(head)) + 1;
> +}
> +
>  /*
>   * Mapcount of compound page as a whole, does not include mapped sub-pages.
>   *
> @@ -785,7 +790,7 @@ static inline int compound_mapcount(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageCompound(page), page);
>  	page = compound_head(page);
> -	return atomic_read(compound_mapcount_ptr(page)) + 1;
> +	return head_mapcount(page);
>  }
>  
>  /*
> @@ -898,11 +903,16 @@ static inline bool hpage_pincount_available(struct page *page)
>  	return PageCompound(page) && compound_order(page) > 1;
>  }
>  
> +static inline int head_pincount(struct page *head)
> +{

Ditto.

> +	return atomic_read(compound_pincount_ptr(head));
> +}
> +
>  static inline int compound_pincount(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
>  	page = compound_head(page);
> -	return atomic_read(compound_pincount_ptr(page));
> +	return head_pincount(page);
>  }
>  
>  static inline void set_compound_order(struct page *page, unsigned int order)
> diff --git a/mm/debug.c b/mm/debug.c
> index c27fff1e3ca8..69b60637112b 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -102,12 +102,12 @@ void __dump_page(struct page *page, const char *reason)
>  		if (hpage_pincount_available(page)) {
>  			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
>  					head, compound_order(head),
> -					compound_mapcount(head),
> -					compound_pincount(head));
> +					head_mapcount(head),
> +					head_pincount(head));
>  		} else {
>  			pr_warn("head:%p order:%u compound_mapcount:%d\n",
>  					head, compound_order(head),
> -					compound_mapcount(head));
> +					head_mapcount(head));
>  		}
>  	}
>  	if (PageKsm(page))
> -- 
> 2.28.0
> 

-- 
 Kirill A. Shutemov
