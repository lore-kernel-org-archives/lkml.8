Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D41206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGHAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:51:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbgGHAvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:51:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B4841322C65DEFE284D;
        Wed,  8 Jul 2020 08:51:43 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 8 Jul 2020
 08:51:33 +0800
Subject: Re: [PATCH] vmalloc: Removing incorrect logs when vmalloc failed
To:     Uladzislau Rezki <urezki@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <1594113232-32193-1-git-send-email-tiantao6@hisilicon.com>
 <5e7885ef-081e-0682-7be7-40eb7712d2c7@arm.com> <20200707132442.GA26493@pc636>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <3cf13a05-a6b8-aa2f-752d-f9a25a1005f9@huawei.com>
Date:   Wed, 8 Jul 2020 08:51:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200707132442.GA26493@pc636>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/7/7 21:24, Uladzislau Rezki Ð´µÀ:
> On Tue, Jul 07, 2020 at 03:18:54PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 07/07/2020 02:43 PM, Tian Tao wrote:
>>> It is not possible to increase size with vmalloc=<size> in arm64
>>> architecture and it will mislead.however vmalloc return failure
>>> is a rare occurrence in 'many architectures including arm64'.
>>
>> But there is a chance that vmalloc() might work on architectures
>> that support 'vmalloc=' command line i.e after a change and this
>> information here might be helpful in those cases.
>>
> Agree. At least i see a few users of it:
> 
> <snip>
> urezki@pc638:~/data/coding/linux-next.git$ grep -rn early_param ./arch/ | grep vmalloc
> ./arch/arm/mm/mmu.c:1152:early_param("vmalloc", early_vmalloc);
> ./arch/unicore32/mm/mmu.c:276:early_param("vmalloc", early_vmalloc);
> ./arch/x86/mm/pgtable_32.c:86:early_param("vmalloc", parse_vmalloc);
> urezki@pc638:~/data/coding/linux-next.git$
> <snip>
> 
I'm actually having this problem with the arm64 architecture at centos 
7.6 and pagesize is 64K.
I followed the prompts and added vmalloc=<size> to the command to 
increase the size of the vmalloc.and found out it's not worked.
It took me some time to find out that this doesn't work for the arm64 
architecture, so this log is misleading on arm64.
I think it's better not to be prompted than to be prompted incorrectly.
I'm sure there will be others with similar problems.
So I'd like to solve this problem this time, Please help me with your 
suggestions.
If I change the PATCH to the following, will you accept it?

       if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
+#ifdef CONFIG_ARM64 && CONFIG_XXX
+        pr_warn("vmap allocation for size %lu failed\n", size);
+#else
           pr_warn("vmap allocation for size %lu failed: use 
vmalloc=<size> to increase size\n",
               size);
+#endif

> Thanks!
> 
> --
> Vlad Rezki
> 
> .
> 

