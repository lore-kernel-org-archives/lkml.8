Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A29720691
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591752078;
	bh=QJTWoYPEt98yHwKpVAXT3b+1WBVQu7Qq4xcRaxMAhH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tU7sTy/65D+EaXUs9cqFbA6YgFJTnye1JMQe1hM33hYWF77UJThDMRPit+lVpuHds
	 +5tH7Hn2XT8AgoW9Qzdp/2kh/J2GiSwZ8rc5Jh3V9F8K/aSSHSfI37wQsQFQBAtYqr
	 RJ+QgsofzDKRzSdWPJ28LPOR4po+qBsElcpOfCl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgFJBVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgFJBVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:21:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193ADC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 18:21:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so285166pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 18:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DcwQVuLC758yK0I+tGrD+0w5Fr7cPaDEkr2hA8CA5cw=;
        b=GembKLP+4i8De+vcRFzj61gw6w2TQI1whOJMmAyRe7jjHjatkw762cncoNGx1a60Iw
         39gOTRMD9wvGd0IQlfumotxVlt65D7/rYIoEUSB1lxucfJWlo/+NrDI0WJhaNgmr2VdX
         6ak+YtPzLGIzkpxpd0fnxSWcejGRLr+WufVvQO2X1d7dEqecMLUyXSb7IzxrcPh+c7DQ
         yod0z4J4WtAI/773cH8uBXkOj+3UJ035zSE2BUHYI+P6kKK4tP8o91ysa8CC1qwXU38W
         G6bF5sqqLZgHTrtLF9yK2DiU/68zF85AWQ1BL8YKhW/4uUUmcmyEHp77S4DeSP3KmTU1
         qh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DcwQVuLC758yK0I+tGrD+0w5Fr7cPaDEkr2hA8CA5cw=;
        b=m5EjP0hPBlI+qrox9AJjZ4qGDtxM0aJwtRiXktrbwk+rvKItGddSMp0VPJPEqb8FIT
         3zMqKydvrHZacqx5upy/dLheszSSU2zIMVmxyyzD9igoM2HsjEasELhO1VY1T44084U6
         xiRp5d/ZcQilyR9JovOmjSgp8F7bbp9jz1wstAXLDDKj1PxIaPDwjCRQWMBhio8wGbnc
         AUzu2+B3u5a+rpK+dJZ88s0dJ4TLc1dWtQYlnIF+TJLfacSjb8HoB+zfXkfm3WP472pl
         0A/eYw5cPjPxOkjuJfHXQD+gGgSOmusKtmK3e1AfA9C3Dp+Q/d1lHrb9FUELYuZUEe9k
         6E9g==
X-Gm-Message-State: AOAM530MJLdema9PGnGaXAbZ5GoYQU0LbvDkZbLE3UKXu9NAgsy9dQwd
        SraoNmGLor+WLYDlAsJ9JyA=
X-Google-Smtp-Source: ABdhPJxONRRsAqs+xQ6lqEjhQAHN/WNWzzfrCv9Zd8aIN8N20pC3btdb37Bsd9inXQ2wecJtg5D7UQ==
X-Received: by 2002:a17:902:c082:: with SMTP id j2mr95551pld.175.1591752075371;
        Tue, 09 Jun 2020 18:21:15 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::e690])
        by smtp.gmail.com with ESMTPSA id l23sm9323129pgc.55.2020.06.09.18.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 18:21:14 -0700 (PDT)
Date:   Tue, 9 Jun 2020 18:21:12 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     mgorman@techsingularity.net, mgorman@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, cmlaika.kim@samsung.com
Subject: Re: [PATCH] page_alloc: consider highatomic reserve in wmartermark
 fast
Message-ID: <20200610012112.GA239587@google.com>
References: <CGME20200609095139epcas1p17f9c213de6daf25fe848921bc70481c0@epcas1p1.samsung.com>
 <20200609095128.8112-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609095128.8112-1-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaewon,

On Tue, Jun 09, 2020 at 06:51:28PM +0900, Jaewon Kim wrote:
> zone_watermark_fast was introduced by commit 48ee5f3696f6 ("mm,
> page_alloc: shortcut watermark checks for order-0 pages"). The commit
> simply checks if free pages is bigger than watermark without additional
> calculation such like reducing watermark.
> 
> It considered free cma pages but it did not consider highatomic
> reserved. This may incur exhaustion of free pages except high order
> atomic free pages.
> 
> Assume that reserved_highatomic pageblock is bigger than watermark min,
> and there are only few free pages except high order atomic free. Because
> zone_watermark_fast passes the allocation without considering high order
> atomic free, normal reclaimable allocation like GFP_HIGHUSER will
> consume all the free pages. Then finally order-0 atomic allocation may
> fail on allocation.
> 
> This means watermark min is not protected against non-atomic allocation.
> The order-0 atomic allocation with ALLOC_HARDER unwantedly can be
> failed. Additionally the __GFP_MEMALLOC allocation with
> ALLOC_NO_WATERMARKS also can be failed.
> 
> To avoid the problem, zone_watermark_fast should consider highatomic
> reserve. If the actual size of high atomic free is counted accurately
> like cma free, we may use it. On this patch just use
> nr_reserved_highatomic.
> 
> This is trace log which shows GFP_HIGHUSER consumes free pages right
> before ALLOC_NO_WATERMARKS.
> 
>   <...>-22275 [006] ....   889.213383: mm_page_alloc: page=00000000d2be5665 pfn=970744 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213385: mm_page_alloc: page=000000004b2335c2 pfn=970745 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213387: mm_page_alloc: page=00000000017272e1 pfn=970278 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213389: mm_page_alloc: page=00000000c4be79fb pfn=970279 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213391: mm_page_alloc: page=00000000f8a51d4f pfn=970260 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213393: mm_page_alloc: page=000000006ba8f5ac pfn=970261 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213395: mm_page_alloc: page=00000000819f1cd3 pfn=970196 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213396: mm_page_alloc: page=00000000f6b72a64 pfn=970197 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
> kswapd0-1207  [005] ...1   889.213398: mm_page_alloc: page= (null) pfn=0 order=0 migratetype=1 nr_free=3650 gfp_flags=GFP_NOWAIT|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_MOVABLE
> 
> This is an example of ALLOC_HARDER allocation failure.
> 
> <4>[ 6207.637280]  [3:  Binder:9343_3:22875] Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
> <4>[ 6207.637311]  [3:  Binder:9343_3:22875] Call trace:
> <4>[ 6207.637346]  [3:  Binder:9343_3:22875] [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
> <4>[ 6207.637356]  [3:  Binder:9343_3:22875] [<ffffff8008223320>] warn_alloc+0xd8/0x12c
> <4>[ 6207.637365]  [3:  Binder:9343_3:22875] [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
> <4>[ 6207.637374]  [3:  Binder:9343_3:22875] [<ffffff800827f6e8>] new_slab+0x128/0x604
> <4>[ 6207.637381]  [3:  Binder:9343_3:22875] [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
> <4>[ 6207.637387]  [3:  Binder:9343_3:22875] [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
> <4>[ 6207.637396]  [3:  Binder:9343_3:22875] [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
> <4>[ 6207.637404]  [3:  Binder:9343_3:22875] [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
> <4>[ 6207.637412]  [3:  Binder:9343_3:22875] [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
> <4>[ 6207.637421]  [3:  Binder:9343_3:22875] [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
> <4>[ 6207.637430]  [3:  Binder:9343_3:22875] [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
> <4>[ 6207.637442]  [3:  Binder:9343_3:22875] [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
> <4>[ 6207.637569]  [3:  Binder:9343_3:22875] Mem-Info:
> <4>[ 6207.637595]  [3:  Binder:9343_3:22875] active_anon:102061 inactive_anon:81551 isolated_anon:0
> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  active_file:59102 inactive_file:68924 isolated_file:64
> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  unevictable:611 dirty:63 writeback:0 unstable:0
> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  slab_reclaimable:13324 slab_unreclaimable:44354
> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  mapped:83015 shmem:4858 pagetables:26316 bounce:0
> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  free:2727 free_pcp:1035 free_cma:178
> <4>[ 6207.637616]  [3:  Binder:9343_3:22875] Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
> <4>[ 6207.637632]  [3:  Binder:9343_3:22875] lowmem_reserve[]: 0 0
> <4>[ 6207.637637]  [3:  Binder:9343_3:22875] Normal: 505*4kB (H) 357*8kB (H) 201*16kB (H) 65*32kB (H) 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 10236kB
> <4>[ 6207.637655]  [3:  Binder:9343_3:22875] 138826 total pagecache pages
> <4>[ 6207.637663]  [3:  Binder:9343_3:22875] 5460 pages in swap cache
> <4>[ 6207.637668]  [3:  Binder:9343_3:22875] Swap cache stats: add 8273090, delete 8267506, find 1004381/4060142
> 
> This is an example of ALLOC_NO_WATERMARKS allocation failure.
> 
> <6>[  156.701551]  [4:        kswapd0: 1209] kswapd0 cpuset=/ mems_allowed=0
> <4>[  156.701563]  [4:        kswapd0: 1209] CPU: 4 PID: 1209 Comm: kswapd0 Tainted: G        W       4.14.113-18113966 #1
> <4>[  156.701572]  [4:        kswapd0: 1209] Call trace:
> <4>[  156.701605]  [4:        kswapd0: 1209] [<0000000000000000>] dump_stack+0x68/0x90
> <4>[  156.701612]  [4:        kswapd0: 1209] [<0000000000000000>] warn_alloc+0x104/0x198
> <4>[  156.701617]  [4:        kswapd0: 1209] [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
> <4>[  156.701623]  [4:        kswapd0: 1209] [<0000000000000000>] zs_malloc+0x148/0x3d0
> <4>[  156.701630]  [4:        kswapd0: 1209] [<0000000000000000>] zram_bvec_rw+0x250/0x568
> <4>[  156.701634]  [4:        kswapd0: 1209] [<0000000000000000>] zram_rw_page+0x8c/0xe0
> <4>[  156.701640]  [4:        kswapd0: 1209] [<0000000000000000>] bdev_write_page+0x70/0xbc
> <4>[  156.701645]  [4:        kswapd0: 1209] [<0000000000000000>] __swap_writepage+0x58/0x37c
> <4>[  156.701649]  [4:        kswapd0: 1209] [<0000000000000000>] swap_writepage+0x40/0x4c
> <4>[  156.701654]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_page_list+0xc3c/0xf54
> <4>[  156.701659]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
> <4>[  156.701664]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_node_memcg+0x23c/0x618
> <4>[  156.701668]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_node+0x1c8/0x304
> <4>[  156.701673]  [4:        kswapd0: 1209] [<0000000000000000>] kswapd+0x680/0x7c4
> <4>[  156.701679]  [4:        kswapd0: 1209] [<0000000000000000>] kthread+0x110/0x120
> <4>[  156.701684]  [4:        kswapd0: 1209] [<0000000000000000>] ret_from_fork+0x10/0x18
> <4>[  156.701689]  [4:        kswapd0: 1209] Mem-Info:
> <4>[  156.701712]  [4:        kswapd0: 1209] active_anon:88690 inactive_anon:88630 isolated_anon:0
> <4>[  156.701712]  [4:        kswapd0: 1209]  active_file:99173 inactive_file:169305 isolated_file:32
> <4>[  156.701712]  [4:        kswapd0: 1209]  unevictable:48292 dirty:538 writeback:38 unstable:0
> <4>[  156.701712]  [4:        kswapd0: 1209]  slab_reclaimable:15131 slab_unreclaimable:47762
> <4>[  156.701712]  [4:        kswapd0: 1209]  mapped:274654 shmem:2824 pagetables:25088 bounce:0
> <4>[  156.701712]  [4:        kswapd0: 1209]  free:2489 free_pcp:444 free_cma:3
> <4>[  156.701728]  [4:        kswapd0: 1209] Node 0 active_anon:354760kB inactive_anon:354520kB active_file:396692kB inactive_file:677220kB unevictable:193168kB isolated(anon):0kB isolated(file):128kB mapped:1098616kB dirty:2152kB writeback:152kB shmem:11296kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> <4>[  156.701738]  [4:        kswapd0: 1209] Normal free:9956kB min:7428kB low:93440kB high:97032kB active_anon:355176kB inactive_anon:354580kB active_file:396196kB inactive_file:677284kB unevictable:193168kB writepending:2304kB present:4081664kB managed:3593324kB mlocked:193168kB kernel_stack:55008kB pagetables:100352kB bounce:0kB free_pcp:1776kB local_pcp:656kB free_cma:12kB
> <4>[  156.701741]  [4:        kswapd0: 1209] lowmem_reserve[]: 0 0
> <4>[  156.701747]  [4:        kswapd0: 1209] Normal: 196*4kB (H) 141*8kB (H) 109*16kB (H) 63*32kB (H) 20*64kB (H) 8*128kB (H) 2*256kB (H) 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 9000kB
> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> ---
>  mm/page_alloc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 13cc653122b7..00869378d387 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3553,6 +3553,11 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  {
>  	long free_pages = zone_page_state(z, NR_FREE_PAGES);
>  	long cma_pages = 0;
> +	long highatomic = 0;
> +	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
> +
> +	if (likely(!alloc_harder))
> +		highatomic = z->nr_reserved_highatomic;
>  
>  #ifdef CONFIG_CMA
>  	/* If allocation can't use CMA areas don't use free CMA pages */
> @@ -3567,8 +3572,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  	 * the caller is !atomic then it'll uselessly search the free
>  	 * list. That corner case is then slower but it is harmless.
>  	 */
> -	if (!order && (free_pages - cma_pages) > mark + z->lowmem_reserve[classzone_idx])
> -		return true;
> +	if (!order) {
> +		long fast_free = free_pages - cma_pages - highatomic;


With your change, it seems we share most code for getting free_pages 
between zone_watermark_fast and __zone_watermark_ok. Only difference
between them is min calculation. If so, can we share most code between
them via introducing like __zone_watermark_free static inline function?
So, we didn't miss one place in future if we change something.

> +
> +		if (fast_free > mark + z->lowmem_reserve[classzone_idx])
> +			return true;
> +	}
>  
>  	return __zone_watermark_ok(z, order, mark, classzone_idx, alloc_flags,
>  					free_pages);
> -- 
> 2.17.1
> 
