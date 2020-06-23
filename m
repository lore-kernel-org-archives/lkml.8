Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED067C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C326A2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGl6N2G5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbgFWCyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbgFWCyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:54:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3307C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:54:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r18so9173145pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQ3SCOG8CEWcdo/tXLcomxA+Sv9DPM6c0TLHTvFTydo=;
        b=pGl6N2G5ObJ6Flfwwb/LTlhcADw8HqeYPMPuDoiqlKFA00zySbJ+jVN0WUI2oK/9wp
         i0U3Hw9lPj95YKs2ZnSpnLyiVg4XcJHZtNF+C4BzXk+2rBH9UPPu0ZjDxBW5s5Crz/IE
         vjFgJxJMtUOD6xJh/+3PFbOW+LGi+N9lnp4yBRxMCJ7Nn2JZ3IT3f1gmjv3axxe6CqCe
         EUJDaYHufbOYowmLLdm7QgQbw9RVN7Vg+mtxIGO8vLAyiK+ht8FyK3TwN2IT3IWAF640
         3hYrR7VxT+gII/F6wHtBK6GhbJuCFg6NnNEMfI2IeL6/VzfOmNPVATRTS4RNSgP8q8H6
         /4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQ3SCOG8CEWcdo/tXLcomxA+Sv9DPM6c0TLHTvFTydo=;
        b=HnjSc5EkkOoNPmRQFWI7DtYLeD6qJsU5xauqa6J4/8/qHgikqYU9uKV+5HwnWkpw0A
         Bo/or+83Mj+3FeRwGjJx/esFufMirnOKxxHHeP2uGfk3uBvdmr+RldwuXKNW4RZvGe5m
         bWncum/9+2V5VHVH5IeER0AGvDeULGQxjTRk6kZFw0n/iHBPVz4iq4kBENd572OsRI5I
         PbtYEgIfdiBH5k2P+BUB9kuC2G2t3CBa+Vg7PsjelOahwzp421McN3uazlVTTSh7D/Ey
         BIihIeVkDnKgKEs+j9gnkLetXlkPAXg3YP9mDZp6WHw3o4dl0iHDA5IaTJc8/GwUFxEG
         asBg==
X-Gm-Message-State: AOAM530jsWkOlC2ZSTPN3HoJie+G4R3M97A5uNABYMKiRcDoZTxa33C0
        4b5Gz9iSBsJH3/KayXX7L/gG
X-Google-Smtp-Source: ABdhPJxohB33RWsPvmL6Y1OqwR64gc0rQ3g/GBld84r8b4FKj1LxmOejpV4ZoFtUuLS26GdmYNvhIw==
X-Received: by 2002:a62:1c46:: with SMTP id c67mr22439884pfc.170.1592880856068;
        Mon, 22 Jun 2020 19:54:16 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:609d:7d26:e4ff:f0b0:edd6:2484])
        by smtp.gmail.com with ESMTPSA id i20sm15589173pfd.81.2020.06.22.19.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 19:54:15 -0700 (PDT)
Date:   Tue, 23 Jun 2020 08:24:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250: Add remoteprocs
Message-ID: <20200623025407.GE11093@Mani-XPS-13-9360>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
 <20200622222747.717306-6-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622222747.717306-6-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:27:46PM -0700, Bjorn Andersson wrote:
> Add remoteproc nodes for the audio, compute and sensor cores, define
> glink for each one and enable them on the MTP with appropriate firmware
> defined.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts |  15 +++
>  arch/arm64/boot/dts/qcom/sm8250.dtsi    | 116 ++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index 63d259931c4d..6894f8490dae 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -55,6 +55,11 @@ vreg_s6c_0p88: smpc6-regulator {
>  	};
>  };
>  
> +&adsp {
> +	status = "okay";
> +	firmware-name = "qcom/sm8250/adsp.mbn";
> +};
> +
>  &apps_rsc {
>  	pm8150-rpmh-regulators {
>  		compatible = "qcom,pm8150-rpmh-regulators";
> @@ -348,10 +353,20 @@ vreg_l7f_1p8: ldo7 {
>  	};
>  };
>  
> +&cdsp {
> +	status = "okay";
> +	firmware-name = "qcom/sm8250/cdsp.mbn";
> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&slpi {
> +	status = "okay";
> +	firmware-name = "qcom/sm8250/slpi.mbn";
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <28 4>, <40 4>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 364d9a798673..a21299b9c62f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -1052,6 +1052,83 @@ tcsr_mutex_regs: syscon@1f40000 {
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
>  		};
>  
> +		slpi: remoteproc@5c00000 {
> +			compatible = "qcom,sm8250-slpi-pas";
> +			reg = <0 0x05c00000 0 0x4000>;
> +
> +			interrupts-extended = <&pdc 9 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&smp2p_slpi_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_slpi_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_slpi_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_slpi_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_LS_SLPI>,
> +					<&rpmhpd SM8250_LCX>,
> +					<&rpmhpd SM8250_LMX>;
> +			power-domain-names = "load_state", "lcx", "lmx";
> +
> +			memory-region = <&slpi_mem>;
> +
> +			qcom,smem-states = <&smp2p_slpi_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_SLPI
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_SLPI
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "lpass";
> +				qcom,remote-pid = <3>;
> +			};
> +		};
> +
> +		cdsp: remoteproc@8300000 {
> +			compatible = "qcom,sm8250-cdsp-pas";
> +			reg = <0 0x08300000 0 0x10000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_LS_CDSP>,
> +					<&rpmhpd SM8250_CX>;
> +			power-domain-names = "load_state", "cx";
> +
> +			memory-region = <&cdsp_mem>;
> +
> +			qcom,smem-states = <&smp2p_cdsp_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_CDSP
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "lpass";
> +				qcom,remote-pid = <5>;
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sm8250-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
> @@ -1668,6 +1745,45 @@ config {
>  			};
>  		};
>  
> +		adsp: remoteproc@17300000 {
> +			compatible = "qcom,sm8250-adsp-pas";
> +			reg = <0 0x17300000 0 0x100>;
> +
> +			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_LS_LPASS>,
> +					<&rpmhpd SM8250_LCX>,
> +					<&rpmhpd SM8250_LMX>;
> +			power-domain-names = "load_state", "lcx", "lmx";
> +
> +			memory-region = <&adsp_mem>;
> +
> +			qcom,smem-states = <&smp2p_adsp_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_LPASS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "lpass";
> +				qcom,remote-pid = <2>;
> +			};
> +		};
> +
>  		intc: interrupt-controller@17a00000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
> -- 
> 2.26.2
> 
