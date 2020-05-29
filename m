Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F17C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB0020721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+UD8cB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437134AbgE2Dic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436976AbgE2Di0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:38:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C380C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:38:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z26so540826pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z9BbpaHftEYOfSKkAeYVmvTLi489Ag0O3FoWtU4xRcw=;
        b=F+UD8cB7lM1BCzDAYfWIOB+m5h+gyvKbnhv+2q8remKC0o9nvM5eRE5Jt3OFMFMLV0
         JRssSwRuyN/tItGKfzVbgCtQ1HwzotxzON3rWnUvbERFWhl/cT12x11bn/epQunWI/Wk
         h95uwFVkPOYf1bG3wNcg6PtDRF/34XY4l80VyZm+6sOGySwqf7qMtsxth3JCjXOia9sk
         yCCVegVucqVdq+kS4jkSkHTjeqf2xH29JH9I5SKAuVs6UfhNohf7yxgwao2s8TwwXJPb
         9D7Dq6C64/eOqJcfg4dUyu+by9PIkNARGMuXXfM9yiBuFNyu7lDlf/oCtvQHVQiTVUj8
         xO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9BbpaHftEYOfSKkAeYVmvTLi489Ag0O3FoWtU4xRcw=;
        b=JYDYRJx4iS0yLFSHbf8/xg+bNUlhhfL1c6FHV/TFYXA/G2nLa5xylKMv/Tye7kp0r2
         Sq4M/Au2sBRZa5a1E2r0WQSlGt8XXqYIiU64Tl2mBofz+BP7O+5SMzthkGyvhW27KAYx
         jrNi3jSHbERvAU7vnGPZclTIaeFfxOTuE41ESwDnasFooT0UKfxZ7/f2y9oLoBWpnxpW
         ZFA7RXk9rm5/XvvS6W/zU6DcGBmUxaZyY06/bZkjx50DFIj+kGSdIsWqihtsVhl0Qgzb
         CrckVNufMwECwWCnPwOXV60WE2tpesZ2YGBg1nr4d/DLbVgVZGVhFxsGXTiGFViwc1Uv
         44Cw==
X-Gm-Message-State: AOAM530tuTkCp4uxFBPvxZkqUw4Ia/IcRbUWeM+5SDG5AbLhviKIEQr9
        LqV5EMCHJGbUgUAx8qxmUrsmYA==
X-Google-Smtp-Source: ABdhPJxALynRZEP+jDZeuuLf03vv374ORmzHtEIE2UtnZ5zj47kJkFl1/PLRZi+nP2KzCeCp8oLgoA==
X-Received: by 2002:a63:7353:: with SMTP id d19mr6532319pgn.239.1590723505907;
        Thu, 28 May 2020 20:38:25 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g65sm1943781pfb.61.2020.05.28.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 20:38:25 -0700 (PDT)
Date:   Thu, 28 May 2020 20:37:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: sort nodes by physical address
Message-ID: <20200529033720.GE279327@builder.lan>
References: <20200523132223.31108-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523132223.31108-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 May 06:22 PDT 2020, Jonathan Marek wrote:

> Other dts have nodes sorted by physical address, be consistent with that.
> 

This didn't apply cleanly, because we haven't yet migrated the hwlock to
the yet to be approved binding and I don't have a usb node.

I resolved it and applied the patch.

Thanks,
Bjorn

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 176 +++++++++++++--------------
>  1 file changed, 88 insertions(+), 88 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a273b99bf1e6..bc8a14df60e5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -379,6 +379,12 @@ ufs_mem_phy_lanes: lanes@1d87400 {
>  			};
>  		};
>  
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x01f40000 0x0 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
>  		usb_1_hsphy: phy@88e3000 {
>  			compatible = "qcom,sm8250-usb-hs-phy",
>  				     "qcom,usb-snps-hs-7nm-phy";
> @@ -559,15 +565,6 @@ usb_2_dwc3: dwc3@a800000 {
>  			};
>  		};
>  
> -		intc: interrupt-controller@17a00000 {
> -			compatible = "arm,gic-v3";
> -			#interrupt-cells = <3>;
> -			interrupt-controller;
> -			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> -			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> -			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sm8250-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
> @@ -596,85 +593,6 @@ spmi_bus: qcom,spmi@c440000 {
>  			#interrupt-cells = <4>;
>  		};
>  
> -		apps_rsc: rsc@18200000 {
> -			label = "apps_rsc";
> -			compatible = "qcom,rpmh-rsc";
> -			reg = <0x0 0x18200000 0x0 0x10000>,
> -				<0x0 0x18210000 0x0 0x10000>,
> -				<0x0 0x18220000 0x0 0x10000>;
> -			reg-names = "drv-0", "drv-1", "drv-2";
> -			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> -			qcom,tcs-offset = <0xd00>;
> -			qcom,drv-id = <2>;
> -			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
> -					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
> -
> -			rpmhcc: clock-controller {
> -				compatible = "qcom,sm8250-rpmh-clk";
> -				#clock-cells = <1>;
> -				clock-names = "xo";
> -				clocks = <&xo_board>;
> -			};
> -
> -			rpmhpd: power-controller {
> -				compatible = "qcom,sm8250-rpmhpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmhpd_opp_table>;
> -
> -				rpmhpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmhpd_opp_ret: opp1 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> -					};
> -
> -					rpmhpd_opp_min_svs: opp2 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> -					};
> -
> -					rpmhpd_opp_low_svs: opp3 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> -					};
> -
> -					rpmhpd_opp_svs: opp4 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> -					};
> -
> -					rpmhpd_opp_svs_l1: opp5 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> -					};
> -
> -					rpmhpd_opp_nom: opp6 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> -					};
> -
> -					rpmhpd_opp_nom_l1: opp7 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> -					};
> -
> -					rpmhpd_opp_nom_l2: opp8 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> -					};
> -
> -					rpmhpd_opp_turbo: opp9 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> -					};
> -
> -					rpmhpd_opp_turbo_l1: opp10 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> -					};
> -				};
> -			};
> -		};
> -
> -		tcsr_mutex: hwlock@1f40000 {
> -			compatible = "qcom,tcsr-mutex";
> -			reg = <0x0 0x01f40000 0x0 0x40000>;
> -			#hwlock-cells = <1>;
> -		};
> -
>  		tlmm: pinctrl@f100000 {
>  			compatible = "qcom,sm8250-pinctrl";
>  			reg = <0 0x0f100000 0 0x300000>,
> @@ -690,6 +608,15 @@ tlmm: pinctrl@f100000 {
>  			wakeup-parent = <&pdc>;
>  		};
>  
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		timer@17c20000 {
>  			#address-cells = <2>;
>  			#size-cells = <2>;
> @@ -749,6 +676,79 @@ frame@17c2d000 {
>  			};
>  		};
>  
> +		apps_rsc: rsc@18200000 {
> +			label = "apps_rsc";
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x0 0x18200000 0x0 0x10000>,
> +				<0x0 0x18210000 0x0 0x10000>,
> +				<0x0 0x18220000 0x0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
> +					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sm8250-rpmh-clk";
> +				#clock-cells = <1>;
> +				clock-names = "xo";
> +				clocks = <&xo_board>;
> +			};
> +
> +			rpmhpd: power-controller {
> +				compatible = "qcom,sm8250-rpmhpd";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmhpd_opp_table>;
> +
> +				rpmhpd_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					rpmhpd_opp_ret: opp1 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> +					};
> +
> +					rpmhpd_opp_min_svs: opp2 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +					};
> +
> +					rpmhpd_opp_low_svs: opp3 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs: opp4 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs_l1: opp5 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					};
> +
> +					rpmhpd_opp_nom: opp6 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					};
> +
> +					rpmhpd_opp_nom_l1: opp7 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					};
> +
> +					rpmhpd_opp_nom_l2: opp8 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> +					};
> +
> +					rpmhpd_opp_turbo: opp9 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					};
> +
> +					rpmhpd_opp_turbo_l1: opp10 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					};
> +				};
> +			};
> +		};
> +
>  		cpufreq_hw: cpufreq@18591000 {
>  			compatible = "qcom,cpufreq-hw";
>  			reg = <0 0x18591000 0 0x1000>,
> -- 
> 2.26.1
> 
