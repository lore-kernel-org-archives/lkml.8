Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89DB207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590883308;
	bh=2p4SBOzIcxqldDQV+EgA8g75sZR4n3jmr6ytOgA1hPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kFz09HF8fJawxPNtTBoYVOffmmPdAW/zGuxBGh8rIHjcKkkyRXKcW9+HwIcuHGHwM
	 7zemKtScERskPPf8+lppyZNPgg7B6fLBQl92UQ3HcJaoXjHOu6ZXsh2v436w+hB5xC
	 Fmg2+cP/rwTwJ0LmQQnUUBHCDsN0HCAAtBLYJUFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgEaABk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 20:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbgEaABj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 20:01:39 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ABCB207DF;
        Sun, 31 May 2020 00:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590883298;
        bh=2p4SBOzIcxqldDQV+EgA8g75sZR4n3jmr6ytOgA1hPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LAZ2ml8d4tllly6yUKcA/bFgxj/GgNzOm0gXCJCNiuDci5YuQ5r4pMox+T1OJYV72
         5PjXNv1Y5hW8w24ZrhtxIMQ3p8jB3cTQoOBZT4n+D+hRCfoeplyK67Lrya9geraBXN
         ab34i9F2dcOBC5NYC1slzpGFwKQ7Cuys08WeKMAk=
Received: by mail-lj1-f180.google.com with SMTP id z18so3687865lji.12;
        Sat, 30 May 2020 17:01:38 -0700 (PDT)
X-Gm-Message-State: AOAM530GAHJBTAO4A3QsHV+IQFbkbAc+8d4aCdwUxV165OamenzaMnBE
        7FMztQZtLLsjG0ltit6fQpbcvJ/iDmCPmPUt2qE=
X-Google-Smtp-Source: ABdhPJzU/8i47JcqsMEUq8jJ7WZ2YavPcT4Y4tu7MIIVGyb75w7ekgPJ3jPOCNAUup5FQRQs5D0G9kNh1jYivsMC+Lo=
X-Received: by 2002:a2e:b5b0:: with SMTP id f16mr7700307ljn.100.1590883296477;
 Sat, 30 May 2020 17:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e@eucas1p2.samsung.com>
 <20200529163200.18031-1-s.nawrocki@samsung.com> <20200529163200.18031-2-s.nawrocki@samsung.com>
In-Reply-To: <20200529163200.18031-2-s.nawrocki@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 31 May 2020 09:01:00 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1yM0KRaEF5VTs2juTm+yrK9VqQZxWjdNf_ffjGHWPLsg@mail.gmail.com>
Message-ID: <CAGTfZH1yM0KRaEF5VTs2juTm+yrK9VqQZxWjdNf_ffjGHWPLsg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/6] dt-bindings: exynos-bus: Add documentation for
 interconnect properties
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


On Sat, May 30, 2020 at 1:32 AM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Add documentation for new optional properties in the exynos bus nodes:
> samsung,interconnect-parent, #interconnect-cells.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 15 ++++++++++=
+++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/D=
ocumentation/devicetree/bindings/devfreq/exynos-bus.txt
> index e71f752..e0d2daa 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -51,6 +51,11 @@ Optional properties only for parent bus device:
>  - exynos,saturation-ratio: the percentage value which is used to calibra=
te
>                         the performance count against total cycle count.
>
> +Optional properties for interconnect functionality (QoS frequency constr=
aints):
> +- samsung,interconnect-parent: phandle to the parent interconnect node; =
for
> +  passive devices should point to same node as the exynos,parent-bus pro=
perty.
> +- #interconnect-cells: should be 0
> +
>  Detailed correlation between sub-blocks and power line according to Exyn=
os SoC:
>  - In case of Exynos3250, there are two power line as following:
>         VDD_MIF |--- DMC
> @@ -185,8 +190,9 @@ Example1:
>         ----------------------------------------------------------
>
>  Example2 :
> -       The bus of DMC (Dynamic Memory Controller) block in exynos3250.dt=
si
> -       is listed below:
> +       The bus of DMC (Dynamic Memory Controller) block in exynos3250.dt=
si is
> +       listed below. An interconnect path "bus_lcd0 -- bus_leftbus -- bu=
s_dmc"
> +       is defined for demonstration purposes.
>
>         bus_dmc: bus_dmc {
>                 compatible =3D "samsung,exynos-bus";
> @@ -376,12 +382,15 @@ Example2 :
>         &bus_dmc {
>                 devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>                 vdd-supply =3D <&buck1_reg>;      /* VDD_MIF */
> +               #interconnect-cells =3D <0>;
>                 status =3D "okay";
>         };
>
>         &bus_leftbus {
>                 devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>                 vdd-supply =3D <&buck3_reg>;
> +               samsung,interconnect-parent =3D <&bus_dmc>;
> +               #interconnect-cells =3D <0>;
>                 status =3D "okay";
>         };
>
> @@ -392,6 +401,8 @@ Example2 :
>
>         &bus_lcd0 {
>                 devfreq =3D <&bus_leftbus>;
> +               samsung,interconnect-parent =3D <&bus_leftbus>;
> +               #interconnect-cells =3D <0>;
>                 status =3D "okay";
>         };
>
> --
> 2.7.4
>

If you add the usage example like the mixer device of patch5 to this
dt-binding document,
I think it is very beneficial and more helpful for user of
exynos-bus/exynos-generic-icc.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

--
Best Regards,
Chanwoo Choi
Samsung Electronics
