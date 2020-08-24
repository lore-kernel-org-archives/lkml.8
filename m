Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46C82078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HmZ0L+ZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHXNVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHXNVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:21:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05277C061575
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:21:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so11873038eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=90su1owIcZp1qZ8W+tbpS5QP1K7qOdgVEZYDn1cZZPI=;
        b=HmZ0L+ZO9rkNEJk5r0Ka6FMGlXEuCReREwZJyU/MzsB9S8jVOUjFNQYMNFTr4abObP
         fVq1khF3ehL0JqKu8fdJVYpL2pp6XNDHNuG3uUUBs0Lfm+yk9/suss49FVzUcBjw/aoI
         gkqBI6IH42fGKgFpGz3vy69QOSjGS+S1H/25Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=90su1owIcZp1qZ8W+tbpS5QP1K7qOdgVEZYDn1cZZPI=;
        b=RNQyk8L11gs6WjGHedO5iMq257XO5y1ht6M7AZr405LWUd2oaSRSo+y8HOG1fz88Gc
         sU143rldGQALA11UHyfn0EUkPSWXm8GyqylrxWLpCyFuVMzxyhqf81jlkwherHcThGmN
         MIP9duymJwaznkIbOSpRrL3zgIGv30QLxti7IqthdWduU+bIFmpdj4SSjg9XSDFASmnR
         9xFmQBr9F5CkBHshZJYmpvkIILyQQUB/01PNpX7+VSPyR3+C9cEdByI/uuUg8T31caR9
         dtluugBV8uoa1PEpfZTjx3cHPx/+Qxo5HSctyYQWdmDiuUCTFrUzUQafFZ67k5YgzGqH
         tcEQ==
X-Gm-Message-State: AOAM5339h5TJf3cYBjBa5Knl1d9iuBamRCWH2qDSGfoVHfP1hRB62TYH
        2wmZOfTNsLJM2GhdIIJHfl7Gi6fef8DKmQ==
X-Google-Smtp-Source: ABdhPJwQChjhnc3i+Jj8DduzbytaRw+2zpSpfb7waBvrovhT7jZZNWJYCbgVeiu6Uun5ZAcprnbqVQ==
X-Received: by 2002:a17:906:bb06:: with SMTP id jz6mr5734620ejb.248.1598275307454;
        Mon, 24 Aug 2020 06:21:47 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id v13sm10189263ejq.59.2020.08.24.06.21.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 06:21:46 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id x5so8325891wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:21:46 -0700 (PDT)
X-Received: by 2002:a1c:5581:: with SMTP id j123mr5764243wmb.11.1598275305542;
 Mon, 24 Aug 2020 06:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200824131716eucas1p16a3fde52aa765e7cd6584d4733762047@eucas1p1.samsung.com>
 <20200822124325.GF20423@kozik-lap> <dleftj5z98xjxs.fsf%l.stelmach@samsung.com>
In-Reply-To: <dleftj5z98xjxs.fsf%l.stelmach@samsung.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 24 Aug 2020 15:21:34 +0200
X-Gmail-Original-Message-ID: <CAAFQd5ADym6YapCoJ8+fJbPjSestcD_2R8L5T8jAfO4c=GFQkA@mail.gmail.com>
Message-ID: <CAAFQd5ADym6YapCoJ8+fJbPjSestcD_2R8L5T8jAfO4c=GFQkA@mail.gmail.com>
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

On Mon, Aug 24, 2020 at 3:17 PM Lukasz Stelmach <l.stelmach@samsung.com> wr=
ote:
>
> It was <2020-08-22 sob 14:43>, when Krzysztof Kozlowski wrote:
> > On Fri, Aug 21, 2020 at 06:13:59PM +0200, =C5=81ukasz Stelmach wrote:
> >> cur_speed is used to calculate transfer timeout and needs to be
> >> set to the actual value of (half) the clock speed for precise
> >> calculations.
> >
> > If you need this only for timeout calculation just divide it in
> > s3c64xx_wait_for_dma().
>
> I divide it here to keep the relationship between the value the variable
> holds and the one that is inside clk_* (See? It's multiplied 3 lines
> above). If you look around every single clk_get_rate() call in the file i=
s
> divided by two.
>
> > Otherwise why only if (cmu) case is updated?
>
> You are righ I will update that too.
>
> However, I wonder if it is even possible that the value read from
> S3C64XX_SPI_CLK_CFG would be different than the one written to it?
>

It is not possible for the register itself, but please see my other
reply, where I explained the integer rounding error which can happen
when calculating the value to write to the register.

> > You are also affecting here not only timeout but
> > s3c64xx_enable_datapath() which is not mentioned in commit log. In othe=
r
> > words, this looks wrong.
>
> Indeed, there is a reference too. I've corrected the message.
>

Thanks!

Best regards,
Tomasz

> >>
> >> Cc: Tomasz Figa <tfiga@chromium.org>
> >> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> >> ---
> >>  drivers/spi/spi-s3c64xx.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index 02de734b8ab1..89c162efe355 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_d=
river_data *sdd)
> >>              ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> >>              if (ret)
> >>                      return ret;
> >> +            sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
> >>      } else {
> >>              /* Configure Clock */
> >>              val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
> >> --
> >> 2.26.2
> >>
> >
> >
>
> --
> =C5=81ukasz Stelmach
> Samsung R&D Institute Poland
> Samsung Electronics
