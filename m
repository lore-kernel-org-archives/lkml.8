Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A348CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC67206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHRDDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:03:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50941 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgHRDDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:03:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U668E35_1597719823;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U668E35_1597719823)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 11:03:43 +0800
Date:   Tue, 18 Aug 2020 11:03:43 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        alexander.h.duyck@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_reporting: the "page" must not be the list head
Message-ID: <20200818030343.GB29756@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200817084836.29216-1-richard.weiyang@linux.alibaba.com>
 <fa97519b-a860-5fea-9511-2237f195caeb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa97519b-a860-5fea-9511-2237f195caeb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:35:29AM +0200, David Hildenbrand wrote:
>On 17.08.20 10:48, Wei Yang wrote:
>> If "page" is the list head, list_for_each_entry_safe() would stop
>> iteration.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  mm/page_reporting.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>> index 3bbd471cfc81..aaaa3605123d 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
>> @@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>>  		 * the new head of the free list before we release the
>>  		 * zone lock.
>>  		 */
>> -		if (&page->lru != list && !list_is_first(&page->lru, list))
>> +		if (!list_is_first(&page->lru, list))
>>  			list_rotate_to_front(&page->lru, list);
>>  
>>  		/* release lock before waiting on report processing */
>> 
>
>Is this a fix or a cleanup? If it's a fix, can this be reproduced easily
>and what ere the effects?
>

I think this is a cleanup.

I am not sure why you ask this, since the check must be true when the
iteration continues.

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
