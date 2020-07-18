Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC04C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E8A2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6iarfdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGRR0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGRR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:26:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB85C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:26:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so8250459pgh.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JKvc2+QCsfjHrJGTDylUQ0qlHg6awaCDIxeDgNldnWM=;
        b=e6iarfdIlJjoE2XZcMhUL5lLhSWV7WqOnkJcOXcw+n/JqWvzQ2cf/fCFcavs8os+Lo
         JEpoggS44iw45PMBUyGPmStXa9r4dE9emLZZmhBqUpNVzoVQFm42zHncy9/S22oN5nUq
         nObZG4jXxDUVEg1Bv4MTvMraLsdwXWgsyHKb3FDl9ss4ycNn1tujOZUVuW6l8cHOUPsg
         lclNAtjzDCU1Uu/0+4Uj6ljk0rLuO0RJZz5wold/Lq67xrG56Ek1HgQB8pMWXwD3wbRc
         C5qFhOrD/t0/gCiNR+dT1UnENazdP5eVFfIoTSnutxkXZzN4M6aCiY7btouFQe/zq+Ei
         XLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JKvc2+QCsfjHrJGTDylUQ0qlHg6awaCDIxeDgNldnWM=;
        b=YZyYFskfAJCI8TAdpujEM/FwduQZzxbbGCIaU4c+lNLgzfrc1VRGUy5AD1qDmZ/kEm
         S+MpScwzwyrI0BK+givKGWh7/Q/ea2231z/ggO/zSAq9O7u9r8HF9+FdQoHOPrAYKCw1
         ig3nKaEZC5kvyO6q/JN6YvF0ynPkIMObbP9+xXHJDtwasUUA+kQGG7DaDe97m2RXHPft
         2xFP/lgOJiEHYgHiF2rCCnNJOOY34NCRO73H65Fjw1+lGnfNvnmfdGYsc/dZRJmAKfnv
         YXCUsojB5hWIDhGIp+Y/FFljr6K939DeyOkQxewhZm9b3bw+rbfHUwnA8Sw55K4t9et/
         DPUg==
X-Gm-Message-State: AOAM531Ol+HJhwovTHnrgtqZZ/CJR5YX2ibuvP7y+xp1LNcE3UGQo7ak
        Jr548qV2oCD2Z8yGPyRCoQ4T
X-Google-Smtp-Source: ABdhPJzTVguVkvmw0iuDXIhid0BN8vdgC6wRgnQ9ZMv2+o7ApvRtCeJrtP6fE/o2zc0dHtLZBOV+uw==
X-Received: by 2002:aa7:8edc:: with SMTP id b28mr12883482pfr.230.1595093182660;
        Sat, 18 Jul 2020 10:26:22 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:641d:175c:d9be:f98c:dadf:a60b])
        by smtp.gmail.com with ESMTPSA id d9sm10631001pgv.45.2020.07.18.10.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 10:26:21 -0700 (PDT)
Date:   Sat, 18 Jul 2020 22:56:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 10/10] arm64: dts: actions: Add uSD support for
 Cubieboard7
Message-ID: <20200718172615.GB3331@Mani-XPS-13-9360>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
 <1595063974-24228-11-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595063974-24228-11-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 02:49:34PM +0530, Amit Singh Tomar wrote:
> This commit adds uSD support for Cubieboard7 board based on Actions Semi
> S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
> added yet, fixed regulator has been used as a regulator node.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since v5:
> 	* Removed the Fixed regulators as these are 
> 	  not needed.

I just asked you to remove the unused (ie. unreferenced fixed regulators) but
you seem to have removed sd_vcc which was supplied to uSD :/ How can the uSD
card work without a power supply? Forget the fact that the regulator was enabled
by bootloader but you are not properly describing it in DT here. The idea is to
model the actual hardware in DT and if you are not able to model the regulator
using PMIC then use fixed-regulator. Hope this makes it clear!

Thanks,
Mani

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
>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 22 ++++++++++++++++++++++
>  arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 63e375cd9eb4..eaaf8f876203 100644
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
> @@ -81,6 +82,14 @@
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
> @@ -90,3 +99,16 @@
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
