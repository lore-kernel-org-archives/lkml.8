Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5984EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A5B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgD1JF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:05:28 -0400
Received: from foss.arm.com ([217.140.110.172]:48042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgD1JF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:05:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4BF30E;
        Tue, 28 Apr 2020 02:05:27 -0700 (PDT)
Received: from [10.57.41.45] (unknown [10.57.41.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6399E3F305;
        Tue, 28 Apr 2020 02:05:25 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm: dts: stm32f769-disco: Enable MIPI DSI display
 support
To:     Adrian Pop <pop.adrian61@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20200424182139.32190-1-pop.adrian61@gmail.com>
 <3efb57a1-283b-f2f0-66a4-97e88c6c02d6@st.com>
 <CAP-HsdS0rq4iCq1oqpTU=EXF8UWbfPivCJVZG-4b7jyvdHHXUw@mail.gmail.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <81d9b932-ef2d-6d5c-9a58-2edb88e7e593@arm.com>
Date:   Tue, 28 Apr 2020 10:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP-HsdS0rq4iCq1oqpTU=EXF8UWbfPivCJVZG-4b7jyvdHHXUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 4/27/20 9:05 PM, Adrian Pop wrote:
> Added lee.jones@linaro.org.
> 
> First, thank you all for taking a look at my changes!
> 
> Hello Alex,
> 
> On Mon, Apr 27, 2020 at 11:28 AM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>>
>> Hi Adrian
>>
>> On 4/24/20 8:21 PM, Adrian Pop wrote:
>>> STM32f769-disco features a 4" MIPI DSI display: add support for it.
>>>
>>> Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
>>> ---
>>
>> Commit title should be ARM: dts: stm32: ...
> 
> Will fix in next version if that's ok.
> 
>>
>> Can you explain a bit more in your commit message why do you use a
>> reserved memory pool for DMA and where this pool is located. (I assume
>> it's linked to a story of DMA and cache memory attribute on cortexM7...)
> 
> Need to look more into this, but if I remove it, /dev/fb0 is not
> available anymore and I get a warning stating:
> ...
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] Initialized stm 1.0.0 20170330 for 40016800.display-controller on minor 0
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 13 at arch/arm/mm/dma-mapping-nommu.c:50 0xc000b8ed
> CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 5.6.0-next-20200412 #23
> Hardware name: STM32 (Device Tree Support)
> Workqueue: events 0xc014fa35
> Function entered at [<c000b325>] from [<c000a487>]
> ...
> 
> When I looked in arch/arm/mm/dma-mapping-nommu.c:50, there is a comment stating:
> 
>     /*
>      * dma_alloc_from_global_coherent() may fail because:
>      *
>      * - no consistent DMA region has been defined, so we can't
>      *   continue.
>      * - there is no space left in consistent DMA region, so we
>      *   only can fallback to generic allocator if we are
>      *   advertised that consistency is not required.
>      */
> 
> This is the reason I added the reserved-memory.
> 
> About the location, does it need to be hardcoded? On my board
> (STM32F769I-Disco, tftp boot) in boot log I get:
> ...
> Reserved memory: created DMA memory pool at 0xc0ef1000, size 1 MiB
> OF: reserved mem: initialized node linux,dma, compatible id shared-dma-pool
> ...
> 

I'd recommend to place it at specific address, otherwise it will play badly with
CONFIG_MPU=y. MPU covers only single contiguous memblock (due to limitations
in number of available MPU regions), so placing DMA pool anywhere may result
in split of such contiguous memblock, as effect you may see that some memory
is not used. Usually, folks place DMA pool at the end of RAM.

>>
>> Did you try this configuration with XIP boot ?
> 
> I did not try with XIP. Currently loading zImage from tftp to memory.
> Will try with XIP as well, and get back with feedback.
> 

Bear in mind that with CONFIG_MPU=y XIP start address need to be aligned to 1M.

Cheers
Vladimir
