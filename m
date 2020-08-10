Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C033BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D9020734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgHJXFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:05:49 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60795 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbgHJXFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:05:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U5Pi6VE_1597100744;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5Pi6VE_1597100744)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Aug 2020 07:05:45 +0800
Date:   Tue, 11 Aug 2020 07:05:44 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] mm/hugetlb: make sure to get NULL when list is
 empty
Message-ID: <20200810230544.GA27669@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-3-richard.weiyang@linux.alibaba.com>
 <20200807124951.GM14854@MiWiFi-R3L-srv>
 <20200807142800.GA14692@L-31X9LVDL-1304.local>
 <9cf6749d-3a0a-480a-ef76-ae8cf5413a90@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf6749d-3a0a-480a-ef76-ae8cf5413a90@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 01:28:46PM -0700, Mike Kravetz wrote:
>On 8/7/20 7:28 AM, Wei Yang wrote:
>> On Fri, Aug 07, 2020 at 08:49:51PM +0800, Baoquan He wrote:
>>> On 08/07/20 at 05:12pm, Wei Yang wrote:
>>>> list_first_entry() may not return NULL even when the list is empty.
>>>>
>>>> Let's make sure the behavior by using list_first_entry_or_null(),
>>>> otherwise it would corrupt the list.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>> ---
>>>>  mm/hugetlb.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 62ec74f6d03f..0a2f3851b828 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -237,7 +237,8 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
>>>>  	VM_BUG_ON(resv->region_cache_count <= 0);
>>>
>>>
>>> We have had above line, is it possible to be NULL from list_first_entry?
>>>
>>>>  
>>>>  	resv->region_cache_count--;
>>>> -	nrg = list_first_entry(&resv->region_cache, struct file_region, link);
>>>> +	nrg = list_first_entry_or_null(&resv->region_cache,
>>>> +			struct file_region, link);
>>>>  	VM_BUG_ON(!nrg);
>> 
>> Or we can remove this VM_BUG_ON()?
>> 
>
>I would prefer that we just remove the 'VM_BUG_ON(!nrg)'.  Code elsewhere
>is responsible for making sure there is ALWAYS an entry in the cache.  That
>is why the 'VM_BUG_ON(resv->region_cache_count <= 0)' is at the beginning
>of the routine.

Sure, will change to this.

>
>-- 
>Mike Kravetz

-- 
Wei Yang
Help you, Help me
