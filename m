Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C62C38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715622072D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587534063;
	bh=+dfQFyU47fAOR0KwYJDbnagG/jqRQAOZmYyxo6EjvL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3bwwiIzuU7IcjXYsmtjrnDi1Nre8ZFruUtUPQlcNQt5mEvm0WOyFzlca3jMLppXc
	 Hk5p606geu9dE3ZewZ+Ie3FgdXqc+Ymesp9XrktIe32INeZE4ME+5uEWtLMN7dZhPu
	 /PVcNtvNKOtL0vc83tnBYRDNJ8WDgm9Zq5CojIgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDVFlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 01:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgDVFlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 01:41:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67CEC03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 22:41:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so537149pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uBImYFPEvlWaVjtMRb0VCbEwinzl3N8twx+hX4o14p0=;
        b=PAcLGzCNQxoSeWCXdDwtKHvJyaRU0j+OQ55Z9Frs4TNGkaBxmjBsJYujOWSp/Zy9gg
         FhiJU4WOi/hRU/vPtYHW1FEsM5/8JK3w6J2XxkW2sCBTlskPwkn4TLQJZD2QJNDUGl1c
         PImUZq+ekaAFcnmim8U35e1g275O3924ilKHY++f5JUevcpM+eChaepUxS0wweQAFlc1
         5QzX1yGJVCC4A7yF5jGOydZlv1lifo/3UsEWWXc4i+AFDVgJ9cB/dAc5KojOB2/dhRga
         vCegeqshYNcuWfGdjPtOOHh1aAQKUwY1CEM++nrFhm8n0vb6YKvDuORmZV+IQE2blGoz
         AV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=uBImYFPEvlWaVjtMRb0VCbEwinzl3N8twx+hX4o14p0=;
        b=Hvsf5AtvSEcpbxwHc0TUAc4B0WCV/6JvQapekPUQ82JU2K3RObQ/liw5N6rdoqoQ04
         sQREVWJJ9uttAaL77I4KtLJf113u7cT/Qp7NPZQrZA3PxmuXahoE7W575i67UtNj6pgN
         q4/FJSn8gxfG7+SlTZXXW8rFPfhXuV4m9UJTWpqgxMTbf4THf0POwNld3I/XDDFkOqOL
         ZII18gDkFbb9FJI/FYFuNfA+IAqCs0VF/4zeDuypy5zm8fGrjxBVmHoJrm9rEL8DHs0h
         jXpE72ggDhqZsnFS/3gVzZje4AUIC8Vm7gHh0TVZhRoHn4OTb6SY0Tlubrz9Evhb7VOV
         HJ9w==
X-Gm-Message-State: AGi0PuZJoD1aovqKXX9wENBEpISxLV2+jKYJ1gYqIwxe1FfZ0NUvDaHm
        oTesiJSQTteW+JxGcgUP4G0=
X-Google-Smtp-Source: APiQypISFdoyegiLRlxTIhukhAHNyAPT+BKJoDO30n9h8KkmeCkYp2QEa1V13f5GiH4Kq+sDkdepnw==
X-Received: by 2002:a62:528e:: with SMTP id g136mr11633989pfb.165.1587534060954;
        Tue, 21 Apr 2020 22:41:00 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id h27sm4000958pgb.90.2020.04.21.22.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 22:40:59 -0700 (PDT)
Date:   Tue, 21 Apr 2020 22:40:57 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, mgorman@suse.de,
        m.szyprowski@samsung.com, mina86@mina86.com, riel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, shli@fb.com
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
Message-ID: <20200422054057.GA97071@google.com>
References: <CGME20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a@epcas1p2.samsung.com>
 <20200416033514.6366-1-jaewon31.kim@samsung.com>
 <20200417003837.GA90471@google.com>
 <20200417151358.GA178621@google.com>
 <5E9A3FB7.1040803@samsung.com>
 <5E9D3EFD.8030008@samsung.com>
 <5E9EE1CD.1030809@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E9EE1CD.1030809@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:06:37PM +0900, Jaewon Kim wrote:
> 
> 
> On 2020년 04월 20일 15:19, Jaewon Kim wrote:
> >
> > On 2020년 04월 18일 08:45, Jaewon Kim wrote:
> >> On 2020년 04월 18일 00:13, Minchan Kim wrote:
> >>> On Thu, Apr 16, 2020 at 05:38:37PM -0700, Minchan Kim wrote:
> >>>> Hi Jaewon,
> >>>>
> >>>> On Thu, Apr 16, 2020 at 12:35:14PM +0900, Jaewon Kim wrote:
> >>>>> This patch fix nr_isolate_* mismatch problem between cma and dirty
> >>>>> lazyfree page.
> >>>>>
> >>>>> If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
> >>>>> page, then the lazyfree page is changed to a normal anon page having
> >>>>> SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
> >>>>> with the change, reclaim context correctly counts isolated files because
> >>>>> it uses is_file_lru to distinguish file. And the change to anon is not
> >>>>> happened if try_to_unmap_one is used for migration. So migration context
> >>>>> like compaction also correctly counts isolated files even though it uses
> >>>>> page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
> >>>>> renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
> >>>>> MADV_FREE").
> >>>>>
> >>>>> But the nr_isolate_* mismatch problem happens on cma alloc. There is
> >>>>> reclaim_clean_pages_from_list which is being used only by cma. It was
> >>>>> introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
> >>>>> contiguous allocation instead of migration") to reclaim clean file pages
> >>>>> without migration. The cma alloc uses both reclaim_clean_pages_from_list
> >>>>> and migrate_pages, and it uses page_is_file_lru to count isolated
> >>>>> files. If there are dirty lazyfree pages allocated from cma memory
> >>>>> region, the pages are counted as isolated file at the beginging but are
> >>>>> counted as isolated anon after finished.
> >>>>>
> >>>>> Mem-Info:
> >>>>> Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> >>>>>
> >>>>> Like log above, there was too much isolated file, 37664kB, which
> >>>>> triggers too_many_isolated in reclaim when there is no isolated file in
> >>>>> system wide. It could be reproducible by running two programs, doing
> >>>>> MADV_FREE, writing and doing cma alloc, respectively. Although isolated
> >>>>> anon is 0, I found that the internal value of isolated anon was the
> >>>>> negative value of isolated file.
> >>>>>
> >>>>> Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
> >>>>> lazyfree page can be checked by both PageAnon(page) and
> >>>>> page_is_file_lru. But in this case, PageAnon is enough to skip all
> >>>>> anon pages.
> >>>>>
> >>>>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> >>>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> >>>> Thanks for the investigation!
> >>>> The thing is MADV_FREEed page since supporting swapless could change
> >>>> his LRU status between reclaim.
> >>>>
> >>>> I am worry about voiding the optimization we have kept in CMA but
> >>>> also don't have good idea, either so I tend to agree with this.
> >>>>
> >>>> Let me Cc Johannes who might have better idea.
> >>>>
> >>>>> ---
> >>>>>  mm/vmscan.c | 3 +++
> >>>>>  1 file changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>>> index b06868fc4926..9380a18eef5e 100644
> >>>>> --- a/mm/vmscan.c
> >>>>> +++ b/mm/vmscan.c
> >>>>> @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> >>>>>  	LIST_HEAD(clean_pages);
> >>>>>  
> >>>>>  	list_for_each_entry_safe(page, next, page_list, lru) {
> >>>>> +		/* to avoid race with MADV_FREE anon page */
> >>>>> +		if (PageAnon(page))
> >>>>> +			continue;
> >>>>>  		if (page_is_file_lru(page) && !PageDirty(page) &&
> >>>>>  		    !__PageMovable(page) && !PageUnevictable(page)) {
> >>>>>  			ClearPageActive(page);
> >>>>> -- 
> >>>>> 2.13.7
> >>>>>
> >>> Hi Jaewon,
> >>>
> >>> How about this idea? I think it could solve the issue with keeping
> >>> CMA alloc latency optimization.
> >> Hello Minchan
> >>
> >> It looks good to me except compilation error.
> >>
> >> And to apply this patch on other stable branches, we may need some other
> >> dependent patches though.
> >>
> >> Thank you
> >>> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> >>> index 292485f3d24d..10cc932e209a 100644
> >>> --- a/include/linux/vmstat.h
> >>> +++ b/include/linux/vmstat.h
> >>> @@ -29,6 +29,7 @@ struct reclaim_stat {
> >>>  	unsigned nr_activate[2];
> >>>  	unsigned nr_ref_keep;
> >>>  	unsigned nr_unmap_fail;
> >>> +	unsigned nr_lazyfree_fail;
> >>>  };
> >>>  
> >>>  enum writeback_stat_item {
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index 4c8a1cdccbba..b390f6094f2f 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -1296,11 +1296,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> >>>  		 */
> >>>  		if (page_mapped(page)) {
> >>>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
> >>> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
> >>>  
> >>>  			if (unlikely(PageTransHuge(page)))
> >>>  				flags |= TTU_SPLIT_HUGE_PMD;
> >>> +
> >>>  			if (!try_to_unmap(page, flags)) {
> >>>  				stat->nr_unmap_fail += nr_pages;
> >>> +				if (lazyfree && PageSwapBacked(page))
> >>> +					stat->nr_lazyfree_fail += nr_pages;
> >>>  				goto activate_locked;
> >>>  			}
> >>>  		}
> >>> @@ -1492,8 +1496,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> >>>  		.priority = DEF_PRIORITY,
> >>>  		.may_unmap = 1,
> >>>  	};
> >>> -	struct reclaim_stat dummy_stat;
> >>> -	unsigned long ret;
> >>> +	struct reclaim_stat stat;
> >>> +	unsigned long reclaimed;
> >>>  	struct page *page, *next;
> >>>  	LIST_HEAD(clean_pages);
> >>>  
> >>> @@ -1505,11 +1509,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> >>>  		}
> >>>  	}
> >>>  
> >>> -	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
> >>> -			TTU_IGNORE_ACCESS, &dummy_stat, true);
> >>> +	reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
> >>> +			TTU_IGNORE_ACCESS, &stat, true);
> >>>  	list_splice(&clean_pages, page_list);
> >>> -	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
> >>> -	return ret;
> >>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -reclaimed);
> >>> +	/*
> >>> +	 * Since lazyfree pages are isolated from file LRU from the beginning,
> >>> +	 * they will rotate back to anonymous LRU in the end if it failed to
> >>> +	 * discard so isolated count will be mismatched.
> >>> +	 * Compensate the isolated count for both LRU lists.
> >>> +	 */
> >>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
> >>> +					stat->nr_lazyfree_fail);
> >>> +	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
> >>> +					-stat->nr_lazyfree_fail);
> >> should be stat.nr_lazyfree_fail and -stat.nr_lazyfree_fail instead of ->
> >>> +	return reclaimed;
> >>>  }
> >>>  
> >>>  /*
> > Let me just CC Shaohua Li for commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
> > , because I missed him/her on other mail thread 
> >  : Sorry, I think I pointed a wrong commit, the SwapBacked was recovered
> >  : by commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages").
> >
> >
> > Hello Minchan
> >
> > I tested on my v4.19 based source tree and it seems to work.
> >
> > Prior to your patch I applied commit 060f005f0747 (
> > "mm/vmscan.c: do not allocate duplicate stack variables in shrink_page_list()"
> > for struct reclaim_stat.
> >
> > I considered other dependent changes below to follow code changes, not really needed for this issue though.
> > v5.3 98879b3b9edc mm: vmscan: correct some vmscan counters for THP swapout
> > v5.2 886cf1901db9 mm: move recent_rotated pages calculation to shrink_inactive_list()
> Hello Minchan
> 
> Are you preparing a complete patch for this issue?
> Sorry if I am bugging you.

Hi Jaewon

Sorry for the late. You catched the bug and gave good description with
the solution. What I did was just suggestion for alternative so feel
free to send the patch with your SoB. You could use my Suggested-by
and Acked-by. It's totally your credit!

Thanks!

Thanks!
