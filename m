Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86879C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B6120700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAi9kUho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgDZMSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:18:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2CC061A0E;
        Sun, 26 Apr 2020 05:18:17 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i16so14049808ils.12;
        Sun, 26 Apr 2020 05:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pnYdgmQFzwhGmDvDPiH/jDwjweMNfoD46y/Y/YmZg10=;
        b=pAi9kUhoZ/Qjs8l84NpVVssFY8uSsu6LKAwtrc3pq83VPsGi48uUd/NV12A9px1xae
         g4LubnCzeRTAW3FSOwhW1SgNb98QvW1B0qi1cVcQsvc5DUpGwlMmcq+QgRQU2NBGg0F5
         lS/lTGusPWyVcGrfbryvjemU/W2dQVX1C/X2u3hcZ3X4aJkhN024LnrhuKj3ZDcNfXpN
         VGdtN2YZ44gfUGTf9rQE+Ec37V5rAoBNI6EHVSQo0qP6ZlZd79KhUr9ZA61vfXA7SEqe
         ihsNWxVNf00/cVSS1U8WLDnvpbhxKUE1sVTTRfyxYCRcGVLW75Qh8IcNfjtkLipXtFQF
         vR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pnYdgmQFzwhGmDvDPiH/jDwjweMNfoD46y/Y/YmZg10=;
        b=LXvZEwMBa6LglJA386xg9A1xlFsYkdYj7iAeF+kHE9KllyogymQRE3KQ74TTz8K2Pd
         3ZFDUIfsojzbyL7/1coHQnGNJzAwL80NnBzaaID2l1Gil7TVZDCHMfWjmUPnUoL+aEoq
         DOy9x28PZQrwn2FrcOWvRyrGumBpl/sIaCLaOiXAZjohATDA5L1nop+DuDWPLaq9UQ13
         /t/KY4uYybXpITXAjyN1SVG9G4M8kwHL773nUgsJe6P0Iu2LtCtGr9YrMS1dhdEUjIIh
         Ar5ZD+efE2JRqZ+XTb9PcyLdS8Zn9Fx1NAqGA9cJKbrcFBLexOAA++LOo65YmkTz68X7
         hELQ==
X-Gm-Message-State: AGi0PuYGDYOKLiG27eBa4T5s/9FSeKyftrtOsGc9rmwwKOu2zJy9Y3WI
        3q+KY5px0QK43ciU06ZhfkqKcHxz6IFJrmvNve0=
X-Google-Smtp-Source: APiQypKrdPuEZGu5BM7WAtgp8dotSKhkd5VuYDkUEwAH98HM5hfJjwS7qSjm3rozkhfzgkjuuzZn6yfB/RvFoZbagQw=
X-Received: by 2002:a92:3a48:: with SMTP id h69mr16189042ila.150.1587903496623;
 Sun, 26 Apr 2020 05:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200426121709.1216-1-peron.clem@gmail.com>
In-Reply-To: <20200426121709.1216-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 26 Apr 2020 14:18:05 +0200
Message-ID: <CAJiuCcfA1f6Q8QN-Y0X5WDKciczLAJ7TWNGr5x3N7X0VGtL2NQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Use dedicated CPU OPP table
 for Tanix TX6
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Warpme,

On Sun, 26 Apr 2020 at 14:17, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> voltage to meet OPP table. The DVFS is not working as expected.
>
> Introduce a dedicated OPP Table where voltage are equals to
> the fixed regulator.
>
> Reported-by: Piotr Oniszczuk <warpme@o2.pl>
> Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables fo=
r Tanix TX6")
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Could you confirm this patch fixed your issue?

If yes could you add your tested-by tag ?

Thanks,
Clement

> ---
>  .../sun50i-h6-tanix-tx6-cpu-opp.dtsi          | 116 ++++++++++++++++++
>  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |   2 +-
>  2 files changed, 117 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu=
-opp.dtsi
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu-opp.dt=
si b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..062940115563
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu-opp.dtsi
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2020 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> +
> +/ {
> +       cpu_opp_table: cpu-opp-table {
> +               compatible =3D "allwinner,sun50i-h6-operating-points";
> +               nvmem-cells =3D <&cpu_speed_grade>;
> +               opp-shared;
> +
> +               opp@480000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <480000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@720000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <720000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@816000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <816000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@888000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <888000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@1080000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <1080000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@1320000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <1320000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@1488000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <1488000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@1608000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <1608000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@1704000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <1704000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +
> +               opp@1800000000 {
> +                       clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> +                       opp-hz =3D /bits/ 64 <1800000000>;
> +
> +                       opp-microvolt-speed0 =3D <1135000>;
> +                       opp-microvolt-speed1 =3D <1135000>;
> +                       opp-microvolt-speed2 =3D <1135000>;
> +               };
> +       };
> +};
> +
> +&cpu0 {
> +       operating-points-v2 =3D <&cpu_opp_table>;
> +};
> +
> +&cpu1 {
> +       operating-points-v2 =3D <&cpu_opp_table>;
> +};
> +
> +&cpu2 {
> +       operating-points-v2 =3D <&cpu_opp_table>;
> +};
> +
> +&cpu3 {
> +       operating-points-v2 =3D <&cpu_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index be81330db14f..3eaa4f49e3d3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -4,7 +4,7 @@
>  /dts-v1/;
>
>  #include "sun50i-h6.dtsi"
> -#include "sun50i-h6-cpu-opp.dtsi"
> +#inlcude "sun50i-h6-tanix-tx6-cpu-opp.dtsi"
>
>  #include <dt-bindings/gpio/gpio.h>
>
> --
> 2.20.1
>
