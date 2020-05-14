Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFB320675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgENI06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:26:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbgENI05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:26:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E33D99F0F89B7D0A6AE6;
        Thu, 14 May 2020 16:26:54 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.93) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 14 May 2020
 16:26:46 +0800
Subject: Re: [PATCH 05/10] riscv: Disable ARCH_HAS_DEBUG_WX if NOMMU
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <hulkci@huawei.com>
References: <mhng-f65a8b91-0836-4927-a39f-8167cd3ec67f@palmerdabbelt-glaptop1>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <5d08390b-613a-516c-0091-0dc78fbc0ef8@huawei.com>
Date:   Thu, 14 May 2020 16:26:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-f65a8b91-0836-4927-a39f-8167cd3ec67f@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.215.93]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/14 5:14, Palmer Dabbelt wrote:
> On Sun, 10 May 2020 19:19:56 PDT (-0700), wangkefeng.wang@huawei.com 
> wrote:
>> DEBUG_WX is only useful when MMU enabled, diable it if nommu
>> and fix the build error.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  arch/riscv/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 78f30f2fdd51..7da0a36a8df0 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -69,7 +69,7 @@ config RISCV
>>      select HAVE_ARCH_KASAN if MMU && 64BIT
>>      select HAVE_ARCH_KGDB
>>      select HAVE_ARCH_KGDB_QXFER_PKT
>> -    select ARCH_HAS_DEBUG_WX
>> +    select ARCH_HAS_DEBUG_WX if MMU
>>
>>  config ARCH_MMAP_RND_BITS_MIN
>>      default 18 if 64BIT
>
> Looks like this depends on something that isn't in any of my trees yet.
as said in cover letter, the patch is based on linux-next, tag 
next-20200508 :)
>
>

