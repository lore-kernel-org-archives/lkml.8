Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3301AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103C22078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XP93cqMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbgFWXUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387640AbgFWXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:20:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF7C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:20:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so145674pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJWrPqXiKSvVRXY+O6NmCxilW6Zjk7UQsDwvGe1vVXE=;
        b=XP93cqMp7EC32h6pKRi6o9Tg1mtfwuL+AFHq256Zt8AD25QuBDQHx6avb0a4Haak28
         7RiBB28E4iWF4xi4cHYqNCmcVoOUcJv37plN2nY4E4igjWXbkAdU0xtaV0sfmU64K6VA
         +yDj0lucR2REPFLu2J3FrYQ9qvTVM0oF9uEzsb8GHoXDNar9EMgae08WsFLrBd1/2P9C
         0/oUsYAkoGYkmXrbXpQZUN2eC2KuKAcUH9DX43+HvY6A0Pn5iGza5ZDH5oMMD7MEWKRQ
         OJ/UrpbW04RSi8HchlSNVm7Ua5HgIRt/q1dICdYLYnuca9xQ/Gxl0DfiEm7bUIAzwvW5
         10kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJWrPqXiKSvVRXY+O6NmCxilW6Zjk7UQsDwvGe1vVXE=;
        b=HUBdMx0i/GrLb5wCrcOXhTCD/pNk/FDMP2Eqxm+Wni6Fmk3ITiUAO/RpgcW+6ZuaWn
         n29Edp3O+ajR052J1li5ge6pnsXPIwssJXpO9huKUM4Z0yUvnVOEo/p7W4ubyoFM5Ze3
         3V60GWX12WJlhi1GpmlAaCQyU3JwUT/KNBlfV7gblVzICiWYqS03dcJcjNQ+EA+s0tZx
         d7qMPUabLRCAGc1STxHqAY4Pm0hDw1Nb1uq1DEpdW3yqsJVPyrzdXaGYNm9xNoYlIL9y
         KRhb8gWH4kwxKk8zLJu96jOthvU/55bp/1pudR4+C1omk2E0WpIuk4AHJMvAuY5/1BJy
         bHrw==
X-Gm-Message-State: AOAM531tGgg5ASMVDhLTrOzPfasU/OPVXuM/fN3AqS84sU0J/FjXfeW+
        fGyJdE36Qy9k+MMLAM6TAzDMKQ==
X-Google-Smtp-Source: ABdhPJzYDJAy69PCfY/P4wslj30q22sq0MjOBfSqvu9Yjco0+o9qUrDiz5fTWQ+l9yC2hoYVgSd+Qw==
X-Received: by 2002:a17:90a:8c96:: with SMTP id b22mr27019625pjo.88.1592954434875;
        Tue, 23 Jun 2020 16:20:34 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 7sm4666769pgh.80.2020.06.23.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:20:34 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:17:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] arm64: dts: qcom: msm8994: Add SDHCI1 node
Message-ID: <20200623231751.GK128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-6-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623224813.297077-6-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 15:48 PDT 2020, Konrad Dybcio wrote:

> Enable support for SDHCI on msm8994-based devices.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Fixed up the indentations and applied the patch, thanks.

> ---
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index a4edc3be7024..f989530ffa90 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -334,6 +334,31 @@ frame@f9028000 {
>  			};
>  		};
>  
> +		sdhc1: sdhci@f9824900 {
> +			compatible = "qcom,sdhci-msm-v4";
> +			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
> +			reg-names = "hc_mem", "core_mem";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> +				<&gcc GCC_SDCC1_AHB_CLK>,
> +				<&xo_board>;
> +			clock-names = "core", "iface", "xo";
> +
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on
> +							&sdc1_rclk_on>;
> +			pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off
> +							&sdc1_rclk_off>;
> +
> +			bus-width = <8>;
> +			non-removable;
> +			status = "disabled";
> +		};
> +
>  		blsp1_uart2: serial@f991e000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0xf991e000 0x1000>;
> -- 
> 2.27.0
> 
