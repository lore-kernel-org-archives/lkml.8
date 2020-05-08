Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4456C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F52C20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHIrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:47:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgEHIrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:47:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7F7242C8CAB7887673CB;
        Fri,  8 May 2020 16:47:41 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 16:47:40 +0800
Subject: Re: [PATCH 1/1] mm: remove an unnecessary goto jump
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200505115858.1718-1-thunder.leizhen@huawei.com>
 <6d06207c-5b1c-d526-ef01-e437c7696dd3@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <dc38f5a5-e318-de61-89ff-27aa35528fed@huawei.com>
Date:   Fri, 8 May 2020 16:47:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6d06207c-5b1c-d526-ef01-e437c7696dd3@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/8 16:06, David Hildenbrand wrote:
> On 05.05.20 13:58, Zhen Lei wrote:
>> This "goto" doesn't reduce any code, but bother the readers.
> 
> "mm/page_io.c: mm: remove an unnecessary goto in generic_swapfile_activate"

Do you mean change the subject? So is it:
"mm/page_io.c: remove an unnecessary goto in generic_swapfile_activate()" ?

> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  mm/page_io.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index 76965be1d40e..b1d4f4558e6b 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -235,10 +235,10 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>>  	sis->highest_bit = page_no - 1;
>>  out:
>>  	return ret;
>> +
> 
> nit: I'd just not mess with newlines here.

OK, I will drop it.

> 
>>  bad_bmap:
>>  	pr_err("swapon: swapfile has holes\n");
>> -	ret = -EINVAL;
>> -	goto out;
>> +	return -EINVAL;
>>  }
>>  
>>  /*
>>
> 
> apart from that
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> 

