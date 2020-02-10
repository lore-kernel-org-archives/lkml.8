Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B4C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39620715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581342614;
	bh=A4cl3SC6S8mfUywUBJUlbl+RXxvceSSnWkxnrhJxtHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aN6aoxziXqncyWJzs94OcnpKE9uluRh3UpnB/+Ru48mUdSdSfIt0QBNLa5n669wCz
	 JL0mCJkQ2NzjFAGAHm93kM5NiYAEUsCHcFky2EfyXuPiVmeuXNeuO/POnU51t/wHyu
	 tKpY6wRwp4gQfYQqQjh94dddehoc5RyveM0HeARg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgBJNuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:50:14 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43427 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBJNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:50:13 -0500
Received: by mail-ed1-f52.google.com with SMTP id dc19so306631edb.10;
        Mon, 10 Feb 2020 05:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUh/ndXbaDqp+3tPebK12Mbm+ONI7sh2CQOdtDK1Y1Q=;
        b=omWazMTgJKzRRnL4XyFfYUbjw0QfgQaEYnOM/sZFP1eblVhI2iUEulVac1koKlMCUl
         JOT9DFpPJ2mkRSWnOsit1oAgW6MHtOj4ETt9Ywc9yNL++WAW4r6t9Xh0vwWvGcVCBh3Y
         3kXfgO87NfSg4fsliLunLB40iit+RkkXH3/VZuFLFOAqfVOVvDMvtPV3SiN4jgq1GaaU
         u+hRQtMafv07ZGZ9VyEEJFsIST6Va3BVvQmGVZiKCZU/aHMe4KE4tYpv8gUq3TFm39OF
         KM+Ict+t4Iym6Sl6N+fjClzdzSyGwkNysY3l/RcHD1iyqenYUFun8Q+MHYrg5Fs3D5FK
         o+Zg==
X-Gm-Message-State: APjAAAV6bQfcqMZoCbRP6QkD2XYnlb5MMhT0vlHDMOr3MlQsKgJ/wCku
        UTJG7bS7Cy/mTUPEOrlDEEk=
X-Google-Smtp-Source: APXvYqyn2t288jmOkFcP+OP9icXtvKT/eVN8DeIO76jSB5/gUw5aD8FBkeSGATGBn0SU9NvUvANfQw==
X-Received: by 2002:a17:906:23e2:: with SMTP id j2mr1165391ejg.257.1581342611234;
        Mon, 10 Feb 2020 05:50:11 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id qw15sm43828ejb.92.2020.02.10.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 05:50:10 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:50:08 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/3] ARM: dts: exynos: Add missing usbdrd3 suspend clk
Message-ID: <20200210135008.GA2163@pi3>
References: <20200210105108.1128-1-linux.amoon@gmail.com>
 <20200210105108.1128-3-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200210105108.1128-3-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:51:07AM +0000, Anand Moon wrote:
> This patch adds new combatible strings for USBDRD3
> for adding missing suspend clk, exynos5422 usbdrd3
> support two clk USBD300 and SCLK_USBD300, so add missing
> suspemd_clk for Exynos542x DWC3 nodes.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 8 ++++----
>  arch/arm/boot/dts/exynos54xx.dtsi | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index b672080e7469..bd505256a223 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1372,8 +1372,8 @@ &trng {
>  };
>  
>  &usbdrd3_0 {
> -	clocks = <&clock CLK_USBD300>;
> -	clock-names = "usbdrd30";
> +	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
> +	clock-names = "usbdrd30", "usbdrd30_susp_clk";
>  };
>  
>  &usbdrd_phy0 {
> @@ -1383,8 +1383,8 @@ &usbdrd_phy0 {
>  };
>  
>  &usbdrd3_1 {
> -	clocks = <&clock CLK_USBD301>;
> -	clock-names = "usbdrd30";
> +	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
> +	clock-names = "usbdrd30", "usbdrd30_susp_clk";
>  };
>  
>  &usbdrd_dwc3_1 {
> diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> index 8aa5117e58ce..0aac6255de5d 100644
> --- a/arch/arm/boot/dts/exynos54xx.dtsi
> +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> @@ -143,7 +143,7 @@ hsi2c_7: i2c@12cd0000 {
>  		};
>  
>  		usbdrd3_0: usb3-0 {
> -			compatible = "samsung,exynos5250-dwusb3";
> +			compatible = "samsung,exynos5420-dwusb3";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -165,7 +165,7 @@ usbdrd_phy0: phy@12100000 {
>  		};
>  
>  		usbdrd3_1: usb3-1 {
> -			compatible = "samsung,exynos5250-dwusb3";
> +			compatible = "samsung,exynos5420-dwusb3";

This affects also Exynos5410 but you do not add new clock there.

Best regards,
Krzysztof

