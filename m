Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD384C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C6921582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDJ/IO44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgDWHsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgDWHsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:48:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E422C03C1AB;
        Thu, 23 Apr 2020 00:48:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id e9so5400930iok.9;
        Thu, 23 Apr 2020 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k3ka4IDV0cfMC6JOHC5pyroHAb+x5SRkSxbfLcsX5AI=;
        b=KDJ/IO44uPtjl2XWhzmum5A4fMJBp7vQqZwQzQ+US4SAkUCIirgn/jct+7xssD9zOp
         vT2pT9hRxu30Wumt3Hww6OyljA9oitrYq0PpUhha16y8Y6Q694+KAuseOLarKP14AAsT
         1oUukmeBzmLwXcTaiLVXBTjLIWff9ezBiBv4IFc6Ez8360JCCtbb8wmVQu0LhdO/zGjB
         e3TleiTgZ9sCrcf1U0JWtCsEfhS3zoCPlgCqmOZwt2wWCNar75PxNIMh2Vg5W2WArbkW
         3SQRoIu2On3JnM/sRhDnvpNk4DvqeceJB7N20Zh7k6DwEJ1NzldKFDY1RTwJ9qpEWt2+
         F3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k3ka4IDV0cfMC6JOHC5pyroHAb+x5SRkSxbfLcsX5AI=;
        b=HAsTtJwVWSRXfTULuzXx77JU80THUUVzHu3DnE2JgTjr765KlJtrV9/2UiXMhCUK8X
         VfU+azSMpUiAHDiBHNrnuRnjXS47mGgP0EkRaIrBTSR/uqg4vjk3+s3wzPMAs39F8ngd
         fSiq88Fke5gSw21VsKQcm48w6x7Gfv0U0FZGvJuDaY2b3FYS7flPCJdnQcPRE8CJmgqR
         SUHrrbocTQpKy3szZivySJLJL+zOyQKQmbWWCiU3E8tzMNiTcV5bnyGig49ZKc2MOCot
         jTQc+KNXFznSTj1viWmjES1FeXmtkTtZInxqyeZtty46a2IBxquox0hZU8afLwEzfUaR
         kUnA==
X-Gm-Message-State: AGi0PuYZpcrbYi+g625nlP2nzxc6xYgW0GVJyVid6BfkbedxpOJJi886
        3jw5p6hGrzTguP+vi/Sykm4NX1ecA8EyqqVpsgZcq39lxmE=
X-Google-Smtp-Source: APiQypK3bXLrqegiRC0mn5WNVpUFxtcYS22c8Po7fiuvhC6lKHUZty/5o7tA7EcbYgzAbCA0UpccFg8ENAtlzxNrMwQ=
X-Received: by 2002:a02:3b4b:: with SMTP id i11mr2162238jaf.16.1587628098711;
 Thu, 23 Apr 2020 00:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200420143016.16835-1-peron.clem@gmail.com>
In-Reply-To: <20200420143016.16835-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 23 Apr 2020 09:48:07 +0200
Message-ID: <CAJiuCccZ6OJXYBZiCnO4VmOQ2WB0CwOsVe6oaU-t5_iiovLzWw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: fix cooling-cell property
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 20 Apr 2020 at 16:30, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> We define cooling-cells property for CPUs only for board including
> the sun50i-h6-cpu-opp.dtsi. As not all boards have the CPU OPP
> dtsi file included this create a warning because the cooling-maps
> is defined but not the cooling-cells property in CPU nodes.

This fix some warnings introduced by the H6 DVFS serie that I sent last wee=
k...

The cooling-cells has been introduced in
7e4bbf3fe67c ("arm64: dts: allwinner: h6: Add CPU Operating
Performance Points table")

instead of
5fc0928782e9 ("arm64: dts: allwinner: h6: Add thermal trip points/cooling m=
ap")

Do you plan to squash it? If yes do you want me to sent two patches
separately (it will be a bit easier to squash them)?

Regards,
Clement

>
> Move the cooling-cells to the sun50i-h6.dtsi instead of the
> sun50i-h6-cpu-opp.dtsi
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 4 ----
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi         | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi b/arch/=
arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
> index 9ebd97b04b1a..dcb789519797 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
> @@ -102,20 +102,16 @@
>
>  &cpu0 {
>         operating-points-v2 =3D <&cpu_opp_table>;
> -       #cooling-cells =3D <2>;
>  };
>
>  &cpu1 {
>         operating-points-v2 =3D <&cpu_opp_table>;
> -       #cooling-cells =3D <2>;
>  };
>
>  &cpu2 {
>         operating-points-v2 =3D <&cpu_opp_table>;
> -       #cooling-cells =3D <2>;
>  };
>
>  &cpu3 {
>         operating-points-v2 =3D <&cpu_opp_table>;
> -       #cooling-cells =3D <2>;
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 83e32f9c4977..2e31632c6ca8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -27,6 +27,7 @@
>                         enable-method =3D "psci";
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu1: cpu@1 {
> @@ -36,6 +37,7 @@
>                         enable-method =3D "psci";
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu2: cpu@2 {
> @@ -45,6 +47,7 @@
>                         enable-method =3D "psci";
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu3: cpu@3 {
> @@ -54,6 +57,7 @@
>                         enable-method =3D "psci";
>                         clocks =3D <&ccu CLK_CPUX>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       #cooling-cells =3D <2>;
>                 };
>         };
>
> --
> 2.20.1
>
