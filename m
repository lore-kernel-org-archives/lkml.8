Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E22CC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEB62076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587083924;
	bh=dsfVZcmcKJN537QBgK6FGyP7iZmiLTZwvWWD2lBwjq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QTGRXIM1gVRkpuS+fR81uvGT8NbpH5bTYNRpUCC5EsMBGCp9BNfdST/DxG0IvslvC
	 GoF254oazuR8Ki/Yg4txpQeahRc8arRIesQYRQ1lV2L4Ppcpl9FGWnsnXr2nyBJvYG
	 iMKUbiHy9qeqoZhdKfRQvY3A+Fd1/2OCwMi4niWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgDQAin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgDQAin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:38:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10AFC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:38:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so322236pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40k/XtvgB9LVenFiOiVygQS7HVI2RZC9x/MgUNMGQ+8=;
        b=DGa99OeHcgqul2lpIMRadFKqrPltY/0DTJCaYLgH/Wx7/RcFpsXtlnXMp+HFBSviDs
         G89HKv3XqIYnZlVuoNVXNSMXVX8A8uhnzr6sUz5QZ25Gk+fMU6r7aLmEsyJE3shFQfp6
         fuvPFrgI3jJiaXT+dvdx/4YXfAvK1h8Xf9sqvoEBSHmZBWP+rPshVdKoOd+61yubtEmp
         J3V9hOlmoans53p8dps1e1GV7RDviUoctZikYRwb7+yW6GAaTv3nxSW0a2YAZg+KLE5Q
         a3FoYQNrNbN06uFxKjvsuQKQ12QTNFCEwsXr9/iPOU2bYV9fa7uV9proDHzw+RY47Oml
         u7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=40k/XtvgB9LVenFiOiVygQS7HVI2RZC9x/MgUNMGQ+8=;
        b=meH4uhBRZhHb/D2ZZuh398DQladnUES20OZdRebcDnON8J3YkxNONjevr7M88oS2ce
         bh2lq8DfUR3JDXmCeozmzRA9FZc2lan/qUYDOds+XSANl/0rbs1BbBLzxzqf8L4XcPXE
         dlMpvlTstNB2cVLSTdcF/7TV/3Pa1sS4LxaqorOnziITyHIJ6FR26uwfd4g6iw+G52Xr
         a+f9olIFwrnYa7y+ipMKc/EBjZKXYWAzX1Rr5eLp9GyKGav2jHwe5s3WQXeYMbpJE0Mi
         b/Ueg1+yaKHjzJ2Km7yHfrufxnL3f7HqVJHiDdncZp9hbRcNlWbQZqfc8uDVhfYvW/D2
         QfhQ==
X-Gm-Message-State: AGi0PuYwYCp9E69+HwiNCOxBPA+zdYYc+RiqlvcYeILYzj+P1EBO09s3
        hpJ9aBfwlNknCZ/e4ko5N8w=
X-Google-Smtp-Source: APiQypJ8+z2d/tbIVisTDIJOW12hGb84xkYG5Q+TvvdKi3d8H64/yGWbztz8UPvj/YRBSc0Z2kFJRg==
X-Received: by 2002:a17:90b:1989:: with SMTP id mv9mr1147373pjb.70.1587083921013;
        Thu, 16 Apr 2020 17:38:41 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id gv7sm382543pjb.16.2020.04.16.17.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 17:38:39 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:38:37 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mgorman@suse.de, m.szyprowski@samsung.com, mina86@mina86.com,
        riel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
Message-ID: <20200417003837.GA90471@google.com>
References: <CGME20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a@epcas1p2.samsung.com>
 <20200416033514.6366-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416033514.6366-1-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaewon,

On Thu, Apr 16, 2020 at 12:35:14PM +0900, Jaewon Kim wrote:
> This patch fix nr_isolate_* mismatch problem between cma and dirty
> lazyfree page.
> 
> If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
> page, then the lazyfree page is changed to a normal anon page having
> SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
> with the change, reclaim context correctly counts isolated files because
> it uses is_file_lru to distinguish file. And the change to anon is not
> happened if try_to_unmap_one is used for migration. So migration context
> like compaction also correctly counts isolated files even though it uses
> page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
> renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
> MADV_FREE").
> 
> But the nr_isolate_* mismatch problem happens on cma alloc. There is
> reclaim_clean_pages_from_list which is being used only by cma. It was
> introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
> contiguous allocation instead of migration") to reclaim clean file pages
> without migration. The cma alloc uses both reclaim_clean_pages_from_list
> and migrate_pages, and it uses page_is_file_lru to count isolated
> files. If there are dirty lazyfree pages allocated from cma memory
> region, the pages are counted as isolated file at the beginging but are
> counted as isolated anon after finished.
> 
> Mem-Info:
> Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> 
> Like log above, there was too much isolated file, 37664kB, which
> triggers too_many_isolated in reclaim when there is no isolated file in
> system wide. It could be reproducible by running two programs, doing
> MADV_FREE, writing and doing cma alloc, respectively. Although isolated
> anon is 0, I found that the internal value of isolated anon was the
> negative value of isolated file.
> 
> Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
> lazyfree page can be checked by both PageAnon(page) and
> page_is_file_lru. But in this case, PageAnon is enough to skip all
> anon pages.
> 
> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>

Thanks for the investigation!
The thing is MADV_FREEed page since supporting swapless could change
his LRU status between reclaim.

I am worry about voiding the optimization we have kept in CMA but
also don't have good idea, either so I tend to agree with this.

Let me Cc Johannes who might have better idea.

> ---
>  mm/vmscan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b06868fc4926..9380a18eef5e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  	LIST_HEAD(clean_pages);
>  
>  	list_for_each_entry_safe(page, next, page_list, lru) {
> +		/* to avoid race with MADV_FREE anon page */
> +		if (PageAnon(page))
> +			continue;
>  		if (page_is_file_lru(page) && !PageDirty(page) &&
>  		    !__PageMovable(page) && !PageUnevictable(page)) {
>  			ClearPageActive(page);
> -- 
> 2.13.7
> 
