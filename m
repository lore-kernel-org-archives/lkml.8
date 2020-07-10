Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2062072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJEwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:52:41 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47115 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgGJEwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 00:52:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U2GOhiJ_1594356756;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2GOhiJ_1594356756)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 12:52:36 +0800
Subject: Re: a question of split_huge_page
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
Date:   Fri, 10 Jul 2020 12:51:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200709160750.utl46xvavceuvnom@box>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/7/10 ÉÏÎç12:07, Kirill A. Shutemov Ð´µÀ:
> On Thu, Jul 09, 2020 at 04:50:02PM +0100, Matthew Wilcox wrote:
>> On Thu, Jul 09, 2020 at 11:11:11PM +0800, Alex Shi wrote:
>>> Hi Kirill & Matthew,
>>>
>>> In the func call chain, from split_huge_page() to lru_add_page_tail(),
>>> Seems tail pages are added to lru list at line 963, but in this scenario
>>> the head page has no lru bit and isn't set the bit later. Why we do this?
>>> or do I miss sth?
>>
>> I don't understand how we get to split_huge_page() with a page that's
>> not on an LRU list.  Both anonymous and page cache pages should be on
>> an LRU list.  What am I missing?> 


Thanks a lot for quick reply!
What I am confusing is the call chain: __iommu_dma_alloc_pages()
to split_huge_page(), in the func, splited page,
	page = alloc_pages_node(nid, alloc_flags, order);
And if the pages were added into lru, they maybe reclaimed and lost,
that would be a panic bug. But in fact, this never happened for long time.
Also I put a BUG() at the line, it's nevre triggered in ltp, and run_vmtests
in kselftest.

> Right, and it's never got removed from LRU during the split. The tail
> pages have to be added to LRU because they now separate from the tail
> page.
> 
According to the explaination, looks like we could remove the code path,
since it's never got into. (base on my v15 patchset). Any comments?

Thanks
Alex

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7c52c5228aab..c28409509ad3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2357,17 +2357,6 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
        if (!list)
                SetPageLRU(page_tail);

        if (likely(PageLRU(head)))
                list_add_tail(&page_tail->lru, &head->lru);
        else if (list) {
                /* page reclaim is reclaiming a huge page */
                get_page(page_tail);
                list_add_tail(&page_tail->lru, list);
-       } else {
-               /*
-                * Head page has not yet been counted, as an hpage,
-                * so we must account for each subpage individually.
-                *
-                * Put page_tail on the list at the correct position
-                * so they all end up in order.
-                */
-               VM_BUG_ON_PAGE(1, head);
-               add_page_to_lru_list_tail(page_tail, lruvec,
-                                         page_lru(page_tail));
        }
 }
