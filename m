Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709E9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB34208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmSH5izG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIAFbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAFbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:31:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CEEC061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:31:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i4so151409ota.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ah4wulanW6w834elfegUZ00h7caLTkMycV73Sq0JJsc=;
        b=EmSH5izGYAYMIMbM05yD68/xN+pZG9cT5IEu4PC7V5EdHFWAtW1dw/0ERlIeS3MK0m
         hvKbP2VsYz1kPp88xPbs0rKAV0sC2BgYo3p9odC4ZXDU47xgDpmlYYQyn+xg5CmrR9Dd
         cNXatf9NQdMCm/EInmMdCFU7ot7LCEPW+ajWkr7YCtfJA7bB2LtV7/BGYyh8+jgzHz2+
         CbGk8kZ0J/YJA8aVUce4DkurE5IzgQ0aRY9uVoUIYsUNOPzs9LjTh85QDcLM9++dKY6L
         LymH66Xyc6UIg5Zg5aUChODTVVDgpIcZizLEKqk8/3xNheD5RQ2xW/sP8vQBiDfoioAn
         pbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ah4wulanW6w834elfegUZ00h7caLTkMycV73Sq0JJsc=;
        b=twALkHQLpgRzFiAmJ4jUgh0V5JaKvgJBOsSIuZB5HV9IZXF/igZNm/esd/JKMb+ZXQ
         h+G00YGJQ0A0V9ct1BXTyJaS06uc4JmiinBcdaiJkYd9ksYLGuB47wYUYQHVfq57Tx1I
         zC0btGYMYaPffbSNP56jtqRGvl1wu8lH89yPjpHWVH0Wfq8U7W66srmNESFRLYMVUYJF
         i9qwICUhJcSZOW1/AJz+f0EvDTKW1mq20EiSA61IuDLAFYbKYNtgTKQkPhjsUcpsfOeb
         g1QeboABg35ZeOvdcD1egIHmK9LYCQng34cvcxD/5/hx9kOYFnUO/38ZWnUUMNeyQSek
         fo4g==
X-Gm-Message-State: AOAM531xz4u07tGs+zJC16ib3cJg7syRnE5iPiVxIP4PC5sCShB1OEXY
        g3hS8ZhMgPoKacM4Jw2GzZZdUA==
X-Google-Smtp-Source: ABdhPJwrHsRNsq+ddPo5+Vm3z1aTAOZfNB+Y5KDPl/h6cDxgUxeU167eyc1o9QYOLAnmTJw0ENBBWg==
X-Received: by 2002:a9d:238b:: with SMTP id t11mr225178otb.60.1598938309430;
        Mon, 31 Aug 2020 22:31:49 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id i23sm2099742oii.53.2020.08.31.22.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 22:31:48 -0700 (PDT)
Date:   Tue, 1 Sep 2020 00:31:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/19] iommu/arm-smmu: add a way for implementations to
 influence SCTLR
Message-ID: <20200901053145.GX3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-19-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-19-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
> pending translations are not terminated on iova fault.  Otherwise
> a terminated CP read could hang the GPU by returning invalid
> command-stream data.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 5640d9960610..2aa6249050ff 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -127,6 +127,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
>  		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
>  
> +	/*
> +	 * On the GPU device we want to process subsequent transactions after a
> +	 * fault to keep the GPU from hanging
> +	 */
> +	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
> +
>  	/*
>  	 * Initialize private interface with GPU:
>  	 */
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index e63a480d7f71..bbec5793faf8 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		reg |= ARM_SMMU_SCTLR_E;
>  
> +	reg |= cfg->sctlr_set;
> +	reg &= ~cfg->sctlr_clr;
> +
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index cd75a33967bb..2df3a70a8a41 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -144,6 +144,7 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_SCTLR		0x0
>  #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
>  #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
> +#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
>  #define ARM_SMMU_SCTLR_CFIE		BIT(6)
>  #define ARM_SMMU_SCTLR_CFRE		BIT(5)
>  #define ARM_SMMU_SCTLR_E		BIT(4)
> @@ -341,6 +342,8 @@ struct arm_smmu_cfg {
>  		u16			asid;
>  		u16			vmid;
>  	};
> +	u32				sctlr_set;    /* extra bits to set in SCTLR */
> +	u32				sctlr_clr;    /* bits to mask in SCTLR */
>  	enum arm_smmu_cbar_type		cbar;
>  	enum arm_smmu_context_fmt	fmt;
>  };
> -- 
> 2.26.2
> 
