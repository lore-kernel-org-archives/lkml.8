Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA2C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9434206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgBQJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:49:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34264 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:49:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id r18so19966329edl.1;
        Mon, 17 Feb 2020 01:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYpNZkgMugd7lxhUSqCjHE99UAOTKhfYi8V45j1F/S4=;
        b=eDeDj0fJV6J9/K0WaAjIKJ/pkFTCuArFmkVOENwKjLoM0rTOdC0PacOhReqvHDmKL4
         3WYX5wTMvQBw5k5Oe5wqdCwprorSl+ysRjTp6BOLYJLUw/KewTGBLtWQhcXK0Zx3Dwzm
         KWdhsQcj95FULmeSaNZZOzSOYR3mZ3aC5fheW8vwBl0Ohaoj06tXCMzXmbJQ3JKcayrp
         k4N/sVN7r33RZU/SgAs36pttL/KXPSCBwDmNvPrkrGXmyCaQWfSLlYGs0FLLflhZqHx9
         wRBrL8EQgunIOPqBoXbLW6ZfAezumqZ6XyI5Qdl/rbCTibFRJHAqvbn9U8h56Z7X8FwG
         uXyw==
X-Gm-Message-State: APjAAAWGn2+0clrSkxnB+5xgyQOS/0lWmbMyKKZjM85RYKv+BL+TwcZ5
        ziBXlCL44ZyX7pVdInCW51FbEbelQa0=
X-Google-Smtp-Source: APXvYqwSVFZHFnOpMTnV5Iu9WJJx3X+sWU1HYyFQIufqIAFfvlKuHZnGWRHsASwaqarqjdv/pCnxKQ==
X-Received: by 2002:a17:906:1e48:: with SMTP id i8mr13099279ejj.189.1581932969269;
        Mon, 17 Feb 2020 01:49:29 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id f25sm807396ejx.33.2020.02.17.01.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 01:49:29 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id s10so16443478wmh.3;
        Mon, 17 Feb 2020 01:49:28 -0800 (PST)
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr22802965wmg.16.1581932968319;
 Mon, 17 Feb 2020 01:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-2-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-2-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 17:49:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v670SH1Ra26eKgOhLYAeRTV719a3TDAfCyMr49bKU8Z=PA@mail.gmail.com>
Message-ID: <CAGb2v670SH1Ra26eKgOhLYAeRTV719a3TDAfCyMr49bKU8Z=PA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/34] ASoC: dt-bindings: Add a separate compatible
 for the A64 codec
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:42 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The digital codec in the A64 is largely compatible with the one in the
> A33, with two changes:
>  - It is missing some muxing options for AIF1/2/3 (not currently
>    supported by the driver)

Is this at the pinctrl level or mixer level? If it's at the pinctrl level
then it's out of the scope of this driver/binding. It could very well have
those signals, just that they aren't routed outside the SoC.


ChenYu

>  - It does not have the LRCK inversion issue that A33 has
>
> To fix the Left/Right channel inversion on the A64 caused by the A33
> LRCK fix, we need to introduce a new compatible for the codec in the
> A64.
>
> Cc: stable@kernel.org
> Fixes: ec4a95409d5c ("arm64: dts: allwinner: a64: add nodes necessary for analog sound support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml  | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> index 55d28268d2f4..7c66409f13ea 100644
> --- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> @@ -15,7 +15,9 @@ properties:
>      const: 0
>
>    compatible:
> -    const: allwinner,sun8i-a33-codec
> +    enum:
> +      - allwinner,sun8i-a33-codec
> +      - allwinner,sun50i-a64-codec
>
>    reg:
>      maxItems: 1
> --
> 2.24.1
>
