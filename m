Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FBDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F272076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f61pGcyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHYPLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgHYPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:11:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:11:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id md23so16286943ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kkcIDEMAHBCOzJLj2phW4jww4X/yisWa3CZ5tOxvSy4=;
        b=f61pGcyw2k5WAoqjit//rvWYqG3FsaVEI4d9ZxtxKUV8x7SNaHgSg/hC+1348B6YxP
         vnIo+SRGkPw8Hk+X9kOTKHE6bd0k75mgUBAHBeiT1FOSQi2QdVszrK2DqfZ1Xwg3onii
         gXDq74poDGCTb29FvZ3BDeZzJWoOYlhy60S70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kkcIDEMAHBCOzJLj2phW4jww4X/yisWa3CZ5tOxvSy4=;
        b=uiK3NpjQWbIgihNqIh48DcuM3qyeNcBSpgor1s1GdJ3nNPyIzwXu02oaRJMLBA6MYl
         WN4Z48dkTKY+mV8flitFkv8SJXCx5lFkYfS+QiUcXOT4eOQ7TDctAEBdXnhjDnezt3I+
         EDO+rsVl7HtcQYXCocZ0Fe8TBm73Vyz/Fa2bfaqI6Xj0NnVS3Vam9lOaRhc17W0mkMn9
         Ew6LAbJyNBuf7Eu3hlNos9atiKjB0jkWkWZyOaCdLL+de4js89u/uubIufwlO/KtzBER
         wh1P2khyg3ZXQ0gPgUBj/tlcl6WKB6IheIrlpeFTiPGzMrxJuzUwT9UhOzjv/Gd15pgh
         2lbA==
X-Gm-Message-State: AOAM530n14b9pEKFRfScza8ywgjWRFYZhMuizdd5bjPSQZo4gZOSHRXx
        WKb9x3pfKY6HS3vAk8s01o/31uMGeT7DtA==
X-Google-Smtp-Source: ABdhPJxa3ykm5NNStfcnyEpq3UTo7C588J6wuh0QEao65TXrHGD2G69tNVfmkkifwjY9g7k0artx5A==
X-Received: by 2002:a17:906:b749:: with SMTP id fx9mr10852462ejb.186.1598368285610;
        Tue, 25 Aug 2020 08:11:25 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id ar21sm6276962ejc.8.2020.08.25.08.11.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 08:11:24 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id o21so2446241wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:11:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr2499533wmi.55.1598368283332;
 Tue, 25 Aug 2020 08:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200825090211eucas1p1b63191fa778a775e33169ba2c1d3b74b@eucas1p1.samsung.com>
 <CAAFQd5ADym6YapCoJ8+fJbPjSestcD_2R8L5T8jAfO4c=GFQkA@mail.gmail.com> <dleftjk0xnw132.fsf%l.stelmach@samsung.com>
In-Reply-To: <dleftjk0xnw132.fsf%l.stelmach@samsung.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 25 Aug 2020 17:11:09 +0200
X-Gmail-Original-Message-ID: <CAAFQd5C7Ysb2wnUhUcFZObuSSn4oW=e-oObO5Abat8rJRvqPqw@mail.gmail.com>
Message-ID: <CAAFQd5C7Ysb2wnUhUcFZObuSSn4oW=e-oObO5Abat8rJRvqPqw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:02 AM Lukasz Stelmach <l.stelmach@samsung.com> w=
rote:
>
> It was <2020-08-24 pon 15:21>, when Tomasz Figa wrote:
> > On Mon, Aug 24, 2020 at 3:17 PM Lukasz Stelmach <l.stelmach@samsung.com=
> wrote:
> >>
> >> It was <2020-08-22 sob 14:43>, when Krzysztof Kozlowski wrote:
> >> > On Fri, Aug 21, 2020 at 06:13:59PM +0200, =C5=81ukasz Stelmach wrote=
:
> >> >> cur_speed is used to calculate transfer timeout and needs to be
> >> >> set to the actual value of (half) the clock speed for precise
> >> >> calculations.
> >> >
> >> > If you need this only for timeout calculation just divide it in
> >> > s3c64xx_wait_for_dma().
> >>
> >> I divide it here to keep the relationship between the value the variab=
le
> >> holds and the one that is inside clk_* (See? It's multiplied 3 lines
> >> above). If you look around every single clk_get_rate() call in the fil=
e is
> >> divided by two.
> >>
> >> > Otherwise why only if (cmu) case is updated?
> >>
> >> You are righ I will update that too.
> >>
> >> However, I wonder if it is even possible that the value read from
> >> S3C64XX_SPI_CLK_CFG would be different than the one written to it?
> >>
> >
> > It is not possible for the register itself, but please see my other
> > reply, where I explained the integer rounding error which can happen
> > when calculating the value to write to the register.
>
> I don't have any board to test it and Marek says there is only one that
> doesn't use cmu *and* has an SPI device attached.
>
> Here is what I think should work for the !cmu case.
>
> --8<---------------cut here---------------start------------->8---
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 18b89e53ceda..5ebb1caade4d 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -655,13 +655,18 @@ static int s3c64xx_spi_config(struct
> s3c64xx_spi_driver_data *sdd)
>                         return ret;
>                 sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
>         } else {
> +               int src_clk_rate =3D clk_get_rate(sdd->src_clk);

The return value of clk_get_rate() is unsigned long.

> +               int clk_val =3D (src_clk_rate / sdd->cur_speed / 2 - 1);

Perhaps u32, since this is a value to be written to a 32-bit register.
Also if you could add a comment explaining that a negative overflow is
impossible:

/* s3c64xx_spi_setup() ensures that sdd->cur_speed <=3D src_clk_rate / 2. *=
/

But actually, unless my lack of sleep is badly affecting my brain
processes, the original computation was completely wrong. Let's
consider the scenario below:

src_clk_rate =3D 8000000
sdd->cur_speed =3D 2500000

clk_val =3D 8000000 / 2500000 / 2 - 1 =3D 3 / 2 - 1 =3D 1 - 1 =3D 0
[...]
sdd->cur_speed =3D 8000000 / (2 * (0 + 1)) =3D 8000000 / (2 * 1) =3D 800000=
0
/ 2 =3D 4000000

So a request for 2.5 MHz ends up with 4 MHz, which could actually be
above the client device or link spec.

I believe the right thing to do would be DIV_ROUND_UP(src_clk_rate /
2, sdd->cur_speed) - 1. It's safe to divide src_clk_rate directly,
because those are normally high rates divisible by two without much
precision loss.

> +
>                 /* Configure Clock */
>                 val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
>                 val &=3D ~S3C64XX_SPI_PSR_MASK;
> -               val |=3D ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / =
2 - 1)
> -                               & S3C64XX_SPI_PSR_MASK);
> +               val |=3D (clk_val & S3C64XX_SPI_PSR_MASK);
>                 writel(val, regs + S3C64XX_SPI_CLK_CFG);
>
> +               /* Keep the actual value */
> +               sdd->cur_speed =3D src_clk_rate / (2 * (clk_val + 1));

Also need to consider S3C64XX_SPI_PSR_MASK here, because clk_val could
actually be > S3C64XX_SPI_PSR_MASK.

Best regards,
Tomasz

> +
>                 /* Enable Clock */
>                 val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
>                 val |=3D S3C64XX_SPI_ENCLK_ENABLE;
> --8<---------------cut here---------------end--------------->8---
>
>
> >> > You are also affecting here not only timeout but
> >> > s3c64xx_enable_datapath() which is not mentioned in commit log. In o=
ther
> >> > words, this looks wrong.
> >>
> >> Indeed, there is a reference too. I've corrected the message.
> >>
> >
> > Thanks!
> >
> > Best regards,
> > Tomasz
> >
> >> >>
> >> >> Cc: Tomasz Figa <tfiga@chromium.org>
> >> >> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> >> >> ---
> >> >>  drivers/spi/spi-s3c64xx.c | 1 +
> >> >>  1 file changed, 1 insertion(+)
> >> >>
> >> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> >> index 02de734b8ab1..89c162efe355 100644
> >> >> --- a/drivers/spi/spi-s3c64xx.c
> >> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> >> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_sp=
i_driver_data *sdd)
> >> >>              ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2)=
;
> >> >>              if (ret)
> >> >>                      return ret;
> >> >> +            sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
> >> >>      } else {
> >> >>              /* Configure Clock */
> >> >>              val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
> >> >> --
> >> >> 2.26.2
> >> >>
> >> >
> >> >
> >>
> >> --
> >> =C5=81ukasz Stelmach
> >> Samsung R&D Institute Poland
> >> Samsung Electronics
> >
> >
>
> --
> =C5=81ukasz Stelmach
> Samsung R&D Institute Poland
> Samsung Electronics
