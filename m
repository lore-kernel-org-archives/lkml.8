Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71091C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA5020768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597325028;
	bh=nwBcHLQtnlfDIMhhidp3mFZTNefj9XCZxmSg2p2PeNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SUfd+mnrOTI5ghU50jJ0qga6UGcUpF8D3wtq9g144eU9tznSWBsRooyFUlEMnknOe
	 79fvCfTCXQQKHK3QpUbNB7gk01yQH+iOCX/TlRFOLAKU+/5uAmhpdXZe8gJTF/sStR
	 3y2x6+RFA9eXTPzUA6VFxjKUaL85QnhU86AH7zeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMNXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHMNXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:23:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA7C20768;
        Thu, 13 Aug 2020 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597325021;
        bh=nwBcHLQtnlfDIMhhidp3mFZTNefj9XCZxmSg2p2PeNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2bZ9XVlxHbkebFL8JjRdtexL55UfQMacYaxyE4tNNZt4FM2Ugk1aqNszSOgJphdf
         lq99tGEJh98XYa0sffw9jLBkTFC5QJsGtyb64dNSjcUhMzvPVOIkyn9DPYdIYhCVO9
         r0K3MWq6HRLkkIwcEysqu15NO+hz+8DfMz2UzrTU=
Date:   Thu, 13 Aug 2020 14:23:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Hanna Hawa <hannah@marvell.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 05/13] iommu/arm-smmu-qcom: Add implementation for
 the adreno GPU SMMU
Message-ID: <20200813132336.GA10359@willie-the-truck>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200810222657.1841322-6-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810222657.1841322-6-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 04:26:49PM -0600, Jordan Crouse wrote:
> Add a special implementation for the SMMU attached to most Adreno GPU
> target triggered from the qcom,adreno-smmu compatible string.
> 
> The new Adreno SMMU implementation will enable split pagetables
> (TTBR1) for the domain attached to the GPU device (SID 0) and
> hard code it context bank 0 so the GPU hardware can implement
> per-instance pagetables.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |   3 +
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 156 ++++++++++++++++++++-
>  2 files changed, 157 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index 88f17cc33023..d199b4bff15d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -223,6 +223,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  	    of_device_is_compatible(np, "qcom,sm8250-smmu-500"))
>  		return qcom_smmu_impl_init(smmu);
>  
> +	if (of_device_is_compatible(smmu->dev->of_node, "qcom,adreno-smmu"))
> +		return qcom_adreno_smmu_impl_init(smmu);
> +
>  	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
>  		smmu->impl = &mrvl_mmu500_impl;
>  
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index be4318044f96..3be10145bf57 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -12,6 +12,138 @@ struct qcom_smmu {
>  	struct arm_smmu_device smmu;
>  };
>  
> +#define QCOM_ADRENO_SMMU_GPU_SID 0
> +
> +static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	int idx, i;
> +
> +	/*
> +	 * The GPU will always use SID 0 so that is a handy way to uniquely
> +	 * identify it and configure it for per-instance pagetables
> +	 */
> +	for_each_cfg_sme(cfg, fwspec, i, idx) {
> +		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
> +
> +		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
> +			return true;
> +	}

Is for_each_cfg_sme() really what you want here? You're not using idx for
anything, so I guess it should really be a loop over the sids (e.g. a bog
standard for loop from 0 to fw->num_ids - 1)?

Will
