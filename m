Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A87C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCBD2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GCcjEPQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDTGTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:19:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30827 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTGTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:19:51 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200420061945epoutp04a7bdf987b42386416e71d392012bd68c~HcsVDwhwN1439414394epoutp04Z
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:19:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200420061945epoutp04a7bdf987b42386416e71d392012bd68c~HcsVDwhwN1439414394epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587363585;
        bh=0d/dg9i+jaY2SUNMF26K1fxxmsfpoJ0k6fjm1LcGFl4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GCcjEPQ206nMgyypvUelzg+d4/FtM7jEv0dVwN72xybHcVEieH7G3Fwt03dY5Lcs2
         n/Hq12yAfz8XF4hv4Hh73sp7uJ4R68e3EswLbLwC67xpQHeDx/2lC7ODF7b14yqw6o
         Uwy0FNTptKeRkq/sQLynUfzuJOskEajrHoE90kpo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200420061944epcas1p173aa7e1e8a8836bddc68864a7e64ed85~HcsUdXqQP1879418794epcas1p15;
        Mon, 20 Apr 2020 06:19:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 495Gkk1q77zMqYlm; Mon, 20 Apr
        2020 06:19:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.CD.04744.EFE3D9E5; Mon, 20 Apr 2020 15:19:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200420061941epcas1p2ee02814507dcdf504ffedc1090730d7f~HcsR1UoJ52731227312epcas1p26;
        Mon, 20 Apr 2020 06:19:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200420061941epsmtrp1bacdf088d65ff78c8b3aafa6e61cc92c~HcsR0SVyA2366923669epsmtrp1E;
        Mon, 20 Apr 2020 06:19:41 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-ad-5e9d3efe12f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.A0.04158.DFE3D9E5; Mon, 20 Apr 2020 15:19:41 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200420061941epsmtip1a2c8e6a26c2181ac23609faa9af18fa0~HcsRhebsR1545015450epsmtip1s;
        Mon, 20 Apr 2020 06:19:41 +0000 (GMT)
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
To:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mgorman@suse.de, m.szyprowski@samsung.com, mina86@mina86.com,
        riel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, shli@fb.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E9D3EFD.8030008@samsung.com>
Date:   Mon, 20 Apr 2020 15:19:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <5E9A3FB7.1040803@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmnu4/u7lxBrfvclnMWb+GzWL1Jl+L
        7s0zGS0u75rDZnFvzX9Wi7VH7rJbTH73jNFiwfEWVotlX9+zW/y9sp7FYtnOfhaLx+u5HXg8
        Dr95z+wxsfkdu8fOWXfZPTat6mTz2PRpErvHiRm/WTzW/XnF5PF+31U2j74tqxg9Np+u9vi8
        SS6AOyrHJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfo
        dCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGR
        KVBlQk5G/6l/LAVrrSsWfHrO3MB4yqCLkZNDQsBEouPpOtYuRi4OIYEdjBKNz/azQTifGCXu
        NzxmgnC+MUp83r2QDaZl4+kFUC17GSUWrP4G5bxllFj1oIkZpEpYIFRiw/Ll7CC2iICXxOcV
        K8GKmAXuMUrM6OkHG8UmoC3xfsEkVhCbV0BL4uP5LWDNLAKqEm0bNoDViApESOyY+5ERokZQ
        4uTMJywgNidQ79onB8BsZgF5ieats5lBFkgILGKX2PVjOyPErS4S87e+YYGwhSVeHd/CDmFL
        Sbzsb2OHaGhmlHg7czMjhNPCKHF3Uy9Ut7FEb88FoLEcQCs0Jdbv0ocIK0rs/D2XEWIzn8S7
        rz2sICUSArwSHW1CECVqEi3PvrJC2DISf/89g7I9JBpPXWKHBNcfRolNm0+xT2BUmIXkuVlI
        HpqFsHkBI/MqRrHUguLc9NRiwwIT5FjexAhOz1oWOxj3nPM5xCjAwajEw8swe06cEGtiWXFl
        7iFGCQ5mJRHeFJu5cUK8KYmVValF+fFFpTmpxYcYTYHhPZFZSjQ5H5g78kriDU2NjI2NLUzM
        zM1MjZXEeadez4kTEkhPLEnNTk0tSC2C6WPi4JRqYJxXfjfyz+nKHdxL+r59ynzzPWhzrKe7
        5fLPhe9SnxuKrWEyr9ts/jd/VbPkudn5yeeehh3nnz3V+fT735XGbmtfder8+6bX9uGoU8Oh
        7RNYs2Y3/VLYyC+pWxXPzO0fGXxg8QeXV42ld9i+3ez5e4qVKy9N4uwTAQ6pnCK/Pyr7r2s/
        676797wSS3FGoqEWc1FxIgDmxI8A5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnO5fu7lxBlt2alrMWb+GzWL1Jl+L
        7s0zGS0u75rDZnFvzX9Wi7VH7rJbTH73jNFiwfEWVotlX9+zW/y9sp7FYtnOfhaLx+u5HXg8
        Dr95z+wxsfkdu8fOWXfZPTat6mTz2PRpErvHiRm/WTzW/XnF5PF+31U2j74tqxg9Np+u9vi8
        SS6AO4rLJiU1J7MstUjfLoEro//UP5aCtdYVCz49Z25gPGXQxcjJISFgIrHx9ALWLkYuDiGB
        3YwS03dMYYRIyEi8Of+UpYuRA8gWljh8uBii5jWjRMu+lWA1wgKhEhuWL2cHsUUEvCQ+r1gJ
        NegPo8Shv6fAHGaBe4wS6/+/ZgOpYhPQlni/YBIriM0roCXx8fwWZhCbRUBVom3DBrAaUYEI
        idXrrjFD1AhKnJz5hAXE5gTqXfvkAJjNLKAu8WfeJWYIW16ieets5gmMgrOQtMxCUjYLSdkC
        RuZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBEaeltYPxxIn4Q4wCHIxKPLwRc+fE
        CbEmlhVX5h5ilOBgVhLhTbGZGyfEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2
        ampBahFMlomDU6qB0XetGlPx6QXb8ll9dzBb2f+ZcSd0qcbnwMiIOU4Nhkn7Nb+IcDx8dKCr
        nfWogY/aY+kXB2sWN4tyeEjypkiZFP7g51E6wJO8o3HbE9OPAX8+xBxZkHLwYF3a7yOFxU2N
        Fo3z3jULGW6YZsZjt2W11cxpGUIBzxT7tzKYFV9cPsH7oN1u3r49SizFGYmGWsxFxYkAB5OM
        orQCAAA=
X-CMS-MailID: 20200420061941epcas1p2ee02814507dcdf504ffedc1090730d7f
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
        <5E9A3FB7.1040803@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 04월 18일 08:45, Jaewon Kim wrote:
>
> On 2020년 04월 18일 00:13, Minchan Kim wrote:
>> On Thu, Apr 16, 2020 at 05:38:37PM -0700, Minchan Kim wrote:
>>> Hi Jaewon,
>>>
>>> On Thu, Apr 16, 2020 at 12:35:14PM +0900, Jaewon Kim wrote:
>>>> This patch fix nr_isolate_* mismatch problem between cma and dirty
>>>> lazyfree page.
>>>>
>>>> If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
>>>> page, then the lazyfree page is changed to a normal anon page having
>>>> SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
>>>> with the change, reclaim context correctly counts isolated files because
>>>> it uses is_file_lru to distinguish file. And the change to anon is not
>>>> happened if try_to_unmap_one is used for migration. So migration context
>>>> like compaction also correctly counts isolated files even though it uses
>>>> page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
>>>> renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
>>>> MADV_FREE").
>>>>
>>>> But the nr_isolate_* mismatch problem happens on cma alloc. There is
>>>> reclaim_clean_pages_from_list which is being used only by cma. It was
>>>> introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
>>>> contiguous allocation instead of migration") to reclaim clean file pages
>>>> without migration. The cma alloc uses both reclaim_clean_pages_from_list
>>>> and migrate_pages, and it uses page_is_file_lru to count isolated
>>>> files. If there are dirty lazyfree pages allocated from cma memory
>>>> region, the pages are counted as isolated file at the beginging but are
>>>> counted as isolated anon after finished.
>>>>
>>>> Mem-Info:
>>>> Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>>>>
>>>> Like log above, there was too much isolated file, 37664kB, which
>>>> triggers too_many_isolated in reclaim when there is no isolated file in
>>>> system wide. It could be reproducible by running two programs, doing
>>>> MADV_FREE, writing and doing cma alloc, respectively. Although isolated
>>>> anon is 0, I found that the internal value of isolated anon was the
>>>> negative value of isolated file.
>>>>
>>>> Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
>>>> lazyfree page can be checked by both PageAnon(page) and
>>>> page_is_file_lru. But in this case, PageAnon is enough to skip all
>>>> anon pages.
>>>>
>>>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>>> Thanks for the investigation!
>>> The thing is MADV_FREEed page since supporting swapless could change
>>> his LRU status between reclaim.
>>>
>>> I am worry about voiding the optimization we have kept in CMA but
>>> also don't have good idea, either so I tend to agree with this.
>>>
>>> Let me Cc Johannes who might have better idea.
>>>
>>>> ---
>>>>  mm/vmscan.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index b06868fc4926..9380a18eef5e 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>>>  	LIST_HEAD(clean_pages);
>>>>  
>>>>  	list_for_each_entry_safe(page, next, page_list, lru) {
>>>> +		/* to avoid race with MADV_FREE anon page */
>>>> +		if (PageAnon(page))
>>>> +			continue;
>>>>  		if (page_is_file_lru(page) && !PageDirty(page) &&
>>>>  		    !__PageMovable(page) && !PageUnevictable(page)) {
>>>>  			ClearPageActive(page);
>>>> -- 
>>>> 2.13.7
>>>>
>> Hi Jaewon,
>>
>> How about this idea? I think it could solve the issue with keeping
>> CMA alloc latency optimization.
> Hello Minchan
>
> It looks good to me except compilation error.
>
> And to apply this patch on other stable branches, we may need some other
> dependent patches though.
>
> Thank you
>> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
>> index 292485f3d24d..10cc932e209a 100644
>> --- a/include/linux/vmstat.h
>> +++ b/include/linux/vmstat.h
>> @@ -29,6 +29,7 @@ struct reclaim_stat {
>>  	unsigned nr_activate[2];
>>  	unsigned nr_ref_keep;
>>  	unsigned nr_unmap_fail;
>> +	unsigned nr_lazyfree_fail;
>>  };
>>  
>>  enum writeback_stat_item {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 4c8a1cdccbba..b390f6094f2f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1296,11 +1296,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>  		 */
>>  		if (page_mapped(page)) {
>>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
>> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
>>  
>>  			if (unlikely(PageTransHuge(page)))
>>  				flags |= TTU_SPLIT_HUGE_PMD;
>> +
>>  			if (!try_to_unmap(page, flags)) {
>>  				stat->nr_unmap_fail += nr_pages;
>> +				if (lazyfree && PageSwapBacked(page))
>> +					stat->nr_lazyfree_fail += nr_pages;
>>  				goto activate_locked;
>>  			}
>>  		}
>> @@ -1492,8 +1496,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>  		.priority = DEF_PRIORITY,
>>  		.may_unmap = 1,
>>  	};
>> -	struct reclaim_stat dummy_stat;
>> -	unsigned long ret;
>> +	struct reclaim_stat stat;
>> +	unsigned long reclaimed;
>>  	struct page *page, *next;
>>  	LIST_HEAD(clean_pages);
>>  
>> @@ -1505,11 +1509,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>  		}
>>  	}
>>  
>> -	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
>> -			TTU_IGNORE_ACCESS, &dummy_stat, true);
>> +	reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
>> +			TTU_IGNORE_ACCESS, &stat, true);
>>  	list_splice(&clean_pages, page_list);
>> -	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
>> -	return ret;
>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -reclaimed);
>> +	/*
>> +	 * Since lazyfree pages are isolated from file LRU from the beginning,
>> +	 * they will rotate back to anonymous LRU in the end if it failed to
>> +	 * discard so isolated count will be mismatched.
>> +	 * Compensate the isolated count for both LRU lists.
>> +	 */
>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
>> +					stat->nr_lazyfree_fail);
>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
>> +					-stat->nr_lazyfree_fail);
> should be stat.nr_lazyfree_fail and -stat.nr_lazyfree_fail instead of ->
>> +	return reclaimed;
>>  }
>>  
>>  /*

Let me just CC Shaohua Li for commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
, because I missed him/her on other mail thread 
 : Sorry, I think I pointed a wrong commit, the SwapBacked was recovered
 : by commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages").


Hello Minchan

I tested on my v4.19 based source tree and it seems to work.

Prior to your patch I applied commit 060f005f0747 (
"mm/vmscan.c: do not allocate duplicate stack variables in shrink_page_list()"
for struct reclaim_stat.

I considered other dependent changes below to follow code changes, not really needed for this issue though.
v5.3 98879b3b9edc mm: vmscan: correct some vmscan counters for THP swapout
v5.2 886cf1901db9 mm: move recent_rotated pages calculation to shrink_inactive_list()

Thank you
Jaewon Kim


