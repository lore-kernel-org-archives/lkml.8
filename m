Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E34C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E528920735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DaDfEnFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDVIjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:39:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:56290 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDVIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:39:14 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200422083908epoutp0135a808126e629b1d86a4bf8b0f463096~IF4mtwlif3116831168epoutp01R
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:39:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200422083908epoutp0135a808126e629b1d86a4bf8b0f463096~IF4mtwlif3116831168epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587544748;
        bh=VeuiuE69Yz5DLVMa9E6jyKHCo18Wdc/fogcFGA7Ff5c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DaDfEnFffa1fojaJ0A/kjcENrmuLEz79PlMD9GrLlLWkc6tuRQnRPO0eUzWFvHBX5
         DCHL/2f46PN8dV1VoImGBAvb/r/Rxu5CfitH/Hl4Ny0Pkfox5/hzzp4c/v9asd2gaY
         7orZhwwz+Qt2ngsOOGVTeHo2qtG/S4REaXxGbCFw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200422083908epcas1p40e8a8ff05f0bce864f3f705b9e058512~IF4mEzaH81527815278epcas1p4l;
        Wed, 22 Apr 2020 08:39:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 496Ykg0KjSzMqYlm; Wed, 22 Apr
        2020 08:39:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.B6.04648.AA200AE5; Wed, 22 Apr 2020 17:39:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200422083906epcas1p499143ad026eff0adafa43558d80560c4~IF4kkyO0T0213002130epcas1p4I;
        Wed, 22 Apr 2020 08:39:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200422083906epsmtrp2cb47deeb3abc14aba1e9be7fc930c2cf~IF4kkA2PS1414614146epsmtrp2V;
        Wed, 22 Apr 2020 08:39:06 +0000 (GMT)
X-AuditID: b6c32a37-1dbff70000001228-df-5ea002aa4925
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.D5.04158.AA200AE5; Wed, 22 Apr 2020 17:39:06 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200422083906epsmtip21657553330e4950ee8947d7b267f8599~IF4kQYM7R3119231192epsmtip2b;
        Wed, 22 Apr 2020 08:39:06 +0000 (GMT)
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
To:     Minchan Kim <minchan@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, mgorman@suse.de,
        m.szyprowski@samsung.com, mina86@mina86.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, shli@fb.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5EA002A9.40703@samsung.com>
Date:   Wed, 22 Apr 2020 17:39:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200422054057.GA97071@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmvu5qpgVxBpNdLeasX8NmsXqTr0X3
        5pmMFpd3zWGzuLfmP6vF2iN32S0mv3vGaLHgeAurxbKv79ktlu3sZ7F4vJ7bgdvj8Jv3zB4T
        m9+xe+ycdZfdY9OqTjaPTZ8msXucmPGbxWPdn1dMHn1bVjF6bD5d7fF5k1wAV1SOTUZqYkpq
        kUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QvUoKZYk5pUChgMTi
        YiV9O5ui/NKSVIWM/OISW6XUgpScAkODAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyM/VOusBQs
        dKmYu+QXcwPjFosuRk4OCQETia03O9i7GLk4hAR2MEq0nr7PBOF8YpTY1zkRyvnGKPFvzW8W
        mJYJF+dDJfYySrw4NJsZwnnLKLF+wRc2kCphgVCJDcuXs4PYIgIqEn+e/mMEKWIW+MwosfTO
        TFaQBJuAtsT7BZPAbF4BDYneF4uYQWwWAVWJ1f+2MIHYogIREjvmfmSEqBGUODnzCdgZnAIG
        EpPeNIItYxaQl2jeCnGFhMB0dolD888wQdzqIrFj3QRGCFtY4tXxLewQtpTE53d72SAamhkl
        3s7czAjhtDBK3N3UC9VhLNHbcwFoLAfQCk2J9bv0IcKKEjt/z2WE2Mwn8e5rDytIiYQAr0RH
        mxBEiZpEy7OvrBC2jMTff8+gbA+JxlOXoMH9gEli6fODLBMYFWYheW4WkodmIWxewMi8ilEs
        taA4Nz212LDAGDmWNzGCE7GW+Q7GDed8DjEKcDAq8fDeOD8vTog1say4MvcQowQHs5II74aH
        QCHelMTKqtSi/Pii0pzU4kOMpsDwnsgsJZqcD8wSeSXxhqZGxsbGFiZm5mamxkrivFOv58QJ
        CaQnlqRmp6YWpBbB9DFxcEo1MM7q/HJLSNKslv2Wj4L+qb3iK0TyL173PnvmeZXAYcO/711N
        n/2JUG2LuHtX4t2kMwH3ox+ujzVVve0d8rpeZ8lrjr2R4sv/snY6cyipzLxeavnljsS2rwz9
        YVnKuyRLDK46zTvpqH2Pt/DGsSm7d0Swx3m72Gz5HxuZ5s/BJva4T5i/8m3uXyWW4oxEQy3m
        ouJEACRUd27aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvO4qpgVxBmcmSljMWb+GzWL1Jl+L
        7s0zGS0u75rDZnFvzX9Wi7VH7rJbTH73jNFiwfEWVotlX9+zWyzb2c9i8Xg9twO3x+E375k9
        Jja/Y/fYOesuu8emVZ1sHps+TWL3ODHjN4vHuj+vmDz6tqxi9Nh8utrj8ya5AK4oLpuU1JzM
        stQifbsEroz9U66wFCx0qZi75BdzA+MWiy5GTg4JAROJCRfnM3UxcnEICexmlPiyookZIiEj
        8eb8U5YuRg4gW1ji8OFikLCQwGtGibf9ziC2sECoxIbly9lBbBEBFYk/T/8xQsx5wCRxovku
        M4jDLPCZUeLEgatgQ9kEtCXeL5jECmLzCmhI9L5YBBZnEVCVWP1vCxOILSoQIbF63TVmiBpB
        iZMzn7CA2JwCBhKT3jSygdjMAuoSf+ZdYoaw5SWat85mnsAoOAtJyywkZbOQlC1gZF7FKJla
        UJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcW1paOxhPnIg/xCjAwajEw3vj/Lw4IdbEsuLK
        3EOMEhzMSiK8Gx4ChXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgsky
        cXBKNTCyTvVkWhvaF6302fzmsV2SvWXnjt0xDXuXPenRb/kZIX3LTLYsYj+3N3HdsTdZDu18
        THHfc2I1LK3+nvWeEafV7zqTM+Of4x/u9oSSfZut7k+as/TzzfZZt5gMJs3nUVZgfDDhpohu
        f47lxhn+cTmv2Qo3XdxhMvHB0sm/r5749qgy97rQ5dVxSizFGYmGWsxFxYkAEgLW76kCAAA=
X-CMS-MailID: 20200422083906epcas1p499143ad026eff0adafa43558d80560c4
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
        <5E9EE1CD.1030809@samsung.com> <20200422054057.GA97071@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 04월 22일 14:40, Minchan Kim wrote:
> On Tue, Apr 21, 2020 at 09:06:37PM +0900, Jaewon Kim wrote:
>>
>> On 2020년 04월 20일 15:19, Jaewon Kim wrote:
>>> On 2020년 04월 18일 08:45, Jaewon Kim wrote:
>>>> On 2020년 04월 18일 00:13, Minchan Kim wrote:
>>>>> On Thu, Apr 16, 2020 at 05:38:37PM -0700, Minchan Kim wrote:
>>>>>> Hi Jaewon,
>>>>>>
>>>>>> On Thu, Apr 16, 2020 at 12:35:14PM +0900, Jaewon Kim wrote:
>>>>>>> This patch fix nr_isolate_* mismatch problem between cma and dirty
>>>>>>> lazyfree page.
>>>>>>>
>>>>>>> If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
>>>>>>> page, then the lazyfree page is changed to a normal anon page having
>>>>>>> SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
>>>>>>> with the change, reclaim context correctly counts isolated files because
>>>>>>> it uses is_file_lru to distinguish file. And the change to anon is not
>>>>>>> happened if try_to_unmap_one is used for migration. So migration context
>>>>>>> like compaction also correctly counts isolated files even though it uses
>>>>>>> page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
>>>>>>> renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
>>>>>>> MADV_FREE").
>>>>>>>
>>>>>>> But the nr_isolate_* mismatch problem happens on cma alloc. There is
>>>>>>> reclaim_clean_pages_from_list which is being used only by cma. It was
>>>>>>> introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
>>>>>>> contiguous allocation instead of migration") to reclaim clean file pages
>>>>>>> without migration. The cma alloc uses both reclaim_clean_pages_from_list
>>>>>>> and migrate_pages, and it uses page_is_file_lru to count isolated
>>>>>>> files. If there are dirty lazyfree pages allocated from cma memory
>>>>>>> region, the pages are counted as isolated file at the beginging but are
>>>>>>> counted as isolated anon after finished.
>>>>>>>
>>>>>>> Mem-Info:
>>>>>>> Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>>>>>>>
>>>>>>> Like log above, there was too much isolated file, 37664kB, which
>>>>>>> triggers too_many_isolated in reclaim when there is no isolated file in
>>>>>>> system wide. It could be reproducible by running two programs, doing
>>>>>>> MADV_FREE, writing and doing cma alloc, respectively. Although isolated
>>>>>>> anon is 0, I found that the internal value of isolated anon was the
>>>>>>> negative value of isolated file.
>>>>>>>
>>>>>>> Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
>>>>>>> lazyfree page can be checked by both PageAnon(page) and
>>>>>>> page_is_file_lru. But in this case, PageAnon is enough to skip all
>>>>>>> anon pages.
>>>>>>>
>>>>>>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>>>>>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>>>>>> Thanks for the investigation!
>>>>>> The thing is MADV_FREEed page since supporting swapless could change
>>>>>> his LRU status between reclaim.
>>>>>>
>>>>>> I am worry about voiding the optimization we have kept in CMA but
>>>>>> also don't have good idea, either so I tend to agree with this.
>>>>>>
>>>>>> Let me Cc Johannes who might have better idea.
>>>>>>
>>>>>>> ---
>>>>>>>  mm/vmscan.c | 3 +++
>>>>>>>  1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>> index b06868fc4926..9380a18eef5e 100644
>>>>>>> --- a/mm/vmscan.c
>>>>>>> +++ b/mm/vmscan.c
>>>>>>> @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>>>>>  	LIST_HEAD(clean_pages);
>>>>>>>  
>>>>>>>  	list_for_each_entry_safe(page, next, page_list, lru) {
>>>>>>> +		/* to avoid race with MADV_FREE anon page */
>>>>>>> +		if (PageAnon(page))
>>>>>>> +			continue;
>>>>>>>  		if (page_is_file_lru(page) && !PageDirty(page) &&
>>>>>>>  		    !__PageMovable(page) && !PageUnevictable(page)) {
>>>>>>>  			ClearPageActive(page);
>>>>>>> -- 
>>>>>>> 2.13.7
>>>>>>>
>>>>> Hi Jaewon,
>>>>>
>>>>> How about this idea? I think it could solve the issue with keeping
>>>>> CMA alloc latency optimization.
>>>> Hello Minchan
>>>>
>>>> It looks good to me except compilation error.
>>>>
>>>> And to apply this patch on other stable branches, we may need some other
>>>> dependent patches though.
>>>>
>>>> Thank you
>>>>> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
>>>>> index 292485f3d24d..10cc932e209a 100644
>>>>> --- a/include/linux/vmstat.h
>>>>> +++ b/include/linux/vmstat.h
>>>>> @@ -29,6 +29,7 @@ struct reclaim_stat {
>>>>>  	unsigned nr_activate[2];
>>>>>  	unsigned nr_ref_keep;
>>>>>  	unsigned nr_unmap_fail;
>>>>> +	unsigned nr_lazyfree_fail;
>>>>>  };
>>>>>  
>>>>>  enum writeback_stat_item {
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> index 4c8a1cdccbba..b390f6094f2f 100644
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -1296,11 +1296,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>>>  		 */
>>>>>  		if (page_mapped(page)) {
>>>>>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
>>>>> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
>>>>>  
>>>>>  			if (unlikely(PageTransHuge(page)))
>>>>>  				flags |= TTU_SPLIT_HUGE_PMD;
>>>>> +
>>>>>  			if (!try_to_unmap(page, flags)) {
>>>>>  				stat->nr_unmap_fail += nr_pages;
>>>>> +				if (lazyfree && PageSwapBacked(page))
>>>>> +					stat->nr_lazyfree_fail += nr_pages;
>>>>>  				goto activate_locked;
>>>>>  			}
>>>>>  		}
>>>>> @@ -1492,8 +1496,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>>>  		.priority = DEF_PRIORITY,
>>>>>  		.may_unmap = 1,
>>>>>  	};
>>>>> -	struct reclaim_stat dummy_stat;
>>>>> -	unsigned long ret;
>>>>> +	struct reclaim_stat stat;
>>>>> +	unsigned long reclaimed;
>>>>>  	struct page *page, *next;
>>>>>  	LIST_HEAD(clean_pages);
>>>>>  
>>>>> @@ -1505,11 +1509,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> -	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
>>>>> -			TTU_IGNORE_ACCESS, &dummy_stat, true);
>>>>> +	reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
>>>>> +			TTU_IGNORE_ACCESS, &stat, true);
>>>>>  	list_splice(&clean_pages, page_list);
>>>>> -	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
>>>>> -	return ret;
>>>>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -reclaimed);
>>>>> +	/*
>>>>> +	 * Since lazyfree pages are isolated from file LRU from the beginning,
>>>>> +	 * they will rotate back to anonymous LRU in the end if it failed to
>>>>> +	 * discard so isolated count will be mismatched.
>>>>> +	 * Compensate the isolated count for both LRU lists.
>>>>> +	 */
>>>>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
>>>>> +					stat->nr_lazyfree_fail);
>>>>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
>>>>> +					-stat->nr_lazyfree_fail);
>>>> should be stat.nr_lazyfree_fail and -stat.nr_lazyfree_fail instead of ->
>>>>> +	return reclaimed;
>>>>>  }
>>>>>  
>>>>>  /*
>>> Let me just CC Shaohua Li for commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
>>> , because I missed him/her on other mail thread 
>>>  : Sorry, I think I pointed a wrong commit, the SwapBacked was recovered
>>>  : by commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages").
>>>
>>>
>>> Hello Minchan
>>>
>>> I tested on my v4.19 based source tree and it seems to work.
>>>
>>> Prior to your patch I applied commit 060f005f0747 (
>>> "mm/vmscan.c: do not allocate duplicate stack variables in shrink_page_list()"
>>> for struct reclaim_stat.
>>>
>>> I considered other dependent changes below to follow code changes, not really needed for this issue though.
>>> v5.3 98879b3b9edc mm: vmscan: correct some vmscan counters for THP swapout
>>> v5.2 886cf1901db9 mm: move recent_rotated pages calculation to shrink_inactive_list()
>> Hello Minchan
>>
>> Are you preparing a complete patch for this issue?
>> Sorry if I am bugging you.
> Hi Jaewon
>
> Sorry for the late. You catched the bug and gave good description with
> the solution. What I did was just suggestion for alternative so feel
> free to send the patch with your SoB. You could use my Suggested-by
> and Acked-by. It's totally your credit!
Thank you for your support and generosity.
>
> Thanks!
>
> Thanks!
>
>

