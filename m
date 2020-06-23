Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047BAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D752120842
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQ4xiTf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgFWC4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbgFWC4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:56:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E61C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:56:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z63so9402627pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSTC0VTBrWDM5by3kGz7hIcxXLRKqyZK1aiOUbh6nM8=;
        b=eQ4xiTf7gx2KjSDgCEoSAdzK7UDZ8pqfOk3ewtrUignzeaxkaEM73d/Yd0pQAF1kbD
         /cTGE2Ja7Mn6ueajaTG/Ravft6sQHIuvGIhhVF55uRTIl9+1LgpYvNlrkNFLOoJdfFNl
         yfxfErmHrKZxhkS+wTdJeJ5kpQHYNVELPQaQc1Sjmwe1Nc403gxMAuo0Ha7p4Kgo+g2Z
         zkwbEyqaG/HsD7XYjTC2SCzs6JwgLPbLEiJhqTYDQFaY2heEyT6V93h/bSG1HyJW/gfw
         RcC0sGEZgafv6zkgZg1tIpHfJPvKHCLiPpRNMX2SoBHwOH42L0gZz4YJg5NQAWkaR6Sr
         B4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSTC0VTBrWDM5by3kGz7hIcxXLRKqyZK1aiOUbh6nM8=;
        b=KJ2Ebe8Ma+npsUX73U29BVR+zSzqoKNAr8xZWp2MwMoXUNmHzf1jSBFnthuNXj0e3A
         vHbLDMXGpfRUNKoTRefK9EVuBcbWCS+yzEUftzcwICW+gmdpucHkLTzza/khPxRfDGFZ
         x+xJitCMiUHJ62WaClYkWCixoIdbam4iLeocVvCa/rI1imMKJ3M9Hcnvf3gaDxa1hjg6
         Y2jtoKN7bhyHd5lzGrikVPs46G19UIS3srFi6SSwJlx4mHx9QTUPTtxOLrL/MekhxvM/
         lkB+1pd558HNxEYw66cCo2C56PQk3cMWqjywYZzQwG+NRrHPEqTjVHc3aTcWUb1lcUcl
         n3Dg==
X-Gm-Message-State: AOAM530ta0E4bxgwo7oeDkvhODQ3l+Mx/KQR+rDtyfaQWC3OmuOGeOiU
        A/N9L2MmDm3/6knchqBWIy14
X-Google-Smtp-Source: ABdhPJyrVggWi5UupCm2eia+264I1LZmyLdnPGHgQa9SBezyVI4TW8Vu1BIiFcqr1BCjXIz0g8Jk4A==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr21976058pfu.164.1592880966978;
        Mon, 22 Jun 2020 19:56:06 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:609d:7d26:e4ff:f0b0:edd6:2484])
        by smtp.gmail.com with ESMTPSA id y12sm15348621pfm.158.2020.06.22.19.56.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 19:56:06 -0700 (PDT)
Date:   Tue, 23 Jun 2020 08:26:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: defconfig: Enable Qualcomm IPCC driver
Message-ID: <20200623025600.GF11093@Mani-XPS-13-9360>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
 <20200622222747.717306-7-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622222747.717306-7-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:27:47PM -0700, Bjorn Andersson wrote:
> The IPCC hardware block provides a mechanism for triggering interrupts
> between co-processors in recent Qualcomm SoCs. This is used as basis for
> most form of communication between co-processors, so enable this
> support.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5848799dcad0..b3d13e1a052a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -834,6 +834,7 @@ CONFIG_IMX_MBOX=y
>  CONFIG_PLATFORM_MHU=y
>  CONFIG_BCM2835_MBOX=y
>  CONFIG_QCOM_APCS_IPC=y
> +CONFIG_QCOM_IPCC=y
>  CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_ARM_SMMU=y
> -- 
> 2.26.2
> 
