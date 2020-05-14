Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E799C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5287A2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgENLnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:43:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbgENLnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:43:02 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 393189755B08008A272F;
        Thu, 14 May 2020 19:42:59 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.93) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 14 May 2020
 19:42:48 +0800
Subject: Re: [PATCH 04/10] riscv: Fix print_vm_layout build error if NOMMU
To:     Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
References: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
 <20200511022001.179767-5-wangkefeng.wang@huawei.com>
 <1daca195-f63c-2693-068f-6d624aa1b899@ghiti.fr>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <669a4a33-42cc-1f5d-a0f5-37ab18a8a371@huawei.com>
Date:   Thu, 14 May 2020 19:42:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1daca195-f63c-2693-068f-6d624aa1b899@ghiti.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.215.93]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/14 18:10, Alex Ghiti wrote:
> Hi,
>
> On 5/10/20 10:19 PM, Kefeng Wang wrote:
>> arch/riscv/mm/init.c: In function ‘print_vm_layout’:
>> arch/riscv/mm/init.c:68:37: error: ‘FIXADDR_START’ undeclared (first 
>> use in this function);
>> arch/riscv/mm/init.c:69:20: error: ‘FIXADDR_TOP’ undeclared
>> arch/riscv/mm/init.c:70:37: error: ‘PCI_IO_START’ undeclared
>> arch/riscv/mm/init.c:71:20: error: ‘PCI_IO_END’ undeclared
>> arch/riscv/mm/init.c:72:38: error: ‘VMEMMAP_START’ undeclared
>> arch/riscv/mm/init.c:73:20: error: ‘VMEMMAP_END’ undeclared (first 
>> use in this function);
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/riscv/mm/init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index dfcaebc3928f..58c39c44b9c9 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -49,7 +49,7 @@ static void setup_zero_page(void)
>>       memset((void *)empty_zero_page, 0, PAGE_SIZE);
>>   }
>>   -#ifdef CONFIG_DEBUG_VM
>> +#if defined(CONFIG_MMU) && defined(DEBUG_VM)
>
>
> Shouldn't it be CONFIG_DEBUG_VM ?
oops, should be CONFIG_DEBUG_VM, will send v2, thanks.
>
>
>>   static inline void print_mlk(char *name, unsigned long b, unsigned 
>> long t)
>>   {
>>       pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
>
>
> Alex
>
>
> .
>

