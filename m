Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFD7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4120792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="shpVXeSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgGUJOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGUJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:14:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F8C0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:14:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so2064957wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=E59bzjWg+c0MHaEx1BoDiS6FYfnfwzF0HRnaYqe7suo=;
        b=shpVXeSITBS4EKpVLrwdRPEWjlOdVZI6BidG4XTDQW2+wUhpxQei7Cuxq6CAnmZCsU
         S/XaADtHoPl0JNTWMqPJmyDNcqdqFQoX4dVjaxya+6vjdpsQrUUDNk1JN6qkztUdDqcb
         UU866k5p6jMaXdiScY9oJhZZoqvCKO7jIf/88rqW6zragfQ16AfDocaKie1uU10/JLh4
         4c5Vr8Ya6KJd/QZBZxVPOJO/qyaWggf4F497tvpmbOlG0f27ZUdJxnnb1rm5/39fEdxF
         reN5whVwlaP3VIGiYNYmlENFVk/uplllFInFLw8FmPTVYwQGLHzQQPOlZv8buvlNcmuI
         /DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=E59bzjWg+c0MHaEx1BoDiS6FYfnfwzF0HRnaYqe7suo=;
        b=hUh8nFQtWZd6Ms6QYMbVQk7blTRZ9kue5MK2B8HViprArgoVfEDevCusvUahTgY1uo
         Y8ZT+T7ZWF75+94rzhC5Y+SksmcGkvqYXp/16Q+uh7tRo3SUj5OgYQjJWLQmQlXJ1wex
         OER+xsxLCXYoHwUal+oOYKSav3SOvzvzlenIwTgesh2oGMMrkQjB28R5BJoAJtLV7RAE
         Tq1FnH0IGfqEhrkS/a/RzMiK0gfHFhIhyggOc+bhJ0y3AwOehhcdZDtraujy8e2WZqcc
         5Dk4OTDM5au8JrUZ8Bax5enIuNTzwKIcbUf6zM7VhCpBzKM0PEVevDiOVLR3zdM+kl8E
         /a6A==
X-Gm-Message-State: AOAM533PiknMcSzLQUI4moIAYM5EtsH1KBR/wwpg4XIBcYmTFCAl3eSh
        BS5nlt3YGIWi7ZVb+/JFjkoU1A==
X-Google-Smtp-Source: ABdhPJxBbU7EYiACWX6oiDhUp9tR7cuERyVtBjdHxSpkHaSwpStuHoOiCT3EbUH505j9OOrf0KN24A==
X-Received: by 2002:a05:600c:282:: with SMTP id 2mr3402783wmk.168.1595322860725;
        Tue, 21 Jul 2020 02:14:20 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m9sm2516472wml.45.2020.07.21.02.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 02:14:19 -0700 (PDT)
References: <20200719141034.8403-1-christianshewitt@gmail.com> <20200719141034.8403-4-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Dongjin Kim <tobetter@hardkernel.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson: add support for the ODROID-N2+
In-reply-to: <20200719141034.8403-4-christianshewitt@gmail.com>
Date:   Tue, 21 Jul 2020 11:14:19 +0200
Message-ID: <1jo8o98c2c.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 19 Jul 2020 at 16:10, Christian Hewitt <christianshewitt@gmail.com> wrote:

> HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of higher
> clock speeds than the original ODROID-N2. Hardkernel supports the big cpu
> cluster at 2.4GHz and the little cpu cluster at 2.0GHz. Opp points and
> regulator changess are from the HardKernel Linux kernel sources.
>
> Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 53 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
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

Are this opp specific to the N2+ or S922x rev C ?
If it is the latter, shouldn't these be in s922x-revC dtsi ?

> +};
> +

