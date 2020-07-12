Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E5C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1045220702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LddmON61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgGLRaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgGLRav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:30:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0CFC08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:30:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so4948155pge.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b52O4yZ4WWPWMkyXBM0Cslv57iFmmN2CyMy2jQ7ZsD4=;
        b=LddmON61RT0OdXk1RGnQPzfQO3pv4v5Wwkx2pNa9zsjn5G4NMYYzYZGctAnheyT3Es
         nJ9eJ7KNvbkIojJI0FgFthDaRzLms+UOCTLjDgpwblskqxvcdNjzqdFZZR9LKAV215eK
         N7eCxBpG0bBZijbqqy5REpfXLtF/db+kIFlLAye2BEvnAeRa1ENaAJNzui+aJJwcWlVt
         8ZHbphqmfa2Tzcnt8phzt3rL0Cv8FzF1xnvntAB/NfRaRi15g15vYDQqV0VtjlR/mLhI
         q04wSQz22HsLDjiKHvGZASF/D3A2Ez53JSp4BED0DeK8RPRpz6xrhKkBMNqduSxGPD2L
         Vt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b52O4yZ4WWPWMkyXBM0Cslv57iFmmN2CyMy2jQ7ZsD4=;
        b=Ac9uShAfiI+fa1rzpIjBb+zAN6unp6l/XKszd7VB8Tjc89QT2AB6lmkVJ6goB0noHw
         wlZ1SFjw/+xrXBwHqYGXGufu83X5WK7EAzFWaGFKXnq2Cwga9CFuHUamI2+aJ9m2xMbQ
         1GJrNLP38740KuPcoiI+F5juA5IkEnc7K4Jy6wI2eursE/92Cg6OKTh/Bo8J5GPlyeGg
         VW3dDS4p3OtQMSAg/faL3sxHSOadVJg3dZ50unNSdDEfiOH5+XUmyxePXj4mnMXt1Igf
         FGQ/4SlZtoNG8bbmlSb71xxc19BlFn0vKd3JIPMWe0Ge12o2DHTDXUprg4oli1OiTL+H
         /B4Q==
X-Gm-Message-State: AOAM530IybDE34SmVF0e70j89Zh1KtUQJJTDX0MZUzovW6YNlljaPW4L
        vKhNJSEHuWG7Ws6nAMzhO2Zv
X-Google-Smtp-Source: ABdhPJz6AvDaMsE8b5SEDGKeF6F6u6F07neWNGvaeWp2nmNpKLu88W56zKF5hvMLBOUhvZ6s+yuw7A==
X-Received: by 2002:a63:1548:: with SMTP id 8mr40566225pgv.172.1594575051183;
        Sun, 12 Jul 2020 10:30:51 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id n9sm11734571pjo.53.2020.07.12.10.30.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:30:50 -0700 (PDT)
Date:   Sun, 12 Jul 2020 23:00:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 10/10] arm64: dts: actions: Add uSD support for
 Cubieboard7
Message-ID: <20200712173044.GL6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-11-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-11-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:56PM +0530, Amit Singh Tomar wrote:
> This commit adds uSD support for Cubieboard7 board based on Actions Semi
> S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
> added yet, fixed regulator has been used as a regulator node.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since v4:
> 	* No change.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * No change.
> ---
>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 41 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 63e375cd9eb4..ec117eb12f3a 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -13,6 +13,7 @@
>  
>  	aliases {
>  		serial3 = &uart3;
> +		mmc0 = &mmc0;
>  	};
>  
>  	chosen {
> @@ -28,6 +29,23 @@
>  		device_type = "memory";
>  		reg = <0x1 0xe0000000 0x0 0x0>;
>  	};
> +
> +	/* Fixed regulator used in the absence of PMIC */
> +	vcc_3v1: vcc-3v1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.1V";
> +		regulator-min-microvolt = <3100000>;
> +		regulator-max-microvolt = <3100000>;
> +	};

Is this regulator used somewhere?

Thanks,
Mani

> +
> +	/* Fixed regulator used in the absence of PMIC */
> +	sd_vcc: sd-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.1V";
> +		regulator-min-microvolt = <3100000>;
> +		regulator-max-microvolt = <3100000>;
> +		regulator-always-on;
> +	};
>  };
>  
>  &i2c0 {
> @@ -81,6 +99,14 @@
>  			bias-pull-up;
>  		};
>  	};
> +
> +	mmc0_default: mmc0_default {
> +		pinmux {
> +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> +			function = "sd0";
> +		};
> +	};
>  };
>  
>  &timer {
> @@ -90,3 +116,18 @@
>  &uart3 {
>  	status = "okay";
>  };
> +
> +/* uSD */
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_default>;
> +	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
> +	no-sdio;
> +	no-mmc;
> +	no-1-8-v;
> +	bus-width = <4>;
> +	vmmc-supply = <&sd_vcc>;
> +	vqmmc-supply = <&sd_vcc>;
> +};
> +
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 9ed88aafc2da..ba498cf9217d 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/clock/actions,s700-cmu.h>
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/owl-s700-powergate.h>
>  #include <dt-bindings/reset/actions,s700-reset.h>
> -- 
> 2.7.4
> 
