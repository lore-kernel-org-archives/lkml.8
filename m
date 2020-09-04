Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B67A2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZy7+nmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIDQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIDQGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:06:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC3C061246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:06:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u25so6327717otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yGsA49rxc5hM77zu3hVnv/Snb3l8Beqqgv9O0m89n9M=;
        b=OZy7+nmo3BIaZ9T9nelyVX4l9QpEbcCuo8yllCgiWtT62uoQjY63QalRFu8zFehO6v
         ZnAVU++j55iEY2+/sYTqgpW965CzNYh5FSFLjLpJUbZlROleC0GufMN2cf17HO1cOrdh
         vlLrs+k7gUMBydn50+D7kwpNIeCJfrsHGQ7J6qgvpCSVbA6vxWMTAVSFIfjIhNhxCoo/
         vW27rwvVuBh+ZoTTMRP+K7vfGOFt0KzFaw693zfr5F+d1dEyCfujTjhQj5DYbITrbKFs
         xUlgzZm6UckT40GBkz51u7zO3ZW6Bdm3+d5Xt6kV1xFyTr++s7HS/jYv/RsDEy2rqQiv
         hg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yGsA49rxc5hM77zu3hVnv/Snb3l8Beqqgv9O0m89n9M=;
        b=UqyScbB5oLChW4sl4dHshC8jYgxKalrxpZyoFoermlvusZy46uzZywaBxPAoOHLS4u
         uUQVWbTz7gUBHNFYQkK8uaV7yJGxFL/THZKKVNxJeE9SYyoATqnZTtC20pYZAKAPTRx3
         8BK/mAjj8BqcvFLdTDEds6xzeqk0XIyEZqX1fkcH12m5hj+v1S6qy0lWiM4x4pFtf5K1
         Dtkz2vqbm7Kc7zVIz4R0ihjfFUVVDfQSPkOKvIf7B8SiZFqBOablK5qu6Khu7GGOe/b7
         StYsCFCzJz6PI9FrdwcEzJ4C5inDChDQAPeIT4yLHyeOCYkF/Gdv8waFHUr9j61+VToP
         rC8w==
X-Gm-Message-State: AOAM530P56BDknGPR5C8pO7bkElaidm0P2X2LoWAAtTYMdRVeajCYeRf
        UFqHzSAIB60f9GkXLI84jDnMVA==
X-Google-Smtp-Source: ABdhPJzGRciwEc32A7jGVOPFZOIbTFY5t2o9ThvPI+Y2vdsQYpVMGnxVgGSNkXlsXYLGJPIR5XUBxw==
X-Received: by 2002:a9d:2c43:: with SMTP id f61mr6394737otb.154.1599235593662;
        Fri, 04 Sep 2020 09:06:33 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id q9sm1264649otk.14.2020.09.04.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:06:32 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:06:20 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v16 19/20] arm: dts: qcom: sm845: Set the compatible
 string for the GPU SMMU
Message-ID: <20200904160620.GI3715@yoga>
References: <20200901164707.2645413-1-robdclark@gmail.com>
 <20200901164707.2645413-20-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901164707.2645413-20-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Sep 11:46 CDT 2020, Rob Clark wrote:

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
> split pagetables and per-instance pagetables for drm/msm.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 9 +++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index 64fc1bfd66fa..39f23cdcbd02 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -633,6 +633,15 @@ &mdss_mdp {
>  	status = "okay";
>  };
>  
> +/*
> + * Cheza fw does not properly program the GPU aperture to allow the
> + * GPU to update the SMMU pagetables for context switches.  Work
> + * around this by dropping the "qcom,adreno-smmu" compat string.
> + */
> +&adreno_smmu {
> +	compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
> +};
> +
>  &mss_pil {
>  	iommus = <&apps_smmu 0x781 0x0>,
>  		 <&apps_smmu 0x724 0x3>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2884577dcb77..76a8a34640ae 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4058,7 +4058,7 @@ opp-257000000 {
>  		};
>  
>  		adreno_smmu: iommu@5040000 {
> -			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
> +			compatible = "qcom,sdm845-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
>  			reg = <0 0x5040000 0 0x10000>;
>  			#iommu-cells = <1>;
>  			#global-interrupts = <2>;
> -- 
> 2.26.2
> 
