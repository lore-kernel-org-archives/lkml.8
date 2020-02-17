Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE341C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9052067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jtItyBiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBQHtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:49:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55649 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgBQHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:49:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so16052210wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=lcsYrSRBQv0/tuOiLtIdcGzeEqOZwy/ucgpprLmBBKY=;
        b=jtItyBiUgRgk6BmdYboXya2a/o9c2S21KkV7KiQxBx+O6/WaPpvHVfErJdssFjbZ4i
         P30GjGDkteiyBRZp0k8BhIW+1GcTywIEbovUouGu/OgfmsDsIjMiWshH7A4OKSd28gaH
         p5SS5NkDBquZz6AKGgu5seByFxMBbzCNQHVBbI7NAocYAgt1VqeoXMVMcjdYd9C4ccU6
         LDQwxS+4Xepn/dGwZJkW2wyMnIxyfFq2eDYcMgs9DQ6Dt7px1HlhQqUTSIfbTL6kZZGl
         jVFgUT/VcLP8iDlE2qaccCbQRDlQ7ewgbyFDpZ9SdHnRiRZuTI/jZHIkheuqwFHAzb/k
         Riiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=lcsYrSRBQv0/tuOiLtIdcGzeEqOZwy/ucgpprLmBBKY=;
        b=ljXNxe4FauRpDjO7oPMydqFKkZj5HIz9rLvoYryFt8v2UhDQMgfcUkEX3dZZ/DBsP5
         yM+K52+FlftdiVpd+jvwX4vK+AWrP0IHyztq2fDhyT6EIFASFZUP8i5uxIAMLmroqryu
         p+DJnmkZmTELnQBrL95FYPv3g5TbNlPVo/ryCjUfpDM4x6AxCxaYtZ9r8ISOanJq8ETq
         yEmelHx84LpzHShTJimYcB4b7i3smkqYMnG2QsZpG+ne41DcCgp+DW3BfY/4xkYkCATF
         t0dYTKy/SR1yHc+kxWxfXwFLQpM58TodhBMzhz5G1V8zOmuQ30CZJPy8D0N0fqZ5F+dN
         iosQ==
X-Gm-Message-State: APjAAAVoSkQ/xeOmyl0PJuiTORDcEE+54QkRNXz/23rnAVSlT380VYBH
        xPuY/XceXZqx+FcfskBepKF3ThSrtfY=
X-Google-Smtp-Source: APXvYqyJtjN2qsgU+dia/mVioDpDwyoJ+ti/pQN/I0BI9y/1B7olbgnxkE2KdsFVusIV1tYvrwUnkA==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr20042142wme.94.1581925754379;
        Sun, 16 Feb 2020 23:49:14 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id u23sm19462367wmu.14.2020.02.16.23.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 23:49:13 -0800 (PST)
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-3-linux.amoon@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCHv1 2/3] arm64: dts: meson: Add missing regulator linked to VCCV5 regulator to VDDIO_C/TF_IO
In-reply-to: <20200216173446.1823-3-linux.amoon@gmail.com>
Date:   Mon, 17 Feb 2020 08:49:12 +0100
Message-ID: <1jo8txzm9z.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 16 Feb 2020 at 18:34, Anand Moon <linux.amoon@gmail.com> wrote:

> As per schematics add missing VCCV5 power supply to VDDIO_C/TF_IO
> regulator. Also add TF_3V3N_1V8_EN signal name to gpio pin.

Why ? I don't see the connection with the cover letter here ...

>
> Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> index 353db3b32cc4..23eddff85fe5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> @@ -66,11 +66,14 @@ tf_io: gpio-regulator-tf_io {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <3300000>;
>  
> +		/* TF_3V3N_1V8_EN */
This is not terribly useful ... same for the previous patch

>  		gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
>  		gpios-states = <0>;
>  
>  		states = <3300000 0>,
>  			 <1800000 1>;
> +		/* U16 RT9179GB */
> +		vin-supply = <&vcc_5v>;
That is not parsed and not even part of the gpio regulator binding
documentation. It won't make any difference.

>  	};
>  
>  	flash_1v8: regulator-flash_1v8 {

