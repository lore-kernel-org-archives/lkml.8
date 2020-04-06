Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C58C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A6320781
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkmsW/xQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgDFJKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:10:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38346 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDFJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:10:18 -0400
Received: by mail-io1-f68.google.com with SMTP id e79so5122781iof.5;
        Mon, 06 Apr 2020 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GIpFRdiLsH923QmyN8wQqcWX+/WhMLr84OozpPJEaUE=;
        b=FkmsW/xQ+XFNOVH8bsSpa35ZszZVS4BIi3STwW48yC47+Y3mnceTZow58CS0jgRcbl
         1Yl3ImvbL1dBSGuQnfOTjy4hZ5i0/X8IRbo7tmWrHRUej0WUf/9bV0TGvlCtCJviiNz2
         Tp9zlpsXdLGHS0NLGsEn/6CU8myL/yHrgsDI/LOstqo/QvF6FKY00rn2OHCS2lzynTCw
         Ad5mlBPrcV/XsuBuMcMyh/VKBAufytMxCy6N8ik7+IPdg2o/akQiCRiOqSxPKi+ryenS
         iNOOIQ8+/0EDZjf0ai2HVaCO2MA+ICpx165GDvumkYzfd1zl1ie+ZgT6naAcLpR7lXwA
         dsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GIpFRdiLsH923QmyN8wQqcWX+/WhMLr84OozpPJEaUE=;
        b=bLfytYO18zJJ7uQiMaFz5/gcV7Jd6D2TAgOyem2dLZybw5iP/GJNTr4U+n1cqbtMMV
         PUrbtMuocMKuB2Vz8VxBuhYnQzqlcZGlBa7r3+0WSPOiKN8tPtG8eJIL4mhiHCdfonNQ
         fLlrvfSMQk8PV0haoGgtYt/DfIUjbaiB00mhGj1iysZVIevLqtlawKrwrwPR8/JWM+78
         L08QnLHEliFvE8X8ZArSrH5DUCsP1QefANxu7SLr6cJTRAVO3EcyZnj/IpVs1+ycrj+m
         UOMXrIyxOsLZY9DrHdwszWNrg5wzNAJobWjw4GeMnoON4LkDlYuQsVOWqVtqm6B0I/8m
         oxzA==
X-Gm-Message-State: AGi0PuZFBz5HsqNrOvhZ0jkRukBxxLftk7uSYzWf/WWG6HtqJozG0LOO
        E2iZYechx9tutTuyPRWMcScT5rjYqVNdOubK7s4=
X-Google-Smtp-Source: APiQypI6WUS4w/Pl7H3i+0Z29uGLfg0BUZ7h87bcQVPI4mu2n4FcYAiepk1wwwunIQdOU5ejrdzdmERAO+JXLVFNamk=
X-Received: by 2002:a6b:14d4:: with SMTP id 203mr3907248iou.123.1586164217295;
 Mon, 06 Apr 2020 02:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200405173601.24331-1-peron.clem@gmail.com> <20200405173601.24331-8-peron.clem@gmail.com>
In-Reply-To: <20200405173601.24331-8-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 6 Apr 2020 11:10:06 +0200
Message-ID: <CAJiuCcdhnCLOfe1t7oFWp8KR+_4gZ-eqpZd7zX1O3OO=5ZMB0w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: h6: Enable CPU and GPU opp
 tables for Orange Pi boards
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

Hi,

On Sun, 5 Apr 2020 at 19:36, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Enable CPU and GPU opp tables for Orange Pi boards.
>
> This needs to change the CPU regulator max voltage to fit
> the OPP table.
>
> Also add the ramp-delay information to avoid any out of spec
> running as the regulator is slower at reaching the voltage
> requested compare to the PLL reaching the frequency.
>
> There is no such information for AXP805 but similar PMIC (AXP813)
> has a DVM (Dynamic Voltage scaling Management) ramp rate equal
> to 2500uV/us.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> index 37f4c57597d4..f3ba500ce4c6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi

Made a mistake here.
Ondrej Jirman test DVFS on Orange Pi 3 board which is not this device-tree =
file.

Will fix in V3.

Regards,
Cl=C3=A9ment

> @@ -5,6 +5,8 @@
>  /dts-v1/;
>
>  #include "sun50i-h6.dtsi"
> +#include "sun50i-h6-cpu-opp.dtsi"
> +#include "sun50i-h6-gpu-opp.dtsi"
>
>  #include <dt-bindings/gpio/gpio.h>
>
> @@ -45,6 +47,10 @@
>         };
>  };
>
> +&cpu0 {
> +       cpu-supply =3D <&reg_dcdca>;
> +};
> +
>  &ehci0 {
>         status =3D "okay";
>  };
> @@ -161,7 +167,8 @@
>                         reg_dcdca: dcdca {
>                                 regulator-always-on;
>                                 regulator-min-microvolt =3D <810000>;
> -                               regulator-max-microvolt =3D <1080000>;
> +                               regulator-max-microvolt =3D <1160000>;
> +                               regulator-ramp-delay =3D <2500>;
>                                 regulator-name =3D "vdd-cpu";
>                         };
>
> @@ -169,6 +176,7 @@
>                                 regulator-enable-ramp-delay =3D <32000>;
>                                 regulator-min-microvolt =3D <810000>;
>                                 regulator-max-microvolt =3D <1080000>;
> +                               regulator-ramp-delay =3D <2500>;
>                                 regulator-name =3D "vdd-gpu";
>                         };
>
> --
> 2.20.1
>
