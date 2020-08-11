Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41492076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgHKXTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:19:37 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:54312 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgHKXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:19:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5Vraek_1597187972;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5Vraek_1597187972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Aug 2020 07:19:32 +0800
Date:   Wed, 12 Aug 2020 07:19:32 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200811231932.GA33666@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
 <20200811015148.GA10792@MiWiFi-R3L-srv>
 <20200811065406.GC4793@dhcp22.suse.cz>
 <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 02:43:28PM -0700, Mike Kravetz wrote:
>On 8/10/20 11:54 PM, Michal Hocko wrote:
>> 
>> I have managed to forgot all the juicy details since I have made that
>> change. All that remains is that the surplus pages accounting was quite
>> tricky and back then I didn't figure out a simpler method that would
>> achieve the consistent look at those counters. As mentioned above I
>> suspect this could lead to pre-mature allocation failures while the
>> migration is ongoing.
>
>It is likely lost in the e-mail thread, but the suggested change was to
>alloc_surplus_huge_page().  The code which allocates the migration target
>(alloc_migrate_huge_page) will not be changed.  So, this should not be
>an issue.
>
>>                       Sure quite unlikely to happen and the race window
>> is likely very small. Maybe this is even acceptable but I would strongly
>> recommend to have all this thinking documented in the changelog.
>
>I wrote down a description of what happens in the two different approaches
>"temporary page" vs "surplus page".  It is at the very end of this e-mail.
>When looking at the details, I came up with what may be an even better
>approach.  Why not just call the low level routine to free the page instead
>of going through put_page/free_huge_page?  At the very least, it saves a
>lock roundtrip and there is no need to worry about the counters/accounting.
>
>Here is a patch to do that.  However, we are optimizing a return path in
>a race condition that we are unlikely to ever hit.  I 'tested' it by allocating
>an 'extra' page and freeing it via this method in alloc_surplus_huge_page.
>
>>From 864c5f8ef4900c95ca3f6f2363a85f3cb25e793e Mon Sep 17 00:00:00 2001
>From: Mike Kravetz <mike.kravetz@oracle.com>
>Date: Tue, 11 Aug 2020 12:45:41 -0700
>Subject: [PATCH] hugetlb: optimize race error return in
> alloc_surplus_huge_page
>
>The routine alloc_surplus_huge_page() could race with with a pool
>size change.  If this happens, the allocated page may not be needed.
>To free the page, the current code will 'Abuse temporary page to
>workaround the nasty free_huge_page codeflow'.  Instead, directly
>call the low level routine that free_huge_page uses.  This works
>out well because the page is new, we hold the only reference and
>already hold the hugetlb_lock.
>
>Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>---
> mm/hugetlb.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>
>diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>index 590111ea6975..ac89b91fba86 100644
>--- a/mm/hugetlb.c
>+++ b/mm/hugetlb.c
>@@ -1923,14 +1923,17 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> 	/*
> 	 * We could have raced with the pool size change.
> 	 * Double check that and simply deallocate the new page
>-	 * if we would end up overcommiting the surpluses. Abuse
>-	 * temporary page to workaround the nasty free_huge_page
>-	 * codeflow
>+	 * if we would end up overcommiting the surpluses.
> 	 */
> 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
>-		SetPageHugeTemporary(page);
>+		/*
>+		 * Since this page is new, we hold the only reference, and
>+		 * we already hold the hugetlb_lock call the low level free
>+		 * page routine.  This saves at least a lock roundtrip.

The change looks good to me, while I may not understand the "lock roundtrip".
You mean we don't need to release the hugetlb_lock?

>+		 */
>+		(void)put_page_testzero(page); /* don't call destructor */
>+		update_and_free_page(h, page);
> 		spin_unlock(&hugetlb_lock);
>-		put_page(page);
> 		return NULL;
> 	} else {
> 		h->surplus_huge_pages++;
>-- 
>2.25.4
>
>
>Here is a description of the difference in "Temporary Page" vs "Surplus
>Page" approach.
>
>Both only allocate a fresh huge page if surplus_huge_pages is less than
>nr_overcommit_huge_pages.  Of course, the lock protecting those counts
>must be dropped to perform the allocation.  After reacquiring the lock
>is where we have the proposed difference in behavior.
>
>temporary page behavior
>-----------------------
>if surplus_huge_pages >= h->nr_overcommit_huge_pages
>	SetPageHugeTemporary(page)
>	spin_unlock(&hugetlb_lock);
>	put_page(page);
>
>At this time we know surplus_huge_pages is 'at least' nr_overcommit_huge_pages.
>As a result, any new allocation will fail.
>Only user visible result is that number of huge pages will be one greater than
>that specified by user and overcommit values.  This is only visible for the
>short time until the page is actully freed as a result of put_page().
>
>free_huge_page()
>	number of huge pages will be decremented
>
>suprlus page behavior
>---------------------
>surplus_huge_pages++
>surplus_huge_pages_node[page_to_nid(page)]++
>if surplus_huge_pages > nr_overcommit_huge_pages
>	spin_unlock(&hugetlb_lock);
>	put_page(page);
>
>At this time we know surplus_huge_pages is greater than
>nr_overcommit_huge_pages.  As a result, any new allocation will fail.
>User visible result is an increase in surplus pages as well as number of
>huge pages.  In addition, surplus pages will exceed overcommit.  This is
>only visible for the short time until the page is actully freed as a
>result of put_page().
>
>free_huge_page()
>	number of huge pages will be decremented
>	h->surplus_huge_pages--;
>	h->surplus_huge_pages_node[nid]--;

-- 
Wei Yang
Help you, Help me
