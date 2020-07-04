Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481A9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CF6208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQWAZEqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGDKaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGDKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:30:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C92C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:30:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t27so24192979ill.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JDeRcZVfoGltA90a8QgS/WtwNssRIDNDM42hl2S6T40=;
        b=WQWAZEqY2SEvvUEpbpybpsA1iqcSo4g7dAPos+7kEhULe/quJpQy+GmGrPKCNXOE4m
         2RZFf352j2ywRHbPAVM4jljwAExie/6fAsCm409gFn75HKif0LoBlH9UZd57wzH3lafc
         uQ/G2PBalUel/DmLEXARMZVb7hMaYMtJAwcxZx4z62K0/qPw0ntlv6EUWRoxy+AwjprN
         j9AWmMj77qOfsrA0VMhsRx4rZUYbxA1LlSD9Z2oeNPMquOqqvQhp8A6/cRcLNZrTc2Ai
         tO/KRjPjwzqK7u01SF9JYQNAcvuPscmZuAXUoYnEA/Hupox36paHKtg8foQkUbyEnQ76
         FkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JDeRcZVfoGltA90a8QgS/WtwNssRIDNDM42hl2S6T40=;
        b=ul5kTMcBFo+9ODWG6W3Tsux/H9VKOyhYsVff/VZMbL8TSJFhQ1nHkO7dN8qoj/jjuI
         83HbSDIXcCwjid7s2jpgCtPqtm8d7fuRdxC0otvvDz0pJofFhilgT3wWQTh+kEpgl2NS
         OO8aTwee7+tktCKjWOO7BzIVqGpkjEQ6bQ5TWwjnWGbXSlYxi5V5+gwqdptVNs9sjxEH
         t5Ju/BgZKhjOqNQNjS7dIItQk/dMXe/tfZk6xTqpvDTPDESOQn17Z7qMSLiwzCP84oZk
         pNvE/+bcI3/geY5uLQUozN+AkrfiFfyJ+ZLUZSuSqKay/8QMG8cQDznT9KXq6YH7Aknn
         YKmg==
X-Gm-Message-State: AOAM533kBY5PygLLXVjqMCL73ioBjIrmOgCuK5+I7QvX4cWgjgQGa15Q
        XCkIiJ5KPkecQxm4w0/EBRJRG3Uztqu3+UPjs2Q=
X-Google-Smtp-Source: ABdhPJztSdHZBJE7E1SqDWxQkz41nlFR4XcRudO7iI1w/ncHQvv1MpqmX5X9N0kyjGV6PNYEiETKIS3CH4KD2W90xYA=
X-Received: by 2002:a92:d811:: with SMTP id y17mr19822262ilm.35.1593858619275;
 Sat, 04 Jul 2020 03:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200704102535.189647-1-peron.clem@gmail.com> <20200704102535.189647-15-peron.clem@gmail.com>
In-Reply-To: <20200704102535.189647-15-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 4 Jul 2020 12:30:08 +0200
Message-ID: <CAJiuCcf8fi_w0-Xo=MMMv=5jBqcS68jEbjbo4NvVR24b4BuZHg@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] [DO NOT MERGE] arm64: dts: allwinner: force GPU
 regulator to be always
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 4 Jul 2020 at 12:25, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 3f7ceeb1a767..14257f7476b8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -245,6 +245,7 @@ reg_dcdca: dcdca {
>                         };
>
>                         reg_dcdcc: dcdcc {
> +                               regulator-always-on;

This patch is normally no more required since this serie:
https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.o=
rg/

>                                 regulator-enable-ramp-delay =3D <32000>;
>                                 regulator-min-microvolt =3D <810000>;
>                                 regulator-max-microvolt =3D <1080000>;
> --
> 2.25.1
>
