Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE0AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA49246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaF3sVJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgB1DVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:21:15 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36950 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730756AbgB1DVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:21:14 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so679118pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CbyhEEBykmw3ddLjjJrI9AM5Mr4hawbbfYF6WKWQqeQ=;
        b=eaF3sVJdk+D/CnRbyfi1cEt+jLNGgv14OlM9uSIxKRbXQeHAUSaINSCt/R0HWLtYbO
         g54dyBqxfM9SxnM7ub7WgPHoBLmR1w8E7FWO43vDqX22aG8/9c3ldoFM7dGRaScYmmaS
         PpdFsqif/jj0zdCCeORObPwwIgUfMW+JelQ8c2gPZeAw/PYfqkJm5T9qzxNlXnZ7lfOJ
         j7SslBVWiThddTLts4jK/LwmDgGMOagdSalhgqmUjessz6JNCshBfwWO4D/7UTtw9akS
         RN7nEnqLQhd1ciMJ7fpkgogVCpcc4v6tLJuegQOEnL3vhkZtV7SB+p3ay/kGvoNBT6/7
         En1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CbyhEEBykmw3ddLjjJrI9AM5Mr4hawbbfYF6WKWQqeQ=;
        b=JXd683YobMF41cJsNZfCc87rT20pkIwVmAMAfx3XpjS2krPvGiS+O3r9opUQi08JJT
         6C8u8Ez7JTuv/w+Cz3pYigpB3wnJwWRmg2/7I4ELk7vefCes1oFe4nZdbge3MBCrDbyb
         udJykAPluzQIUqmJF/Q0lzzbCQUEybNps4Xs/AzTP5Le/GU67Hbvhxtu+tu1Ha/DIYWF
         /7OLF5YdfuhsihvWUf8FN9zH0yuj/aLygnA1nhOyuWdcgYVzzF+0FiIzsVY5iNlAxDtr
         duIADubnbLJLyFUpwCcGND3UZwSQXvdFuOO6wp3GAtchrfZv2DO14rc5sBB4/HsyiFGy
         p0qw==
X-Gm-Message-State: APjAAAWb/Dw/ozx57h7j7/S0eusfvOIfwUBvY6i0cIQPhOa/1is2BaeG
        yX/YvBvCZRuDlATTP1N7GPd2hA==
X-Google-Smtp-Source: APXvYqxnXJjE6XpBiYWXE9n4CqpA5PKI58DdjfVc/8hHp/0MIWMFGqP01x9wpnW3o5Yt5UWsh2lP1g==
X-Received: by 2002:a17:902:7009:: with SMTP id y9mr2032503plk.254.1582860073796;
        Thu, 27 Feb 2020 19:21:13 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q21sm9132715pff.105.2020.02.27.19.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 19:21:13 -0800 (PST)
Date:   Thu, 27 Feb 2020 19:21:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: tsens: Add qcom,tsens-v0_1
 to msm8916.dtsi compatible
Message-ID: <20200228032110.GA210720@yoga>
References: <cover.1582705101.git.amit.kucheria@linaro.org>
 <ab6a982bd9bcbc76262cd9ca5dd6ea10cf45b8a1.1582705101.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6a982bd9bcbc76262cd9ca5dd6ea10cf45b8a1.1582705101.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 Feb 01:31 PST 2020, Amit Kucheria wrote:

$subject should be "arm64: dts: qcom: msm8916: ..."

Apart from that this looks good.

Regards,
Bjorn

> The qcom-tsens binding requires a SoC-specific and a TSENS
> family-specific binding to be specified in the compatible string.
> 
> Since them family-specific binding is not listed in the .dtsi file, we
> see the following warnings in 'make dtbs_check'. Fix them.
> 
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is not valid
> under any of the given schemas (Possible causes of the failure):
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is too short
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
> ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
> ['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 9f31064f2374..1748ea3f4b4f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -860,7 +860,7 @@
>  		};
>  
>  		tsens: thermal-sensor@4a9000 {
> -			compatible = "qcom,msm8916-tsens";
> +			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
>  			reg = <0x4a9000 0x1000>, /* TM */
>  			      <0x4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> -- 
> 2.20.1
> 
