Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA9AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2BF204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+6OvY9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgF2Sr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgF2Srp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C4C02F03B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:08:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so2525840ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4y8exEch/tKRaBNQLAYeMwPWRyiMK4ptsIMntud+MXQ=;
        b=b+6OvY9YlTc7zqY/dztuJpoG/Rv3+LKyJYRaT9JZUTlOOz5S6O+nibuvuEAc7YH4R5
         p59Xsu5A4V+/Qsk1kPh/N9fgolUhsZ+2QA+HeMokBeO282fNXdRE/jANuB5jHB192oEv
         PMTWsCVzoYA9gu3qEVo1Hha7S/egJkuclC6IqoKGdIo++WnYpU1Nyt5aIJcJwsivQ6Ik
         q/tumWzrZitYPNEG/gjTnW8ntJZLaOIdAxPYtdDxrUXvpUE9EIrhHfdPRZLqkG77NRZb
         zgROIf7E1KgZT6xHXEK5dY8ZmHHPSKVpM/Ko4YGOPgD4iv1cF8wg0NKgbYDsn/4mOTf2
         K4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4y8exEch/tKRaBNQLAYeMwPWRyiMK4ptsIMntud+MXQ=;
        b=B/a2plcfwJpQRBd1OdRUxU3XyvuQ2yhNtmMrw2WiFrSLK2mFH7Q1h6bYHsFs0ye0u4
         Cq8MvGmJaFf7KcAbvFYwsg62ELTznlpojOmygBiQSOfhBVPRKzzSF4QTiV46D0STMy96
         IRqZ6nB6xrELZJZ49ezPipjYNUJx67X1nwNSaRyBt+IkbQLcadyS/EeHu0RpFoM/FfGy
         15H6YygVWQZxGrQoUwaI/pQWRJPudlLbuXdgb4hK1cPrR0WlngEpNNe6uQ723Su7wn0Y
         J2Y/VvUtt87BwuwHPztVSrzTnqza26q204S5O/FBMxv6/8o74kIqMm7K6gszMjP1wJ/G
         md/w==
X-Gm-Message-State: AOAM533gCg20nu0pTqe460UwRRz7ecXxHMBhU8gjCZIUBDsfE7jUNZ+u
        BrJU+vTQQmYbgJpbK6KWEdZo1JRijkrqTJjG25Y=
X-Google-Smtp-Source: ABdhPJyzuVnCp/IYxWb/rQdTa6stFTpO6vvTzoA5WVDttSSlYl7UQTLv5fL2Anu57Te3t2p3SwVk9oc4eWWgyBGD/T8=
X-Received: by 2002:a2e:b4ec:: with SMTP id s12mr8535217ljm.155.1593443297962;
 Mon, 29 Jun 2020 08:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org> <20200629130644.GU3334@localhost>
 <20200629140137.GK177734@dell> <CADBw62r_tkGEr9kHpojAi+fJ+qUqbsc-DQgG1TUAwOdbDXTgNQ@mail.gmail.com>
 <20200629144325.GV3334@localhost>
In-Reply-To: <20200629144325.GV3334@localhost>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 29 Jun 2020 23:08:06 +0800
Message-ID: <CADBw62oFcDVcQMRx+F3omCsYYGeuw+-X2zGt_tm+T5mJ6Vaqjw@mail.gmail.com>
Subject: Re: [PATCH 4/5] mfd: sprd-sc27xx-spi: Fix divide by zero when
 allocating register offset/mask
To:     Johan Hovold <johan@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:43 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 10:35:06PM +0800, Baolin Wang wrote:
> > On Mon, Jun 29, 2020 at 10:01 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Mon, 29 Jun 2020, Johan Hovold wrote:
> > >
> > > > On Mon, Jun 29, 2020 at 01:32:14PM +0100, Lee Jones wrote:
> > > > > Since ddata->irqs[] is already zeroed when allocated by devm_kcalloc() and
> > > > > dividing 0 by anything is still 0, there is no need to re-assign
> > > > > ddata->irqs[i].* values.  Instead, it should be safe to begin at 1.
> > > > >
> > > > > This fixes the following W=1 warning:
> > > > >
> > > > >  drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero
> > > > >
> > > > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > > > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > > > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/mfd/sprd-sc27xx-spi.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > > > > index c305e941e435c..694a7d429ccff 100644
> > > > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > > > @@ -251,7 +251,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
> > > > >             return -ENOMEM;
> > > > >
> > > > >     ddata->irq_chip.irqs = ddata->irqs;
> > > > > -   for (i = 0; i < pdata->num_irqs; i++) {
> > > > > +   for (i = 1; i < pdata->num_irqs; i++) {
> > > > >             ddata->irqs[i].reg_offset = i / pdata->num_irqs;
> > > > >             ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
> > > > >     }
> > > >
> > > > This doesn't look right either.
> > > >
> > > > First, the loop is never executed if num_irqs is zero.
> > >
> > > The point of the patch is that 0 entries are never processed.
>
> So what's the problem? There's no division by zero here.
>
> And what compiler are you using, Lee? Seems broken.
>
> > > > Second, the current code looks bogus too as reg_offset is always set to
> > > > zero and mask to BIT(i)...
> >
> > Now the result is correct, since all PMIC irq mask bits are in one
> > register now, which means the reg_offset is always 0 can work well.
> > But I think the logics still can be improved if our PMIC irq numbers
> > are larger than 32 in future.
>
> The code is still bogus as pointed out above. Why do you bother to
> divide by num_irqs at all?

Right, no need to divide by num_irqs, can be simplified as below. Lee,
care to resend your patch with simplifying the code? Or you want me to
send a patch?
diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 33336cde4724..2ed5f3a4e79c 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -250,10 +250,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
                return -ENOMEM;

        ddata->irq_chip.irqs = ddata->irqs;
-       for (i = 0; i < pdata->num_irqs; i++) {
-               ddata->irqs[i].reg_offset = i / pdata->num_irqs;
-               ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
-       }
+       for (i = 0; i < pdata->num_irqs; i++)
+               ddata->irqs[i].mask = BIT(i);

-- 
Baolin Wang
