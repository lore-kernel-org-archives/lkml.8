Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA96C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2B2221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgHGOcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:32:55 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43742 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgHGOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:32:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U50nngy_1596810749;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U50nngy_1596810749)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 22:32:29 +0800
Date:   Fri, 7 Aug 2020 22:32:29 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/hugetlb: return non-isolated page in the loop
 instead of break and check
Message-ID: <20200807143229.GC14692@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-9-richard.weiyang@linux.alibaba.com>
 <20200807130931.GS14854@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807130931.GS14854@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 09:09:31PM +0800, Baoquan He wrote:
>On 08/07/20 at 05:12pm, Wei Yang wrote:
>> Function dequeue_huge_page_node_exact() iterates the free list and
>> return the first non-isolated one.
>> 
>> Instead of break and check the loop variant, we could return in the loop
>> directly. This could reduce some redundant check.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  mm/hugetlb.c | 26 ++++++++++++--------------
>>  1 file changed, 12 insertions(+), 14 deletions(-)
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index b8e844911b5a..9473eb6800e9 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1035,20 +1035,18 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>>  {
>>  	struct page *page;
>>  
>> -	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
>> -		if (!PageHWPoison(page))
>> -			break;
>
>I don't see how it can reduce redundant check, just two different
>styles.
>

list_for_each_entry() stops by checking whether the item reach list head.

>> -	/*
>> -	 * if 'non-isolated free hugepage' not found on the list,
>> -	 * the allocation fails.
>
>But the above code comment seems stale, it checks HWPoision page()
>directly, but not the old isolated page checking.
>
>> -	 */
>> -	if (&h->hugepage_freelists[nid] == &page->lru)
>> -		return NULL;

And here the check is done again, if we really iterate the whole list.

By take the code in the loop, we can avoid this check.

>> -	list_move(&page->lru, &h->hugepage_activelist);
>> -	set_page_refcounted(page);
>> -	h->free_huge_pages--;
>> -	h->free_huge_pages_node[nid]--;
>> -	return page;
>> +	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
>> +		if (PageHWPoison(page))
>> +			continue;
>> +
>> +		list_move(&page->lru, &h->hugepage_activelist);
>> +		set_page_refcounted(page);
>> +		h->free_huge_pages--;
>> +		h->free_huge_pages_node[nid]--;
>> +		return page;
>> +	}
>> +
>> +	return NULL;
>>  }
>>  
>>  static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
>> -- 
>> 2.20.1 (Apple Git-117)
>> 
>> 

-- 
Wei Yang
Help you, Help me
