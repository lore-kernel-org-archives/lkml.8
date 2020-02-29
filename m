Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2076FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91C9246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 10:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rv9T+7k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgB2KmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 05:42:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38330 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2KmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 05:42:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id q9so159675pfs.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 02:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZzIyS9yhP5PRMubXOxIFShxNXKSbCIxvvlyoIGTDdSQ=;
        b=rv9T+7k3rSDBBf7tiievZuA7eWs2xiVZldc+zDpZK+kepfOQAd6F+wfTMPAMqW89mm
         V4dwiTF+KENZa4T5IQDYXS2FmaWNZF2j1LcFuAqfjrdI8fBG6Y9uL/4J80BzYUv0mXj3
         xpsL9PGb2xOUeR0nkHqLaEm6e+xPTl7EXiViWZlYjJ35Ri6WG2P7+N8LPLqv+Do6YNGg
         0xoFjdrnjqQkfsp4PpEAxcRoB0e3QRdBmqJupTbfZifYRx4HWzU8QGzz+QmZfmk4sviR
         nBmNWFvq2e7fvM2ilTIYdeRDp5ifWnSVCV6SAPCOS1QmQ7JWraBBABzARzGLK77WuNBw
         xMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZzIyS9yhP5PRMubXOxIFShxNXKSbCIxvvlyoIGTDdSQ=;
        b=BsfrDYMNkQHVIiC6Jcq+UO7nRFz/rhPZLC+DSPf2aGd6OthucTAL0obp/h2/VWL1wv
         6iAqIpXl6692ThK7UOEiJyazx3jElohr0vjyylBEnl2o3K43ZgKXyD6rouQYrRXclUp7
         DVxlM8GBoPuPkGbkZjbe9Ip7n6p6VzTyhMBE+DhPikbsckCPSP0wTK5SQqMr5MSdsHOW
         do9g4T/wW/Sxbz3CVQ+DMEO075qLS8oW6uI8+SaZElG6WcFtDdoVGAiKjGulz3r5BmPj
         Lzhk5Ewnd33jurxR15jRirfqAJaRoZWaEU61qPfJU2hf5QLXhixlPc3g9MmBPjIcZJIY
         ztkg==
X-Gm-Message-State: APjAAAXTD1F1VGFr18LXbzkYJYg1g+TdNWYJ8ntyBzmnB8Gb1s09pnHa
        yMoKJ5hlGGIClcqZMrGpVsK/
X-Google-Smtp-Source: APXvYqxFuIpAAUSXOCIb8wR8iP1M+6alf1Wcq8lFOXfAz0qwvzIiIYz/WHDdik1cpwtmkMbwWaBi7A==
X-Received: by 2002:a63:5124:: with SMTP id f36mr8819866pgb.288.1582972929850;
        Sat, 29 Feb 2020 02:42:09 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 7sm2513995pfg.12.2020.02.29.02.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 02:42:09 -0800 (PST)
Date:   Sat, 29 Feb 2020 16:12:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: dts: Add Caninos Loucos Labrador
Message-ID: <20200229104202.GA19610@mani>
References: <20200227201557.368533-1-matheus@castello.eng.br>
 <20200227201557.368533-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227201557.368533-3-matheus@castello.eng.br>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch! Please find comments inline.

On Thu, Feb 27, 2020 at 05:15:57PM -0300, Matheus Castello wrote:
> Add Device Trees for Caninos Loucos Labrador SoM and base board.
> Based on the work of Andreas Färber on Lemaker Guitar device tree.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  arch/arm/boot/dts/Makefile                  |  3 +-
>  arch/arm/boot/dts/owl-s500-labrador-bb.dts  | 33 +++++++++++++++++++++
>  arch/arm/boot/dts/owl-s500-labrador-v2.dtsi | 21 +++++++++++++
>  3 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/owl-s500-labrador-bb.dts
>  create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d6546d2676b9..acdf65ef3236 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -842,7 +842,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>  dtb-$(CONFIG_ARCH_ACTIONS) += \
>  	owl-s500-cubieboard6.dtb \
>  	owl-s500-guitar-bb-rev-b.dtb \
> -	owl-s500-sparky.dtb
> +	owl-s500-sparky.dtb \
> +	owl-s500-labrador-bb.dtb

Please sort the entries alphabetically.

>  dtb-$(CONFIG_ARCH_PRIMA2) += \
>  	prima2-evb.dtb
>  dtb-$(CONFIG_ARCH_PXA) += \
> diff --git a/arch/arm/boot/dts/owl-s500-labrador-bb.dts b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
> new file mode 100644
> index 000000000000..1e821804da30
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*

A title here would be helpful like how you added for the SoM below.

> + * Copyright (c) 2019-2020 Matheus Castello
> + */
> +
> +/dts-v1/;
> +
> +#include "owl-s500-labrador-v2.dtsi"
> +#include <dt-bindings/leds/common.h>

Do we need this now?

Thanks,
Mani

> +
> +/ {
> +	compatible = "caninos,labrador-bb", "caninos,labrador", "actions,s500";
> +	model = "Caninos Labrador Base Board M v1.0";
> +
> +	aliases {
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial3:115200n8";
> +	};
> +
> +	uart3_clk: uart3-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <921600>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	clocks = <&uart3_clk>;
> +};
> diff --git a/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> new file mode 100644
> index 000000000000..ee079f02b5dd
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Caninos Labrador SoM V2
> + *
> + * Copyright (c) 2019-2020 Matheus Castello
> + */
> +
> +#include "owl-s500.dtsi"
> +
> +/ {
> +	compatible = "caninos,labrador", "actions,s500";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>;
> +	};
> +};
> +
> +&timer {
> +	clocks = <&hosc>;
> +};
> --
> 2.25.0
> 
