Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBF9C3B1BD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED7A24673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fiI9CoPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgBNStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:49:41 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36347 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgBNStk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:49:40 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so4289181pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z9X+mnbPdiAT3gi0kBtvocX45hqfGLXwGRWm7XiWrUQ=;
        b=fiI9CoPovHs74fmaFmlOCZw+PBp/qyX6P9JdrzpnP5akcLRhqwvvQHZCkXeNg27/P9
         B0OGzoMmcNxWD9DcINrkF7JnQM4nNUjE/5vVWFOQskW4tj4YgXhlcvetn50Uw0hx+GBL
         mdFjE0+85VM45BpsczLNE11gS4Gl5UCjOmCAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9X+mnbPdiAT3gi0kBtvocX45hqfGLXwGRWm7XiWrUQ=;
        b=t9NcqfurKYXscGWAPWPaC4L/YHrpZlTUxbVXL30x8vlPAWBMtrNfmUHC9JmSYiJY6L
         IURDrkOMw8WgY/91btvSQJavgIraLwQlTuiBk9YE4TrI2EhBZW7uFtwApWEsBxQeb4ki
         Jee5pUhoRXhKrnxJjQ163vrff31PDz3+KfY4uTn3GnBC0AnxZDgwjZYItWS6sL00v96h
         q8xI34kRFWPIMFtaFqtkrHo2i0SiGEuddfqCYtYTigpdOp6wzz/xZTeBURHalvbGahOt
         wIJLg7kwwN3tk1YA01QlZI5oXpMAhEmIunsFuEHbQ1XFW6fS3X/La6SzqHPwkNWVmeA7
         b/KQ==
X-Gm-Message-State: APjAAAXckar3LatpdzuMvyJsqVPv1NeFcY4NFhsJCbz2rbO2WpV+Qf36
        xYgGpRgoHq9hlQc5tTaMfVt4Aw==
X-Google-Smtp-Source: APXvYqynq99jlrl1qDm8z7d+FI9VC6ZSrWYeVFxihmLzWem1+jdU3ObIhzmt20oiM2H6je9jvHluKg==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr4611111plt.221.1581706179645;
        Fri, 14 Feb 2020 10:49:39 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h3sm7530961pfo.102.2020.02.14.10.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 10:49:38 -0800 (PST)
Date:   Fri, 14 Feb 2020 10:49:37 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harigovindan P <harigovi@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
Subject: Re: [v2] arm64: dts: sc7180: add dsi controller and phy entries for
 idp dts
Message-ID: <20200214184937.GA15781@google.com>
References: <20200211113735.6840-1-harigovi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211113735.6840-1-harigovi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:07:35PM +0530, Harigovindan P wrote:

> subject: arm64: dts: sc7180: add dsi controller and phy entries for idp dts

nit: 'dts' at the end is redundant, the prefixes make it clear that this
is about DT entries.

Also the message isn't really concise. The main entries for the DSI
controller and the PHY are in sc7180.dtsi. I would suggest to drop
any mentions of DSI controller and PHYs, and just say something like
'Add nodes for IDP display'. In the body you could mention that the
display is the Visionox RM69299.

> Adding dsi controller and phy entries for idp dt.
> 
> Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
> ---
> 
> Changes in v1:
> 	- Added dsi controller and dsi phy entries for idp dts

Changes in v1 is pointless, it's the first patch

> Changes in v2:
> 	- Adding dependency patchwork series
> 	- Removing suspend configuration
> 	- Adding blank before curly brace
> 
> This patch depends on following patchwork series:
> 
> https://patchwork.kernel.org/patch/11364687/
> https://patchwork.kernel.org/patch/11366303/
> 
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 55 +++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 388f50ad4fde..6ccf8c3603ab 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -7,6 +7,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7180.dtsi"
>  #include "pm6150.dtsi"
> @@ -232,6 +233,49 @@ vreg_bob: bob {
>  	};
>  };
>  
> +&dsi0 {
> +	status = "okay";
> +
> +	vdda-supply = <&vreg_l3c_1p2>;
> +
> +	panel@0 {
> +		compatible = "visionox,rm69299-1080p-display";
> +		reg = <0>;
> +
> +		vdda-supply = <&vreg_l8c_1p8>;
> +		vdd3p3-supply = <&vreg_l18a_2p8>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&disp_pins>;
> +
> +		reset-gpios = <&pm6150l_gpio 3 GPIO_ACTIVE_HIGH>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				panel0_in: endpoint {
> +					remote-endpoint = <&dsi0_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port@1 {
> +			endpoint {
> +				remote-endpoint = <&panel0_in>;
> +				data-lanes = <0 1 2 3>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi_phy {
> +	status = "okay";
> +};
> +
>  &qspi {
>  	status = "okay";
>  	pinctrl-names = "default";
> @@ -289,6 +333,17 @@ &usb_1_qmpphy {
>  
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
> +&pm6150l_gpio {
> +	disp_pins: disp-pins {
> +		pins = "gpio3";
> +		function = "func1";
> +		qcom,drive-strength = <2>;
> +		power-source = <0>;
> +		bias-disable;
> +		output-low;
> +	};
> +};
> +
>  &qspi_clk {
>  	pinconf {
>  		pins = "gpio63";

To get the display actually to work you also need this:

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 88919da1510b03..fdbcb56dfa81f9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -276,6 +276,14 @@
        status = "okay";
 };

+&mdp {
+       status = "okay";
+};
+
+&mdss {
+       status = "okay";
+};
+
 &qspi {
        status = "okay";
        pinctrl-names = "default";

Maybe just add this to this patch?
