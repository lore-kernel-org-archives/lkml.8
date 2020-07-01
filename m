Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E996CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44052073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aPd4B47o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgGAIQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:16:14 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16514 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgGAIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:16:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efc461b0000>; Wed, 01 Jul 2020 01:15:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 01:16:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 01:16:13 -0700
Received: from [10.26.73.166] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 08:16:04 +0000
Subject: Re: [PATCH v9 2/4] iommu/arm-smmu: add NVIDIA implementation for ARM
 MMU-500 usage
To:     Krishna Reddy <vdumpa@nvidia.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robh+dt@kernel.org>,
        <treding@nvidia.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <yhsu@nvidia.com>,
        <snikam@nvidia.com>, <praithatha@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>
References: <20200630235752.8737-1-vdumpa@nvidia.com>
 <20200630235752.8737-3-vdumpa@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ed35713b-ec24-db7b-7367-7873134f76ca@nvidia.com>
Date:   Wed, 1 Jul 2020 09:16:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630235752.8737-3-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593591323; bh=4I8oqO18CDsJelJAvfh/7H1AvPcTauGIZI8cYK+8mV4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aPd4B47oOaZ0+he7yiJKIv2HwyBtSjF4hGrYa3pH4P333lHQsnzl8o1DTvuRFzPou
         JsSdKo+HPDo7q6TktSYreIyoWLd/qJFaGILHFuhn/5inpVmmcDJ+HDYj3FeVkypHMO
         /lpIhcdRquy/yqt/E3lwVQG+/epovLj7gUQtglLXE39vjP3FRtdySRn7AviWAExwNX
         1kr+vRnuwS5URij1AUgbjgOyoTNX6EvdKSViJiszfOw+Xjdp5CKWkHslfB4OeVBIc5
         R20WIcH1fC7jlvT5QF2b69owN4Qw5Q17JmLrkClYmRuEKSBOqfQwcqvpk1coMwH4pm
         duWWjn/4T0jGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/07/2020 00:57, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC has three ARM MMU-500 instances.
> It uses two of ARM MMU-500s together to interleave IOVA accesses
> across them and must be programmed identically.
> The third SMMU instance is used as a regular ARM MMU-500 and it
> can either be programmed independently or identical to other
> two ARM MMU-500s.
> 
> This implementation supports programming two or three ARM MMU-500s
> identically as per DT config.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/iommu/Makefile          |   2 +-
>  drivers/iommu/arm-smmu-impl.c   |   3 +
>  drivers/iommu/arm-smmu-nvidia.c | 206 ++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.h        |   1 +
>  5 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/arm-smmu-nvidia.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b5ffd646c6b9..64c37dbdd4426 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16808,8 +16808,10 @@ F:	drivers/i2c/busses/i2c-tegra.c
>  
>  TEGRA IOMMU DRIVERS
>  M:	Thierry Reding <thierry.reding@gmail.com>
> +R:	Krishna Reddy <vdumpa@nvidia.com>
>  L:	linux-tegra@vger.kernel.org
>  S:	Supported
> +F:	drivers/iommu/arm-smmu-nvidia.c
>  F:	drivers/iommu/tegra*
>  
>  TEGRA KBC DRIVER
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 342190196dfb0..2b8203db73ec3 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
>  obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
> -arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
> +arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>  obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
>  obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c75b9d957b702..f15571d05474e 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -171,6 +171,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
>  		smmu->impl = &calxeda_impl;
>  
> +	if (of_device_is_compatible(np, "nvidia,tegra194-smmu"))
> +		return nvidia_smmu_impl_init(smmu);
> +
>  	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
>  	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
>  		return qcom_smmu_impl_init(smmu);
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> new file mode 100644
> index 0000000000000..5c874912e1c1a
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// NVIDIA ARM SMMU v2 implementation quirks
> +// Copyright (C) 2019-2020 NVIDIA CORPORATION.  All rights reserved.
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "arm-smmu.h"
> +
> +/*
> + * Tegra194 has three ARM MMU-500 Instances.
> + * Two of them are used together for interleaved IOVA accesses and
> + * used by non-isochronous HW devices for SMMU translations.
> + * Third one is used for SMMU translations from isochronous HW devices.
> + * It is possible to use this implementation to program either
> + * all three or two of the instances identically as desired through
> + * DT node.
> + *
> + * Programming all the three instances identically comes with redundant TLB
> + * invalidations as all three never need to be TLB invalidated for a HW device.
> + *
> + * When Linux kernel supports multiple SMMU devices, the SMMU device used for
> + * isochornous HW devices should be added as a separate ARM MMU-500 device
> + * in DT and be programmed independently for efficient TLB invalidates.
> + */

We should address Robin's comment about the 'When' above.

> +#define MAX_SMMU_INSTANCES 3
> +
> +struct nvidia_smmu {
> +	struct arm_smmu_device	smmu;
> +	unsigned int		num_inst;
> +	void __iomem		*bases[MAX_SMMU_INSTANCES];
> +};
> +
> +static inline struct nvidia_smmu *to_nvidia_smmu(struct arm_smmu_device *smmu)
> +{
> +	return container_of(smmu, struct nvidia_smmu, smmu);
> +}
> +
> +static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
> +					     unsigned int inst, int page)
> +{
> +	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
> +
> +	if (!nvidia_smmu->bases[0])
> +		nvidia_smmu->bases[0] = smmu->base;


Robin said that he would accept a patch to move the
devm_ioremap_resource() call in arm_smmu_device_probe() so that we do
not need to do this. See the V7 series. I think that this would be a
good improvement so that we could avoid doing the above.

Cheers
Jon

-- 
nvpublic
