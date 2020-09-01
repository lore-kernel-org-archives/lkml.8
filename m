Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E10C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E011220707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIABmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:42:08 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:57547 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgIABmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:42:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7Tly0l_1598924523;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7Tly0l_1598924523)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 09:42:04 +0800
Date:   Tue, 1 Sep 2020 09:42:03 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com
Subject: Re: [Patch v3 7/7] mm/hugetlb: take the free hpage during the
 iteration directly
Message-ID: <20200901014203.GA29343@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
 <20200831022351.20916-8-richard.weiyang@linux.alibaba.com>
 <d36e57db-b02f-fd75-6c0c-734635f58ff5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36e57db-b02f-fd75-6c0c-734635f58ff5@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 04:06:54PM -0700, Mike Kravetz wrote:
>On 8/30/20 7:23 PM, Wei Yang wrote:
>> Function dequeue_huge_page_node_exact() iterates the free list and
>> return the first valid free hpage.
>> 
>> Instead of break and check the loop variant, we could return in the loop
>> directly. This could reduce some redundant check.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  mm/hugetlb.c | 20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 7b3357c1dcec..709be7ab65af 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1040,21 +1040,17 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>>  		if (nocma && is_migrate_cma_page(page))
>>  			continue;
>>  
>> -		if (!PageHWPoison(page))
>> +		if (PageHWPoison(page))
>>  			break;
>
>Previously, when encountering a PageHWPoison(page) the loop would continue
>and check the next page in the list.  It now breaks the loop and returns
>NULL.  Is not this a change in behavior?  Perhaps you want to change that
>break to a continue.  Or, restructure in some other way.

Shame on me. You are right. I should change it to continue.

Andrew,

Sorry for the inconvenience.

>-- 
>Mike Kravetz
>
>> +
>> +		list_move(&page->lru, &h->hugepage_activelist);
>> +		set_page_refcounted(page);
>> +		h->free_huge_pages--;
>> +		h->free_huge_pages_node[nid]--;
>> +		return page;
>>  	}
>>  
>> -	/*
>> -	 * if 'non-isolated free hugepage' not found on the list,
>> -	 * the allocation fails.
>> -	 */
>> -	if (&h->hugepage_freelists[nid] == &page->lru)
>> -		return NULL;
>> -	list_move(&page->lru, &h->hugepage_activelist);
>> -	set_page_refcounted(page);
>> -	h->free_huge_pages--;
>> -	h->free_huge_pages_node[nid]--;
>> -	return page;
>> +	return NULL;
>>  }
>>  
>>  static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
>> 

-- 
Wei Yang
Help you, Help me
