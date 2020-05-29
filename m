Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECFCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C812075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuqUIHqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbgE2DD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390360AbgE2DCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:02:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6FC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:02:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so637432pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dAwCWLS8KNCCm6d/9f1YSwjOl8xYnF9FTA83+5uv/nE=;
        b=LuqUIHqx0kxzduKBCDkwf2McZn1HVH7hh3mhxIHXmglmbEgJKUtO1ZthgPp0gOkX0m
         P8nmCqXKi1qeAzsw/3IwQ76dEBnaYtf4XbHQ3+4SsMzk3Qpt1jzu1+h+RmcHGBAyil7B
         mDE9XApFYMKiQug2hQXbplDdYt9fOvo10FbOWDJ0lzI+owbqFjBvVKkfE3dc3njf2gPe
         kyrf9lg6eJLCWFM3u5Bj5pvHoPxDFB6HjHh+Vt2ZjO3XPQJ5thy1WioZ+Xjs1iGYg6je
         WjUA2FVgvPhsEZ/yTmyzI7M3fvKSEMnE6nPTW704c9KyU8DP3CUQCbjHx1kZWd/rovrh
         CamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dAwCWLS8KNCCm6d/9f1YSwjOl8xYnF9FTA83+5uv/nE=;
        b=mYC8c2MC2Jb+1PiXzSn0T4WWwbLU1Qh+iJTfROneezJN6IbcHa+Spm3i8s+bZKNTnW
         1vWk3Y8eKsNCT+sjIqrgvA/mf2FfOZ8ZkWC8NDT5BRAw+iOhbp2zvgXvZbMdil/+vGNd
         L/0eAZPdZXImTdx9O16ZKtH7scS2pfV+E2/M0oNwcVdaYxpxpbPGBCxLXSa/eAtQn1d/
         0t3qkUT3aqz2x5rLfe4Ypg0SqyZWXQa2GMRJAUeJcmof9kxVFIiVDfAyR2Gt2tAFgjTq
         eyVgrLkNmD0ANXD13AwAggvWsN0Hf1fKqbRvZ94vp499TNcAZtT5eGA0KaA27WE8Jox/
         FIbg==
X-Gm-Message-State: AOAM530tjPpU/SV3BfjUUWZhLAOgcbUPsp0wI+Sn1ScJdy2oI/Au2N6I
        KkJFDt6aHPVhN+Pa8UUhxIE2uUZ5RL4=
X-Google-Smtp-Source: ABdhPJwBhO/+Ty8z7FnOpjylDnlmGng+vNHINF8hhIftqJlHHzIrMLF87ndNsvwwCgzwAU2Ee/BYkQ==
X-Received: by 2002:a63:ec44:: with SMTP id r4mr6186650pgj.11.1590721352143;
        Thu, 28 May 2020 20:02:32 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n10sm5808220pfd.192.2020.05.28.20.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 20:02:31 -0700 (PDT)
Date:   Thu, 28 May 2020 20:01:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: add sm8150 hdk dts
Message-ID: <20200529030126.GW279327@builder.lan>
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200524023815.21789-6-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524023815.21789-6-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 May 19:38 PDT 2020, Jonathan Marek wrote:

> Add initial HDK855 dts, based on sm8150-mtp, with a few changes.
> 

Happy to see this on the list Jonathan, just some minor things on the
remoteproc nodes below.

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 461 ++++++++++++++++++++++++
>  2 files changed, 462 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index cc103f7020fd..e5dbd8b63951 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
[..]
> +/ {
> +	model = "Qualcomm Technologies, Inc. SM8150 HDK";
> +	compatible = "qcom,sm8150-hdk";
> +
> +	aliases {
> +		serial0 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +	};
> +
> +	/*
> +	 * Apparently RPMh does not provide support for PM8150 S4 because it
> +	 * is always-on; model it as a fixed regulator.
> +	 */

One day we should stop being surprised by this and drop the "Apparently"
from this comment ;)

> +	vreg_s4a_1p8: pm8150-s4 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_s4a_1p8";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&vph_pwr>;
> +	};
[..]
> +&remoteproc_adsp {
> +	status = "okay";

It would be nice to see a
	firmware-name = "qcom/sm8150/adsp.mbn";

here. Because if we ever end up pushing firmware to linux-firmware this
DTB would continue to work.

Use https://github.com/andersson/pil-squasher to get mbn files out of
the mdt+bXX files for your testing (or just rename/symlink the mdt to
mbn for now).

> +};
> +
> +&remoteproc_cdsp {
> +	status = "okay";

	firmware-name = "qcom/sm8150/cdsp.mbn";

> +};
> +
> +&remoteproc_slpi {
> +	status = "okay";

	firmware-name = "qcom/sm8150/slpi.mbn";

Regards,
Bjorn

> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <126 4>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&ufs_mem_hc {
> +	status = "okay";
> +
> +	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l10a_2p5>;
> +	vcc-max-microamp = <750000>;
> +	vccq-supply = <&vreg_l9a_1p2>;
> +	vccq-max-microamp = <700000>;
> +	vccq2-supply = <&vreg_s4a_1p8>;
> +	vccq2-max-microamp = <750000>;
> +};
> +
> +&ufs_mem_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vdda_ufs_2ln_core_1>;
> +	vdda-max-microamp = <90200>;
> +	vdda-pll-supply = <&vreg_l3c_1p2>;
> +	vdda-pll-max-microamp = <19000>;
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +	vdda-pll-supply = <&vdd_usb_hs_core>;
> +	vdda33-supply = <&vdda_usb_hs_3p1>;
> +	vdda18-supply = <&vdda_usb_hs_1p8>;
> +};
> +
> +&usb_2_hsphy {
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
> +&usb_2_qmpphy {
> +	status = "okay";
> +	vdda-phy-supply = <&vreg_l3c_1p2>;
> +	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";
> +};
> -- 
> 2.26.1
> 
