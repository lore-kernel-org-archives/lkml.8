Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1989C20825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="cKt3xtSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbgGVXDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:03:21 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D6C0619DC;
        Wed, 22 Jul 2020 16:03:21 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D28885C3C5A;
        Thu, 23 Jul 2020 01:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1595458998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdMZJqRkVGvuWEDFrcGlBP7yBOdaxQVCDcUt6SHzHQg=;
        b=cKt3xtSu46nk8Lwaf8+GZ04qFypC6ZpJQSjGkh8auUvRnBlnXOgNRKPBh5ewMryAh+/0qy
        +6BxM/HIGRpokoTk/d0r4vUcn09Aw/h/YydoIkfL7XTX6k0KJDuKZ9ynSWyE1hIcBuXlzN
        Q/2hK0IdSNKG/WqSSB7KyHTgvS6dcUI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Jul 2020 01:03:18 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@hardkernel.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson: add support for the ODROID-N2+
In-Reply-To: <20200719141034.8403-4-christianshewitt@gmail.com>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
 <20200719141034.8403-4-christianshewitt@gmail.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <9e2894b3ad0311dcd8179237305d1cd5@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 2020-07-19 16:10, Christian Hewitt wrote:
> HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of higher
> clock speeds than the original ODROID-N2. Hardkernel supports the big cpu
> cluster at 2.4GHz and the little cpu cluster at 2.0GHz. Opp points and
> regulator changess are from the HardKernel Linux kernel sources.

According to the ODROID wiki those values are already in the
overclocking range:
https://wiki.odroid.com/odroid-n2/hardware/overclocking

From what I can tell, for ODROID-N2 upstream Linux so far used defaults
from meson-g12b-s922x.dtsi, which were 1896MHz for the A53 and 1704MHz
for the A73 (so it seems currently the A73 running even 100MHz below
"Stock").

I guess we should pick either Stock or Overclock for the two models.
Unless there is another good reason not to?

--
Stefan

> 
> Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 53 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile
> b/arch/arm64/boot/dts/amlogic/Makefile
> index 5cac4d1d487d..6dc508b80133 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> new file mode 100644
> index 000000000000..99e96be509f8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12b-odroid-n2.dtsi"
> +
> +/ {
> +	compatible = "hardkernel,odroid-n2-plus", "amlogic,s922x", "amlogic,g12b";
> +	model = "Hardkernel ODROID-N2+";
> +
> +	vddcpu_a: regulator-vddcpu-a {
> +		regulator-min-microvolt = <680000>;
> +		regulator-max-microvolt = <1040000>;
> +
> +		pwms = <&pwm_ab 0 1500 0>;
> +	};
> +
> +	vddcpu_b: regulator-vddcpu-b {
> +		regulator-min-microvolt = <680000>;
> +		regulator-max-microvolt = <1040000>;
> +
> +		pwms = <&pwm_AO_cd 1 1500 0>;
> +	};
> +
> +	cpu_opp_table_0: opp-table-0 {
> +		opp-1908000000 {
> +			opp-hz = /bits/ 64 <1908000000>;
> +			opp-microvolt = <1030000>;
> +		};
> +
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1040000>;
> +		};
> +	};
> +
> +	cpub_opp_table_1: opp-table-1 {
> +		opp-2304000000 {
> +			opp-hz = /bits/ 64 <2304000000>;
> +			opp-microvolt = <1030000>;
> +		};
> +
> +		opp-2400000000 {
> +			opp-hz = /bits/ 64 <2400000000>;
> +			opp-microvolt = <1040000>;
> +		};
> +	};
> +};
> +
