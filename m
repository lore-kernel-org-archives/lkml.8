Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32946C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE3D2245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="vmpN/XsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgGaPR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgGaPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:17:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A3C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:17:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h7so29051706qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pNskHEW12lh46n0Zlsd60MF+6OVuuX4EV9sgDes5FR4=;
        b=vmpN/XsHGRmAJzX5ODCmQOdU9dwEyRp4t7ZUCD4yk9xdf2LrjaQbv+MGtE58Gw5Hk0
         fCc1sTUG9N2JEiTEPZ02eEnWasxmDlL+3cufg1hkd5Br741rCh0DLfqCA12pW9rmoS5w
         S2sLfPoLcfilrvfhKBcLMpVBeLGqe3V5nPNIcPIPTjtGEVHhmBxlFHl033WuVronNsQT
         CMJWEYn2c7vUpTzI1ChIzAoJXE7ERBOkILmts0mZvxCifvZDsDuRBSUTs6RYS0BbfSIi
         FRv4zq27dRtme/tQsrb1pIB2YY/c2B8VEBWij6lB4lORsAREM0tk9dV7ZmS9bSEQKZUO
         38Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNskHEW12lh46n0Zlsd60MF+6OVuuX4EV9sgDes5FR4=;
        b=AkoGF9awusF6HF5dUOtbBAgkhyr0h4+RsFEiFG6WbDfQk+eJ3y5oJ2iToHc2/iMVu6
         H7qdQhsMnrdr3+OiKvY8vGMpAmT8WMd8Tp3dTrLhttUZqgnV5zIpZO6gyCbLOTDwdFjE
         oMZqLJePB6SqCCvecYpGpy6V6zYSBJgrBSLecERNZOkyxhA2vbbcSde8SayzA4vNZ7pF
         c/6pvLHt/4lmv2jDk9Vrzjk+eYIt6xFY5z0nKMdAbi5eM1MXcFhbuluaKx/dv0hXf6wq
         CfYlMY8QaqImzizQ8WGsdKuNqbKjfWL+O3u2cZNjLbkLH4rLwo+2/sRG6tN8OVu92Pus
         JZ7g==
X-Gm-Message-State: AOAM533i9e/GzTLbUjgo6JUO3oDPAkLGJXMsunPiVM1S06POAxOjEaru
        CMzMTVnGYnVYSKx3NmNNh7e2gw==
X-Google-Smtp-Source: ABdhPJyiF3c2kk77NFw/RswzR9D58w6iAB6/VDp+1WDgbwVvj9yXCVCuU1nROvR45TchoNFVAq+dvg==
X-Received: by 2002:a05:620a:12cf:: with SMTP id e15mr4256707qkl.459.1596208678297;
        Fri, 31 Jul 2020 08:17:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:11a4])
        by smtp.gmail.com with ESMTPSA id n81sm8397098qke.11.2020.07.31.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:17:57 -0700 (PDT)
Date:   Fri, 31 Jul 2020 11:16:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
Message-ID: <20200731151655.GB491801@cmpxchg.org>
References: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 11:34:40AM +0800, Alex Shi wrote:
> Since readahead page will be charged on memcg too. We don't need to
> check this exception now. Rmove them is safe as all user pages are
> charged before use.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/memcontrol.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e84c2b5596f2..9e44ae22d591 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1322,12 +1322,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  	}
>  
>  	memcg = page->mem_cgroup;
> -	/*
> -	 * Swapcache readahead pages are added to the LRU - and
> -	 * possibly migrated - before they are charged.
> -	 */
> -	if (!memcg)
> -		memcg = root_mem_cgroup;
> +	VM_BUG_ON_PAGE(!memcg, page);
>  
>  	mz = mem_cgroup_page_nodeinfo(memcg, page);
>  	lruvec = &mz->lruvec;
> @@ -6897,10 +6892,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  	if (newpage->mem_cgroup)
>  		return;
>  
> -	/* Swapcache readahead pages can get replaced before being charged */
>  	memcg = oldpage->mem_cgroup;
> -	if (!memcg)
> -		return;
> +	VM_BUG_ON_PAGE(!memcg, oldpage);
>  
>  	/* Force-charge the new page. The old one will be freed soon */
>  	nr_pages = thp_nr_pages(newpage);
> @@ -7094,10 +7087,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  		return;
>  
>  	memcg = page->mem_cgroup;
> -
> -	/* Readahead page, never charged */
> -	if (!memcg)
> -		return;
> +	VM_BUG_ON_PAGE(!memcg, page);
>  
>  	/*
>  	 * In case the memcg owning these pages has been offlined and doesn't
> @@ -7158,10 +7148,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  		return 0;
>  
>  	memcg = page->mem_cgroup;
> -
> -	/* Readahead page, never charged */
> -	if (!memcg)
> -		return 0;
> +	VM_BUG_ON_PAGE(!memcg, page);
>  
>  	if (!entry.val) {
>  		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);

Uncharged readahead pages are gone, but I'm not 100% sure uncharged
pages in general are gone. ISTR that the !page->mem_cgroup check in
mem_cgroup_uncharge() prevented a crash - although that is of course a
much broader interface, whereas the ones you change should only apply
to LRU pages (which are hopefully all charged).

Nevertheless, to avoid unnecessary crashes if we discover that we've
been wrong, how about leaving the branches for now, but adding a (new)
VM_WARN_ON_ONCE_PAGE() to them?
