Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83839C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BE62072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDGFNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:13:18 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34223 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgDGFNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:13:18 -0400
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 24AB9200004;
        Tue,  7 Apr 2020 05:13:10 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [RFC PATCH 3/7] riscv: Simplify MAXPHYSMEM config
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-f28ea5f1-ad10-4216-8612-f92863d20cca@palmerdabbelt-glaptop1>
Message-ID: <61d65afd-1650-4e16-b93d-f6d44c95ada7@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:13:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-f28ea5f1-ad10-4216-8612-f92863d20cca@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/20 11:53 AM, Palmer Dabbelt wrote:
> On Sun, 22 Mar 2020 04:00:24 PDT (-0700), alex@ghiti.fr wrote:
>> Either the user specifies maximum physical memory size of 2GB or the
>> user lives with the system constraint which is 128GB in 64BIT for now.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/Kconfig | 20 ++++++--------------
>>  1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 8e4b1cbcf2c2..a475c78e66bc 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -104,7 +104,7 @@ config PAGE_OFFSET
>>      default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>>      default 0x80000000 if 64BIT && !MMU
>>      default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>> -    default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>> +    default 0xffffffe000000000 if 64BIT && !MAXPHYSMEM_2GB
>>
>>  config ARCH_FLATMEM_ENABLE
>>      def_bool y
>> @@ -216,19 +216,11 @@ config MODULE_SECTIONS
>>      bool
>>      select HAVE_MOD_ARCH_SPECIFIC
>>
>> -choice
>> -    prompt "Maximum Physical Memory"
>> -    default MAXPHYSMEM_2GB if 32BIT
>> -    default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
>> -    default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
>> -
>> -    config MAXPHYSMEM_2GB
>> -        bool "2GiB"
>> -    config MAXPHYSMEM_128GB
>> -        depends on 64BIT && CMODEL_MEDANY
>> -        bool "128GiB"
>> -endchoice
>> -
>> +config MAXPHYSMEM_2GB
>> +    bool "Maximum Physical Memory 2GiB"
>> +    default y if 32BIT
>> +    default y if 64BIT && CMODEL_MEDLOW
>> +    default n
>>
>>  config SMP
>>      bool "Symmetric Multi-Processing"
> 
> I'm not sure this actually helps with anything, but if it's all going 
> away then it's
> fine.  Originally the 2G/128G stuff was there to allow for larger VA 
> spaces in
> the future.

With runtime sv48 introduction, whatever we would have used here could 
have been wrong at runtime, so removing it was easier.

Alex
