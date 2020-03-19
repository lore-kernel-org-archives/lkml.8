Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AEEC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3714B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCSNu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:50:59 -0400
Received: from foss.arm.com ([217.140.110.172]:36370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgCSNu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:50:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5937101E;
        Thu, 19 Mar 2020 06:50:57 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971113F52E;
        Thu, 19 Mar 2020 06:50:56 -0700 (PDT)
Subject: Re: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
To:     Alexander Dahl <post@lespocky.de>, x86@kernel.org
Cc:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200302181612.20597-1-post@lespocky.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b6f6c1de-13bc-79b4-ad0a-fdfb5cb33cec@arm.com>
Date:   Thu, 19 Mar 2020 13:50:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200302181612.20597-1-post@lespocky.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-02 6:16 pm, Alexander Dahl wrote:
> For ARCH=x86 (32 bit) when you set CONFIG_IOMMU_INTEL since c5a5dc4cbbf4
> ("iommu/vt-d: Don't switch off swiotlb if bounce page is used") there's
> a dependency on CONFIG_SWIOTLB, which was not necessarily active before.
> 
> The init code for swiotlb in 'pci_swiotlb_detect_4gb()' compares
> something against MAX_DMA32_PFN to decide if it should be active.
> However that define suffers from an arithmetic overflow since
> 1b7e03ef7570 ("x86, NUMA: Enable emulation on 32bit too") when it was
> first made visible to x86_32.
> 
> The effect is at boot time 64 MiB (default size) were allocated for
> bounce buffers now, which is a noticeable amount of memory on small
> systems. We noticed this effect on the fli4l Linux distribution when
> migrating from kernel v4.19 (LTS) to v5.4 (LTS) on boards like pcengines
> ALIX 2D3 with 256 MiB memory for example:
> 
>    Linux version 5.4.22 (buildroot@buildroot) (gcc version 7.3.0 (Buildroot 2018.02.8)) #1 SMP Mon Nov 26 23:40:00 CET 2018
>    …
>    Memory: 183484K/261756K available (4594K kernel code, 393K rwdata, 1660K rodata, 536K init, 456K bss , 78272K reserved, 0K cma-reserved, 0K highmem)
>    …
>    PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>    software IO TLB: mapped [mem 0x0bb78000-0x0fb78000] (64MB)
> 
> The initial analysis and the suggested fix was done by user 'sourcejedi'
> at stackoverflow and explicitly marked as GPLv2 for inclusion in the
> Linux kernel:
> 
>    https://unix.stackexchange.com/a/520525/50007
> 
> Fixes: https://web.nettworks.org/bugs/browse/FFL-2560
> Fixes: https://unix.stackexchange.com/q/520065/50007
> Suggested-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> Signed-off-by: Alexander Dahl <post@lespocky.de>
> ---
> We tested this in qemu and on real hardware with fli4l on top of v5.4,
> v5.5, and v5.6-rc kernels, but only as far as the reserved memory goes.
> The patch itself is based on v5.6-rc3 (IIRC).
> 
> A quick grep over the kernel code showed me this define MAX_DMA32_PFN is
> used in other places as well. I would appreciate feedback on this,
> because I can not oversee all side effects this might have?!
> 
> Thanks again to Alan who proposed the fix, and for his permission to
> send it upstream.
> 
> Greets
> Alex
> ---
>   arch/x86/include/asm/dma.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
> index 00f7cf45e699..e25514eca8d6 100644
> --- a/arch/x86/include/asm/dma.h
> +++ b/arch/x86/include/asm/dma.h
> @@ -74,7 +74,7 @@
>   #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
>   
>   /* 4GB broken PCI/AGP hardware bus master zone */
> -#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
> +#define MAX_DMA32_PFN (4UL * ((1024 * 1024 * 1024) >> PAGE_SHIFT))

FWIW, wouldn't s/UL/ULL/ in the original expression suffice? Failing 
that, rather than awkward parenthesis trickery it might be clearer to 
just copy the one from arch/mips/include/asm/dma.h.

Robin.

>   
>   #ifdef CONFIG_X86_32
>   /* The maximum address that we can perform a DMA transfer to on this platform */
> 
