Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E0524670
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgB0DDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:03:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42088 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgB0DDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:03:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id n18so1146483edw.9;
        Wed, 26 Feb 2020 19:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtHlgLRX0Ly1dpjJoNOMTYupoReKd7p9hU8mplQI2J0=;
        b=qi18pXu48vllfmTBWnTOCPZo+giTSnhbm1MGlL0cuqhQ7aCeMdwiSBGNvmGANFYrEJ
         0XdZUbK+EjS2KgPqA9tfWcKMqmDrOjjUKZQ5umMqKjhlHpRoPE9GjS3CJ9yPkC+xd/K9
         g1jps5kaxT++v4UjkPeVQyoi9R7oAmWMz4Z/Rl44tgWEjOsXWjrphyE8SmugPD8hwwq0
         KxGTKS8LYlHe4tdG9ivE6PhG71Tnr+GEVdkva6+Gk9RXdO26zapoQE9ILdDLHpQF2ze7
         rr7Nnhii92lGCwlw7xwSkp6sReEJ4xaFdwOUbm2O3MxDKXjQPT8iG03Fw+79JbX34SvV
         zMrQ==
X-Gm-Message-State: APjAAAVOnqhS4MFnR7lKGlAAmkrGRp2kGi+457rfzBJEHHkVphZ+gRQ4
        aJbW+yhr89l336cNNNnsE7BsV6G/J8A=
X-Google-Smtp-Source: APXvYqygS8G5dz941BGVWuH7JsFwgF/ReSktIoQ/UJnzU7GZneQ4K5DFx/7iOvzPyRGrErFL1602Lg==
X-Received: by 2002:aa7:c6c5:: with SMTP id b5mr1467529eds.281.1582772595491;
        Wed, 26 Feb 2020 19:03:15 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id q18sm268936eds.7.2020.02.26.19.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 19:03:15 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id z3so1490865wru.3;
        Wed, 26 Feb 2020 19:03:14 -0800 (PST)
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr2035871wrq.104.1582772594580;
 Wed, 26 Feb 2020 19:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20200226183316.26159-1-mans@mansr.com>
In-Reply-To: <20200226183316.26159-1-mans@mansr.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 27 Feb 2020 11:03:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ka=7n0BHw_UDY4AH+PmvEJDTrr8JZUB2e5jCXdgSq3Q@mail.gmail.com>
Message-ID: <CAGb2v67ka=7n0BHw_UDY4AH+PmvEJDTrr8JZUB2e5jCXdgSq3Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sunxi: h3/h5: add r_pwm node
To:     Mans Rullgard <mans@mansr.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:33 AM Mans Rullgard <mans@mansr.com> wrote:
>
> There is a second PWM unit available in the PL I/O block.
> Add a node and pinmux definition for it.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 107eeafad20a..1842c9f12c36 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -871,6 +871,19 @@
>                                 pins = "PL0", "PL1";
>                                 function = "s_i2c";
>                         };
> +
> +                       r_pwm_pins: r-pwm-pins {

Since it's just one pin, you could use the singular form instead.
And also set it as the default.

With that,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +                               pins = "PL10";
> +                               function = "s_pwm";
> +                       };
> +               };
> +
> +               r_pwm: pwm@1f03800 {
> +                       compatible = "allwinner,sun8i-h3-pwm";
> +                       reg = <0x01f03800 0x8>;
> +                       clocks = <&osc24M>;
> +                       #pwm-cells = <3>;
> +                       status = "disabled";
>                 };
>         };
>  };
> --
> 2.25.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
