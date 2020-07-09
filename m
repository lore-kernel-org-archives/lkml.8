Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CEBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7488720674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+SHRE9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGIEmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGIEmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:42:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C53C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 21:42:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so538505pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pTAzdoR1iN01t/o6IGGOMW4lUNtEdPviP+EREnFTumw=;
        b=n+SHRE9Ua8fMAWjFYOgNrl8i+y+/wi7luuOf8JRUES039HMvzP3fg+t5pG3pdY/VKY
         Ux0xL3tiwAb90UAPQhMPQIBkcK8fblXPeWI8QGk2nw+3c43jvcdIcEpUsx5xxQ3eRqAl
         /T45fd2rtkgzrRGg/yVeaPi7/HKJ+P0ttw/ROclQZBUuCsXwaDvNVZ2hkwLt2aSaFht8
         LvZOVViLVpMJ7DRHjz3XvTSXtt19VeOSTrTmCQaLEd61i4rlDJEtpKdcds32Hj+rKO/O
         vySVkJCCTEL0DQPYcWIjsakGOh0BAmR6bhUQq6XmfGhBK7ZvH2eInjnZun+7BQSDOLoJ
         sElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pTAzdoR1iN01t/o6IGGOMW4lUNtEdPviP+EREnFTumw=;
        b=XqCOIXahSn7vOxVo2wmergXwLnbcDXXIKOrudKWaTVaOGH1SajVLoZq3/I5MrBoUqK
         CWMhYuU8X/brvvcjhbk8GKS2n8xdBHThwnGbq6F3IxyEmOV2MZHOJfrv03FDFvfzq8s8
         h8vW5w9ivYMPdAAtQ/x0JmvWC67QfzXWgCna03nVpjrmEVf6coyR29l9M+aLQTkpQGTe
         lYEo1/yMZUl2YkwXtOSXdmLa6mdtmAK638+ai1vdDURW9gV2oQZAr1aIZo0/NQorQcDr
         ofh6aYmcRKxD5Nv1Bt4yRbhBx5C9xppRn0purXg02KNqBbmpruiMKGzuOMWeG8KpqBqO
         XeXg==
X-Gm-Message-State: AOAM530ekjM7uifoVAII2v1FexR7YcYOjTU5G1jXRWVvwzK4OGxcan2f
        Sfe/rVJEVENzmx9fzIypOk7grA==
X-Google-Smtp-Source: ABdhPJyrm5vz51JSJy0lUCVNkroG/XfjsDb45YFwdd0ZYnD6cYxRHPchu5dD4ScTiTIEeUIiSD1ocQ==
X-Received: by 2002:a17:90a:ff03:: with SMTP id ce3mr13844333pjb.174.1594269772843;
        Wed, 08 Jul 2020 21:42:52 -0700 (PDT)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z11sm1228667pfk.46.2020.07.08.21.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 21:42:51 -0700 (PDT)
Date:   Wed, 8 Jul 2020 21:43:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/8] iommu: arm-smmu-impl: Use qcom impl for sm8150
 and sm8250 compatibles
Message-ID: <20200709044318.GA3453565@ripper>
References: <20200609194030.17756-1-jonathan@marek.ca>
 <20200609194030.17756-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609194030.17756-3-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Jun 12:40 PDT 2020, Jonathan Marek wrote:

> Use the qcom implementation for IOMMU hardware on sm8150 and sm8250 SoCs.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm-smmu-impl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c75b9d957b70..f5f6cab626be 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -172,7 +172,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  		smmu->impl = &calxeda_impl;
>  
>  	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
> -	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
> +	    of_device_is_compatible(np, "qcom,sc7180-smmu-500") ||
> +	    of_device_is_compatible(np, "qcom,sm8150-smmu-500") ||
> +	    of_device_is_compatible(np, "qcom,sm8250-smmu-500"))
>  		return qcom_smmu_impl_init(smmu);
>  
>  	return smmu;
> -- 
> 2.26.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
