Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A6C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCD82072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgD3X7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 19:59:37 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50239 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbgD3X7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 19:59:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tx82dB6_1588291170;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tx82dB6_1588291170)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 May 2020 07:59:33 +0800
Subject: Re: [linux-next PATCH 1/2] mm: khugepaged: add exceed_max_ptes_*
 helpers
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200430215932.5w5dck3rnieppzqa@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <cc8ac985-73a5-698f-f108-fb2d8410d14c@linux.alibaba.com>
Date:   Thu, 30 Apr 2020 16:59:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200430215932.5w5dck3rnieppzqa@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/20 2:59 PM, Kirill A. Shutemov wrote:
> On Thu, Apr 30, 2020 at 06:56:21AM +0800, Yang Shi wrote:
>> The max_ptes_{swap|none|shared} are defined to tune the behavior of
>> khugepaged.  The are checked at a couple of places with open coding.
>> Replace the opencoding to exceed_pax_ptes_{swap|none_shared} helpers to
>> improve the readability.
>>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/khugepaged.c | 27 +++++++++++++++++++++------
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index a02a4c5..0c8d30b 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -339,6 +339,21 @@ struct attribute_group khugepaged_attr_group = {
>>   };
>>   #endif /* CONFIG_SYSFS */
>>   
>> +static inline bool exceed_max_ptes_none(unsigned int *nr_ptes)
>> +{
>> +	return (++(*nr_ptes) > khugepaged_max_ptes_none);
>> +}
>> +
>> +static inline bool exceed_max_ptes_swap(unsigned int *nr_ptes)
>> +{
>> +	return (++(*nr_ptes) > khugepaged_max_ptes_swap);
>> +}
>> +
>> +static inline bool exceed_max_ptes_shared(unsigned int *nr_ptes)
>> +{
>> +	return (++(*nr_ptes) > khugepaged_max_ptes_shared);
>> +}
>> +
> Frankly, I find this ugly and confusing. Open-coded version is more
> readable to me.

I'm sorry you feel that way. I tend to agree that dereference looks not 
good. The open-coded version is not hard to understand to me either.

They are checked at a couple of different places with different 
variables, i.e. unmapped vs swap, and with different comparisons, > vs 
<=. I just thought the helpers with unified name started with "exceed_" 
may make it more self-explained and readable. Anyway this totally 
depends on taste and I really don't insist on this change.

>

