Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80CBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE4420812
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/RCRg0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgFHEtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 00:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgFHEtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 00:49:42 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6A1C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 21:49:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id i74so14160506oib.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fzg2nl+sgX2QPQ80XKAbujZzMFR/66UOzSejiEZeB8A=;
        b=F/RCRg0mMaMLUaM0EpD1MsHLDCNmFDkHC8QSxyRvkrg7DG5jcPyV/IS+mv7pcce6oC
         BSrkuCPWvaZ/bPI8g4KUakyKuv++jds02ZTEq+NuoyKB/uyzRTbSC0LNthTs510m6YOa
         l3bkfP7WwAPpLKVJrNRsDOEx/Dn8LgQehoqW+F348rtito9TTkqSSYXG6cEZz5SWy9eH
         JViX41EgrZb2BQlOMYFBuxp+8iSPjmkVtOg3KLVPfb2GRVa8umbUg4pXJuE7DD6jVmvv
         KimMV+K72bhyA5b4xIDNM23cjd92EjS1uk3KZAo0YzTOBBSXxB4m4fXSjsTSYwoMKZ4O
         XmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fzg2nl+sgX2QPQ80XKAbujZzMFR/66UOzSejiEZeB8A=;
        b=s3l5xNuh5ueiozd9kiCuGmqvM+R9ET79E8ea9odHwJoBCF9cKRXsIkfZJhFTzMivFj
         hkpr+wQfAqBaFa6TDgjQSKQHJModQbMcbyRq3/kkqJiRw8GI3627m+NkEq82K/2ezjbs
         F2nf5EetgWuDB18nAnFvm4131tk7co7KHZzrPrXhbZN0/PSTybGBn+xpthIq1MaI+Xfw
         1JkI0hT9P5hZ8rFmKgpn/NsG49+KG28vzjwVDbIU4EcTLpK0bkZIe4tN6k7uumWblpax
         oUOPR4NKcf/S5G95TWot9gN9Vf4lFnBxFBHGmOI7ZWILx2X+DNkkCvWYow90INTVYkjp
         XwQA==
X-Gm-Message-State: AOAM530B/e9b0Xb8XjA3iIj82kr4GMfmNG9xtW+g0LmuCF91kgbRLAdz
        hWmeSRbj9q9EYhPCtRcfSwblrQ==
X-Google-Smtp-Source: ABdhPJyuy4x2+Zw38Qry7mE8Pp8LB3JxQQa0PP97MH9pLm7TkRi4yjbji58EqTD3ECPjpxQdxRFbmw==
X-Received: by 2002:aca:af94:: with SMTP id y142mr8876765oie.111.1591591780578;
        Sun, 07 Jun 2020 21:49:40 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f6sm61996oon.8.2020.06.07.21.49.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2020 21:49:39 -0700 (PDT)
Date:   Sun, 7 Jun 2020 21:49:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Greg Thelen <gthelen@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem, memcg: enable memcg aware shrinker
In-Reply-To: <20200601032204.124624-1-gthelen@google.com>
Message-ID: <alpine.LSU.2.11.2006072116120.2001@eggly.anvils>
References: <20200601032204.124624-1-gthelen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020, Greg Thelen wrote:

> Since v4.19 commit b0dedc49a2da ("mm/vmscan.c: iterate only over charged
> shrinkers during memcg shrink_slab()") a memcg aware shrinker is only
> called when the per-memcg per-node shrinker_map indicates that the
> shrinker may have objects to release to the memcg and node.
> 
> shmem_unused_huge_count and shmem_unused_huge_scan support the per-tmpfs
> shrinker which advertises per memcg and numa awareness.  The shmem
> shrinker releases memory by splitting hugepages that extend beyond
> i_size.
> 
> Shmem does not currently set bits in shrinker_map.  So, starting with
> b0dedc49a2da, memcg reclaim avoids calling the shmem shrinker under
> pressure.  This leads to undeserved memcg OOM kills.
> Example that reliably sees memcg OOM kill in unpatched kernel:
>   FS=/tmp/fs
>   CONTAINER=/cgroup/memory/tmpfs_shrinker
>   mkdir -p $FS
>   mount -t tmpfs -o huge=always nodev $FS
>   # Create 1000 MB container, which shouldn't suffer OOM.
>   mkdir $CONTAINER
>   echo 1000M > $CONTAINER/memory.limit_in_bytes
>   echo $BASHPID >> $CONTAINER/cgroup.procs
>   # Create 4000 files.  Ideally each file uses 4k data page + a little
>   # metadata.  Assume 8k total per-file, 32MB (4000*8k) should easily
>   # fit within container's 1000 MB.  But if data pages use 2MB
>   # hugepages (due to aggressive huge=always) then files consume 8GB,
>   # which hits memcg 1000 MB limit.
>   for i in {1..4000}; do
>     echo . > $FS/$i
>   done
> 
> v5.4 commit 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg
> aware") maintains the per-node per-memcg shrinker bitmap for THP
> shrinker.  But there's no such logic in shmem.  Make shmem set the
> per-memcg per-node shrinker bits when it modifies inodes to have
> shrinkable pages.
> 
> Fixes: b0dedc49a2da ("mm/vmscan.c: iterate only over charged shrinkers during memcg shrink_slab()")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  mm/shmem.c | 61 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index bd8840082c94..e11090f78cb5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1002,6 +1002,33 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
>  	return 0;
>  }
>  
> +/*
> + * Expose inode and optional page to shrinker as having a possibly splittable
> + * hugepage that reaches beyond i_size.
> + */
> +static void shmem_shrinker_add(struct shmem_sb_info *sbinfo,
> +			       struct inode *inode, struct page *page)
> +{
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	spin_lock(&sbinfo->shrinklist_lock);
> +	/*
> +	 * _careful to defend against unlocked access to ->shrink_list in
> +	 * shmem_unused_huge_shrink()
> +	 */
> +	if (list_empty_careful(&info->shrinklist)) {
> +		list_add_tail(&info->shrinklist, &sbinfo->shrinklist);
> +		sbinfo->shrinklist_len++;
> +	}
> +	spin_unlock(&sbinfo->shrinklist_lock);
> +
> +#ifdef CONFIG_MEMCG
> +	if (page && PageTransHuge(page))
> +		memcg_set_shrinker_bit(page->mem_cgroup, page_to_nid(page),
> +				       inode->i_sb->s_shrink.id);
> +#endif
> +}
> +
>  static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
>  {
>  	struct inode *inode = d_inode(dentry);
> @@ -1048,17 +1075,13 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
>  			 * to shrink under memory pressure.
>  			 */
>  			if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -				spin_lock(&sbinfo->shrinklist_lock);
> -				/*
> -				 * _careful to defend against unlocked access to
> -				 * ->shrink_list in shmem_unused_huge_shrink()
> -				 */
> -				if (list_empty_careful(&info->shrinklist)) {
> -					list_add_tail(&info->shrinklist,
> -							&sbinfo->shrinklist);
> -					sbinfo->shrinklist_len++;
> -				}
> -				spin_unlock(&sbinfo->shrinklist_lock);
> +				struct page *page;
> +
> +				page = find_get_page(inode->i_mapping,
> +					(newsize & HPAGE_PMD_MASK) >> PAGE_SHIFT);
> +				shmem_shrinker_add(sbinfo, inode, page);
> +				if (page)
> +					put_page(page);
>  			}
>  		}
>  	}

Thanks Greg. But it looks like v5.7's 71725ed10c40 ("mm: huge tmpfs:
try to split_huge_page() when punching hole") actually made this block
of shmem_setattr() redundant, and I should have deleted it in that patch.

There are admittedly circumstances in thich shmem_truncate_range() is
unable to split the huge page: but it has already retried, and putting
it on this shrinklist, probably to fail again and again, is not the right
thing.  Cleaner just to delete all this (either as part of this patch or
separately), and just add memcg_set_shrinker_bit() in shmem_getpage_gfp().

But I see you're suggesting Cc: <stable@vger.kernel.org> # 4.19+
Hmm, I suppose we could put in a version like you have here, then I
follow up immediately with the patch deleting most of what you wrote.
Or, we could recommend 71725ed10c40 for stable too: I'm not sure.

For now at least, I'm not myself giving much thought to the wider issue,
of how best to reimplement the shrinker in a more memcg-friendly way.

Hugh

> @@ -1889,21 +1912,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	if (PageTransHuge(page) &&
>  	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
>  			hindex + HPAGE_PMD_NR - 1) {
> -		/*
> -		 * Part of the huge page is beyond i_size: subject
> -		 * to shrink under memory pressure.
> -		 */
> -		spin_lock(&sbinfo->shrinklist_lock);
> -		/*
> -		 * _careful to defend against unlocked access to
> -		 * ->shrink_list in shmem_unused_huge_shrink()
> -		 */
> -		if (list_empty_careful(&info->shrinklist)) {
> -			list_add_tail(&info->shrinklist,
> -				      &sbinfo->shrinklist);
> -			sbinfo->shrinklist_len++;
> -		}
> -		spin_unlock(&sbinfo->shrinklist_lock);
> +		shmem_shrinker_add(sbinfo, inode, page);
>  	}
>  
>  	/*
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog
