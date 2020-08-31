Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03741C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EBC2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgnV7T2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHaJ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgHaJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:26:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:26:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so2749451plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cE6tbCI2FK1spDu2EWGHl52dUoomgzZk3UG4ySpVivk=;
        b=GgnV7T2zwkVAz2Ck+rOkM0vrXa0VA5BB7eyoHuXsIJ9gtCMP0LsEc0J9ZJR2WNMqRd
         VvwPJu3iU7wa0IFHaQsgwj2RjanOo/8qWnALRAnUhzLOJadHxMlPDEEQIi4BD2fzO30N
         dhDfm2lZgMU0/QPsqMRJkjKtU6GGU6csI7W5ebXGDaOz/DK/F5V26NKS9FW6SNvpdxVZ
         +eHR+mgRlpEU5eDJv3zHozBrz7YV8F5J0Uzt7jFCz/YScys08QI/WJ8Ob+8b1vVHejAP
         Ygjj+q934ElRMl8dutFwwUB+0rbpbqTACM6MKUVj/lpcfRdzXDHxl2ZAuFT+Uk6a3GHS
         Y9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cE6tbCI2FK1spDu2EWGHl52dUoomgzZk3UG4ySpVivk=;
        b=tG9B+6BKGGIpRkl8CmyA3NAmAcuWC1nQOkrh+6oeXvz8rbBDQdla3lUYHqfJTJidzY
         S409OzMLuTIkDULAZ5PE5KkqMI6QfHaTnZPr+c0tS0DbqEvnn4GhMbJuOUE+f+WB4W0a
         1M+ykiUEL+bYMaQFmuKe0JGyuhnGt4iXLLX3p0DGGTBAmiv/7RKBPc/Ry85ZWiSIRxE7
         28f8Kqyej0A3XeOAi87oR18plu6pskN8KWGaXRYodbnbUdW0a+DE3F2nM912LaVJy1+j
         vhkDSVwv0l3kyrNwXPM3lfUdnReW7jHhtlN4Rtp0LzTZ3L5dh0kLsxyz7WHjV83z5G3T
         wXVA==
X-Gm-Message-State: AOAM5327RYaiqEtqtteyUDbHHZSdjFCs3h+32sg2g9vBMSBBLmwjJBKY
        jdm6cyw/1Ob0S9+obM6XoE3n
X-Google-Smtp-Source: ABdhPJyukiMgta+UgmTqi9LwaARd2wmCD0A9V+10E/aJgrh4r5nu3wI16YpE31+xthJA7ak5I3A5mQ==
X-Received: by 2002:a17:902:a60e:: with SMTP id u14mr393643plq.179.1598866016646;
        Mon, 31 Aug 2020 02:26:56 -0700 (PDT)
Received: from mani ([2409:4072:70f:fdfa:1d6f:524d:c4d3:917e])
        by smtp.gmail.com with ESMTPSA id 128sm7234595pfy.132.2020.08.31.02.26.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 02:26:56 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:56:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 4/4] arm: dts: owl-s500: Add RoseapplePi
Message-ID: <20200831092648.GD4154@mani>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
 <5a6fc55341b346439ba32b5a3e14087edbaa6226.1598621459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6fc55341b346439ba32b5a3e14087edbaa6226.1598621459.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0828, Cristian Ciocaltea wrote:
> Add a Device Tree for the RoseapplePi SBC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/Makefile                 |  1 +
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 47 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>  create mode 100644 arch/arm/boot/dts/owl-s500-roseapplepi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4572db3fa5ae..bff9ef996fbb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -868,6 +868,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>  dtb-$(CONFIG_ARCH_ACTIONS) += \
>  	owl-s500-cubieboard6.dtb \
>  	owl-s500-guitar-bb-rev-b.dtb \
> +	owl-s500-roseapplepi.dtb \
>  	owl-s500-sparky.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += \
>  	prima2-evb.dtb
> diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> new file mode 100644
> index 000000000000..a2087e617cb2
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Roseapple Pi
> + *
> + * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "owl-s500.dtsi"
> +
> +/ {
> +	compatible = "roseapplepi,roseapplepi", "actions,s500";
> +	model = "Roseapple Pi";
> +
> +	aliases {
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>; /* 2GB */
> +	};
> +
> +	uart2_clk: uart2-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <921600>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&twd_timer {
> +	status = "okay";
> +};
> +
> +&timer {
> +	clocks = <&hosc>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	clocks = <&uart2_clk>;
> +};
> -- 
> 2.28.0
> 
