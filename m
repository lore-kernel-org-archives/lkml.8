Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF8C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6643E208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIACEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:04:20 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54564 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgIACET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:04:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0U7TxlIk_1598925854;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7TxlIk_1598925854)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 10:04:15 +0800
Subject: Re: [PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
 <alpine.LSU.2.11.2008301405000.5954@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <5875bdbe-c1af-737b-9ec2-4b48b3c2465f@linux.alibaba.com>
Date:   Tue, 1 Sep 2020 10:04:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2008301405000.5954@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/8/31 ÉÏÎç5:08, Hugh Dickins Ð´µÀ:
> check_move_unevictable_pages() is used in making unevictable shmem pages
> evictable: by shmem_unlock_mapping(), drm_gem_check_release_pagevec() and
> i915/gem check_release_pagevec().  Those may pass down subpages of a huge
> page, when /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force".
> 
> That does not crash or warn at present, but the accounting of vmstats
> unevictable_pgs_scanned and unevictable_pgs_rescued is inconsistent:
> scanned being incremented on each subpage, rescued only on the head
> (since tails already appear evictable once the head has been updated).
> 
> 5.8 commit 5d91f31faf8e ("mm: swap: fix vmstats for huge page") has
> established that vm_events in general (and unevictable_pgs_rescued in
> particular) should count every subpage: so follow that precedent here.
> 
> Do this in such a way that if mem_cgroup_page_lruvec() is made stricter
> (to check page->mem_cgroup is always set), no problem: skip the tails
> before calling it, and add thp_nr_pages() to vmstats on the head.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Nothing here worth going to stable, since it's just a testing config
> that is fixed, whose event numbers are not very important; but this
> will be needed before Alex Shi's warning, and might as well go in now.
> 
> The callers of check_move_unevictable_pages() could be optimized,
> to skip over tails: but Matthew Wilcox has other changes in flight
> there, so let's skip the optimization for now.
> 
>  mm/vmscan.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> --- 5.9-rc2/mm/vmscan.c	2020-08-16 17:32:50.721507348 -0700
> +++ linux/mm/vmscan.c	2020-08-28 17:47:10.595580876 -0700
> @@ -4260,8 +4260,14 @@ void check_move_unevictable_pages(struct
>  	for (i = 0; i < pvec->nr; i++) {
>  		struct page *page = pvec->pages[i];
>  		struct pglist_data *pagepgdat = page_pgdat(page);
> +		int nr_pages;
> +
> +		if (PageTransTail(page))
> +			continue;
> +
> +		nr_pages = thp_nr_pages(page);
> +		pgscanned += nr_pages;
>  
> -		pgscanned++;
>  		if (pagepgdat != pgdat) {
>  			if (pgdat)
>  				spin_unlock_irq(&pgdat->lru_lock);
> @@ -4280,7 +4286,7 @@ void check_move_unevictable_pages(struct
>  			ClearPageUnevictable(page);
>  			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
>  			add_page_to_lru_list(page, lruvec, lru);

So, we might randomly del or add a thp tail page into lru?
It's interesting to know here. :)

Thanks
Alex

> -			pgrescued++;
> +			pgrescued += nr_pages;
>  		}
>  	}
>  
> 
