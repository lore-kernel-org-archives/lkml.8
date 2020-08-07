Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8E2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHGO2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:28:54 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46192 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgHGO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:28:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U50laYt_1596810517;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U50laYt_1596810517)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 22:28:38 +0800
Date:   Fri, 7 Aug 2020 22:28:37 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] mm/hugetlb: remove the redundant check on
 non_swap_entry()
Message-ID: <20200807142837.GB14692@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-6-richard.weiyang@linux.alibaba.com>
 <20200807125550.GP14854@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807125550.GP14854@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 08:55:50PM +0800, Baoquan He wrote:
>On 08/07/20 at 05:12pm, Wei Yang wrote:
>> Migration and hwpoison entry is a subset of non_swap_entry().
>> 
>> Remove the redundant check on non_swap_entry().
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>
>Hmm, I have posted one patch to do the same thing, got reivewed by
>people.
>
>https://lore.kernel.org/linux-mm/20200723104636.GS32539@MiWiFi-R3L-srv/
>

Nice

>> ---
>>  mm/hugetlb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index d775e514eb2e..f5f04e89000d 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3778,7 +3778,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
>>  	if (huge_pte_none(pte) || pte_present(pte))
>>  		return false;
>>  	swp = pte_to_swp_entry(pte);
>> -	if (non_swap_entry(swp) && is_migration_entry(swp))
>> +	if (is_migration_entry(swp))
>>  		return true;
>>  	else
>>  		return false;
>> @@ -3791,7 +3791,7 @@ static int is_hugetlb_entry_hwpoisoned(pte_t pte)
>>  	if (huge_pte_none(pte) || pte_present(pte))
>>  		return 0;
>>  	swp = pte_to_swp_entry(pte);
>> -	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
>> +	if (is_hwpoison_entry(swp))
>>  		return 1;
>>  	else
>>  		return 0;
>> -- 
>> 2.20.1 (Apple Git-117)
>> 
>> 

-- 
Wei Yang
Help you, Help me
