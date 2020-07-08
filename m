Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7EDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B7020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XFgTNR8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGHM2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:28:21 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10309 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgGHM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:28:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05bb790000>; Wed, 08 Jul 2020 05:26:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 05:28:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Jul 2020 05:28:20 -0700
Received: from [10.26.73.185] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:28:12 +0000
Subject: Re: [PATCH v10 5/5] iommu/arm-smmu: Add global/context fault
 implementation hooks
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
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-6-vdumpa@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ba3f527e-5f84-164b-f910-7ef9d7866520@nvidia.com>
Date:   Wed, 8 Jul 2020 13:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708050017.31563-6-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594211194; bh=QrCM0lFUfro/x+MbXA9Ul85Jcdrlp1ViTBtNrtWjDCo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XFgTNR8K5mgZM0iYZZHU6FAA9juDlv4mevWpcBfDyiI6DYPpdMTYgMjzc3Y3TI4CB
         BhclKRMV51c/+j3kQW9Idoy76XlQ9i+q5dOG3qb9a1Xy0R/E45XZKrecu+mwJA1T0j
         4jgjKqPpMYpMAEIcvsCD1j8k+Mbo3TLqt7OL7RFzOJLD446OBvLIRQ6M4UUTpdklPy
         8j9jacsljUJlI1Bg9Lq/ygSU5ETqohn32OcFh6hL4iwcpcog+2ufRl8WJ0w8kEa50g
         9BVmSFxZ4UA67MWDVnCKToPWO+altIWy3fpt9TZBEmqsu31ZO8D3Z9kAXkzPvRvzDa
         cmK0kZKaB8lpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/07/2020 06:00, Krishna Reddy wrote:
> Add global/context fault hooks to allow vendor specific implementations
> override default fault interrupt handlers.
> 
> Update NVIDIA implementation to override the default global/context fault
> interrupt handlers and handle interrupts across the two ARM MMU-500s that
> are programmed identically.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/arm-smmu-nvidia.c | 99 +++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c        | 17 +++++-
>  drivers/iommu/arm-smmu.h        |  3 +
>  3 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> index 2f55e5793d34..31368057e9be 100644
> --- a/drivers/iommu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -127,6 +127,103 @@ static int nvidia_smmu_reset(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> +static irqreturn_t nvidia_smmu_global_fault_inst(int irq,
> +						 struct arm_smmu_device *smmu,
> +						 int inst)
> +{
> +	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
> +	void __iomem *gr0_base = nvidia_smmu_page(smmu, inst, 0);
> +
> +	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
> +	if (!gfsr)
> +		return IRQ_NONE;
> +
> +	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
> +	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
> +	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
> +
> +	dev_err_ratelimited(smmu->dev,
> +			    "Unexpected global fault, this could be serious\n");
> +	dev_err_ratelimited(smmu->dev,
> +			    "\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
> +			    gfsr, gfsynr0, gfsynr1, gfsynr2);
> +
> +	writel_relaxed(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nvidia_smmu_global_fault(int irq, void *dev)
> +{
> +	unsigned int inst;
> +	irqreturn_t ret = IRQ_NONE;
> +	struct arm_smmu_device *smmu = dev;
> +
> +	for (inst = 0; inst < NUM_SMMU_INSTANCES; inst++) {
> +		irqreturn_t irq_ret;
> +
> +		irq_ret = nvidia_smmu_global_fault_inst(irq, smmu, inst);
> +		if (irq_ret == IRQ_HANDLED)
> +			ret = IRQ_HANDLED;
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t nvidia_smmu_context_fault_bank(int irq,
> +						  struct arm_smmu_device *smmu,
> +						  int idx, int inst)
> +{
> +	u32 fsr, fsynr, cbfrsynra;
> +	unsigned long iova;
> +	void __iomem *gr1_base = nvidia_smmu_page(smmu, inst, 1);
> +	void __iomem *cb_base = nvidia_smmu_page(smmu, inst, smmu->numpage + idx);
> +
> +	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> +	if (!(fsr & ARM_SMMU_FSR_FAULT))
> +		return IRQ_NONE;
> +
> +	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
> +	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> +	cbfrsynra = readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(idx));
> +
> +	dev_err_ratelimited(smmu->dev,
> +			    "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> +			    fsr, iova, fsynr, cbfrsynra, idx);
> +
> +	writel_relaxed(fsr, cb_base + ARM_SMMU_CB_FSR);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
> +{
> +	int idx;
> +	unsigned int inst;
> +	irqreturn_t ret = IRQ_NONE;
> +	struct arm_smmu_device *smmu;
> +	struct iommu_domain *domain = dev;
> +	struct arm_smmu_domain *smmu_domain;
> +
> +	smmu_domain = container_of(domain, struct arm_smmu_domain, domain);
> +	smmu = smmu_domain->smmu;
> +
> +	for (inst = 0; inst < NUM_SMMU_INSTANCES; inst++) {
> +		irqreturn_t irq_ret;
> +
> +		/*
> +		 * Interrupt line is shared between all contexts.
> +		 * Check for faults across all contexts.
> +		 */
> +		for (idx = 0; idx < smmu->num_context_banks; idx++) {
> +			irq_ret = nvidia_smmu_context_fault_bank(irq, smmu,
> +								 idx, inst);
> +			if (irq_ret == IRQ_HANDLED)
> +				ret = IRQ_HANDLED;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct arm_smmu_impl nvidia_smmu_impl = {
>  	.read_reg = nvidia_smmu_read_reg,
>  	.write_reg = nvidia_smmu_write_reg,
> @@ -134,6 +231,8 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
>  	.write_reg64 = nvidia_smmu_write_reg64,
>  	.reset = nvidia_smmu_reset,
>  	.tlb_sync = nvidia_smmu_tlb_sync,
> +	.global_fault = nvidia_smmu_global_fault,
> +	.context_fault = nvidia_smmu_context_fault,
>  };
>  
>  struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c123a5814f70..020afddfaa0f 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -670,6 +670,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	enum io_pgtable_fmt fmt;
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	irqreturn_t (*context_fault)(int irq, void *dev);
>  
>  	mutex_lock(&smmu_domain->init_mutex);
>  	if (smmu_domain->smmu)
> @@ -832,7 +833,13 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	 * handler seeing a half-initialised domain state.
>  	 */
>  	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> -	ret = devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
> +
> +	if (smmu->impl && smmu->impl->context_fault)
> +		context_fault = smmu->impl->context_fault;
> +	else
> +		context_fault = arm_smmu_context_fault;
> +
> +	ret = devm_request_irq(smmu->dev, irq, context_fault,
>  			       IRQF_SHARED, "arm-smmu-context-fault", domain);
>  	if (ret < 0) {
>  		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> @@ -2105,6 +2112,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	struct arm_smmu_device *smmu;
>  	struct device *dev = &pdev->dev;
>  	int num_irqs, i, err;
> +	irqreturn_t (*global_fault)(int irq, void *dev);
>  
>  	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>  	if (!smmu) {
> @@ -2191,9 +2199,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		smmu->num_context_irqs = smmu->num_context_banks;
>  	}
>  
> +	if (smmu->impl && smmu->impl->global_fault)
> +		global_fault = smmu->impl->global_fault;
> +	else
> +		global_fault = arm_smmu_global_fault;
> +
>  	for (i = 0; i < smmu->num_global_irqs; ++i) {
>  		err = devm_request_irq(smmu->dev, smmu->irqs[i],
> -				       arm_smmu_global_fault,
> +				       global_fault,
>  				       IRQF_SHARED,
>  				       "arm-smmu global fault",
>  				       smmu);
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index fad63efa1a72..d890a4a968e8 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -18,6 +18,7 @@
>  #include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/io-pgtable.h>
>  #include <linux/iommu.h>
> +#include <linux/irqreturn.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> @@ -389,6 +390,8 @@ struct arm_smmu_impl {
>  	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>  			 int status);
>  	int (*def_domain_type)(struct device *dev);
> +	irqreturn_t (*global_fault)(int irq, void *dev);
> +	irqreturn_t (*context_fault)(int irq, void *dev);
>  };
>  
>  static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
> 


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
