Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C12EC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0CD21919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5LZ7Lm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgIII6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIII6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19416C061573;
        Wed,  9 Sep 2020 01:58:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so2007013wrl.12;
        Wed, 09 Sep 2020 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mY/fzmuc9Z9J54FdM2ZzI/TWtsjmz4gHfBgSVB4ZBAo=;
        b=n5LZ7Lm+YDmFKKER+/ysMgI/kt0PyaoCrAXe1aD247+zCUUizrKYj6N+IvvXOS2kas
         NpY98kod+KZqr0NIu9MWhZcd+HqkWcYQJlrIXUhm0XObO0wFbjH13m0bKEM7LmG+mYir
         sPtBcQHjYxKxyMWQuBq5rFsOtKs+1nWxGNhHKmlJw39/mB9U6Kms6Eg+pRimya3W58+g
         CkuTu2/jgtvH6JWUn84QE+ADu1UmouhHMlYPdiI2Jezx2aUyuR/zRc3EWurt5tqIHsdM
         FRQkIXU2Z6LXkNSBnA1Kk1ZBG99ZFdsIt6kaFnnRgG7nGF0tuOD4Q81OdUeBnLd2DptB
         vsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mY/fzmuc9Z9J54FdM2ZzI/TWtsjmz4gHfBgSVB4ZBAo=;
        b=qFKEpJ1VN9YnaKu23L3Xw7Jj9hBwJka5tDL0YTukbfWjH+4OT0y7GKO1pCtv+1BTGV
         Z5HAndTf7DpnV317R3/95IrDo7XxTERaSrc3C11z28E/VCMGPCuC3aa9mrh9L3SRYm8u
         0NPWnypwS9VwkF/0C293ZXSb8jlmAtvoqmfNZk8hWToMbzS3Acjr1Hd3rUqmVq9I+vwP
         jUNz8FtwUPdVXllPbWNxyycJSHiuH4uprHMtMoU6Zt78KCOn5Oei+ZHThLl8SipO1Tq8
         3DozoPMzoX6cGXfoIdm2arZ/+CJIkelWRJIAUmuHFYQBujKGa2gn3Pk/y/93LF9K0t9y
         RO+Q==
X-Gm-Message-State: AOAM530VfrPAUWcnW+QxQBpzt5tpWQ3kqhvQrDJhfUr0TKSPTPPOga7F
        WyxoCR0mnZ/MNGifoRTcunSlVKt8Xcc=
X-Google-Smtp-Source: ABdhPJxBlZkTjgNZg2GsUVOdYfL4ThVMkW2G4Y+Yebj4FIFY/o9pwrA+mol3aBqWMdivXg9XmXRlFg==
X-Received: by 2002:adf:f6c2:: with SMTP id y2mr2720456wrp.79.1599641880528;
        Wed, 09 Sep 2020 01:58:00 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id d2sm3339157wro.34.2020.09.09.01.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 01:57:59 -0700 (PDT)
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
Message-ID: <dd5a6b8b-71dc-ce54-1f0d-7fa6b1dd6248@gmail.com>
Date:   Wed, 9 Sep 2020 10:57:58 +0200
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

Do we expect other boards to have a different memory reservation? I can see that 
EVB and Kukui uses the same. If not, we should add the node in mt8183.dtsi instead.

Regards,
Matthias

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
