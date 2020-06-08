Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12036C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FF3206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgFHMyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:54:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbgFHMxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:53:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97DF31B;
        Mon,  8 Jun 2020 05:53:21 -0700 (PDT)
Received: from [10.57.9.113] (unknown [10.57.9.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02BA3F52E;
        Mon,  8 Jun 2020 05:53:20 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: Fix too large DMA pools on medium systems
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200608085231.8924-1-geert@linux-m68k.org>
 <92b53a24-2f1f-2add-6bea-eeda7317520f@arm.com>
 <CAMuHMdXxT5ZgcK5r0MWOk7vWVj63gmr6k3zgACe2Lew7Q4KC9w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aef59070-6e16-1503-b7a0-0e089369b72b@arm.com>
Date:   Mon, 8 Jun 2020 13:53:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXxT5ZgcK5r0MWOk7vWVj63gmr6k3zgACe2Lew7Q4KC9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-08 13:25, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Mon, Jun 8, 2020 at 2:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2020-06-08 09:52, Geert Uytterhoeven wrote:
>>> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
>>> memory pools are much larger than intended (e.g. 2 MiB instead of 128
>>> KiB on a 256 MiB system).
>>>
>>> Fix this by correcting the calculation of the number of GiBs of RAM in
>>> the system.
>>>
>>> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>>> --- a/kernel/dma/pool.c
>>> +++ b/kernel/dma/pool.c
>>> @@ -175,8 +175,8 @@ static int __init dma_atomic_pool_init(void)
>>>         * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>>>         */
>>>        if (!atomic_pool_size) {
>>> -             atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
>>> -                                     SZ_128K;
>>> +             unsigned long gigs = totalram_pages() >> (30 - PAGE_SHIFT);
>>> +             atomic_pool_size = max(gigs, 1UL) * SZ_128K;
>>>                atomic_pool_size = min_t(size_t, atomic_pool_size,
>>>                                         1 << (PAGE_SHIFT + MAX_ORDER-1));
>>>        }
>>
>> Nit: although this probably is right, it seems even less readable than
> 
> ">> (x - PAGE_SHIFT)" is a commonly used construct in the kernel.

Sure, but when "x" is a magic number there's still extra cognitive load 
in determining whether it's the *right* magic number ;)

Mostly, though, it was just the fact that an expression involving 5 
different units (bytes, pages, "gigs", bits, and whatever MAX_ORDER is) 
is inherently more challenging to follow than the equivalent thing 
framed in fewer, especially when it can be reasonably done in just two 
(bytes and pages).

Robin.

>> the broken version (where at least some at-a-glance 'dimensional
>> analysis' flags up "(number of pages) >> PAGE_SHIFT" as rather
>> suspicious). How about a something a little more self-explanatory, e.g.:
>>
>>          unsigned long pages = totalram_pages() * SZ_128K / SZ_1GB;
> 
> That multiplication will overflow on 32-bit systems (perhaps even on
> large 64-bit systems; any 47-bit addressing?).
> 
>          unsigned long pages = totalram_pages() / (SZ_1GB / SZ_128K);
> 
>>          atomic_pool_size = min(pages, MAX_ORDER_NR_PAGES) << PAGE_SHIFT;
>>          atomic_pool_size = max_t(size_t, atomic_pool_size, SZ_128K);
> 
> I agree this part is an improvement.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
