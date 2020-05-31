Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B075C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5826020776
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590883376;
	bh=4kQfV8Z5NM+yv61ENjp90Sn1Rp/tfJj+VqnQHQ+4R9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qU0Ax3zJgZRTZd/S1ATB5cnxgvlue68S0y1j3dS47I7e9wq6RD0nfrP6Ip4+AsEKx
	 beLUaGndIsfvolWrMYWDvYK2imzJVZPQIORyGEhZWoVXfz2frQsgKAzfGcZwBU0reC
	 054r+Omed8fCNTfdxJ9XIq1kC6GZJ0dKAFjlUhBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgEaACw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 20:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbgEaACw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 20:02:52 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3662207BB;
        Sun, 31 May 2020 00:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590883371;
        bh=4kQfV8Z5NM+yv61ENjp90Sn1Rp/tfJj+VqnQHQ+4R9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=12M1Hve3RHexJsmswOs0TlhMFJARWj0+2NznHPBBm83jla4rExldF3IvR1HOx1JGF
         r16MrMY789R0ouRaSPystO3TUEtxcisQrWmXo5EpDSfQ4b7bhFNTCJp1LAKXrv3QIL
         u90JT/e+vl3cRcehJnN74mErRNLD+GKBUtaQRjk4=
Received: by mail-lj1-f181.google.com with SMTP id k5so3696888lji.11;
        Sat, 30 May 2020 17:02:50 -0700 (PDT)
X-Gm-Message-State: AOAM531aps7CfjBBS6WixSfLxK1CUExTk/XXzF1gYD9FDrQRkdOmDEjP
        5Wf69Sr5DnVA6rCQkEtb2cAMUa/lJBfPtPo2UAE=
X-Google-Smtp-Source: ABdhPJy+whAFBYV/fP7KNi+oY3T4bic8rdTdkffy4fJ20iLO1POc6g0O/PC7z3+uiuU/GjVeqLatWylwfkZl4RfapeQ=
X-Received: by 2002:a05:651c:1130:: with SMTP id e16mr7569379ljo.10.1590883369324;
 Sat, 30 May 2020 17:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200529163226eucas1p15bea74bed9cc5d22727c9ba732a5cbb9@eucas1p1.samsung.com>
 <20200529163200.18031-1-s.nawrocki@samsung.com> <20200529163200.18031-5-s.nawrocki@samsung.com>
In-Reply-To: <20200529163200.18031-5-s.nawrocki@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 31 May 2020 09:02:13 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0wdAdEFJ74USv62MXxs=Ytx0g_pFNG4B9DpUnNqDcY7w@mail.gmail.com>
Message-ID: <CAGTfZH0wdAdEFJ74USv62MXxs=Ytx0g_pFNG4B9DpUnNqDcY7w@mail.gmail.com>
Subject: Re: [RFC PATCH v5 4/6] ARM: dts: exynos: Add interconnect properties
 to Exynos4412 bus nodes
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On Sat, May 30, 2020 at 1:33 AM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> This patch adds the following properties for Exynos4412 interconnect
> bus nodes:
>  - samsung,interconnect-parent: to declare connections between
>    nodes in order to guarantee PM QoS requirements between nodes;
>  - #interconnect-cells: required by the interconnect framework.
>
> Note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - add properties in common exynos4412.dtsi file rather than
>    in Odroid specific odroid4412-odroid-common.dtsi.
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos=
4412.dtsi
> index 4886894..a7496d3 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -381,6 +381,7 @@
>                         clocks =3D <&clock CLK_DIV_DMC>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_dmc_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -450,6 +451,8 @@
>                         clocks =3D <&clock CLK_DIV_GDL>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_leftbus_opp_table>;
> +                       samsung,interconnect-parent =3D <&bus_dmc>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -466,6 +469,8 @@
>                         clocks =3D <&clock CLK_ACLK160>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_display_opp_table>;
> +                       samsung,interconnect-parent =3D <&bus_leftbus>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> --
> 2.7.4
>

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
