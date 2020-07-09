Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D51C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D574320772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGIBDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:03:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgGIBDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:03:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7F3E4836568A6F36098;
        Thu,  9 Jul 2020 09:03:21 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Jul 2020
 09:03:14 +0800
Subject: Re: [PATCH] vmalloc: Removing incorrect logs when vmalloc failed
To:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <1594113232-32193-1-git-send-email-tiantao6@hisilicon.com>
 <5e7885ef-081e-0682-7be7-40eb7712d2c7@arm.com> <20200707132442.GA26493@pc636>
 <3cf13a05-a6b8-aa2f-752d-f9a25a1005f9@huawei.com>
 <20200708134804.GA32309@pc636>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <bd1a23cb-bc23-5131-2674-12d956fdbf10@huawei.com>
Date:   Thu, 9 Jul 2020 09:03:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200708134804.GA32309@pc636>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/7/8 21:48, Uladzislau Rezki Ð´µÀ:
>>>> On 07/07/2020 02:43 PM, Tian Tao wrote:
>>>>> It is not possible to increase size with vmalloc=<size> in arm64
>>>>> architecture and it will mislead.however vmalloc return failure
>>>>> is a rare occurrence in 'many architectures including arm64'.
>>>>
>>>> But there is a chance that vmalloc() might work on architectures
>>>> that support 'vmalloc=' command line i.e after a change and this
>>>> information here might be helpful in those cases.
>>>>
>>> Agree. At least i see a few users of it:
>>>
>>> <snip>
>>> urezki@pc638:~/data/coding/linux-next.git$ grep -rn early_param ./arch/ | grep vmalloc
>>> ./arch/arm/mm/mmu.c:1152:early_param("vmalloc", early_vmalloc);
>>> ./arch/unicore32/mm/mmu.c:276:early_param("vmalloc", early_vmalloc);
>>> ./arch/x86/mm/pgtable_32.c:86:early_param("vmalloc", parse_vmalloc);
>>> urezki@pc638:~/data/coding/linux-next.git$
>>> <snip>
>>>
>> I'm actually having this problem with the arm64 architecture at centos 7.6
>> and pagesize is 64K.
>> I followed the prompts and added vmalloc=<size> to the command to increase
>> the size of the vmalloc.and found out it's not worked.
>> It took me some time to find out that this doesn't work for the arm64
>> architecture, so this log is misleading on arm64.
>>
> Agree, it can take time to understand some code or logic behind of it.
> So in that case having good documentation or comments always help.
> 
>> I think it's better not to be prompted than to be prompted incorrectly.
>> I'm sure there will be others with similar problems.
>> So I'd like to solve this problem this time, Please help me with your
>> suggestions.
>> If I change the PATCH to the following, will you accept it?
>>
> Actually it is not up to me to decide what to take or not. Andrew Morton
> is the key person here :) I can just review or make some comments same
> as others.
> 
>>        if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
>> +#ifdef CONFIG_ARM64 && CONFIG_XXX
>> +        pr_warn("vmap allocation for size %lu failed\n", size);
>> +#else
>>            pr_warn("vmap allocation for size %lu failed: use vmalloc=<size>
>> to increase size\n",
>>                size);
>> +#endif
>>
> I do not have a strong opinion here, but counting arches seems odd.
> Maybe modify the string with following message:
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1f46c3b86f9f..0aa26bc128d7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1202,7 +1202,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>          }
>   
>          if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> -               pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
> +               pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size, if your ARCH supports it\n",
>                          size);
>   
>          kmem_cache_free(vmap_area_cachep, va);
> <snip>
> 
Thanks, that's a good suggestion, I'll send v2 as you suggested!
> --
> Vlad Rezki
> 
> .
> 

