Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3213C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC83204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BarODWwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFVH5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFVH5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:57:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:57:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so14728524wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTEdUGQ/w/ghXNLjd79PUz5ivxXpaTqUBfH8mvzqnkg=;
        b=BarODWwhlvaiQDmdeb4sS1QAPSeiVm9FrTWXkct0qwI7TsRsZjRYDNycKjDpnoqofT
         N+ABryTgnEugJBaITr9WSUGXyOd5ApsSvDdfGoMp22GixsuFLS03Pgvtbg70rzs1x5CV
         oBAeBNoJGuLLf8qRAQ/UdbqvPY1GkvbVEmNuDj7TAmNy9ThBPm2wPU6TuSOcs+4JtzO9
         Z0QBpSg2e6Ek1m5ByXMsLChIqHMzdjlkkvQxTVM8GhKUJDxVyNakgPAZWTtDfuPIjbtu
         70lFPc61Qdovzc987T5D50OyjnfSAhglCrmkGlwUli25T0FXeaRHjzamvYQIOBkrTgDq
         GGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PTEdUGQ/w/ghXNLjd79PUz5ivxXpaTqUBfH8mvzqnkg=;
        b=r+m52EBiAbKP6F5JaBLFBQ7DuHNgg4GG+GE7i2/ALk3jdYE042lG7qaJdkoI9ZUPXo
         KkJUz5+7f7p4GFqlbkmxCGwE9yPKpGGbrXNQzKswJUH16wB0lD/uhuvHd6j2pJi466dk
         hbwwmJ2kdGST5zQb8/1mZ3xtpZqUvV7o1bEwng/VxmiWnTwX04iWBWFG9Xms076aNA1w
         uZKHufv1zGbo6Y6QsemdNPTjAoJSaR/nOgZRPS+TfDjPB6NE0OtHDRbco3UlW7zWxW6o
         zXOCPT94g0GZ6w+yxzlAnoTiMl0pDDPvqNciwKJ8ewsgiGBjnvD02mYmaoivwP74KvBS
         koRg==
X-Gm-Message-State: AOAM531xNqH4c6yIEHklHBt/wYSwMHq6kpUVNylRR2AB/udv/lVgXlM6
        AHtPQKkYu9WC/G7NibSqA7X7vg==
X-Google-Smtp-Source: ABdhPJyCH9UmdCCMzTEl6S90oRW4/9aeAm0gAzCUzQg/oHQoia9n3QO3NUGhC1Y4u3tku0mSjdSh4Q==
X-Received: by 2002:a1c:2e58:: with SMTP id u85mr16787261wmu.123.1592812619297;
        Mon, 22 Jun 2020 00:56:59 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc? ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id r8sm2600714wrp.40.2020.06.22.00.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 00:56:58 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: amlogic: Add the Ethernet
 "timing-adjustment" clock
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     andrew@lunn.ch, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200620162347.26159-1-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <2cc17a6e-9886-b50a-b979-b34cc28f5540@baylibre.com>
Date:   Mon, 22 Jun 2020 09:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620162347.26159-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2020 18:23, Martin Blumenstingl wrote:
> Add the "timing-adjustment" clock now that we know how it is connected
> to the PRG_ETHERNET registers. It is used internally to generate the
> RGMII RX delay on the MAC side (if needed).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes since v1 at [0]:
> - fixed all typos in the commit message (hopefully...). Thanks to Andrew
>   for spotting the first ("no" -> "on") one and shame on me for having
>   to find two more ("adjusment" -> "adjustment", "now" -> "know")
> 
> 
> [0] https://patchwork.kernel.org/patch/11616101/
> 
> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 6 ++++--
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++--
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi       | 5 +++--
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 5 +++--
>  4 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 8e6281c685fa..b9efc8469265 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -181,8 +181,10 @@ ethmac: ethernet@ff3f0000 {
>  			interrupt-names = "macirq";
>  			clocks = <&clkc CLKID_ETH>,
>  				 <&clkc CLKID_FCLK_DIV2>,
> -				 <&clkc CLKID_MPLL2>;
> -			clock-names = "stmmaceth", "clkin0", "clkin1";
> +				 <&clkc CLKID_MPLL2>,
> +				 <&clkc CLKID_FCLK_DIV2>;
> +			clock-names = "stmmaceth", "clkin0", "clkin1",
> +				      "timing-adjustment";
>  			rx-fifo-depth = <4096>;
>  			tx-fifo-depth = <2048>;
>  			status = "disabled";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 593a006f4b7b..41805f2ed8fc 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -185,8 +185,10 @@ ethmac: ethernet@ff3f0000 {
>  			interrupt-names = "macirq";
>  			clocks = <&clkc CLKID_ETH>,
>  				 <&clkc CLKID_FCLK_DIV2>,
> -				 <&clkc CLKID_MPLL2>;
> -			clock-names = "stmmaceth", "clkin0", "clkin1";
> +				 <&clkc CLKID_MPLL2>,
> +				 <&clkc CLKID_FCLK_DIV2>;
> +			clock-names = "stmmaceth", "clkin0", "clkin1",
> +				      "timing-adjustment";
>  			rx-fifo-depth = <4096>;
>  			tx-fifo-depth = <2048>;
>  			status = "disabled";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 234490d3ee68..03c25b9facff 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -333,8 +333,9 @@ &efuse {
>  &ethmac {
>  	clocks = <&clkc CLKID_ETH>,
>  		 <&clkc CLKID_FCLK_DIV2>,
> -		 <&clkc CLKID_MPLL2>;
> -	clock-names = "stmmaceth", "clkin0", "clkin1";
> +		 <&clkc CLKID_MPLL2>,
> +		 <&clkc CLKID_FCLK_DIV2>;
> +	clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
>  };
>  
>  &gpio_intc {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index fc59c8534c0f..60484bbc7272 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -131,8 +131,9 @@ &efuse {
>  &ethmac {
>  	clocks = <&clkc CLKID_ETH>,
>  		 <&clkc CLKID_FCLK_DIV2>,
> -		 <&clkc CLKID_MPLL2>;
> -	clock-names = "stmmaceth", "clkin0", "clkin1";
> +		 <&clkc CLKID_MPLL2>,
> +		 <&clkc CLKID_FCLK_DIV2>;
> +	clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
>  
>  	mdio0: mdio {
>  		#address-cells = <1>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
