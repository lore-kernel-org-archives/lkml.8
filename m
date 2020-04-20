Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A53C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE222084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdfckbbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDTTnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTTnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:43:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D4C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:43:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so4331658pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSI5jaWP14AnIVoCm5Yym8gL3leYasCeNvQ4GTDuwpc=;
        b=fdfckbbL3Y3uWvzDUUyOxIri3i9PeJkVn5ApWa+tEt4PQtc2OS9H8fyfU/z7Z4Jqd1
         wFQF+xUEANETRWIfTPV5zbCQeg3BJ0xB34S0wUT/avm16gdpgQ2v83cPMQWMrugKWTyH
         A8mVI3Z2Gl2Y2OPG3aXMKBmgMceybHBf1p9KoOfrBvShPT8C23qO2gxcq6kow2eb7/Nb
         DHCTChK+LUUjMzVoTSAg12KZqFVvjN/auUJYlKVEiZwj/sEChD3RSDKt1XlqNB6/Wn4a
         POGectpZr2SSXelqOZ1HvmpvaAzG4tOOzwE831Sgz5q0pGIhBSJJzOSQ3nNgKw6m6nz+
         CSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSI5jaWP14AnIVoCm5Yym8gL3leYasCeNvQ4GTDuwpc=;
        b=EnqZKFH1yfTuTvRVSgvTci31WhKoKIxNkcjwZUiSc7x0WvBM6efb75FDnVBQWPAV2i
         YsNR2wtC0obgfzznvRTZf4t6jSDkXMwx0Z46PkewU2DOZuAb1bXVhgvgRtWQc/Yy/pad
         1p5jHw/2vRr/ieWA7IAta0HfzR8698SI78TVgMbLO/wauxJI5ic08TFRU4HFqs39ajUT
         TINMejiNvRJ3gFKChQC2lIZqZ+p5SJ1dqwyvy6zT/YpCgsbfwgFDhoeSc6qBkh1Cq9/U
         qDJKeAMOkAbozzjGDcedmoXcGTyV3Rk4g94jK2ofaHvs/ttIeBn6zWASrszbTelAIDCn
         lzAQ==
X-Gm-Message-State: AGi0PuZvvjcbzrwdRfESCdXmxXCls6OMFy1yxEia6ZghI8kMGq4dugl/
        e+x/1LX9CHdgXXic8iXjOh+GtQ==
X-Google-Smtp-Source: APiQypKrQXVRMSn0gc3hbu3DCD9d+ihrNQzBeB13kvI3v5YoT7hBI1RfU8/Jxkt5h4VR7OZ5cNVEGA==
X-Received: by 2002:a17:90a:fb89:: with SMTP id cp9mr1169242pjb.40.1587411816359;
        Mon, 20 Apr 2020 12:43:36 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 185sm300063pfv.9.2020.04.20.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:43:35 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:43:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: fix pm8150 gpio interrupts
Message-ID: <20200420194359.GP576963@builder.lan>
References: <20200420153543.14512-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420153543.14512-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 Apr 08:35 PDT 2020, Jonathan Marek wrote:

> This was mistakenly copied from the downstream dts, however the upstream
> driver works differently.
> 
> I only tested this with the pm8150_gpios node (used with volume button),
> but the 2 others should be the same.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Applied, thanks Jonathan

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pm8150.dtsi  | 14 ++------------
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi | 14 ++------------
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi | 14 ++------------
>  3 files changed, 6 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> index b6e304748a57..c0b197458665 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> @@ -73,18 +73,8 @@ pm8150_gpios: gpio@c000 {
>  			reg = <0xc000>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -			interrupts = <0x0 0xc0 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc1 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc2 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc3 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc4 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc5 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc6 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc7 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc8 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xc9 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xca 0x0 IRQ_TYPE_NONE>,
> -				     <0x0 0xcb 0x0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> index 322379d5c31f..40b5d75a4a1d 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> @@ -62,18 +62,8 @@ pm8150b_gpios: gpio@c000 {
>  			reg = <0xc000>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -			interrupts = <0x2 0xc0 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc1 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc2 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc3 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc4 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc5 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc6 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc7 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc8 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xc9 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xca 0x0 IRQ_TYPE_NONE>,
> -				     <0x2 0xcb 0x0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> index eb0e9a090e42..cf05e0685d10 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> @@ -56,18 +56,8 @@ pm8150l_gpios: gpio@c000 {
>  			reg = <0xc000>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -			interrupts = <0x4 0xc0 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc1 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc2 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc3 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc4 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc5 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc6 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc7 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc8 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xc9 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xca 0x0 IRQ_TYPE_NONE>,
> -				     <0x4 0xcb 0x0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  	};
>  
> -- 
> 2.26.1
> 
