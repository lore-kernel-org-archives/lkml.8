Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25475C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6CE21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGO2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:28:06 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33169 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgHGO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:28:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U50nlUT_1596810480;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U50nlUT_1596810480)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 22:28:00 +0800
Date:   Fri, 7 Aug 2020 22:28:00 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] mm/hugetlb: make sure to get NULL when list is
 empty
Message-ID: <20200807142800.GA14692@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-3-richard.weiyang@linux.alibaba.com>
 <20200807124951.GM14854@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807124951.GM14854@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 08:49:51PM +0800, Baoquan He wrote:
>On 08/07/20 at 05:12pm, Wei Yang wrote:
>> list_first_entry() may not return NULL even when the list is empty.
>> 
>> Let's make sure the behavior by using list_first_entry_or_null(),
>> otherwise it would corrupt the list.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  mm/hugetlb.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 62ec74f6d03f..0a2f3851b828 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -237,7 +237,8 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
>>  	VM_BUG_ON(resv->region_cache_count <= 0);
>
>
>We have had above line, is it possible to be NULL from list_first_entry?
>
>>  
>>  	resv->region_cache_count--;
>> -	nrg = list_first_entry(&resv->region_cache, struct file_region, link);
>> +	nrg = list_first_entry_or_null(&resv->region_cache,
>> +			struct file_region, link);
>>  	VM_BUG_ON(!nrg);

Or we can remove this VM_BUG_ON()?

>>  	list_del(&nrg->link);
>>  
>> -- 
>> 2.20.1 (Apple Git-117)
>> 
>> 

-- 
Wei Yang
Help you, Help me
