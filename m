Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3578FC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14ACA206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8egdX65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgEKT2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731416AbgEKT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:28:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B66C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:28:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so4342497plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mmxsKTmzzbLv6+3T1G9FHUh6tg9h/CmFldk9hKJlhm8=;
        b=T8egdX65u6oP3Lu9rCh6tg1hlvtDznfgBRlFiL+LAgjhOHKwiDaKpayHklBvpvm5FY
         8OwuooaZ/rrjIpmUIBACOW5JZ7mc17/9DyMcW2FVmFgqM6kgeZqi3ECob+LrfUbH3AsC
         TQv2oClapf16ImftRlU15/F6HY4Ip6gU83Yo1EsumBsvHYYklNqyZp+sMbZjTxZyPb6Y
         PpwyGka6AjHwY2vbewEqIIP6kl4OLn6fggxETQ+WQaWy74MJu2lHNaPk+GeVbhpaU4zU
         HZkt5mA+GDw39HYmOafQB9ZamJ88gcGhY0Bnu1xzj6caMuDgSedaxfvqN4uxUwolLeR9
         bZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmxsKTmzzbLv6+3T1G9FHUh6tg9h/CmFldk9hKJlhm8=;
        b=svZZ4gLc3oOU3pyW/RgkPsSUCqDNtd4C7F3lpA6jntn/ZgR1CwS/MEZB9Zonqx+zq0
         5cSMPuJ3Ho9Z5IRjj0UQvNNFoZGsv/V2phYGyDt/+SqExougHIOIJbvWQYWCdfCTEGqD
         yJNL++gNhcKeq0Yn01n4OaeTU1u+jcZ/7AQcYC4+g3eiSJ/yjtL+KEw6pLdFkqyPUojt
         GmVF4h+jv1pHofnvN5AwEjRSjdX2EYbSILqffwGvy9LxQaro39RqSfmChmEfM1fJqswX
         B8wbKWTDWs03yo0YH6jXHi8FGgQUqj52BFgp0oYFbGolXbEefjfqxLmYkc4ZF75BeTbW
         fnvQ==
X-Gm-Message-State: AGi0PubHiWZ83CE7/n0YZQSORQ4HQ13wv8q0J3AokMcnXPh1m4F+qL5X
        AI3HFN6WDRGbFY4ZfUqZHzD2oA==
X-Google-Smtp-Source: APiQypILvvBPZ7bf15t3ZrOp+xi4m+cNa1GdeI7W4qsrfWcwPBK7cP1kV7woQcKPUjV8D+rNcXi72w==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr16279880plp.286.1589225317828;
        Mon, 11 May 2020 12:28:37 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y25sm8987977pgc.63.2020.05.11.12.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:28:37 -0700 (PDT)
Date:   Mon, 11 May 2020 12:29:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        ohad@wizery.com, mka@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sc7180: Update Q6V5 MSS node
Message-ID: <20200511192930.GD2166963@builder.lan>
References: <20200421143228.8981-1-sibis@codeaurora.org>
 <20200421143228.8981-8-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421143228.8981-8-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Apr 07:32 PDT 2020, Sibi Sankar wrote:

> Add TCSR node and update MSS node to support MSA based Modem boot on
> SC7180 SoCs.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> V2:
>  * use memory-region to reference mba/mpss regions [Bjorn]
>  * overload the base remoteproc_mpss node wherever possible [Bjorn]
> 
> Depends on the following bindings:
> iommus: https://patchwork.kernel.org/patch/11499603/
> spare-regs: https://patchwork.kernel.org/patch/11491425/
> 
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  7 +++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 28 +++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 5405cde1a32ef..08f1f04cca734 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -309,6 +309,13 @@ &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&remoteproc_mpss {
> +	status = "okay";
> +	compatible = "qcom,sc7180-mss-pil";
> +	iommus = <&apps_smmu 0x460 0x1>, <&apps_smmu 0x444 0x3>;
> +	memory-region = <&mba_mem &mpss_mem>;
> +};
> +
>  &sdhc_1 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 94cead96eade0..5e2618eb1b7fa 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -932,6 +932,11 @@ tcsr_mutex_regs: syscon@1f40000 {
>  			reg = <0 0x01f40000 0 0x40000>;
>  		};
>  
> +		tcsr_regs: syscon@1fc0000 {
> +			compatible = "syscon";
> +			reg = <0 0x01fc0000 0 0x40000>;
> +		};
> +
>  		tlmm: pinctrl@3500000 {
>  			compatible = "qcom,sc7180-pinctrl";
>  			reg = <0 0x03500000 0 0x300000>,
> @@ -1325,7 +1330,8 @@ pinconf-sd-cd {
>  
>  		remoteproc_mpss: remoteproc@4080000 {
>  			compatible = "qcom,sc7180-mpss-pas";
> -			reg = <0 0x04080000 0 0x4040>;
> +			reg = <0 0x04080000 0 0x4040>, <0 0x04180000 0 0x48>;
> +			reg-names = "qdsp6", "rmb";
>  
>  			interrupts-extended = <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
>  					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> @@ -1336,19 +1342,33 @@ remoteproc_mpss: remoteproc@4080000 {
>  			interrupt-names = "wdog", "fatal", "ready", "handover",
>  					  "stop-ack", "shutdown-ack";
>  
> -			clocks = <&rpmhcc RPMH_CXO_CLK>;
> -			clock-names = "xo";
> +			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
> +				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> +				 <&gcc GCC_MSS_NAV_AXI_CLK>,
> +				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
> +				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "bus", "nav", "snoc_axi",
> +				      "mnoc_axi", "xo";
>  
>  			power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
>  					<&rpmhpd SC7180_CX>,
> +					<&rpmhpd SC7180_MX>,
>  					<&rpmhpd SC7180_MSS>;
> -			power-domain-names = "load_state", "cx", "mss";
> +			power-domain-names = "load_state", "cx", "mx", "mss";
>  
>  			memory-region = <&mpss_mem>;
>  
>  			qcom,smem-states = <&modem_smp2p_out 0>;
>  			qcom,smem-state-names = "stop";
>  
> +			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
> +				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
> +			reset-names = "mss_restart", "pdc_reset";
> +
> +			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
> +			qcom,spare-regs = <&tcsr_regs 0xb3e4>;
> +
>  			status = "disabled";
>  
>  			glink-edge {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
