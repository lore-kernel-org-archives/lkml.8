Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C24C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED512072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585647673;
	bh=QaWz0Ky7/b+8uYuJxXejaRDwGwgH1AYef1XqSjfsSwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wNxVxTpvTcMAVfa0xryt9CP+XyBw1+KkfaiJFfTxj+z0ZV0ADHbXYQNEF+TvU0Mvd
	 m5uWla9zuRUgAzOselm8mabbAciQBMkMC8Ik5Rxkgk8sWhl/5xmi5VqJ2g+Ghhutgr
	 LOrABgnlc2ShIWXC/TeA+dCr2veleM2iWbAJ4crE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgCaJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgCaJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so25111858wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 02:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58+/5NefjfDBA450NHbW1G0QGlQpuiB5cRHa0KqFj8g=;
        b=XuozW9/DUk11XbOyj7xBfY+ugEeQ4m5q4KfGjNqWWxFlV6k3SItBCHKLlvOPB+J7qi
         oMfVwjfSMqHKgs8e545AHFLz+4epB6Ur4ZjVaIibmsy7BCThnwoIsw8mOrHgWjJamFIF
         IcRKSRcJIv3TXkOuNERjx/dHrZpYKV8pdt9dDkl+aY8PnqrduEC6hEEzt9fnTFQ+Lz7U
         vYQxOn2Bsr35V+fC2Fjg2/ne6ae3apec9iGj2Adb+gqIqKIUSizJt4iM9w9mxXZfhpAM
         n4qY61reDzQCIKdLVu4w2oA79oJ7ULxhKnhQoGwbIUWJ/0lrr9ywBy6VWDmg8L1q4LfT
         Jx3w==
X-Gm-Message-State: ANhLgQ0z6WsQyWBu/T1TN7qSIsz40vVh5XPKWkXBFfc1jJf14eH4swQM
        DpYZ8UhdH/cyu5bvSuLHwfTB0alI
X-Google-Smtp-Source: ADFU+vvgYTuzWYwgm9i/rfopy7dePe+nM0xOhiNp0/W8VGm5/5vTnOxv2BssE1te4n4opGUCZo/l1g==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr19950428wru.27.1585647670072;
        Tue, 31 Mar 2020 02:41:10 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id r5sm3188023wmr.15.2020.03.31.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 02:41:09 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:41:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm, trivial: Simplify swap related code in
 try_to_unmap_one()
Message-ID: <20200331094108.GF30449@dhcp22.suse.cz>
References: <20200331084613.1258555-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331084613.1258555-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-03-20 16:46:13, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Because PageSwapCache() will always return false if PageSwapBacked() returns
> false, and PageSwapBacked() will be check for MADV_FREE pages in
> try_to_unmap_one().  The swap related code in try_to_unmap_one() can be
> simplified to improve the readability.

My understanding is that this is a sanity check to let us know if
something breaks. Do we really want to get rid of it? Maybe it is not
really useful but if that is the case then the changelog should reflect
this fact.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> ---
>  mm/rmap.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2126fd4a254b..cd3c406aeac7 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1613,19 +1613,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		} else if (PageAnon(page)) {
>  			swp_entry_t entry = { .val = page_private(subpage) };
>  			pte_t swp_pte;
> -			/*
> -			 * Store the swap location in the pte.
> -			 * See handle_pte_fault() ...
> -			 */
> -			if (unlikely(PageSwapBacked(page) != PageSwapCache(page))) {
> -				WARN_ON_ONCE(1);
> -				ret = false;
> -				/* We have to invalidate as we cleared the pte */
> -				mmu_notifier_invalidate_range(mm, address,
> -							address + PAGE_SIZE);
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> -			}
>  
>  			/* MADV_FREE page check */
>  			if (!PageSwapBacked(page)) {
> @@ -1648,6 +1635,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  				break;
>  			}
>  
> +			/*
> +			 * Store the swap location in the pte.
> +			 * See handle_pte_fault() ...
> +			 */
> +			if (unlikely(!PageSwapCache(page))) {
> +				WARN_ON_ONCE(1);
> +				ret = false;
> +				/* We have to invalidate as we cleared the pte */
> +				mmu_notifier_invalidate_range(mm, address,
> +							address + PAGE_SIZE);
> +				page_vma_mapped_walk_done(&pvmw);
> +				break;
> +			}
> +
>  			if (swap_duplicate(entry) < 0) {
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  				ret = false;
> -- 
> 2.25.0

-- 
Michal Hocko
SUSE Labs
