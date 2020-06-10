Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B309C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067212074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgFJCNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:13:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:2178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgFJCNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:13:23 -0400
IronPort-SDR: YL2b84haY4LFndFQeLFBbHcdN/giGriyJWsPZ72oLLx5nP5AMo7jilEgwA8/i3Ja7Tlo+IYM2L
 Ur3vb7+18AcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 19:13:22 -0700
IronPort-SDR: SawyiA4Z/FCBmSlc72AT0UUtM3IbxWHu0pB8nRF7JlkxVF3rLQNTGws4fPOQNSG7/2C+aTVhJI
 aFAG1GLCvBAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,494,1583222400"; 
   d="scan'208";a="296036010"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2020 19:13:20 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Qian Cai <cai@lca.pw>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Move Intel IOMMU driver into
 subdirectory
To:     Joerg Roedel <joro@8bytes.org>
References: <20200609130303.26974-1-joro@8bytes.org>
 <20200609130303.26974-3-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <240f0608-73fd-6a77-8043-3f4a8c145067@linux.intel.com>
Date:   Wed, 10 Jun 2020 10:09:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609130303.26974-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 6/9/20 9:03 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Move all files related to the Intel IOMMU driver into its own
> subdirectory.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   MAINTAINERS                                          |  3 +--
>   drivers/iommu/Makefile                               | 12 ++++++------
>   .../iommu/{intel-iommu-debugfs.c => intel/debugfs.c} |  0
>   drivers/iommu/{ => intel}/dmar.c                     |  2 +-
>   drivers/iommu/{ => intel}/intel-pasid.h              |  0
>   drivers/iommu/{intel-iommu.c => intel/iommu.c}       |  2 +-
>   .../{intel_irq_remapping.c => intel/irq_remapping.c} |  2 +-
>   drivers/iommu/{intel-pasid.c => intel/pasid.c}       |  0
>   drivers/iommu/{intel-svm.c => intel/svm.c}           |  0
>   drivers/iommu/{intel-trace.c => intel/trace.c}       |  0
>   10 files changed, 10 insertions(+), 11 deletions(-)
>   rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
>   rename drivers/iommu/{ => intel}/dmar.c (99%)
>   rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
>   rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
>   rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
>   rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
>   rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
>   rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c31d3f8ae4..fa2078dd57d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8716,8 +8716,7 @@ M:	Lu Baolu <baolu.lu@linux.intel.com>
>   L:	iommu@lists.linux-foundation.org
>   S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> -F:	drivers/iommu/dmar.c
> -F:	drivers/iommu/intel*.[ch]
> +F:	drivers/iommu/intel/
>   F:	include/linux/intel-iommu.h
>   F:	include/linux/intel-svm.h
>   
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 3af7e374b0cb..342190196dfb 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -17,13 +17,13 @@ obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
>   obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
>   arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> -obj-$(CONFIG_DMAR_TABLE) += dmar.o
> -obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
> -obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
> -obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
> -obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
> +obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
> +obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
> +obj-$(CONFIG_INTEL_IOMMU) += intel/trace.o
> +obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel/debugfs.o
> +obj-$(CONFIG_INTEL_IOMMU_SVM) += intel/svm.o
>   obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
> -obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
> +obj-$(CONFIG_IRQ_REMAP) += intel/irq_remapping.o irq_remapping.o
>   obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
>   obj-$(CONFIG_MTK_IOMMU_V1) += mtk_iommu_v1.o
>   obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
> diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel/debugfs.c
> similarity index 100%
> rename from drivers/iommu/intel-iommu-debugfs.c
> rename to drivers/iommu/intel/debugfs.c
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/intel/dmar.c
> similarity index 99%
> rename from drivers/iommu/dmar.c
> rename to drivers/iommu/intel/dmar.c
> index 60a2970c37ff..cc46dff98fa0 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -32,7 +32,7 @@
>   #include <asm/irq_remapping.h>
>   #include <asm/iommu_table.h>
>   
> -#include "irq_remapping.h"
> +#include "../irq_remapping.h"
>   
>   typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
>   struct dmar_res_callback {
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel/intel-pasid.h
> similarity index 100%
> rename from drivers/iommu/intel-pasid.h
> rename to drivers/iommu/intel/intel-pasid.h
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel/iommu.c
> similarity index 99%
> rename from drivers/iommu/intel-iommu.c
> rename to drivers/iommu/intel/iommu.c
> index 648a785e078a..9129663a7406 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -47,7 +47,7 @@
>   #include <asm/iommu.h>
>   #include <trace/events/intel_iommu.h>
>   
> -#include "irq_remapping.h"
> +#include "../irq_remapping.h"
>   #include "intel-pasid.h"
>   
>   #define ROOT_SIZE		VTD_PAGE_SIZE
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> similarity index 99%
> rename from drivers/iommu/intel_irq_remapping.c
> rename to drivers/iommu/intel/irq_remapping.c
> index a042f123b091..7f8769800815 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -21,7 +21,7 @@
>   #include <asm/pci-direct.h>
>   #include <asm/msidef.h>
>   
> -#include "irq_remapping.h"
> +#include "../irq_remapping.h"
>   
>   enum irq_mode {
>   	IRQ_REMAPPING,
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel/pasid.c
> similarity index 100%
> rename from drivers/iommu/intel-pasid.c
> rename to drivers/iommu/intel/pasid.c
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel/svm.c
> similarity index 100%
> rename from drivers/iommu/intel-svm.c
> rename to drivers/iommu/intel/svm.c
> diff --git a/drivers/iommu/intel-trace.c b/drivers/iommu/intel/trace.c
> similarity index 100%
> rename from drivers/iommu/intel-trace.c
> rename to drivers/iommu/intel/trace.c
> 
