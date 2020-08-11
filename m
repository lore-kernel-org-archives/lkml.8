Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9084920756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597161160;
	bh=Md+DuKzkPkps098XTMNCHzY4udMS2jS0iQepiNGeuLA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=wB6PMMYjUprGFUzCvm/BfVyuQE5sXhvYdISpnWkyB1eI006feOG9hJjZ6pdyrcEUH
	 q2wDvBiKOw81amA6T2v/nxQACXNNPgImAgimLcVIab62ujttREWgxlTF+dIWDeVl8r
	 95I7wbs/RTeKdKqMoilYFUghLQZvObSViIrdmBb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgHKPwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:52:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38286 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgHKPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:52:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id t14so3320263wmi.3;
        Tue, 11 Aug 2020 08:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=88Li6T5Kvmt1uKW639G+kKlxhB5o4hvW9Qv3b1Xe4fc=;
        b=b+4udarGNc0ip9dRgLsZARTX7oyEnqaII0YzdqX8YY/wtjnu2/OsB3U0lCFLuyhYJ7
         bURGxBn9QMt6EK4GLqCmrpFp1Gr8k8PvEHbo2zLp4zHViAb0RM/DDPOtpe9wTHFylVLN
         EAX1ra8oFagQrW3OYmeOuUcmV3RzK8gsYpC6cTp5M3TiH1PC6HK2KhfW7gQIEeSuTRNJ
         srqpU/lXkPUTso961GjCrIRKRfaFLnZUuqE4RKuaAPA/psdqPRT68EWsqOV7yzjcVJfD
         vXmxo9nBb8L3hL02G1n7cpbbn40QoDrDjzH2B/ySFP+VYAHRL8nRtgR2uJPSvDwjxYKp
         hScA==
X-Gm-Message-State: AOAM533r9JlRHUAejhZqYUoivajKgk6ekjpUMGCnIHVb2MClWsVHBWh+
        N0BQjB1Bl62XT/CneOyDQJs=
X-Google-Smtp-Source: ABdhPJyzdO+JmvDCM9jhUwcbnTiLn2XLEM04kKLEy3PYPoJe0SBFCP6ecOG0QL0HA2H7u2pDAXa+bA==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr4367049wma.62.1597161155302;
        Tue, 11 Aug 2020 08:52:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id v11sm27603864wrr.10.2020.08.11.08.52.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 08:52:34 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:52:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm64: dts: imx8mm-var-som-symphony: Add Variscite
 Symphony board with VAR-SOM-MX8MM
Message-ID: <20200811155232.GA5960@kozik-lap>
References: <20200811153916.5455-1-krzk@kernel.org>
 <20200811153916.5455-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811153916.5455-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 05:39:16PM +0200, Krzysztof Kozlowski wrote:
> Add a DTS for Variscite Symphony evaluation kit with VAR-SOM-MX8MM
> System on Module.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-var-som-symphony.dts | 244 ++++++++++++++++++
>  2 files changed, 245 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index a39f0a1723e0..dcfb8750cd78 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> new file mode 100644
> index 000000000000..5bfb650a04cc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm-var-som.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-MX8MM Symphony evaluation board";
> +	compatible = "variscite,var-som-mx8mm-symphony", "variscite,var-som-mx8mm", "fsl,imx8mm";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		status {
> +			label = "status";
> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +	};

I just spotted own mistake - this is a left-over and should be removed.
I will send a v2 in few days, maybe after initial feedback.

Best regards,
Krzysztof
