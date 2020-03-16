Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB3AC5ACC0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCCA20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XC8IduI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbgCPWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:24:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41401 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732803AbgCPWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:24:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so10733568pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6ndrgmuuUAK5hm/H1dB1OftgnRfJrkMSYT9SqSBgeY=;
        b=XC8IduI7Qw2chs8n9iX1udLK76soadPPYfOj5pT6m32Lky/hcl4mXMOOjJ5ejzCj6F
         X5W8aqnGHOH3NaMiJilSYvpbXSGc7oeMqFaJ5km7dfHfd/AgiHHqC8oy3zsRaHrz3iOq
         lPaDfLoWJ6FCa6gKc5ZofMiLejGKUcYmSHL2rE4roXOBCwRK8F/LGhzl3qoSN+pDY4jX
         n3RX+rkikUlto1hoDROgM+52I9vyYMJ0zALLRfs6dNzbCnQBBhCbzqjYgNJIg6DO4Jkr
         ieesMHwQ1NCzUPqi9Mw0OLYfZjjfoqrIMaOGLtARMw6NdER7hayZyWpsZL6Vo6UeicSZ
         2FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6ndrgmuuUAK5hm/H1dB1OftgnRfJrkMSYT9SqSBgeY=;
        b=BvWDhomGyAadvpXIPojtRXuTwHxfjSpYSQYx2EBhhuzirovSgnY1TDmDfzmZNtJ8zd
         D5NIy+Co7Vsj4C0vxP0uObsiGu75v4kGdUUzp/tBWs7iF5rgXOrQdRItqYRzwWbD2VBO
         YVk4YvSZ740JLDhZ2AwNhJdVVIwlRc1O8wsKWcFlXk9I+FFEXx8HrnIvaA7mhJB5qEW5
         pehSE7sDzUM2EJciA8tNfL0UGmnNLjuHcqxPiyS9v6tSrQ8CuayLhgDIQ2TxiHyHyTv7
         Y+ViCl2BuisJ1oQYeGkaoF9LW8jzb8gXqR3QdMNMKNDNNDYJNRRJnSylsuHgD5yQ8SV9
         nJkQ==
X-Gm-Message-State: ANhLgQ3Zb3mWBS2x0PjaPt/zKtMXIeoMm1q2nRBJ1ttIo8YC3Lp7mNcm
        2MgmpL6ulwwskVKLwZLSFFEwfQ==
X-Google-Smtp-Source: ADFU+vsI49Wtpc8Ne96NqWJvZPgisxl0b8Xy2y4OI14OhOSDawWlTsg2AQnxFU3ehRAdrInZ4dJJtg==
X-Received: by 2002:aa7:824e:: with SMTP id e14mr1974560pfn.18.1584397477087;
        Mon, 16 Mar 2020 15:24:37 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y143sm863538pfb.22.2020.03.16.15.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 15:24:36 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:24:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8150: Add USB and PHY device
 nodes
Message-ID: <20200316222434.GB1135@builder>
References: <1584172319-24843-1-git-send-email-wcheng@codeaurora.org>
 <1584172319-24843-4-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584172319-24843-4-git-send-email-wcheng@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14 Mar 00:51 PDT 2020, Wesley Cheng wrote:

> From: Jack Pham <jackp@codeaurora.org>
> 
> Add device nodes for the USB3 controller, QMP SS PHY and
> SNPS HS PHY.
> 
> Signed-off-by: Jack Pham <jackp@codeaurora.org>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 17 ++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 92 +++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> index 8ab1661..edf0abc 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> @@ -408,3 +408,20 @@
>  	vdda-pll-supply = <&vreg_l3c_1p2>;
>  	vdda-pll-max-microamp = <19000>;
>  };
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +	vdda-pll-supply = <&vdd_usb_hs_core>;
> +	vdda33-supply = <&vdda_usb_hs_3p1>;
> +	vdda18-supply = <&vdda_usb_hs_1p8>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +	vdda-phy-supply = <&vreg_l3c_1p2>;
> +	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 141c21d..cf58fb7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -855,6 +855,98 @@
>  
>  			#freq-domain-cells = <1>;
>  		};
> +
> +		usb_1_hsphy: phy@88e2000 {

Please sort these nodes by address, i.e. this should come right after
the cdsp remoteproc node.


Apart from that this looks good, thank you!

Regards,
Bjorn

> +			compatible = "qcom,usb-snps-hs-7nm-phy",
> +							"qcom,sm8150-usb-hs-phy";
> +			reg = <0 0x088e2000 0 0x400>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		};
> +
> +		usb_1_qmpphy: phy@88e9000 {
> +			compatible = "qcom,sm8150-qmp-usb3-phy";
> +			reg = <0 0x088e9000 0 0x18c>,
> +			      <0 0x088e8000 0 0x10>;
> +			reg-names = "reg-base", "dp_com";
> +			status = "disabled";
> +			#clock-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
> +
> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +
> +			usb_1_ssphy: lanes@88e9200 {
> +				reg = <0 0x088e9200 0 0x200>,
> +				      <0 0x088e9400 0 0x200>,
> +				      <0 0x088e9c00 0 0x218>,
> +				      <0 0x088e9600 0 0x200>,
> +				      <0 0x088e9800 0 0x200>,
> +				      <0 0x088e9a00 0 0x100>;
> +				#phy-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
> +		usb_1: usb@a6f8800 {
> +			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
> +			reg = <0 0x0a6f8800 0 0x400>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			dma-ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +				      "sleep", "xo";
> +
> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <150000000>;
> +
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq", "ss_phy_irq",
> +					  "dm_hs_phy_irq", "dp_hs_phy_irq";
> +
> +			power-domains = <&gcc USB30_PRIM_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
> +
> +			usb_1_dwc3: dwc3@a600000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a600000 0 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
>  	};
>  
>  	timer {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
