Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3CAC433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0325620776
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVoIE2zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgH2Ubr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgH2Ubp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 16:31:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC057C061236;
        Sat, 29 Aug 2020 13:31:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a12so2080897eds.13;
        Sat, 29 Aug 2020 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tAoCr0VCeK5KcMwknjMyq6oj1L3l2+lCy1t0IF04zBc=;
        b=iVoIE2zjoHSzIAK+z94dBG3y14lZJ37XXCfKo2FMoOM65p6Yagm8YGW83fSq/BO4Lw
         5bWxjxN7srhtFDY3J5Q1IiWfcP4G31LaxWztdc7mz63QiMBtLNg49Ygc8HiGgYfwmFfV
         rc4v+RS12QGHxUZG/fK9DqUjOsR3A14/UzYURb7RxgfAAb0adA+HrUXJBEgOosA6DUB9
         piYQA3khcctdGezFgcE0CixbgaLVFM8EnJRlKQg0WDNjQSo2n8Iw5oIqXMlrE5lMatQw
         SExLpD7jrAFoG0ePEeLEjRzuChHoiRUGRoSl3X9t3eXMMbq5QfA4Hja+CCJlLchREDHw
         nwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tAoCr0VCeK5KcMwknjMyq6oj1L3l2+lCy1t0IF04zBc=;
        b=Vo2z1X9zBv36YhBQ3pLCLphiyDjsTrVVVqQ4jGMYj9b8or2M6XhsgfMHisvy6CoxeP
         Gn5eWVvYGpodnh1TO/38OCTqRccj1EmksUDVlRGhawDlNXrgzNO2IvI+M9fcXejkwUM6
         HhdUHW8NWCCVfOyv1ttylI5MQMfnvuZxHPFtdvC+6xkHGRZG/7s1blPSrXIUBAQMqZsa
         bTBdWvFz0mbm05QHmhbt2Gwpi2f/CnPJo8Zmh3zuKT6MFBmbprOBsdt/+CCfnZ5UFgBf
         kPNueyM/mSKFCGv5hcdG4EnfaOFahO0FXiD687hbSs9O0265VPiE000Crj5HbHiY38if
         NKwg==
X-Gm-Message-State: AOAM530Xr9uuH6HxwARmJut+S3oESCkqrxEnR101fudeNipDgsMGmZKM
        nHEPz11LFDi63z/JD7aCu7AjSHCRado=
X-Google-Smtp-Source: ABdhPJwR+ih3tePsg9LFgIH5cWODQaSiv61g5vPSa38l0AkmEBEQ645GZAoQGieS4pSUYtigmIDT+A==
X-Received: by 2002:aa7:d68f:: with SMTP id d15mr4844255edr.69.1598733102724;
        Sat, 29 Aug 2020 13:31:42 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id dm22sm69847edb.49.2020.08.29.13.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 13:31:42 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] arm64: dts: rockchip: px30: Add Engicam EDIMM2.2
 Starter Kit
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
 <20200829155823.247360-3-jagan@amarulasolutions.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <25b87188-bd06-90da-b2ce-bbfdb716e00a@gmail.com>
Date:   Sat, 29 Aug 2020 22:31:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200829155823.247360-3-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On 8/29/20 5:58 PM, Jagan Teki wrote:
> Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
> Evaluation Board.
> 
> Genaral features:
> - LCD 7" C.Touch
> - microSD slot
> - Ethernet 1Gb
> - Wifi/BT
> - 2x LVDS Full HD interfaces
> - 3x USB 2.0
> - 1x USB 3.0
> - HDMI Out
> - Mini PCIe
> - MIPI CSI
> - 2x CAN
> - Audio Out
> 
> SOM's like PX30.Core needs to mount on top of this Evaluation board
> for creating complete PX30.Core EDIMM2.2 Starter Kit.
> 
> Add support for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - move carrier enablement nodes in carrier dtsi
> 
>  .../dts/rockchip/px30-engicam-common.dtsi     | 39 +++++++++++++++++++
>  .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |  7 ++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
> new file mode 100644
> index 000000000000..4e85c1a690e5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +/ {
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";

Just one of the exceptions to the sort rule...

		regulator-name = "vcc5v0_sys";	/* +5V */

> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;

> +		regulator-name = "vcc5v0_sys";	/* +5V */

Move on top of the other regulator properties.
Same goes for the regulators in px30-px30-core.dtsi.

> +	};
> +};
> +
> +&gmac {
> +	clock_in_out = "output";
> +	phy-supply = <&vcc_3v3>;	/* +3V3_SOM */
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 50000 50000>;
> +	snps,reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&sdmmc {

> +	cap-mmc-highspeed;

Remove.
Board only has a micro-SD card.

> +	cap-sd-highspeed;
> +	card-detect-delay = <800>;

> +	vqmmc-supply = <&vcc_3v3>;
> +	vmmc-supply = <&vcc_3v3>;	/* +3V3_SOM */

sort

> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2m1_xfer>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
> new file mode 100644
> index 000000000000..cb00988953e9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +#include "px30-engicam-common.dtsi"
> 

