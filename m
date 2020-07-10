Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7803C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C663D206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJJfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:35:33 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33774 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbgGJJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:35:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U2H8hSR_1594373729;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2H8hSR_1594373729)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 17:35:30 +0800
Subject: Re: a question of split_huge_page
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
 <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
Date:   Fri, 10 Jul 2020 17:34:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/7/10 下午1:28, Mika Penttilä 写道:
> 
> 
> On 10.7.2020 7.51, Alex Shi wrote:
>>
>> 在 2020/7/10 上午12:07, Kirill A. Shutemov 写道:
>>> On Thu, Jul 09, 2020 at 04:50:02PM +0100, Matthew Wilcox wrote:
>>>> On Thu, Jul 09, 2020 at 11:11:11PM +0800, Alex Shi wrote:
>>>>> Hi Kirill & Matthew,
>>>>>
>>>>> In the func call chain, from split_huge_page() to lru_add_page_tail(),
>>>>> Seems tail pages are added to lru list at line 963, but in this scenario
>>>>> the head page has no lru bit and isn't set the bit later. Why we do this?
>>>>> or do I miss sth?
>>>> I don't understand how we get to split_huge_page() with a page that's
>>>> not on an LRU list.  Both anonymous and page cache pages should be on
>>>> an LRU list.  What am I missing?> 
>>
>> Thanks a lot for quick reply!
>> What I am confusing is the call chain: __iommu_dma_alloc_pages()
>> to split_huge_page(), in the func, splited page,
>> 	page = alloc_pages_node(nid, alloc_flags, order);
>> And if the pages were added into lru, they maybe reclaimed and lost,
>> that would be a panic bug. But in fact, this never happened for long time.
>> Also I put a BUG() at the line, it's nevre triggered in ltp, and run_vmtests
> 
> 
> In  __iommu_dma_alloc_pages, after split_huge_page(),  who is taking a
> reference on tail pages? Seems tail pages are freed and the function
> errornously returns them in pages[] array for use?
> 

CC Joerg and iommu list,

That's a good question. seems the split_huge_page was never triggered here,
since the func would check the PageLock first. and have page->mapping and PageAnon
check, any of them couldn't be matched for the alloced page.

Hi Joerg,
would you like look into this? do we still need the split_huge_page() here?

Thanks
Alex

int split_huge_page_to_list(struct page *page, struct list_head *list)
{
        struct page *head = compound_head(page);
        struct deferred_split *ds_queue = get_deferred_split_queue(head);
        struct anon_vma *anon_vma = NULL;
        struct address_space *mapping = NULL;
        int count, mapcount, extra_pins, ret;
        pgoff_t end;

        VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
        VM_BUG_ON_PAGE(!PageLocked(head), head);	<==
> 
