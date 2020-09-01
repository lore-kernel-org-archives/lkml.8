Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4707CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0CE208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZM/Hx5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIAE4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAE4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:56:08 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24912C0612A0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:56:07 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v16so73400otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vtOK+JdyZooaz1NAnQQXA6CpZw+KJadIhTEL2kbj1TY=;
        b=sZM/Hx5YPU8n2Dalo1uiJyMbr745uxuBPAiHY508RWFAugXsnmybzaLCEO2xBNgLhG
         OHE3C4OULSiQYqRcs6BgvhFZC+zZO/VmAeoeqk0k8gB826LBP5qidYnIAYU4rOIrINgM
         TQ+yTWu9Sxp8KC9xZ0TtcnzBbSYCkRapMjBxSKHKoL/KQMvdRc035C9nWtMEqtqRJ36N
         mxJCS9ZoY3Rle9LHVK05/P3R23ouMMKvMCxvJyUkXSUI8qASZExglvLZXweoLVSTAFGu
         Ppbut+TiK/e+1by4PrTo8/2Fewu7TTf0mn3QUYRsvS8RpzJPQ2SJY84gO+/bEYyQ2701
         WYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vtOK+JdyZooaz1NAnQQXA6CpZw+KJadIhTEL2kbj1TY=;
        b=S6o/SSJ0TpFZSZMvGryN8TtjM5HFs06xIsFYCuUEFr5oLVpZpwpCAWQEWKn0HyA98/
         8d6JXkoFj40yBMyKFOyjekHBeDvitgOQyNSrVecS+3hIcT4Ke4U8eUY+UBFzn8J/2y9X
         zyn+6uYtuaD4JOqsi+Dkq88ghClUgw2JJT8gjs2G6qmBq46ethPR5x6c4CvKwvoV4Vcz
         Tv4bhBDdXbMH6JX5l45laruN9UQAos+eJW+Iu2nKPzh3eyK0iBHP+cxSahIchqO8AiJx
         LCZpaODPTwJJCxMx/OdBNfRvX95RPQqoyOV3MDrt/4YWc+B8ZMTIgYoZjjABAIU36oJf
         ZP0w==
X-Gm-Message-State: AOAM531hMTzQSqUh1TLi/2Gk8mXigYL0G1MT+fT2fAVsV4ryPAOfTcf1
        UZ+8WwJJCRkib1nHXWNDiMUbqw==
X-Google-Smtp-Source: ABdhPJw+EMv9TyDAnLqJQrXIIowFlV6IK//RYKVec+GZUzuKneC5cn+zskaRocfswvWbn08780xMEw==
X-Received: by 2002:a9d:7e85:: with SMTP id m5mr138888otp.330.1598936166935;
        Mon, 31 Aug 2020 21:56:06 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id r189sm2033728oih.51.2020.08.31.21.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 21:56:06 -0700 (PDT)
Date:   Mon, 31 Aug 2020 23:56:03 -0500
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
        Pritesh Raithatha <praithatha@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/19] iommu/arm-smmu: constify some helpers
Message-ID: <20200901045603.GO3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-9-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-9-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Sprinkle a few `const`s where helpers don't need write access.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 59ff3fc5c6c8..27c83333fc50 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -377,7 +377,7 @@ struct arm_smmu_master_cfg {
>  	s16				smendx[];
>  };
>  
> -static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
> +static inline u32 arm_smmu_lpae_tcr(const struct io_pgtable_cfg *cfg)
>  {
>  	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
>  		FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> @@ -398,13 +398,13 @@ static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
>  	return tcr;
>  }
>  
> -static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
> +static inline u32 arm_smmu_lpae_tcr2(const struct io_pgtable_cfg *cfg)
>  {
>  	return FIELD_PREP(ARM_SMMU_TCR2_PASIZE, cfg->arm_lpae_s1_cfg.tcr.ips) |
>  	       FIELD_PREP(ARM_SMMU_TCR2_SEP, ARM_SMMU_TCR2_SEP_UPSTREAM);
>  }
>  
> -static inline u32 arm_smmu_lpae_vtcr(struct io_pgtable_cfg *cfg)
> +static inline u32 arm_smmu_lpae_vtcr(const struct io_pgtable_cfg *cfg)
>  {
>  	return ARM_SMMU_VTCR_RES1 |
>  	       FIELD_PREP(ARM_SMMU_VTCR_PS, cfg->arm_lpae_s2_cfg.vtcr.ps) |
> -- 
> 2.26.2
> 
