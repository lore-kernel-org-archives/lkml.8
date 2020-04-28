Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FCDC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4160206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipeT6iMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgD1OaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD1OaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:30:19 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70AC03C1AB;
        Tue, 28 Apr 2020 07:30:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so20462226ilo.6;
        Tue, 28 Apr 2020 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JpPVmG/ic6yi3Tk4GAQi6DB6GCxhlbKT5nO4XO5x++4=;
        b=ipeT6iMZnvOHZp+nbd29xbN+3F4XtHwR0HnaFmlAEmd3xsb6RDgzYxpn8ZDFijCYEg
         k5dE7yv8JOff1Dab/0/7fyVTh8hv9JYG0FS71e5AcxWqUdORGAbesb0dvPXwh1bd7SE3
         2KXB1xW4WKiSNttBfEbuY0YajvNaFl3KBw9K/5UguM9ltO3Xh+cwo3UvTXFYIPSlQEVU
         89Yv8GHfhnkWkqvurh/CSL5ZV7W4f4gxQVRs92epAMEt3+I020alJpPqA5Zrq6RFiq3k
         SI/Zo/DpQTeQNAX792L6jXTTfLOIV8qrs5YTgzwEC+PTpLjlw7RAm1bM3s1bop8fdG2l
         TZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JpPVmG/ic6yi3Tk4GAQi6DB6GCxhlbKT5nO4XO5x++4=;
        b=DCxqbWr1MUBEPL1lDtfHFiXYCn+u4NLj+9gZfQ2cTyHotbZCr2AfhA90+ypuEbtWgw
         xWQfKUugISAYpjkdpcV4McAz2DEp1cEWICZge54c2c5ODR05r9vj3tdoaU+Ry7wWw2QT
         NvhoT/BADwZMI3XncxvgNW5jrx23wCc8qpiL3MQpqL00mOVbzZh0VFqvCnlN9U3ETbnk
         WoX/TJwSocSLXlm+cRMm+Je0xj1UxlSI9w52ngMS5ijUlscXDKBWKXkUM+ruf/Xd/J45
         KccqP20mj4HgiJm+ofsFrzcHx5X1tjc8EkxTQznoNZ1QGMe14PgkS3KtXlON65MvpIaG
         zNjQ==
X-Gm-Message-State: AGi0PuYPXh4SlAhmzEc2+oxbTCe+3C1x0gmKYln+GOLqa0XsuoB5se9P
        xGN58nIgXz624Kly/uOY8Jjq3QooedEVZykcgdk=
X-Google-Smtp-Source: APiQypJoCBUTROFxqXlwhz34VHgNyehOqvvky/DAp7KIJoHxTKkUUYKeoBF1v3WwiPOZFL3Hm+dNa1O7Cnx/FGJIbW0=
X-Received: by 2002:a92:d151:: with SMTP id t17mr4772428ilg.35.1588084217885;
 Tue, 28 Apr 2020 07:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200428142629.8950-1-peron.clem@gmail.com>
In-Reply-To: <20200428142629.8950-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 16:30:06 +0200
Message-ID: <CAJiuCcevho5fGxW+WLHtJAqfYw+desy5-PipBvtz_vbH6EXVPQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: Use dummy regulator for
 Tanix TX6
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

Hi Maxime, Warpme,

On Tue, 28 Apr 2020 at 16:26, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> voltage to meet OPP table, the DVFS is not working as expected.
>
> Avoid to introduce a new dedicated OPP Table where voltage are
> equals to the fixed regulator as it will only duplicate all the OPPs.
> Instead remove the fixed regulator so the DVFS framework will create
> dummy regulator and will have the same behavior.
>
> Add some comments to explain this in the device-tree.

Changes since v1:
I have change this patch to use dummy regulator and add comment about
this choice.
I think it's a bit better than just dropping the regulator.

@Piotr Oniszczuk:
Please add your tested-by tag, to be sure this is working as expected !

Thanks & Regards
Clement

>
> Reported-by: Piotr Oniszczuk <warpme@o2.pl>
> Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables fo=
r Tanix TX6")
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index be81330db14f..3e96fcb317ea 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -48,7 +48,15 @@
>  };
>
>  &cpu0 {
> -       cpu-supply =3D <&reg_vdd_cpu_gpu>;
> +       /*
> +        * Don't specify the CPU regulator, as it's a fixed
> +        * regulator DVFS will not work as it is intructed
> +        * to reach a voltage which can't be reached.
> +        * Not specifying a regulator will create a dummy
> +        * regulator allowing all OPPs.
> +        *
> +        * cpu-supply =3D <&reg_vdd_cpu_gpu>;
> +        */
>  };
>
>  &de {
> @@ -68,7 +76,13 @@
>  };
>
>  &gpu {
> -       mali-supply =3D <&reg_vdd_cpu_gpu>;
> +       /*
> +        * Don't specify the GPU regulator, see comment
> +        * above for the CPU supply.
> +        *
> +        * mali-supply =3D <&reg_vdd_cpu_gpu>;
> +        */
> +
>         status =3D "okay";
>  };
>
> --
> 2.20.1
>
