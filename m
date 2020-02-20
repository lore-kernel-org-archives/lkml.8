Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEFC761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D6F24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBTFtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:49:24 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43555 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgBTFtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:49:24 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7561A20006;
        Thu, 20 Feb 2020 05:49:21 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] riscv: Fix crash when flushing executable ioremap
 regions
From:   Alex Ghiti <alex@ghiti.fr>
To:     Jan Kiszka <jan.kiszka@web.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1581767384.git.jan.kiszka@web.de>
 <8a555b0b0934f0ba134de92f6cf9db8b1744316c.1581767384.git.jan.kiszka@web.de>
 <e721c440-2baf-d962-62ef-41a4f3b1333b@ghiti.fr>
 <b63e5945-0e31-940f-5ff7-6754ef5c034f@web.de>
 <441527ef-1fd4-ed98-8381-8902c4e05fc5@ghiti.fr>
Message-ID: <74bd5c0c-cdeb-5498-2948-35f40600a8bc@ghiti.fr>
Date:   Thu, 20 Feb 2020 00:49:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <441527ef-1fd4-ed98-8381-8902c4e05fc5@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 2/16/20 2:56 PM, Alex Ghiti wrote:
> On 2/16/20 11:05 AM, Jan Kiszka wrote:
>> On 16.02.20 15:41, Alex Ghiti wrote:
>>> Hi Jan,
>>>
>>> On 2/15/20 6:49 AM, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Those are not backed by page structs, and pte_page is returning an
>>>> invalid pointer.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> =2D--
>>>>   arch/riscv/mm/cacheflush.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>>>> index 8930ab7278e6..9ee2c1a387cc 100644
>>>> =2D-- a/arch/riscv/mm/cacheflush.c
>>>> +++ b/arch/riscv/mm/cacheflush.c
>>>> @@ -84,7 +84,8 @@ void flush_icache_pte(pte_t pte)
>>>>   {
>>>>       struct page *page =3D pte_page(pte);
>>>>
>>>> -    if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>>>> +    if (!pfn_valid(pte_pfn(pte)) ||
>>>> +        !test_and_set_bit(PG_dcache_clean, &page->flags))
>>>>           flush_icache_all();
>>>>   }
>>>>   #endif /* CONFIG_MMU */
>>>> =2D-
>>>> 2.16.4
>>>>
>>>>
>>>
>>> When did you encounter such a situation ? i.e. executable code that is
>>> not backed by struct page ?
>>>
>>> Riscv uses the generic implementation of ioremap and the way
>>> _PAGE_IOREMAP is defined does not allow to map executable memory region
>>> using ioremap, so I'm interested to understand how we end up in
>>> flush_icache_pte for an executable region not backed by any struct page.
>>
>> You can create executable mappings of memory that Linux does not
>> initially consider as RAM via ioremap_prot or ioremap_page_range. We are
>> using that in Jailhouse to load the hypervisor code into reserved memory
>> that is ioremapped for the purpose. Works fine on x86, arm and arm64.
>>
>> Jan
> 
> Ok thanks, I had missed this API.
> 
> Regarding your patch, I find it weird to do anything if the pfn is 
> invalid, we could have garbage in pte pointing to an invalid region for 
> example (I admit that the effect of flushing the icache would not be 
> catastrophic in that situation).
> 
> I'm not saying I will come with a better solution but I'll take a deeper 
> look tomorrow.
> 
> Alex
> 

I took a look at the Jailhouse driver. After loading the hypervisor into 
the ioremapped region, it explicitly ensures icache/dcache consistency 
by calling flush_icache_range here:

https://github.com/siemens/jailhouse/blob/master/driver/main.c#L505

There seems to be an implicit (?) rule that states that in-kernel code 
modification must handle icache/dcache consistency:

In arm64 set_pte_at definition, they do not sync icache/dcache when the 
pte is kernel:

https://elixir.bootlin.com/linux/latest/source/arch/arm64/include/asm/pgtable.h#L271

In mips, they do the same:

https://elixir.bootlin.com/linux/latest/source/arch/mips/mm/cache.c#L137

So funnily, I'd do the contrary of what you have done, the mips way:

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 8930ab7278e6..c90c8bb49109 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -84,6 +84,9 @@ void flush_icache_pte(pte_t pte)
  {
         struct page *page = pte_page(pte);

+       if (unlikely(!pfn_valid(pte_pfn(pte))))
+               return;
+
         if (!test_and_set_bit(PG_dcache_clean, &page->flags))
                 flush_icache_all();
  }

What do you think ?

Alex
