Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA741C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DFC204EA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgFIOHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:07:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgFIOHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:07:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E6E31FB;
        Tue,  9 Jun 2020 07:07:31 -0700 (PDT)
Received: from [10.57.49.155] (unknown [10.57.49.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83BD23F66F;
        Tue,  9 Jun 2020 07:07:28 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
To:     dillon.minfei@gmail.com, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux@armlinux.org.uk, kstewart@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
Date:   Tue, 9 Jun 2020 15:08:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 9:30 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Currently, we use dma direct to request coherent memory for driver on armv7m
> platform if 'cacheid' is zero, but dma_direct_can_mmap() is return false,
> dma_direct_mmap() return -ENXIO for CONFIG_MMU undefined platform.
> 
> so we have to back to use 'arm_nommu_dma_ops', add use_reserved_mem() to check
> if device support global or device corherent memory. if yes, then call
> set_dma_ops()
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  arch/arm/mm/dma-mapping-nommu.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index 287ef898a55e..e1c213fec152 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -14,6 +14,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/outercache.h>
>  #include <asm/cp15.h>
> +#include <linux/of.h>
>  
>  #include "dma.h"
>  
> @@ -188,6 +189,31 @@ const struct dma_map_ops arm_nommu_dma_ops = {
>  };
>  EXPORT_SYMBOL(arm_nommu_dma_ops);
>  
> +static bool use_reserved_mem(struct device *dev)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_node_by_path("/reserved-memory/linux,dma");
> +
> +	if (np &&
> +		of_device_is_compatible(np, "shared-dma-pool") &&
> +		of_property_read_bool(np, "no-map") &&
> +		of_property_read_bool(np, "linux,dma-default")) {
> +		/* has global corherent mem support */
> +		of_node_put(np);
> +		return true;
> +	}
> +
> +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (np) {
> +		/* has dev corherent mem support */
> +		of_node_put(np);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  			const struct iommu_ops *iommu, bool coherent)
>  {
> @@ -206,6 +232,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  		dev->archdata.dma_coherent = (get_cr() & CR_M) ? coherent : true;
>  	}
>  
> -	if (!dev->archdata.dma_coherent)
> +	if (!dev->archdata.dma_coherent || use_reserved_mem(dev))
>  		set_dma_ops(dev, &arm_nommu_dma_ops);
>  }
> 

Sorry I have to NAK this hack :(

Digging git history reveled 79964a1c2972 ("ARM: 8633/1: nommu: allow mmap when !CONFIG_MMU")
which make me wonder if diff below does the trick for you

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f4bbda..8623b9e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -456,14 +456,14 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 #else /* CONFIG_MMU */
 bool dma_direct_can_mmap(struct device *dev)
 {
-	return false;
+	return true;
 }
 
 int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
-	return -ENXIO;
+	return vm_iomap_memory(vma, vma->vm_start, (vma->vm_end - vma->vm_start));;
 }
 #endif /* CONFIG_MMU */

Cheers
Vladimir
