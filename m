Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E50C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2C20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="CC5rGlvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBCNQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:16:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38291 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgBCNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:16:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so14607792ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qg71wuq+HUuLTE+gluyqJRk6R7IYzrOtEHHz+ac8ZpM=;
        b=CC5rGlvJRzYFaVvEQmwbNC1ul7esNJjYZyLDrHnuq3t5DBbgrsp/MkjWbYCroY76KX
         chkfamGwMrF0+DaINosh1xHU81SKo5fm1lydTwoN0uFEvTeARKthdNRLVZaL/0FlORqq
         G7O04FeWYkPeix/e53R0JU+cuMFaRswnn3H/WM1jHREA9lX6nX8fDBJ1W8C5O/QWJ/YQ
         +raTMUmUBx34sERgrv/+jVhVnnutHf/zLu+T67mXOkRqRbZ9OSo7rt00erNYA3JN/pla
         YN1lA1E5sdJA3YLfVavlvfm9eN/+JNjgxwp47UfigpuPvgHtmzn9p7zFvpO/G6VzENtI
         Cubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qg71wuq+HUuLTE+gluyqJRk6R7IYzrOtEHHz+ac8ZpM=;
        b=I40PxAp3kyPViXF/Wq03BRvNYThnD3Khy7cVYLkPP9IOweDfx0YSGYggLt6ZFEPQq5
         xjybU8D0CiZQIoBfXekH6MiP5/22Ebx4ux6AorRh4RG9Uf0owet9XymPxLQMTt5fDD8D
         8udkINjsXt37xhAVK01H4bXtpEZQYj5Z87MGm61H87tdDFn4GKYlLb0a9vo092FrV6wg
         7CAneS2hTbX99AlpPDmwHL8sIJT9PywEJ/Ga7g1oAt/98bt++6A83llOia0nMXgOglo1
         zH43oB59fdSaBAL3v/4X1Sp3XJjhkZjDCPTDz8jR2vKZ8wzB2sriP+OatTJv7hK5NYuj
         +e+Q==
X-Gm-Message-State: APjAAAV4xVGqG82xNHlL5wW+sr74NAEbe5W5oX2bLgD+41fNqfmuopf4
        nYO+0gMZU2LfEjbxaeoXtZgA/w==
X-Google-Smtp-Source: APXvYqyGAMixTSCi/O2Fbmmvwq4F+Kpwzelp/ZePNtB0r7IGFSK1fy7tUEjC85bYyQIG+4m03dECqA==
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr14513915ljm.58.1580735798292;
        Mon, 03 Feb 2020 05:16:38 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x29sm10469144lfg.45.2020.02.03.05.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:16:37 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id CA41C100DC8; Mon,  3 Feb 2020 16:16:49 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:16:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 01/12] mm: dump_page(): better diagnostics for
 compound pages
Message-ID: <20200203131649.vptndo5emkzlaiew@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-2-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:18PM -0800, John Hubbard wrote:
> A compound page collects the refcount in the head page, while leaving
> the refcount of each tail page at zero. Therefore, when debugging a
> problem that involves compound pages, it's best to have diagnostics that
> reflect that situation. However, dump_page() is oblivious to these
> points.
> 
> Change dump_page() as follows:
> 
> 1) For tail pages, print relevant head page information: refcount, in
>    particular. But only do this if the page is not corrupted so badly
>    that the pointer to the head page is all wrong.
> 
> 2) Do a separate check to catch any (rare) cases of the tail page's
>    refcount being non-zero, and issue a separate, clear pr_warn() if
>    that ever happens.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Few nit-picks below.

> ---
>  mm/debug.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index ecccd9f17801..beb1c59d784b 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -42,6 +42,32 @@ const struct trace_print_flags vmaflag_names[] = {
>  	{0, NULL}
>  };
>  
> +static void __dump_tail_page(struct page *page, int mapcount)
> +{
> +	struct page *head = compound_head(page);
> +
> +	if ((page < head) || (page >= head + MAX_ORDER_NR_PAGES)) {

I'm not sure if we want to use compound_nr() here instead of
MAX_ORDER_NR_PAGES. Do you have any reasonaing about it?

> +		/*
> +		 * Page is hopelessly corrupted, so limit any reporting to
> +		 * information about the page itself. Do not attempt to look at
> +		 * the head page.
> +		 */
> +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> +			"index:%#lx (corrupted tail page case)\n",
> +			page, page_ref_count(page), mapcount, page->mapping,
> +			page_to_pgoff(page));
> +	} else {
> +		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
> +			"index:%#lx compound_mapcount:%d\n",
> +			page, page_ref_count(head), mapcount, head->mapping,
> +			page_to_pgoff(head), compound_mapcount(page));
> +	}
> +
> +	if (page_ref_count(page) != 0)
> +		pr_warn("page:%px PROBLEM: non-zero refcount (==%d) on this "
> +			"tail page\n", page, page_ref_count(page));

Wrap into {}, please.

> +}
> +
>  void __dump_page(struct page *page, const char *reason)
>  {
>  	struct address_space *mapping;
> @@ -75,12 +101,8 @@ void __dump_page(struct page *page, const char *reason)
>  	 */
>  	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
>  
> -	if (PageCompound(page))
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> -			"index:%#lx compound_mapcount: %d\n",
> -			page, page_ref_count(page), mapcount,
> -			page->mapping, page_to_pgoff(page),
> -			compound_mapcount(page));
> +	if (PageTail(page))
> +		__dump_tail_page(page, mapcount);
>  	else
>  		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
>  			page, page_ref_count(page), mapcount,
> -- 
> 2.25.0
> 

-- 
 Kirill A. Shutemov
