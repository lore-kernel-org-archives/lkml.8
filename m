Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE52DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D21B2100A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGCRmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:31 -0400
Received: from foss.arm.com ([217.140.110.172]:56312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGCRm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2175831B;
        Fri,  3 Jul 2020 10:42:27 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF653F73C;
        Fri,  3 Jul 2020 10:42:25 -0700 (PDT)
Subject: Re: [BUG] XHCI getting ZONE_DMA32 memory > than its bus_dma_limit
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mm@kvack.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        rientjes@google.com, Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
References: <34619bdf-6527-ae82-7e4d-e2ea7c67ed56@arm.com>
 <a9058fd2c54bbea69fdf97e30277338a61b5c0b4.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cc17fe85-99a3-ec8c-985a-2a21cf09bf49@arm.com>
Date:   Fri, 3 Jul 2020 18:42:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a9058fd2c54bbea69fdf97e30277338a61b5c0b4.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-03 15:53, Nicolas Saenz Julienne wrote:
> Hi Jeremy,
> thanks for the bug report.
> 
> Just for the record the offending commit is: c84dc6e68a1d2 ("dma-pool: add
> additional coherent pools to map to gfp mask").
> 
> On Thu, 2020-07-02 at 12:49 -0500, Jeremy Linton wrote:
>> Hi,
>>
>> Using 5.8rc3:
>>
>> The rpi4 has a 3G dev->bus_dma_limit on its XHCI controller. With a usb3
>> hub, plus a few devices plugged in, randomly devices will fail
>> operations. This appears to because xhci_alloc_container_ctx() is
>> getting buffers > 3G via dma_pool_zalloc().
>>
>> Tracking that down, it seems to be caused by dma_alloc_from_pool() using
>> dev_to_pool()->dma_direct_optimal_gfp_mask() to "optimistically" select
>> the atomic_pool_dma32 but then failing to verify that the allocations in
>> the pool are less than the dev bus_dma_limit.
> 
> I can reproduce this too.
> 
> The way I see it, dev_to_pool() wants a strict dma_direct_optimal_gfp_mask()
> that is never wrong, since it's going to stick to that pool for the device's
> lifetime. I've been looking at how to implement it, and it's not so trivial as
> I can't see a failproof way to make a distinction between who needs DMA32 and
> who is OK with plain KERNEL memory.
> 
> Otherwise, as Jeremy points out, the patch needs to implement allocations with
> an algorithm similar to __dma_direct_alloc_pages()'s, which TBH I don't know if
> it's a little overkill for the atomic context.
> 
> Short of finding a fix in the coming rc's, I suggest we revert this.

Or perhaps just get rid of atomic_pool_dma32 (and allocate 
atomic_pool_dma from ZONE_DMA32 if !ZONE_DMA). That should make it fall 
pretty much back in line while still preserving the potential benefit of 
the kernel pool for non-address-constrained devices.

Robin.
