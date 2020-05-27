Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AC8207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgE0RaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:30:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgE0RaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:30:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0DCB31B;
        Wed, 27 May 2020 10:30:19 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D2B73F305;
        Wed, 27 May 2020 10:30:17 -0700 (PDT)
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
Date:   Wed, 27 May 2020 18:30:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27 17:03, Srinath Mannam wrote:
> This patch gives the provision to change default value of MSI IOVA base
> to platform's suitable IOVA using module parameter. The present
> hardcoded MSI IOVA base may not be the accessible IOVA ranges of platform.

That in itself doesn't seem entirely unreasonable; IIRC the current 
address is just an arbitrary choice to fit nicely into Qemu's memory 
map, and there was always the possibility that it wouldn't suit everything.

> Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
> DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
> property are reserved.

That, however, doesn't seem to fit here; iommu-dma maps MSI doorbells 
dynamically, so they aren't affected by reserved regions any more than 
regular DMA pages are. In fact, it explicitly ignores the software MSI 
region, since as the comment says, it *is* the software that manages those.

The MSI_IOVA_BASE region exists for VFIO, precisely because in that case 
the kernel *doesn't* control the address space, but still needs some way 
to steal a bit of it for MSIs that the guest doesn't necessarily know 
about, and give userspace a fighting chance of knowing what it's taken. 
I think at the time we discussed the idea of adding something to the 
VFIO uapi such that userspace could move this around if it wanted or 
needed to, but decided we could live without that initially. Perhaps now 
the time has come?

Robin.

> If any platform has the limitaion to access default MSI IOVA, then it can
> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>   drivers/iommu/arm-smmu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 4f1a350..5e59c9d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -72,6 +72,9 @@ static bool disable_bypass =
>   module_param(disable_bypass, bool, S_IRUGO);
>   MODULE_PARM_DESC(disable_bypass,
>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> +static unsigned long msi_iova_base = MSI_IOVA_BASE;
> +module_param(msi_iova_base, ulong, S_IRUGO);
> +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
>   
>   struct arm_smmu_s2cr {
>   	struct iommu_group		*group;
> @@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>   	struct iommu_resv_region *region;
>   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>   
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +	region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
>   					 prot, IOMMU_RESV_SW_MSI);
>   	if (!region)
>   		return;
> 
