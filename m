Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9CC20758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkS0shFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGTFgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgGTFgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:36:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C09C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 22:36:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a23so6889524pfk.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 22:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=17xC3zHkV5PUpI7z+zPeu3cX7BA+aM3Er4zehoS3ak4=;
        b=MkS0shFE3ftUVhWnfoXUc5V+S6atgTtJF+ILzCVuPl7dWk9GjKhBSMQR+DKIInroEA
         Q0DC89HoowRni0/JcTBmWhY3Khw1xm66xuFiFRM2u3jDFOiknyQJka0C+StFEeca27/E
         Cr6KcH9jU5kCU+/Whd/bL67VQLvgD+eMKbjDuEoxSrnCFH804cHYNfbzsWkGEgY3lRSD
         dse7igiiuO33+4ibTGyaoqByQzFjxnA27Ir/3jppWH/8ppSvWtgPoIDp9C8h/Fi+rPuh
         X04HUZqLCuYdNiLEXM7gcqgfRZde3fJTqWt6/3NzFpvaMV1vYw6+kLmx6qi8ZH8ux79w
         ufRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=17xC3zHkV5PUpI7z+zPeu3cX7BA+aM3Er4zehoS3ak4=;
        b=Nzp49SaA3TxuwUyeP+gxNgY1TCyRndeh/NC6Z23KEMdwtEVQYvaUY7OYzMFG6y9bwz
         +jk2NKN452nCSQdwBVa+Q8m8/IbXmP+C1CKNVRa3gAFVQgK0pLRrmJM3+MozBy3OQjqL
         7XiV09Bk3D8jb6T2rNY3r+K719FDXssmNSTQawW7ikaGZ+0ZLf8BMBtsfbLEemT2fJa0
         Ia3I4Q4Y7/Nfm481AUspTq9Q17shAXMHrmR63HeXAPoiKSRAePWWjOo5KT3iAeItPrNa
         sCFwnleWfM4FG6jVssSHMHWOi0g0QzKLcKjZc7cKGnSAJeFfggVbH7+9RJhF+RDfWzsI
         VJwA==
X-Gm-Message-State: AOAM531okHW30EEfkufEvjBPOToqF4Qm/2LE/r5+1f1y4clLAFgL81b5
        qRC0+ozp0KQmXY+QWWDgouHh
X-Google-Smtp-Source: ABdhPJwvvC1me79D5JJyNEBxZZAHQxK1zws8J+BsAgLETk0wPX18DOEZrZF+OpBszSIeFlBylyZk7A==
X-Received: by 2002:a62:190a:: with SMTP id 10mr18189612pfz.29.1595223399205;
        Sun, 19 Jul 2020 22:36:39 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d8b:7b19:7469:2fbc:c3c3:3562])
        by smtp.gmail.com with ESMTPSA id z2sm15054596pfq.67.2020.07.19.22.36.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 22:36:38 -0700 (PDT)
Date:   Mon, 20 Jul 2020 11:06:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 10/10] arm64: dts: actions: Add uSD support for
 Cubieboard7
Message-ID: <20200720053628.GA19022@Mani-XPS-13-9360>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-11-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-11-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:12:07PM +0530, Amit Singh Tomar wrote:
> This commit adds uSD support for Cubieboard7 board based on Actions Semi
> S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
> added yet, fixed regulator has been used as a regulator node.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes since v6:
> 	* Brought back the uSD fixed regulator.
> Changes since v5:
>         * Removed the Fixed regulators as these are
>           not needed.
> Changes since v4:
>         * No change.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * No change.
> ---
>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 33 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 63e375cd9eb4..f81d63261ba2 100644
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
> @@ -28,6 +29,15 @@
>  		device_type = "memory";
>  		reg = <0x1 0xe0000000 0x0 0x0>;
>  	};
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
> @@ -81,6 +91,14 @@
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
> @@ -90,3 +108,18 @@
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
