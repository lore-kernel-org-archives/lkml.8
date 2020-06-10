Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B0B2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgFJITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:19:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgFJITu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:19:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A88C1F1;
        Wed, 10 Jun 2020 01:19:49 -0700 (PDT)
Received: from [10.57.43.21] (unknown [10.57.43.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E74FE3F6CF;
        Wed, 10 Jun 2020 01:19:46 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dillon.minfei@gmail.com, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux@armlinux.org.uk, kstewart@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
 <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
 <20200610072444.GA6293@infradead.org>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <9c3a7b4e-0190-e9bb-91fe-6d5692559888@arm.com>
Date:   Wed, 10 Jun 2020 09:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200610072444.GA6293@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 8:24 AM, Christoph Hellwig wrote:
> Ok, I finally found the original patch from Vladimir.  Comments below:
> 
>> +++ b/kernel/dma/direct.c
>> @@ -456,14 +456,14 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>>  #else /* CONFIG_MMU */
>>  bool dma_direct_can_mmap(struct device *dev)
>>  {
>> -	return false;
>> +	return true;
>>  }
>>  
>>  int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>>  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>>  		unsigned long attrs)
>>  {
>> -	return -ENXIO;
>> +	return vm_iomap_memory(vma, vma->vm_start, (vma->vm_end - vma->vm_start));;
> 
> I think we should try to reuse the mmu dma_direct_mmap implementation,
> which does about the same.  This version has been compile tested on
> arm-nommu only, let me know what you think: (btw, a nommu_defconfig of
> some kind for arm would be nice..)

Catch-all nommu_defconfig is not easy for ARM, AFAIK folk carry few hacks
for randconfig...

Meanwhile, known working NOMMU configs

$ git grep "# CONFIG_MMU is not set" arch/arm/configs/
arch/arm/configs/efm32_defconfig:# CONFIG_MMU is not set
arch/arm/configs/lpc18xx_defconfig:# CONFIG_MMU is not set
arch/arm/configs/mps2_defconfig:# CONFIG_MMU is not set
arch/arm/configs/stm32_defconfig:# CONFIG_MMU is not set
arch/arm/configs/vf610m4_defconfig:# CONFIG_MMU is not set

> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index d006668c0027d2..e0dae570a51530 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -71,6 +71,7 @@ config SWIOTLB
>  # in the pagetables
>  #
>  config DMA_NONCOHERENT_MMAP
> +	default y if !MMU
>  	bool

Nit: def_bool !MMU

>  
>  config DMA_REMAP
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 0a4881e59aa7d6..9ec6a5c3fc578c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -459,7 +459,6 @@ int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_MMU
>  bool dma_direct_can_mmap(struct device *dev)
>  {
>  	return dev_is_dma_coherent(dev) ||
> @@ -485,19 +484,6 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
>  			user_count << PAGE_SHIFT, vma->vm_page_prot);
>  }
> -#else /* CONFIG_MMU */
> -bool dma_direct_can_mmap(struct device *dev)
> -{
> -	return false;
> -}
> -
> -int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> -{
> -	return -ENXIO;
> -}
> -#endif /* CONFIG_MMU */
>  
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> 

LGTM. FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

