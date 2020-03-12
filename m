Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D639C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F99420737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J08u2w/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgCLFDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:03:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45107 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387761AbgCLFDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:03:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so2609942pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 22:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cTgoCb839w9OT0HV/GelOC2bBejqZHZyMGPiFKWTS/E=;
        b=J08u2w/Zf7UGNyiE282O3vgUMkztg53mwZdynLXMMKVUqMuiK2YqTiVvoQDsJgGpv4
         0otKKtN/SiVW3dyVhymAEtPrXh2MyM2WvOZgvkZx/YveoBLedK3g/xxYgIOO2OYrvhck
         rnj/wqIf37KO131R1ABcBYvng6GCMJ2MJTbjfF/n6aX3HwEYOnJRzufsneI6FT0GyzmU
         Uw3u8GvwHjHeoa+cxn9jmbz1veUatAaqfYKpPSbgN2txE7K7CWRB/5h6C4/N76bf8kML
         5682MY5ss5c+KqDKdIX/G1rdkV1HwMBEj3hr1gie1T1MuLRm9pkCVmRHKPShzgKD4gJJ
         uBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTgoCb839w9OT0HV/GelOC2bBejqZHZyMGPiFKWTS/E=;
        b=s7U1c7/obmIxYqi+HhuCbHJZJHviYjlWA34Kh8/MjEIE8aGanhyClrZ0rHblFRElY1
         m2IJFn5DPmpKJROD2+4ehThNBUC1rTGofWVSpBeaqc/NedDRo9kmkxzQqngRhgnhQTD4
         F+0V6Fjbpqlnk3tFaFo3o8SgwXS9pdIxwjpPDQq6aufMPdLyo9T2TmNVubZZ02FXg3JH
         lIq4yiAD9wAnMXJrFTlum82/Q9DwxUq0QPxzSwX1HIeRMO/aRLL4e5u/Bz93uD7s5BmD
         myICdNy9oKbrB2WaisxqSDgzeRclU1o6HGKaHomlpWE2nbHctQzmFj4FN6Qi750pAhaW
         HspQ==
X-Gm-Message-State: ANhLgQ2ZPjtHRXa+QibsTh7FcblSAJVBVSDsfc8KszK3Pq81u3MA8S8N
        a56ehQHKau8KYXH7/yE3yG0YQw==
X-Google-Smtp-Source: ADFU+vs21f/l4jH6Bg1k/SVgcLp8lig2v5uQGw4OkgWvTJTRpScTVWOWhPCZokHdhiZSRONggGreOg==
X-Received: by 2002:a62:e909:: with SMTP id j9mr6407295pfh.134.1583989392797;
        Wed, 11 Mar 2020 22:03:12 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s12sm24253061pgi.38.2020.03.11.22.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 22:03:12 -0700 (PDT)
Date:   Wed, 11 Mar 2020 22:03:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        olof@lixom.net, Anson.Huang@nxp.com, maxime@cerno.tech,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [v1 2/6] arm64: dts: apq8016-sbc: Add CCI/Sensor nodes
Message-ID: <20200312050309.GU264362@yoga>
References: <20200311123501.18202-1-robert.foss@linaro.org>
 <20200311123501.18202-3-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123501.18202-3-robert.foss@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 Mar 05:34 PDT 2020, Robert Foss wrote:

> From: Loic Poulain <loic.poulain@linaro.org>
> 
> Add cci device to msm8916.dtsi.
> Add default 96boards camera node for db410c (apq8016-sbc).
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 75 +++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 037e26b3f8d5..a3e6982f4f93 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -495,6 +495,81 @@
>  		wcnss@a21b000 {
>  			status = "okay";
>  		};
> +
> +		camera_vdddo_1v8: fixedregulator@0 {

While "fixedregulator" is a seemingly good name, you're not allows to
use a unit address on the node if there's no address information in the
node. So you need to give these nodes a non-generic name.


And please move nodes without a reg (i.e. not on an mmio bus) out of
/soc, i.e. place it near /chosen.

> +			compatible = "regulator-fixed";
> +			regulator-name = "camera_vdddo";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		camera_vdda_2v8: fixedregulator@1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "camera_vdda";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-always-on;
> +		};
> +
> +		camera_vddd_1v5: fixedregulator@2 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "camera_vddd";
> +			regulator-min-microvolt = <1500000>;
> +			regulator-max-microvolt = <1500000>;
> +			regulator-always-on;
> +		};
> +
> +		cci@1b0c000 {

Please ensure that cci and camss have labels and reference them by &cci
and &camss below the / {}, sorted by label name.

> +			status = "ok";
> +			i2c-bus@0 {

Please reference this by its label as well.

> +				camera_rear@3b {
> +					compatible = "ovti,ov5640";
> +					reg = <0x3b>;
> +
> +					enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
> +					reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> +					pinctrl-names = "default";
> +					pinctrl-0 = <&camera_rear_default>;
> +
> +					clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
> +					clock-names = "xclk";
> +					clock-frequency = <23880000>;
> +
> +					vdddo-supply = <&camera_vdddo_1v8>;
> +					vdda-supply = <&camera_vdda_2v8>;
> +					vddd-supply = <&camera_vddd_1v5>;
> +
> +					/* No camera mezzanine by default */

This comment gives me the feeling that this node should have been status
disabled, please confirm.

Regards,
Bjorn

> +					status = "okay";
> +
> +					port {
> +						ov5640_ep: endpoint {
> +							clock-lanes = <1>;
> +							data-lanes = <0 2>;
> +							remote-endpoint = <&csiphy0_ep>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
> +		camss@1b00000 {
> +			status = "ok";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {
> +					reg = <0>;
> +					csiphy0_ep: endpoint {
> +						clock-lanes = <1>;
> +						data-lanes = <0 2>;
> +						remote-endpoint = <&ov5640_ep>;
> +						status = "okay";
> +					};
> +				};
> +			};
> +		};
>  	};
>  
>  	usb2513 {
> -- 
> 2.20.1
> 
