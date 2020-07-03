Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0B8207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGCJD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:03:29 -0400
Received: from foss.arm.com ([217.140.110.172]:39668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgGCJD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:03:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4BA32F;
        Fri,  3 Jul 2020 02:03:26 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA1C93F68F;
        Fri,  3 Jul 2020 02:03:24 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] iommu/arm-smmu: Workaround for Marvell
 Armada-AP806 SoC erratum #582743
To:     Tomasz Nowicki <tn@semihalf.com>, will@kernel.org, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-3-tn@semihalf.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8c3fea9-2bd7-e776-447e-54886cd61568@arm.com>
Date:   Fri, 3 Jul 2020 10:03:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702201633.22693-3-tn@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02 21:16, Tomasz Nowicki wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit to
> ARM SMMUv2 registers.
> 
> Provide implementation relevant hooks:
> - split the writeq/readq to two accesses of writel/readl.
> - mask the MMU_IDR2.PTFSv8 fields to not use AArch64 format (but
> only AARCH32_L) since with AArch64 format 32 bits access is not supported.
> 
> Note that separate writes/reads to 2 is not problem regards to
> atomicity, because the driver use the readq/writeq while initialize
> the SMMU, report for SMMU fault, and use spinlock in one
> case (iova_to_phys).

The comment about the spinlock seems to be out of date, and TBH that 
whole sentence is a bit unclear - how about something like:

"Note that most 64-bit registers like TTBRn can be accessed as two 
32-bit halves without issue, and AArch32 format ensures that the 
register writes which must be atomic (for TLBI etc.) need only be 32-bit."

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>   Documentation/arm64/silicon-errata.rst |  3 ++
>   drivers/iommu/arm-smmu-impl.c          | 52 ++++++++++++++++++++++++++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 936cf2a59ca4..157214d3abe1 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -125,6 +125,9 @@ stable kernels.
>   | Cavium         | ThunderX2 Core  | #219            | CAVIUM_TX2_ERRATUM_219      |
>   +----------------+-----------------+-----------------+-----------------------------+
>   +----------------+-----------------+-----------------+-----------------------------+
> +| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
> ++----------------+-----------------+-----------------+-----------------------------+
>   | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>   +----------------+-----------------+-----------------+-----------------------------+
>   +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c75b9d957b70..c1fc5e1b8193 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -147,6 +147,53 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
>   	.reset = arm_mmu500_reset,
>   };
>   
> +static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
> +{
> +	u64 val;
> +
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the readq to double readl
> +	 */
> +	val = (u64)readl_relaxed(arm_smmu_page(smmu, page) + off + 4) << 32;
> +	val |= readl_relaxed(arm_smmu_page(smmu, page) + off);

Even though io-64-nonatomic-hi-lo.h doesn't override readq() etc. for 
64-bit builds, you can still use hi_lo_readq_relaxed() directly.

> +
> +	return val;
> +}
> +
> +static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
> +			       u64 val)
> +{
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the writeq to double writel
> +	 */
> +	writel_relaxed(upper_32_bits(val), arm_smmu_page(smmu, page) + off + 4);
> +	writel_relaxed(lower_32_bits(val), arm_smmu_page(smmu, page) + off);

Similarly, hi_lo_writeq_relaxed().

> +}
> +
> +static u32 mrvl_mmu500_cfg_id2_fixup(u32 id)
> +{
> +
> +	/*
> +	 * Armada-AP806 erratum #582743.
> +	 * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
> +	 * formats altogether and allow using 32 bits access on the
> +	 * interconnect.
> +	 */
> +	id &= ~(ARM_SMMU_ID2_PTFS_4K | ARM_SMMU_ID2_PTFS_16K |
> +		ARM_SMMU_ID2_PTFS_64K);
> +
> +	return id;
> +}
> +
> +static const struct arm_smmu_impl mrvl_mmu500_impl = {
> +	.read_reg64 = mrvl_mmu500_readq,
> +	.write_reg64 = mrvl_mmu500_writeq,
> +	.cfg_id2_fixup = mrvl_mmu500_cfg_id2_fixup,
> +	.reset = arm_mmu500_reset,
> +};
> +
>   
>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   {
> @@ -160,6 +207,11 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   	 */
>   	switch (smmu->model) {
>   	case ARM_MMU500:
> +		if (of_device_is_compatible(smmu->dev->of_node,

Nit: there's a local "np" variable now.

> +					    "marvell,ap806-smmu-500")) {
> +			smmu->impl = &mrvl_mmu500_impl;
> +			return smmu;
> +		}

Please put this with the other integration checks below the switch 
statement. Yes, it means we'll end up assigning smmu->impl twice for 
this particular case, but that's the intended pattern.

Robin.

>   		smmu->impl = &arm_mmu500_impl;
>   		break;
>   	case CAVIUM_SMMUV2:
> 
