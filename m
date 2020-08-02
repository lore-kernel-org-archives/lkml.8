Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC76C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 17:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A9720738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwLLA9Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHBRwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHBRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 13:52:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F4C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 10:52:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so9760566ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dm47XeqfiIXQHiJ7C2rGcD9otFEGWLo5uyRvjiXFXCo=;
        b=SwLLA9Purvw+IiR2q8P8/6G+aRXeBURRNa1qFZziEG8Nvk/4zANOo9V5JvagGAxxPj
         uE9JlRZwWHV/8uUjLW1bSdyo1zyCx/DfJkEuwn5Z1UcTXrYBtxKRFGn1mnW7fvNsUFQl
         Vn9ZozFzIsOu+5wXuM/uucPHUBQqVfs6Bt5riA8UtQmD2gSHh05QkSG2iyxphQ4dNk59
         753uDdt1Eer0Pu7nBQi7mL3DGB5d0l4sARkN5nG2k8AricdeJjqklZsiz8w767ii+cka
         rSZorz1+KIIQRIPOWDqHnv1xe06nmEQXiEcmEpqgNanaJOF1gJVFSnp9f6psu/MRpa9G
         UZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dm47XeqfiIXQHiJ7C2rGcD9otFEGWLo5uyRvjiXFXCo=;
        b=L85zFL2E9tZXciUMAhvDfx/SFG8iuuq1smz+5QmRQShkA9MUiVwdPKHArp3jlyWUgz
         v6tEGL1c0BV92lgk3fZj6YivftfTwfoXgicy27LB1hdNWRRHjHsqavIoB4v7y7cLjfvp
         kwUVG8OSZmIwZIsdLK3xpMTk1tyGEbJpPI0QjbUZ3Nzbzk6+D4P+ojgT6rOOfSTPXWSw
         HQCJSJZ+LT9aLUluC4CSnO6A4X9sJYBbg68LgkVhJl2zjmJ1qpyYgU+MN0dXNjn6406h
         9mAl5ONpEFX2+FL/dq5BwfvXV+kG9s6hid28VC+JfFrUP3WPgL4FJpThlQ2pUWgqjFOx
         Muug==
X-Gm-Message-State: AOAM5312YWMJ0ZkKGk4VDTEk8RRMbknbD99JuY2jKD8N//QbAVDHuvtR
        Fw0m4vlhQFr0+/4v8fODmmBr5l+a5Ek=
X-Google-Smtp-Source: ABdhPJyay6xNSSmIJyIeFQRvLz1beSHzt0FFGQJagiSTKtDT85ll0aDDpODqHSs5I7U9ijZZ8lgItg==
X-Received: by 2002:a17:906:ce43:: with SMTP id se3mr13061328ejb.403.1596390748992;
        Sun, 02 Aug 2020 10:52:28 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bx22sm13926185ejc.18.2020.08.02.10.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 10:52:28 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200801174950.2309273-1-katsuhiro@katsuster.net>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <1e16b653-3820-7944-2254-a99627f9eeb0@gmail.com>
Date:   Sun, 2 Aug 2020 19:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200801174950.2309273-1-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Katsuhiro,

On 8/1/20 7:49 PM, Katsuhiro Suzuki wrote:
> This patch adds 'disabled' SPDIF sound node and related settings
> for rk3399-rockpro64.
> 
> There are 2 reasons:
>   - All RK3399 dma-bus channels have been already used by I2S0/1/2
>   - RockPro64 does not have SPDIF optical nor coaxial connector,
>     just have 3pins
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 6e553ff47534..e35b30f8a46e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -76,6 +76,23 @@ sound {
>  		dais = <&i2s1_p0>;
>  	};
>  
> +	sound-dit {
> +		compatible = "audio-graph-card";
> +		label = "rockchip,rk3399";
> +		dais = <&spdif_p0>;
> +	};
> +
> +	spdif-dit {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +
> +		port {
> +			dit_p0_0: endpoint {
> +				remote-endpoint = <&spdif_p0_0>;
> +			};
> +		};
> +	};
> +
>  	vcc12v_dcin: vcc12v-dcin {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
> @@ -698,6 +715,17 @@ &sdhci {
>  	status = "okay";
>  };
>  
> +&spdif {
> +	pinctrl-0 = <&spdif_bus_1>;

> +	status = "disabled";

The status is already disabled.
Adding more unused nodes and properties doesn't make sense here.

	spdif: spdif@ff870000 {
		compatible = "rockchip,rk3399-spdif";
		reg = <0x0 0xff870000 0x0 0x1000>;
		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH 0>;
		dmas = <&dmac_bus 7>;
		dma-names = "tx";
		clock-names = "mclk", "hclk";
		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
		pinctrl-names = "default";
		pinctrl-0 = <&spdif_bus>;
		power-domains = <&power RK3399_PD_SDIOAUDIO>;
		#sound-dai-cells = <0>;
		status = "disabled";
	};

> +
> +	spdif_p0: port {
> +		spdif_p0_0: endpoint {
> +			remote-endpoint = <&dit_p0_0>;
> +		};
> +	};
> +};
> +
>  &spi1 {
>  	status = "okay";
>  
> 

