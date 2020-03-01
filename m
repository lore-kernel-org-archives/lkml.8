Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB508C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5E214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysXG6e0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCAJDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 04:03:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43455 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCAJDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 04:03:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id e10so7185230wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 01:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=slGxF9qjBPq+owUSM5HA+cWARavYP/l9u8125Kfep3Q=;
        b=ysXG6e0H6OQFTHDPORu3KqmtZFiQlM47kqdFx1B5YIYLXT2JjdB3lFv5ZvWuoc5Uf2
         2ExWooxYZxvazVD7HS0V/wsSLraVjM4T7MzY+X9H66arzNt5PF+6ekFF4NM/coFnhNnF
         CY6A4onQ8ripK7vv/LaV32Ev8sq/wZ/zMC5nbJOixLWMpH7F9ez0JyXdaLdB8bVtlfGY
         NB6yZlk3YykB8hgqRBM+BBI7zSIOASFF8cKkEE1sp0YGouJeRrqIJpQCpUk8hIj3/ZJZ
         u4Qw0RHCF5e1fG8jwW0izXtWOXYuiNTeIxEg7CKuPPIyM72JiYxDqViQOBpFcRI0tcro
         W9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=slGxF9qjBPq+owUSM5HA+cWARavYP/l9u8125Kfep3Q=;
        b=EUCOlz8a8R99Vxu7Fz9AsxMJ03kLU7sAkFLo/f1mawWznX5E7f3MDiopdyGWb9t+M7
         dOe9MeeWdduo/GzPGolmzoZmrNi9GYyeQCB5M+oMjlbIf2sXhZ86xMCEJwf83Ctk1+t8
         d5SxEPjD2XwA4RAKZeApPU3+LxY0Ju0kl/5CbnOob1R9YmJUKFSxTuKOxh6NzGxs4SNj
         iulTYgNWff6Biiyf0kRO1cH4Un5D1WyFflEDPm4RhrN38M1Ln4MhrV1FGgfb9AJXkD05
         C0CCUT5YPSWH4scs6RnPG1DFe2N+sHl2QAD71fXe9P3e0ReuTnrTiIxhB8bbimtIid9P
         2DsQ==
X-Gm-Message-State: APjAAAXnZq+fnMcqkMBTKw3v494SRlQIoQuKqZwkzOo/w3A5aJWo0vfw
        rkkZHDzbaHJt4bu1c6R8tpvi1P/ksaE=
X-Google-Smtp-Source: APXvYqwtqzLgXYZckgw7NwmNvCx/NUB+nLWIm0ENVHSQDAr8KR8jLjFUPo6/biQfCdmVDAcJqc+snQ==
X-Received: by 2002:adf:a304:: with SMTP id c4mr14879111wrb.186.1583053379973;
        Sun, 01 Mar 2020 01:02:59 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:41d5:595f:62f:a254? ([2a01:e34:ed2f:f020:41d5:595f:62f:a254])
        by smtp.googlemail.com with ESMTPSA id i8sm15585002wrq.10.2020.03.01.01.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 01:02:59 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: Add txpbl node for RK3399/RK3328
To:     Carlos de Paula <me@carlosedp.com>
Cc:     papadakospan@gmail.com, jose.abreu@synopsys.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Peter Geis <pgwipeout@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200218221040.10955-1-me@carlosedp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <92930c13-3538-32a7-b016-4150bcbc0e56@linaro.org>
Date:   Sun, 1 Mar 2020 10:02:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218221040.10955-1-me@carlosedp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 23:10, Carlos de Paula wrote:
> Some rockchip SoCs like the RK3399 and RK3328 exhibit an issue
> where tx checksumming does not work with packets larger than 1498.
> 
> The default Programmable Buffer Length for TX in these GMAC's is
> not suitable for MTUs higher than 1498. The workaround is to disable
> TX offloading with 'ethtool -K eth0 tx off rx off' causing performance
> impacts as it disables hardware checksumming.
> 
> This patch sets snps,txpbl to 0x4 which is a safe number tested ok for
> the most popular MTU value of 1500.

What about using something like:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt#n16

or

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-controller.yaml#n37

?

> For reference, see https://lkml.org/lkml/2019/4/1/1382.
> 
> Signed-off-by: Carlos de Paula <me@carlosedp.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 ++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 1f53ead52c7f..b7f1de4b7fd0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -906,6 +906,7 @@
>  		resets = <&cru SRST_GMAC2IO_A>;
>  		reset-names = "stmmaceth";
>  		rockchip,grf = <&grf>;
> +		snps,txpbl = <0x4>;
>  		status = "disabled";
>  	};
>  
> @@ -913,6 +914,7 @@
>  		compatible = "rockchip,rk3328-gmac";
>  		reg = <0x0 0xff550000 0x0 0x10000>;
>  		rockchip,grf = <&grf>;
> +		snps,txpbl = <0x4>;
>  		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "macirq";
>  		clocks = <&cru SCLK_MAC2PHY_SRC>, <&cru SCLK_MAC2PHY_RXTX>,
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 33cc21fcf4c1..cd5415d7e559 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -288,6 +288,7 @@
>  		resets = <&cru SRST_A_GMAC>;
>  		reset-names = "stmmaceth";
>  		rockchip,grf = <&grf>;
> +		snps,txpbl = <0x4>;
>  		status = "disabled";
>  	};
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

