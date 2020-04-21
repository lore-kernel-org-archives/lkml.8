Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E41C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C416D206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DjDjElFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgDUMGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:06:46 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42948 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgDUMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:06:44 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200421120640epoutp046b9d4e17056d9545a5a8800b2d75deb3~H1EgyjkeP0991509915epoutp04w
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:06:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200421120640epoutp046b9d4e17056d9545a5a8800b2d75deb3~H1EgyjkeP0991509915epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587470800;
        bh=LHao2zOpkgotBzhh79G2Hgz+GC907gZH5iKlUAw46HU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DjDjElFtyfH7Fn+5KMshi0vn8ZbIuCcJl5h0lr9HzbxQKHUIQRB7JWd9O2giGFZwR
         guW5vLuwAhBUW9bRW1XHcK2OxE5DYSrPxqfPanlyHl78tPD7cQyJUQjnyZTuYm1I41
         7heit+6J8UkK1XFyYaA+bex+iTNP9+iquXswL7lk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200421120639epcas1p26aea092dd66784ed4f31e32f47b2cfb2~H1Ef7E5j33015030150epcas1p2B;
        Tue, 21 Apr 2020 12:06:39 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4962NZ2cV6zMqYlr; Tue, 21 Apr
        2020 12:06:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.8F.04402.EC1EE9E5; Tue, 21 Apr 2020 21:06:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200421120637epcas1p4cf390cc70a1a0b7eb38bfa2050e4b705~H1EemJl3V0307003070epcas1p4F;
        Tue, 21 Apr 2020 12:06:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200421120637epsmtrp1ae19c0a92b146ab58e3fe9dc284830bc~H1EelOjQX2605326053epsmtrp1H;
        Tue, 21 Apr 2020 12:06:37 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-74-5e9ee1ce4bb0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.49.04024.DC1EE9E5; Tue, 21 Apr 2020 21:06:37 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200421120637epsmtip17d2563f3506bdff32122706868136c0c~H1EeBhM0C1437214372epsmtip1S;
        Tue, 21 Apr 2020 12:06:37 +0000 (GMT)
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
To:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mgorman@suse.de, m.szyprowski@samsung.com, mina86@mina86.com,
        riel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, shli@fb.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E9EE1CD.1030809@samsung.com>
Date:   Tue, 21 Apr 2020 21:06:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <5E9D3EFD.8030008@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0zTUBTmrl1bYDN1iN4QlVnURAy6MofVCDHxkUYxkhgT4mNYoAK6dXMd
        RjQkEhaCE5koGhmCaCLofAwHGjDxEXzgez4jPmYkKlFEiBCM+EDXFSP/vnPu953znXPvJRDN
        fSyGyBPsvE3gTBQWgV64NkOX8KCz1qh7VE4yh72nMeaUbwWzu6kKME8uHsaYN6f/KJkz1wM4
        s7+3CzB17Q4lUz/YhzO/n3pRpr7VhTLvvJELVey1nj6ErSjuxdlWdwBnfZ5dGOvr34eztw79
        RNmzv7oVbN/lZxhb3uwBbNPdHeyAb3Ja5BrTglyey+ZtWl7IsmTnCTnJ1PJVGYsyDEk6OoGe
        x8yltAJn5pOpxalpCUvzTEHrlHYrZ8oPptI4UaRmpyywWfLtvDbXItqTKd6abbLSOusskTOL
        +ULOrCyLeT6t0yUagswNptxddwqtxSnbPGfUO0F/ohMQBCTnwNJSrRNEEBqyBcAnzeW4HPQD
        eLnHNRJ8A7D9403ECcJDiqHOBqWENeQlAD/3CzLpC4CB4UZMOogiV8PGhgZcwuPIZXDgxEml
        RELINwAeKnOFSBg5E/bV7QtVUpPxsN7/EpU8oeQ06PTlSeloMh221HwFMmUsvF31HpVweFDq
        ft8RkiJkLCw+X41I9SF5DIcvHGcVstPF0O8vwWQcBbvbm3EZx8BPrhJcFhQD+KWqCciBIziC
        bw+QWXq4p+whIjlCyBnQe3G2nJ4CW3/WALnzGNg7WKaUF6mGpSUamTIdOroGlTKeCH8Pd41g
        FhbdeTyy0moFLG30KvYCrXvUcO5RA7n/d64DiAeM562iOYcXaSs9+oJ9IPSU4w0toPJBahsg
        CUCp1B3+WqNGyW0VC8xtABIINU6d3hFMqbO5gu28zZJhyzfxYhswBNddgcREZ1mCH0OwZ9CG
        RL1ez8xJmptk0FMT1Aeem4waMoez85t53srb/ukURHjMTrAazxRi/TfAklcqoiAu8+C5wNpo
        YyX6+FWEvejHpW03mj5FpA4kbR+zu/CK/3jK+ueZ9Z2VYY4tLUNHV354uiH97b2hRmN39e2J
        Ro/qalWP6zUdtnlTuG35pBoVduvzQaErzrduXq2xMDA5TnElPWqqYv+6jZFHvjNtPwaWOsOO
        n1pGoWIuR8cjNpH7C5AhqWPgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnO7Zh/PiDKZe1bCYs34Nm8XqTb4W
        3ZtnMlpc3jWHzeLemv+sFmuP3GW3mPzuGaPFguMtrBbLvr5nt/h7ZT2LxbKd/SwWj9dzO/B4
        HH7zntljYvM7do+ds+6ye2xa1cnmsenTJHaPEzN+s3is+/OKyeP9vqtsHn1bVjF6bD5d7fF5
        k1wAdxSXTUpqTmZZapG+XQJXRuep2oJmu4pVa3kbGD8ZdTFyckgImEj8fLictYuRi0NIYDej
        xLfeHYwQCRmJN+efsnQxcgDZwhKHDxdD1LxmlLj16iYbSI2wQKjEhuXL2UFsEQEvic8rVrKC
        2EICs5kkDt7XB2lgFrjHKLH+/2uwBjYBbYn3CyaBFfEKaEksO38LbAGLgKpE16ZMkLCoQITE
        6nXXmCFKBCVOznzCAmJzArXOenIDrJVZQF3iz7xLzBC2vETz1tnMExgFZyFpmYWkbBaSsgWM
        zKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIjTUtzB+PlJfGHGAU4GJV4eG+cnxcn
        xJpYVlyZe4hRgoNZSYQ34gZQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2amp
        BalFMFkmDk6pBsbCOHbXxPDGPo3bTFdYX397JfNRhbF80d6rF/S3fBFxlHy1Yu6xe2s5mBTN
        Th7fE+UpX1G/v09nR/i/pohjT7cWfQvbfq952hruzVsfRd5vW2i4WeL+xL7mP752pl+3RPLI
        8tSUn/Kdero8tcTMbVqykuHxgFcP9lS97TT4eq3U+njHu8krAr4psRRnJBpqMRcVJwIAkLG4
        B7ACAAA=
X-CMS-MailID: 20200421120637epcas1p4cf390cc70a1a0b7eb38bfa2050e4b705
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
        <5E9A3FB7.1040803@samsung.com> <5E9D3EFD.8030008@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 04월 20일 15:19, Jaewon Kim wrote:
>
> On 2020년 04월 18일 08:45, Jaewon Kim wrote:
>> On 2020년 04월 18일 00:13, Minchan Kim wrote:
>>> On Thu, Apr 16, 2020 at 05:38:37PM -0700, Minchan Kim wrote:
>>>> Hi Jaewon,
>>>>
>>>> On Thu, Apr 16, 2020 at 12:35:14PM +0900, Jaewon Kim wrote:
>>>>> This patch fix nr_isolate_* mismatch problem between cma and dirty
>>>>> lazyfree page.
>>>>>
>>>>> If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
>>>>> page, then the lazyfree page is changed to a normal anon page having
>>>>> SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
>>>>> with the change, reclaim context correctly counts isolated files because
>>>>> it uses is_file_lru to distinguish file. And the change to anon is not
>>>>> happened if try_to_unmap_one is used for migration. So migration context
>>>>> like compaction also correctly counts isolated files even though it uses
>>>>> page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
>>>>> renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
>>>>> MADV_FREE").
>>>>>
>>>>> But the nr_isolate_* mismatch problem happens on cma alloc. There is
>>>>> reclaim_clean_pages_from_list which is being used only by cma. It was
>>>>> introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
>>>>> contiguous allocation instead of migration") to reclaim clean file pages
>>>>> without migration. The cma alloc uses both reclaim_clean_pages_from_list
>>>>> and migrate_pages, and it uses page_is_file_lru to count isolated
>>>>> files. If there are dirty lazyfree pages allocated from cma memory
>>>>> region, the pages are counted as isolated file at the beginging but are
>>>>> counted as isolated anon after finished.
>>>>>
>>>>> Mem-Info:
>>>>> Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>>>>>
>>>>> Like log above, there was too much isolated file, 37664kB, which
>>>>> triggers too_many_isolated in reclaim when there is no isolated file in
>>>>> system wide. It could be reproducible by running two programs, doing
>>>>> MADV_FREE, writing and doing cma alloc, respectively. Although isolated
>>>>> anon is 0, I found that the internal value of isolated anon was the
>>>>> negative value of isolated file.
>>>>>
>>>>> Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
>>>>> lazyfree page can be checked by both PageAnon(page) and
>>>>> page_is_file_lru. But in this case, PageAnon is enough to skip all
>>>>> anon pages.
>>>>>
>>>>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>>>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>>>> Thanks for the investigation!
>>>> The thing is MADV_FREEed page since supporting swapless could change
>>>> his LRU status between reclaim.
>>>>
>>>> I am worry about voiding the optimization we have kept in CMA but
>>>> also don't have good idea, either so I tend to agree with this.
>>>>
>>>> Let me Cc Johannes who might have better idea.
>>>>
>>>>> ---
>>>>>  mm/vmscan.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> index b06868fc4926..9380a18eef5e 100644
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>>>  	LIST_HEAD(clean_pages);
>>>>>  
>>>>>  	list_for_each_entry_safe(page, next, page_list, lru) {
>>>>> +		/* to avoid race with MADV_FREE anon page */
>>>>> +		if (PageAnon(page))
>>>>> +			continue;
>>>>>  		if (page_is_file_lru(page) && !PageDirty(page) &&
>>>>>  		    !__PageMovable(page) && !PageUnevictable(page)) {
>>>>>  			ClearPageActive(page);
>>>>> -- 
>>>>> 2.13.7
>>>>>
>>> Hi Jaewon,
>>>
>>> How about this idea? I think it could solve the issue with keeping
>>> CMA alloc latency optimization.
>> Hello Minchan
>>
>> It looks good to me except compilation error.
>>
>> And to apply this patch on other stable branches, we may need some other
>> dependent patches though.
>>
>> Thank you
>>> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
>>> index 292485f3d24d..10cc932e209a 100644
>>> --- a/include/linux/vmstat.h
>>> +++ b/include/linux/vmstat.h
>>> @@ -29,6 +29,7 @@ struct reclaim_stat {
>>>  	unsigned nr_activate[2];
>>>  	unsigned nr_ref_keep;
>>>  	unsigned nr_unmap_fail;
>>> +	unsigned nr_lazyfree_fail;
>>>  };
>>>  
>>>  enum writeback_stat_item {
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 4c8a1cdccbba..b390f6094f2f 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1296,11 +1296,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>  		 */
>>>  		if (page_mapped(page)) {
>>>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
>>> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
>>>  
>>>  			if (unlikely(PageTransHuge(page)))
>>>  				flags |= TTU_SPLIT_HUGE_PMD;
>>> +
>>>  			if (!try_to_unmap(page, flags)) {
>>>  				stat->nr_unmap_fail += nr_pages;
>>> +				if (lazyfree && PageSwapBacked(page))
>>> +					stat->nr_lazyfree_fail += nr_pages;
>>>  				goto activate_locked;
>>>  			}
>>>  		}
>>> @@ -1492,8 +1496,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>  		.priority = DEF_PRIORITY,
>>>  		.may_unmap = 1,
>>>  	};
>>> -	struct reclaim_stat dummy_stat;
>>> -	unsigned long ret;
>>> +	struct reclaim_stat stat;
>>> +	unsigned long reclaimed;
>>>  	struct page *page, *next;
>>>  	LIST_HEAD(clean_pages);
>>>  
>>> @@ -1505,11 +1509,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>  		}
>>>  	}
>>>  
>>> -	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
>>> -			TTU_IGNORE_ACCESS, &dummy_stat, true);
>>> +	reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
>>> +			TTU_IGNORE_ACCESS, &stat, true);
>>>  	list_splice(&clean_pages, page_list);
>>> -	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
>>> -	return ret;
>>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -reclaimed);
>>> +	/*
>>> +	 * Since lazyfree pages are isolated from file LRU from the beginning,
>>> +	 * they will rotate back to anonymous LRU in the end if it failed to
>>> +	 * discard so isolated count will be mismatched.
>>> +	 * Compensate the isolated count for both LRU lists.
>>> +	 */
>>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
>>> +					stat->nr_lazyfree_fail);
>>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
>>> +					-stat->nr_lazyfree_fail);
>> should be stat.nr_lazyfree_fail and -stat.nr_lazyfree_fail instead of ->
>>> +	return reclaimed;
>>>  }
>>>  
>>>  /*
> Let me just CC Shaohua Li for commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
> , because I missed him/her on other mail thread 
>  : Sorry, I think I pointed a wrong commit, the SwapBacked was recovered
>  : by commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages").
>
>
> Hello Minchan
>
> I tested on my v4.19 based source tree and it seems to work.
>
> Prior to your patch I applied commit 060f005f0747 (
> "mm/vmscan.c: do not allocate duplicate stack variables in shrink_page_list()"
> for struct reclaim_stat.
>
> I considered other dependent changes below to follow code changes, not really needed for this issue though.
> v5.3 98879b3b9edc mm: vmscan: correct some vmscan counters for THP swapout
> v5.2 886cf1901db9 mm: move recent_rotated pages calculation to shrink_inactive_list()
Hello Minchan

Are you preparing a complete patch for this issue?
Sorry if I am bugging you.
>
> Thank you
> Jaewon Kim
>
>

