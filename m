Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DCC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2DB20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587136444;
	bh=qooN1eiHA+0ky/PzXcYNX5LJvyxIt+2rmgYag6zhE4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+Bj6T5grxjEhnrhPNILBGL8CoxPFgJi1Oehu+2FS5AVxlbdmqsPO56cxQsRUD7lE
	 /dsmf4d1gYKhiwfivzCD20LBrCYKeLa/9p3n2VfD0FiB0RqW/izQbasFyXVRPAAK8w
	 rZOAz7OeRaI/wYKHpvKsRJhxSvmpqkQy6L8qq58k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgDQPOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728272AbgDQPOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:14:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A73AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:14:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so1200714pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9vmUW9SF/4EBzVT/P6VKC9VFo38kAUkp6d4jrsY3VRw=;
        b=InJizvVl/agy3Aur19LVdlrlh8Rz39sqzCHktUfl8x/wAfoyy9CM3XVeO1kdFK1xUy
         f0clsMiNBrmnabYhmskW1amBATdI6IHRx2TDmRKnpH5o8pQvizMCsvoWSlmjjyd7/VW0
         h0T3bXp1bR45FLMArd/UA0YhoEtTHf4n5I1Yul28g6l28R0M56Z7HxSG18DEgI0rBMwl
         O1FLvtOzwD6SsOUb9eR1sK3wfwHBECpE3fUrzsBs7hLKnT9WCFW/Dc+i+8O3UJ9SpWy0
         uczgCC5gypfa2aOYDrADVmM4+ommqAKBr83c8FmIjNUOQgvWz/e1njOP5Tn2EDqgp5pu
         3W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9vmUW9SF/4EBzVT/P6VKC9VFo38kAUkp6d4jrsY3VRw=;
        b=FB3Hv+VOu6XlmOjVpvSBElH88R+2alSnYcgJ7uzwyt2maGKOoykArgPwGOcq5x32Xu
         F1Go2x0GhzrILS0Uw+WHD0ga3OgRmRjUbUK6bOfZtpEH2sdYmFvdSkNgC0TlJUb/Zcq5
         cVQfBGCLrGrCUVeIsrYpl82hVzK7Yu8//tZCs7iRctkrwREZpYfNILasMfa/3yzRgalM
         OOovJI4cw4xiLqOJuZT4n3qyu4SFNKjzJqI9jgnyuI9/tpNT5IUnU24+7aQapxNaetC0
         xmaoytEjQc2fLsVZRdPnYrN3ld1T+n4rf4SNfwaeTIBs8bWtExt2arzEItAiuvjMQBxH
         2VHg==
X-Gm-Message-State: AGi0PuZtZmBIIe2nveLIiU0xFSicnC5ZdFVEc6A0+mAOxq4UUmtS8//l
        y893+Olw04T1rzVDUUEO2Y4=
X-Google-Smtp-Source: APiQypKoiF0EMRbeJ6y9aifLrhJoEUfOjrvxJg7Ekv4h1orz4zptd56Qu1lK/8ymKoVCSIvLziwCfw==
X-Received: by 2002:a17:902:c202:: with SMTP id 2mr3872132pll.196.1587136441695;
        Fri, 17 Apr 2020 08:14:01 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id a17sm7688794pfr.24.2020.04.17.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:14:00 -0700 (PDT)
Date:   Fri, 17 Apr 2020 08:13:58 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mgorman@suse.de, m.szyprowski@samsung.com, mina86@mina86.com,
        riel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
Message-ID: <20200417151358.GA178621@google.com>
References: <CGME20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a@epcas1p2.samsung.com>
 <20200416033514.6366-1-jaewon31.kim@samsung.com>
 <20200417003837.GA90471@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417003837.GA90471@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:38:37PM -0700, Minchan Kim wrote:
> Hi Jaewon,
> 
> On Thu, Apr 16, 2020 at 12:35:14PM +0900, Jaewon Kim wrote:
> > This patch fix nr_isolate_* mismatch problem between cma and dirty
> > lazyfree page.
> > 
> > If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
> > page, then the lazyfree page is changed to a normal anon page having
> > SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
> > with the change, reclaim context correctly counts isolated files because
> > it uses is_file_lru to distinguish file. And the change to anon is not
> > happened if try_to_unmap_one is used for migration. So migration context
> > like compaction also correctly counts isolated files even though it uses
> > page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
> > renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
> > MADV_FREE").
> > 
> > But the nr_isolate_* mismatch problem happens on cma alloc. There is
> > reclaim_clean_pages_from_list which is being used only by cma. It was
> > introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
> > contiguous allocation instead of migration") to reclaim clean file pages
> > without migration. The cma alloc uses both reclaim_clean_pages_from_list
> > and migrate_pages, and it uses page_is_file_lru to count isolated
> > files. If there are dirty lazyfree pages allocated from cma memory
> > region, the pages are counted as isolated file at the beginging but are
> > counted as isolated anon after finished.
> > 
> > Mem-Info:
> > Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> > 
> > Like log above, there was too much isolated file, 37664kB, which
> > triggers too_many_isolated in reclaim when there is no isolated file in
> > system wide. It could be reproducible by running two programs, doing
> > MADV_FREE, writing and doing cma alloc, respectively. Although isolated
> > anon is 0, I found that the internal value of isolated anon was the
> > negative value of isolated file.
> > 
> > Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
> > lazyfree page can be checked by both PageAnon(page) and
> > page_is_file_lru. But in this case, PageAnon is enough to skip all
> > anon pages.
> > 
> > Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> > Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> 
> Thanks for the investigation!
> The thing is MADV_FREEed page since supporting swapless could change
> his LRU status between reclaim.
> 
> I am worry about voiding the optimization we have kept in CMA but
> also don't have good idea, either so I tend to agree with this.
> 
> Let me Cc Johannes who might have better idea.
> 
> > ---
> >  mm/vmscan.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b06868fc4926..9380a18eef5e 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> >  	LIST_HEAD(clean_pages);
> >  
> >  	list_for_each_entry_safe(page, next, page_list, lru) {
> > +		/* to avoid race with MADV_FREE anon page */
> > +		if (PageAnon(page))
> > +			continue;
> >  		if (page_is_file_lru(page) && !PageDirty(page) &&
> >  		    !__PageMovable(page) && !PageUnevictable(page)) {
> >  			ClearPageActive(page);
> > -- 
> > 2.13.7
> > 

Hi Jaewon,

How about this idea? I think it could solve the issue with keeping
CMA alloc latency optimization.

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 292485f3d24d..10cc932e209a 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -29,6 +29,7 @@ struct reclaim_stat {
 	unsigned nr_activate[2];
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
+	unsigned nr_lazyfree_fail;
 };
 
 enum writeback_stat_item {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4c8a1cdccbba..b390f6094f2f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1296,11 +1296,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 */
 		if (page_mapped(page)) {
 			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
+			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
 
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
+
 			if (!try_to_unmap(page, flags)) {
 				stat->nr_unmap_fail += nr_pages;
+				if (lazyfree && PageSwapBacked(page))
+					stat->nr_lazyfree_fail += nr_pages;
 				goto activate_locked;
 			}
 		}
@@ -1492,8 +1496,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 		.priority = DEF_PRIORITY,
 		.may_unmap = 1,
 	};
-	struct reclaim_stat dummy_stat;
-	unsigned long ret;
+	struct reclaim_stat stat;
+	unsigned long reclaimed;
 	struct page *page, *next;
 	LIST_HEAD(clean_pages);
 
@@ -1505,11 +1509,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 		}
 	}
 
-	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
-			TTU_IGNORE_ACCESS, &dummy_stat, true);
+	reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
+			TTU_IGNORE_ACCESS, &stat, true);
 	list_splice(&clean_pages, page_list);
-	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
-	return ret;
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -reclaimed);
+	/*
+	 * Since lazyfree pages are isolated from file LRU from the beginning,
+	 * they will rotate back to anonymous LRU in the end if it failed to
+	 * discard so isolated count will be mismatched.
+	 * Compensate the isolated count for both LRU lists.
+	 */
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
+					stat->nr_lazyfree_fail);
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
+					-stat->nr_lazyfree_fail);
+	return reclaimed;
 }
 
 /*
-- 
2.26.1.301.g55bc3eb7cb9-goog

