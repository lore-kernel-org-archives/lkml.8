Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB462064B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgGHQUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:20:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgGHQUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:20:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33BB831B;
        Wed,  8 Jul 2020 09:20:18 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5F663F68F;
        Wed,  8 Jul 2020 09:20:16 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
To:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
 <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
 <20200708153635.GB26743@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <304053c7-9f88-8830-3287-2496a4cb48cd@arm.com>
Date:   Wed, 8 Jul 2020 17:20:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708153635.GB26743@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08 16:36, Christoph Hellwig wrote:
> On Wed, Jul 08, 2020 at 12:35:34PM +0200, Nicolas Saenz Julienne wrote:
>>> Which allows me to switch between ACPI/DT on the machine. In DT mode it
>>> works fine now,
>>
>> Nice, would that count as a Tested-by from you?
>>
>>> but with ACPI I continue to have failures unless I
>>> disable CMA via cma=0 on the kernel command line.
>>
>> Yes, I see why, in atomic_pool_expand() memory is allocated from CMA without
>> checking its correctness. That calls for a separate fix. I'll try to think of
>> something.
> 
> I think we need a dma_coherent_ok for the allocations from the
> pool and then fall back to the next better one to get started.  And
> yes, CMA is a bit of a mess, that generally needs better checks.

Yeah, another thought that came to mind later is that iommu-dma can use 
pages from any pool regardless of the device's DMA mask, so we could 
stand to be a lot less restrictive in that case too.

Perhaps it is better to just bite the bullet, keep the straightforward 
one-pool-per-zone setup, and implement the dma_coherent_ok() type 
fallback logic. More complexity for dma_alloc_from_pool(), but 
everything else stays nice and simple - lose the assumption that 
dev_to_pool() can work for this and and just let callers pass an 
allocation mask directly, and have dma_free_from_pool() simply check all 
available pools.

Robin.
