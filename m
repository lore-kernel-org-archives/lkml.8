Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F404DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34642087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkTkOtpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIAFAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIAFAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:00:50 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64CC0612A0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:00:50 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 3so73922oih.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yS6GI89LI/f0FNWAupbk3KUTtqw1Z/rOa16+RpMuRmA=;
        b=KkTkOtpb155K2KuZCtBzjJYA591c+C7gNJIzWBRPD6NFNJTdClG28hsfJFj3UJ3sAx
         sHnH55pKW+wjdveHMCrtGj76TRtZ4iEJBc88P42HhoBOmRRdgbLoXBU952TSkx5T7ZiG
         8XIts/Uopwy1Oq7yJ1IXf56a+zWf5yohjJvEzkE0UaVx1lB3XgxWycFvxtFqvD6V+Wgw
         MVit4PM/EUHFfJha8cuPCYtWvYPOxlJ8zEi7BsJSqZ+UJIFaW3kfo3Pxm20O8TuGlPxg
         ymoa+Ho2KMXimSYuBOErbEwFeI0CwOBal+89a99M7xhg4stZrDht2IzsQed+5UQySQDg
         KOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yS6GI89LI/f0FNWAupbk3KUTtqw1Z/rOa16+RpMuRmA=;
        b=Ghg6XBEDZ0TlOOeXFNOVGQOXiZSJAglUKzBt5BdOmvCmQmpgPzktPVkEYVi7JUwUoD
         R9TUJZsLVe1aVJjBS1/Vx/KzP/B9HabRpTtgGpp9dltBOJKVifnzCX3ALDEXLD2hzWxB
         VXHCADTrY6pRDBp2iyTploCCV0fjW7bmVWoeWGGSP1tozVLU2oJEPykkNd68JMfquQ3E
         L6ICTkk4sgd5+AhvQE6+RFAruqbAod5NK876xQ+9Es8CjNxWFtSC5De5KhRjPqKzMP4b
         aizHawgKSxh+57C35gpUKW84/MoQ//r4oO8A+CrXzhpilwsPuzia3Tm3p5pbNUjppZ37
         brHg==
X-Gm-Message-State: AOAM532DZ3XyxJGPcQwhMBoTBspxY8yijAD2INfZJOlqv7cKTlKGMhvo
        Lz/PYC4eBa96ZqTAPNYDB7iNXg==
X-Google-Smtp-Source: ABdhPJw49W2MfiCQSAmX6Y0Pae9n6VKgj97b2xwM4u73son8yqzElosho5iEd0Mm4wvTQCxEWQ41mA==
X-Received: by 2002:a54:4388:: with SMTP id u8mr72201oiv.1.1598936449699;
        Mon, 31 Aug 2020 22:00:49 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id m5sm4933ote.27.2020.08.31.22.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 22:00:49 -0700 (PDT)
Date:   Tue, 1 Sep 2020 00:00:46 -0500
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
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/19] dt-bindings: arm-smmu: Add compatible string for
 Adreno GPU SMMU
Message-ID: <20200901050046.GR3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-11-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-11-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Every Qcom Adreno GPU has an embedded SMMU for its own use. These
> devices depend on unique features such as split pagetables,
> different stall/halt requirements and other settings. Identify them
> with a compatible string so that they can be identified in the
> arm-smmu implementation specific code.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 503160a7b9a0..5ec5d0d691f6 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -40,6 +40,10 @@ properties:
>                - qcom,sm8150-smmu-500
>                - qcom,sm8250-smmu-500
>            - const: arm,mmu-500
> +      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
> +        items:
> +          - const: qcom,adreno-smmu
> +          - const: qcom,smmu-v2
>        - description: Marvell SoCs implementing "arm,mmu-500"
>          items:
>            - const: marvell,ap806-smmu-500
> -- 
> 2.26.2
> 
