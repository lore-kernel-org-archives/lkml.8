Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E3C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FD621D95
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="af4cPLmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgDQXqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:46:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47500 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgDQXqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 19:46:08 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200417234603epoutp04f51d9992ba9630a4f5319592e5875aa1~GwCA9-zxv1952819528epoutp043
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 23:46:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200417234603epoutp04f51d9992ba9630a4f5319592e5875aa1~GwCA9-zxv1952819528epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587167163;
        bh=seeFjaJPhc37ohY0tFs3YsQBiO34ZkHGGBV7nfv9MB4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=af4cPLmgLxl4H4+S2XJygobRl+UpzOgo+v8oxQismPwpiG3u6fcbJ/0eoWRfOppHi
         NoM+mid5Js3xap0CKjdHm2HIC531ZivlL5jI8h/9W37GKRBuOHZNVPaJvP4+mKcyQP
         8pHRDsrsHNWqLGBU4HG8HMF5c/atVVwZpMy1Cw94=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200417234602epcas1p1e8891fa092ba7f39bafcc9bcb0699035~GwB-uF0sq0133501335epcas1p1T;
        Fri, 17 Apr 2020 23:46:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 493t5P0kzmzMqYlr; Fri, 17 Apr
        2020 23:46:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.21.04744.8BF3A9E5; Sat, 18 Apr 2020 08:46:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200417234600epcas1p16b8b877f0d1eb8a172ce2406a5cdcc9c~GwB_EjHBT2847028470epcas1p1f;
        Fri, 17 Apr 2020 23:46:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200417234600epsmtrp119cfb65d3db21be0e957007d85e4ec7f~GwB_A7EQN2171921719epsmtrp1O;
        Fri, 17 Apr 2020 23:46:00 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-5f-5e9a3fb85643
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.86.04024.8BF3A9E5; Sat, 18 Apr 2020 08:46:00 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200417234559epsmtip1e38c1d6a564bc86df37f397101493c50~GwB9l4wLq0883008830epsmtip1i;
        Fri, 17 Apr 2020 23:45:59 +0000 (GMT)
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
To:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mgorman@suse.de, m.szyprowski@samsung.com, mina86@mina86.com,
        riel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E9A3FB7.1040803@samsung.com>
Date:   Sat, 18 Apr 2020 08:45:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200417151358.GA178621@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmge5O+1lxBi8XMlnMWb+GzWL1Jl+L
        7s0zGS0u75rDZnFvzX9Wi7VH7rJbTH73jNFiwfEWVotlX9+zW/y9sp7F4vF6bgduj8Nv3jN7
        7Jx1l91j06pONo9Nnyaxe5yY8ZvFY92fV0we7/ddZfPo27KK0WPz6WqPz5vkAriicmwyUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZNw4+Jmx
        YKVxRd+1u0wNjO81uxg5OSQETCS279vJBGILCexglOi9KN7FyAVkf2KUmNLfywjhfGOUuDbp
        GgtMx7Ltq9ghEnsZJdZfXc4M4bxllLh8cx5YlbBAqMSG5cvZQWwRAS+JzytWsoLYzALnGSVW
        3NECsdkEtCXeL5gEFOfg4BXQkphyLQwkzCKgKrHuO8QyUYEIiR1zPzKC2LwCghInZz4Bi3MK
        GEr0Lv3IBDFSXqJ562ywGyQE+tklfrT/ZoS41EXi+5WpTBC2sMSr41vYIWwpiZf9bewQDc2M
        Em9nbmaEcFoYJe5u6oXqNpbo7bnADHIds4CmxPpd+hBhRYmdv+cyQmzmk3j3tQfsAQkBXomO
        NiGIEjWJlmdfWSFsGYm//55B2R4SjacuQUPuNqPE/1lHWCYwKsxC8twsJA/NQti8gJF5FaNY
        akFxbnpqsWGBCXIUb2IEJ2Etix2Me875HGIU4GBU4uHt6JsZJ8SaWFZcmXuIUYKDWUmE96Ab
        UIg3JbGyKrUoP76oNCe1+BCjKTC8JzJLiSbnAzNEXkm8oamRsbGxhYmZuZmpsZI479TrOXFC
        AumJJanZqakFqUUwfUwcnFINjMe7dOW/NKnIGk4IUko8ZjQ5RU/cNVp1DfuEut7PdnusP7q/
        WPb+ren+S79Sj6baPxbe/3jt6l/zpljdWlJ/88aClUaW6lkrtxXtWpu7eVPJyiupHlNavrDV
        MBbO+7dm59Q1243uZkX+Zef7ZS5YZxXDbHIk4uHbf+dbrbKdxVSOZZ/qTb3NEqXEUpyRaKjF
        XFScCAApbl6e2AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO4O+1lxBmefslvMWb+GzWL1Jl+L
        7s0zGS0u75rDZnFvzX9Wi7VH7rJbTH73jNFiwfEWVotlX9+zW/y9sp7F4vF6bgduj8Nv3jN7
        7Jx1l91j06pONo9Nnyaxe5yY8ZvFY92fV0we7/ddZfPo27KK0WPz6WqPz5vkAriiuGxSUnMy
        y1KL9O0SuDJuHPzMWLDSuKLv2l2mBsb3ml2MnBwSAiYSy7avYu9i5OIQEtjNKLHnUzs7REJG
        4s35pyxdjBxAtrDE4cPFEDWvGSVObJ0MViMsECqxYflyMFtEwEvi84qVrBBFtxklLqzaAZZg
        FjgP5FxxAbHZBLQl3i+YxAoylFdAS2LKtTCQMIuAqsS679dYQGxRgQiJ1euuMYPYvAKCEidn
        PgGLcwoYSvQu/cgE0sosoC6xfp4QxHR5ieats5knMArOQtIxC6FqFpKqBYzMqxglUwuKc9Nz
        iw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNKS3MH4+Ul8YcYBTgYlXh4DXpmxgmxJpYVV+YeYpTg
        YFYS4T3oBhTiTUmsrEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qB
        sTLw/56NC/o71zIzCUqX8zgri+db31zUcmbCFZ2byZ9+vDiwyZajrME7reZD38kLMbGnuSeu
        C129YNl1/XPm0/b39pZa7362f0kFl1+nupRimoLYnIhdmdIaHUY+2gJJ2Z535c6Eq5e93qdS
        V+5bnSqqL7Y2eeL8RTdnBG18osb69O2Rua7pSizFGYmGWsxFxYkAZUUMa6YCAAA=
X-CMS-MailID: 20200417234600epcas1p16b8b877f0d1eb8a172ce2406a5cdcc9c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a
References: <CGME20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a@epcas1p2.samsung.com>
        <20200416033514.6366-1-jaewon31.kim@samsung.com>
        <20200417003837.GA90471@google.com> <20200417151358.GA178621@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 04월 18일 00:13, Minchan Kim wrote:
> On Thu, Apr 16, 2020 at 05:38:37PM -0700, Minchan Kim wrote:
>> Hi Jaewon,
>>
>> On Thu, Apr 16, 2020 at 12:35:14PM +0900, Jaewon Kim wrote:
>>> This patch fix nr_isolate_* mismatch problem between cma and dirty
>>> lazyfree page.
>>>
>>> If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
>>> page, then the lazyfree page is changed to a normal anon page having
>>> SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
>>> with the change, reclaim context correctly counts isolated files because
>>> it uses is_file_lru to distinguish file. And the change to anon is not
>>> happened if try_to_unmap_one is used for migration. So migration context
>>> like compaction also correctly counts isolated files even though it uses
>>> page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
>>> renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
>>> MADV_FREE").
>>>
>>> But the nr_isolate_* mismatch problem happens on cma alloc. There is
>>> reclaim_clean_pages_from_list which is being used only by cma. It was
>>> introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
>>> contiguous allocation instead of migration") to reclaim clean file pages
>>> without migration. The cma alloc uses both reclaim_clean_pages_from_list
>>> and migrate_pages, and it uses page_is_file_lru to count isolated
>>> files. If there are dirty lazyfree pages allocated from cma memory
>>> region, the pages are counted as isolated file at the beginging but are
>>> counted as isolated anon after finished.
>>>
>>> Mem-Info:
>>> Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>>>
>>> Like log above, there was too much isolated file, 37664kB, which
>>> triggers too_many_isolated in reclaim when there is no isolated file in
>>> system wide. It could be reproducible by running two programs, doing
>>> MADV_FREE, writing and doing cma alloc, respectively. Although isolated
>>> anon is 0, I found that the internal value of isolated anon was the
>>> negative value of isolated file.
>>>
>>> Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
>>> lazyfree page can be checked by both PageAnon(page) and
>>> page_is_file_lru. But in this case, PageAnon is enough to skip all
>>> anon pages.
>>>
>>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> Thanks for the investigation!
>> The thing is MADV_FREEed page since supporting swapless could change
>> his LRU status between reclaim.
>>
>> I am worry about voiding the optimization we have kept in CMA but
>> also don't have good idea, either so I tend to agree with this.
>>
>> Let me Cc Johannes who might have better idea.
>>
>>> ---
>>>  mm/vmscan.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index b06868fc4926..9380a18eef5e 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>  	LIST_HEAD(clean_pages);
>>>  
>>>  	list_for_each_entry_safe(page, next, page_list, lru) {
>>> +		/* to avoid race with MADV_FREE anon page */
>>> +		if (PageAnon(page))
>>> +			continue;
>>>  		if (page_is_file_lru(page) && !PageDirty(page) &&
>>>  		    !__PageMovable(page) && !PageUnevictable(page)) {
>>>  			ClearPageActive(page);
>>> -- 
>>> 2.13.7
>>>
> Hi Jaewon,
>
> How about this idea? I think it could solve the issue with keeping
> CMA alloc latency optimization.
Hello Minchan

It looks good to me except compilation error.

And to apply this patch on other stable branches, we may need some other
dependent patches though.

Thank you
>
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 292485f3d24d..10cc932e209a 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -29,6 +29,7 @@ struct reclaim_stat {
>  	unsigned nr_activate[2];
>  	unsigned nr_ref_keep;
>  	unsigned nr_unmap_fail;
> +	unsigned nr_lazyfree_fail;
>  };
>  
>  enum writeback_stat_item {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4c8a1cdccbba..b390f6094f2f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1296,11 +1296,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		 */
>  		if (page_mapped(page)) {
>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
>  
>  			if (unlikely(PageTransHuge(page)))
>  				flags |= TTU_SPLIT_HUGE_PMD;
> +
>  			if (!try_to_unmap(page, flags)) {
>  				stat->nr_unmap_fail += nr_pages;
> +				if (lazyfree && PageSwapBacked(page))
> +					stat->nr_lazyfree_fail += nr_pages;
>  				goto activate_locked;
>  			}
>  		}
> @@ -1492,8 +1496,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  		.priority = DEF_PRIORITY,
>  		.may_unmap = 1,
>  	};
> -	struct reclaim_stat dummy_stat;
> -	unsigned long ret;
> +	struct reclaim_stat stat;
> +	unsigned long reclaimed;
>  	struct page *page, *next;
>  	LIST_HEAD(clean_pages);
>  
> @@ -1505,11 +1509,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  		}
>  	}
>  
> -	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
> -			TTU_IGNORE_ACCESS, &dummy_stat, true);
> +	reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
> +			TTU_IGNORE_ACCESS, &stat, true);
>  	list_splice(&clean_pages, page_list);
> -	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
> -	return ret;
> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -reclaimed);
> +	/*
> +	 * Since lazyfree pages are isolated from file LRU from the beginning,
> +	 * they will rotate back to anonymous LRU in the end if it failed to
> +	 * discard so isolated count will be mismatched.
> +	 * Compensate the isolated count for both LRU lists.
> +	 */
> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
> +					stat->nr_lazyfree_fail);
> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
> +					-stat->nr_lazyfree_fail);
should be stat.nr_lazyfree_fail and -stat.nr_lazyfree_fail instead of ->
> +	return reclaimed;
>  }
>  
>  /*

