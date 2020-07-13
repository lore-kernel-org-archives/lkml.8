Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF6EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EE620758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgGMLkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:40:04 -0400
Received: from foss.arm.com ([217.140.110.172]:57170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMLkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:40:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B0BD1FB;
        Mon, 13 Jul 2020 04:40:02 -0700 (PDT)
Received: from [10.57.62.178] (unknown [10.57.62.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 326733F7D8;
        Mon, 13 Jul 2020 04:40:00 -0700 (PDT)
Subject: Re: [PATCH 0/4] Bounced DMA support
To:     Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, hch@lst.de, m.szyprowski@samsung.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tfiga@chromium.org, drinkcat@chromium.org
References: <20200713091211.2183368-1-tientzu@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8a7ce34e-87c0-d224-3974-34f1877fbb0e@arm.com>
Date:   Mon, 13 Jul 2020 12:39:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713091211.2183368-1-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-13 10:12, Claire Chang wrote:
> This series implements mitigations for lack of DMA access control on
> systems without an IOMMU, which could result in the DMA accessing the
> system memory at unexpected times and/or unexpected addresses, possibly
> leading to data leakage or corruption.
> 
> For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus
> is not behind an IOMMU. As PCI-e, by design, gives the device full
> access to system memory, a vulnerability in the Wi-Fi firmware could
> easily escalate to a full system exploit (remote wifi exploits: [1a],
> [1b] that shows a full chain of exploits; [2], [3]).
> 
> To mitigate the security concerns, we introduce bounced DMA. The bounced
> DMA ops provide an implementation of DMA ops that bounce streaming DMA
> in and out of a specially allocated region. The feature on its own
> provides a basic level of protection against the DMA overwriting buffer
> contents at unexpected times. However, to protect against general data
> leakage and system memory corruption, the system needs to provide a way
> to restrict the DMA to a predefined memory region (this is usually done
> at firmware level, e.g. in ATF on some ARM platforms).

More to the point, this seems to need some fairly special interconnect 
hardware too. On typical systems that just stick a TZASC directly in 
front of the memory controller it would be hard to block DMA access 
without also blocking CPU access. With something like Arm TZC-400 I 
guess you could set up a "secure" region for most of DRAM that allows NS 
accesses by NSAID from the CPUs, then similar regions for the pools with 
NSAID access for both the respective device and the CPUs, but by that 
point you've probably used up most of the available regions before even 
considering what the firmware and TEE might want for actual Secure memory.

In short, I don't foresee this being used by very many systems.

That said,, although the motivation is different, it appears to end up 
being almost exactly the same end result as the POWER secure 
virtualisation thingy (essentially: constrain DMA to a specific portion 
of RAM). The more code can be shared with that, the better.

> Currently, 32-bit architectures are not supported because of the need to
> handle HIGHMEM, which increases code complexity and adds more
> performance penalty for such platforms. Also, bounced DMA can not be
> enabled on devices behind an IOMMU, as those require an IOMMU-aware
> implementation of DMA ops and do not require this kind of mitigation
> anyway.

Note that we do actually have the notion of bounced DMA with IOMMUs 
already (to avoid leakage of unrelated data in the same page). I think 
it's only implemented for intel-iommu so far, but shouldn't take much 
work to generalise to iommu-dma if anyone wanted to. That's already done 
a bunch of work to generalise the SWIOTLB routines to be more reusable, 
so building on top of that would be highly preferable.

Thirdly, the concept of device-private bounce buffers does in fact 
already exist to some degree too - there are various USB, crypto and 
other devices that can only DMA to a local SRAM buffer (not to mention 
subsystems doing their own bouncing for the sake of alignment/block 
merging/etc.). Again, a slightly more generalised solution that makes 
this a first-class notion for dma-direct itself and could help supplant 
some of those hacks would be really really good.

Robin.

> [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> [2] https://blade.tencent.com/en/advisories/qualpwn/
> [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> 
> 
> Claire Chang (4):
>    dma-mapping: Add bounced DMA ops
>    dma-mapping: Add bounced DMA pool
>    dt-bindings: of: Add plumbing for bounced DMA pool
>    of: Add plumbing for bounced DMA pool
> 
>   .../reserved-memory/reserved-memory.txt       |  36 +++
>   drivers/of/address.c                          |  37 +++
>   drivers/of/device.c                           |   3 +
>   drivers/of/of_private.h                       |   6 +
>   include/linux/device.h                        |   3 +
>   include/linux/dma-mapping.h                   |   1 +
>   kernel/dma/Kconfig                            |  17 +
>   kernel/dma/Makefile                           |   1 +
>   kernel/dma/bounced.c                          | 304 ++++++++++++++++++
>   9 files changed, 408 insertions(+)
>   create mode 100644 kernel/dma/bounced.c
> 
