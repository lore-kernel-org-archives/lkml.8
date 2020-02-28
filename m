Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8662824692
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTpcztdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgB1DYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:24:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44492 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbgB1DYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:24:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so941656pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/v7KsyZaSnIQHt4LUxp0DK1a2Lu38EDYZabaVLVetk=;
        b=eTpcztdHQTm5/rDIVIQIhxvItqZKHbqp4cI9mZTTdONiVx8F9HtFEuVvn1jG1sN9n/
         4SrvRPjkf814oGpFtngkhLRb9OmPMwakJjkTERr22C9HsAbrrD4FkhOuL+GrYHrP8nBs
         z7KhCttgvL/kQKAwVpE5ZgWyF2grXLwev9S00BA9I/UuqmzkutEzH0bess2NzdVxCarZ
         42o3bA6puBJJVbN1Q5nS/y6caMe/Vnmd+dALa1VEMt1AfqmotHqc0pMv9a3SKIAUAzmQ
         bnOkoHLEMMkeQYo2WRuSM11EggSJyEJQInx0OVpgjN49XXFCDoheLw3GT5M6pYkadBwW
         Masg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/v7KsyZaSnIQHt4LUxp0DK1a2Lu38EDYZabaVLVetk=;
        b=YDuUYQr8sGwKFXZ9uWnRneKp9iFvM5AEevaASwy0Ri43J05Iedw+x8plQua0mwEYjS
         KB+6fH9FU+5EQPcbUP9cz2kDQcCFqapfamDKFSFLqO4ADrM6flTbmMpxBuQr/JBMcfS9
         XI8a8pdIIHPgyp+cqMY+R6bImukL9hKWwz1NNsot20/L18uFvNfvCSlQPBaU6ftfDkiq
         Om8sbmRyZdzi0F9sWw0zztLXdEPhqDb2KtWRBwDz9pe9JLTd4bgrOIpOwexViV/9w/2n
         QX6BCT2KmFlXAIudS2Fpvoc9VD/o2NEjv8LjMBBWRxvsp3cNSpLBU4+bPLuD7g3bY3wv
         O9Fg==
X-Gm-Message-State: APjAAAWH56N/b3qL1xELs0J6hS9u46MtNgeax4deKCu+s1ZC8yr0wncz
        JpqrGtKb45RmtUnPVlosQLa1Kw==
X-Google-Smtp-Source: APXvYqxcXORPyb7DbvPZYryfw+X2PjFVWDfnTU6OxjUhkfzPetW6eG/5nxsAIrTsbdOAHZeW0urarw==
X-Received: by 2002:a63:df02:: with SMTP id u2mr2341345pgg.403.1582860291347;
        Thu, 27 Feb 2020 19:24:51 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm112165pjj.17.2020.02.27.19.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 19:24:50 -0800 (PST)
Date:   Thu, 27 Feb 2020 19:24:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: thermal: tsens: Add qcom,tsens-v2 to
 msm8996.dtsi compatible
Message-ID: <20200228032448.GB210720@yoga>
References: <cover.1582705101.git.amit.kucheria@linaro.org>
 <4e337c4a4194bb15f9efec67821f38504de1704c.1582705101.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e337c4a4194bb15f9efec67821f38504de1704c.1582705101.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 Feb 01:31 PST 2020, Amit Kucheria wrote:

As with patch 2, $subject should have an appropriate prefix. Please
update this.

Regards,
Bjorn

> The qcom-tsens binding requires a SoC-specific and a TSENS
> family-specific binding to be specified in the compatible string.
> 
> Since them family-specific binding is not listed in the .dtsi file, we
> see the following warnings in 'make dtbs_check'. Fix them.
> 
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is not valid
> under any of the given schemas (Possible causes of the failure):
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is too short
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
> ['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
> ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> 
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is not valid
> under any of the given schemas (Possible causes of the failure):
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is too short
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
> ['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
> thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
> ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 7ae082ea14ea..f157cd4f53b4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -446,7 +446,7 @@
>  		};
>  
>  		tsens0: thermal-sensor@4a9000 {
> -			compatible = "qcom,msm8996-tsens";
> +			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
>  			reg = <0x004a9000 0x1000>, /* TM */
>  			      <0x004a8000 0x1000>; /* SROT */
>  			#qcom,sensors = <13>;
> @@ -457,7 +457,7 @@
>  		};
>  
>  		tsens1: thermal-sensor@4ad000 {
> -			compatible = "qcom,msm8996-tsens";
> +			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
>  			reg = <0x004ad000 0x1000>, /* TM */
>  			      <0x004ac000 0x1000>; /* SROT */
>  			#qcom,sensors = <8>;
> -- 
> 2.20.1
> 
