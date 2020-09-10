Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA99C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC7E214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc08PSXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgIJKyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgIJKwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:52:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C0C0613ED;
        Thu, 10 Sep 2020 03:52:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so5317202wmb.4;
        Thu, 10 Sep 2020 03:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xqxwM/Mvfa18vvLY/SDCcgMXW/SBJ2dGdITvWLFzj1E=;
        b=hc08PSXfEdHk3COElKF3/mNchbHltsWM1NVW016Nef7xJ/Bu/gVPH54E6MsFKRgL3h
         GKHbCyPIpoZqCeDsQzs5wMDpvQDI4pRY07pPOost7/lMarWSz+k7apLCCdPhDXN1RkGX
         czsCIFE4B+dW3XXOyBCy1/5/CJac4LLyQjD+peyjlO+cxyRxlYewCTGAS/2oowKqjh+a
         byRfHewsPXge4IFC+gMrI5ax1hyBFY/5rMBmMfc9KvD2qSyIhqwZ+7hHhk8JqCw3zSbb
         xMC6QkmkvtdhzCMh6TIDMpAxtn4kCukPD5PHdN5pzWbgnAvGJnS8DqtTqscJYfyyVqZH
         i3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xqxwM/Mvfa18vvLY/SDCcgMXW/SBJ2dGdITvWLFzj1E=;
        b=BYW8XkeQ0nEzYFxJQx9LaWDC2wFA8WZcJE7pN1WC3fo6kpKuzAc8pSUbyPEuUZOePF
         rDwoM8hIvt15DJtJOpo3o8HOFGJxFFivJ7a5mxA8dZZAtE6UuZ3XosdXD/Mb5azlmcf9
         JN8dV0oBE6qkuYygib4hDM6L2aer88OiuHCzkDFN5+ojvRW4+WDBxvnCNFYGLSBjWOZh
         qgtbXJAqaUzRdnGeVVPtt8FR7gKS2TFJPAdb2sqLznppKKujutRjsRWmMhdkc0rA793Y
         z/uWcE5tCskVSRdzz+HosX+s52RqROY4EIgkWhHaMZp0PHB5y861GT2x+9jr0gBaZktM
         OypQ==
X-Gm-Message-State: AOAM530WCS188QfU8ThEPRmxNf0/6VCoYjK2ltp/HZzT/DStoPVRWWXh
        Y66N9zgdFXCRBuLSHeSEGVV66fS6vEo=
X-Google-Smtp-Source: ABdhPJwk1Wpe3AlLx/+HN1qYohBdzkjzG9xzrHBAw7o7z5BWCvFB04lhR2xSpqcNQYSX+4AgqzKdNg==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr7614433wmb.44.1599735157246;
        Thu, 10 Sep 2020 03:52:37 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id a74sm3129769wme.11.2020.09.10.03.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 03:52:36 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: mt8183-kukui: add scp node
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200909081422.2412795-1-pihsun@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <161d403a-2a3a-3365-1bb2-5067e8fb7cb8@gmail.com>
Date:   Thu, 10 Sep 2020 12:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909081422.2412795-1-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2020 10:14, Pi-Hsun Shih wrote:
> Add scp node to mt8183-kukui
> 
> Fixes: 0d5e41709f76 ("arm64: dts: mt8183: add scp node")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Applied to v5.9-next/dts64

I squashed this fix with the first patch to maintain bisectability.

Thanks!

> ---
> 
> Change since v1:
> * Add Fixes tag.
> 
> ---
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index f0a070535b34..85f7c33ba446 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -90,6 +90,18 @@ pp3300_alw: regulator6 {
>   		regulator-max-microvolt = <3300000>;
>   	};
>   
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scp_mem_reserved: scp_mem_region {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +	};
> +
>   	max98357a: codec0 {
>   		compatible = "maxim,max98357a";
>   		sdmode-gpios = <&pio 175 0>;
> @@ -524,6 +536,13 @@ pins_clk {
>   		};
>   	};
>   
> +	scp_pins: scp {
> +		pins_scp_uart {
> +			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
> +				 <PINMUX_GPIO112__FUNC_TP_UTXD1_AO>;
> +		};
> +	};
> +
>   	spi0_pins: spi0 {
>   		pins_spi{
>   			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
> @@ -651,6 +670,17 @@ pins_wifi_wakeup {
>   	};
>   };
>   
> +&scp {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&scp_pins>;
> +
> +	cros_ec {
> +		compatible = "google,cros-ec-rpmsg";
> +		mtk,rpmsg-name = "cros-ec-rpmsg";
> +	};
> +};
> +
>   &soc_data {
>   	status = "okay";
>   };
> 
