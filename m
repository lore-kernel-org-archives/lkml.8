Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1389CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4E1206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3q7wPvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgF2TXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbgF2TWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA8C02E2F9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:35:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d21so9190297lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaTcPoUQJY1lOqOm/hLw7WScDE1kdon3oAxJjzWJBGs=;
        b=c3q7wPvuWmxbXEeQbOXweKx9JWUXhVEdKTI9tOiGufjlgDQVL+HCyOLJP+J74EWwaS
         PHpEkg184kjqjYLicQRA2S5pusbsv40d2NPwsfR/i1/sI1jcwOnFMzq8I06Ep0vk/BhQ
         VaBAup3tV/I2JN+YGMDkQEviOdvR/Dr0DHalr7UdlABf5RkDM2ZgB2tBmszegEkzKc3S
         UiMzSzA38BAqrqn2UuOd4SIRwddzJyIKCPq97MFVawrYNZ2rFzK+6bKzg/tgUkx0uY76
         cdWkO4Nxxb4Fdn5afDc7s2m/Ta5XCqx4EehNzw5TbXPj2N8hGm9pfhQf1kSHxkWEBnye
         PG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaTcPoUQJY1lOqOm/hLw7WScDE1kdon3oAxJjzWJBGs=;
        b=nu3dY6dkX5wDLwvR44VzRaEfoXaHFwbim8rqgoJzJiDtRsQ+cwoweILU+TrzBZm+mK
         PIv8zNa42RWHmy6SOoyNGfiR2XiPaPfZwqDZShiwmP8ICHrIVnroiXQkvDyPdUtsfyg/
         aoS7kJXCCGOdP8pZPS8aID5e/olD/UD2xnWTD+s2fI+pmqGcDDTQCte8LY3dSdwfO74g
         nKvcHRABmHVLMv3/+GkRdUw3rc7QI6gZZGn/mwiGMf+DtRh0HLSdxrp4dO58ucYIs9ml
         xfVs+g2qoS5RP6RqUbVP/1ibCsDrfa7OZ7AL/tYItPI+uJ1KYS58sy+05uT24xx4nulS
         mSQQ==
X-Gm-Message-State: AOAM5331vR9Maa76mjTYz0vhRQNuGUZ7RZiXMaEUehoztrzcBYERJsP6
        1yoAVbxr6EgKXY4NimvtxoncFBVPWuPZT/jpjog=
X-Google-Smtp-Source: ABdhPJw9k6oTdppBMyT/KY2IUwKfPX6ngAt9KNp5tgyRQ/K3MrIhYF73uYTXUj1LpJ3QS0XdIxjni9cckLDUTwSJIzA=
X-Received: by 2002:a05:6512:108f:: with SMTP id j15mr9276546lfg.19.1593441317711;
 Mon, 29 Jun 2020 07:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org> <20200629130644.GU3334@localhost>
 <20200629140137.GK177734@dell>
In-Reply-To: <20200629140137.GK177734@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 29 Jun 2020 22:35:06 +0800
Message-ID: <CADBw62r_tkGEr9kHpojAi+fJ+qUqbsc-DQgG1TUAwOdbDXTgNQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] mfd: sprd-sc27xx-spi: Fix divide by zero when
 allocating register offset/mask
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:01 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 29 Jun 2020, Johan Hovold wrote:
>
> > On Mon, Jun 29, 2020 at 01:32:14PM +0100, Lee Jones wrote:
> > > Since ddata->irqs[] is already zeroed when allocated by devm_kcalloc() and
> > > dividing 0 by anything is still 0, there is no need to re-assign
> > > ddata->irqs[i].* values.  Instead, it should be safe to begin at 1.
> > >
> > > This fixes the following W=1 warning:
> > >
> > >  drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero
> > >
> > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/mfd/sprd-sc27xx-spi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > > index c305e941e435c..694a7d429ccff 100644
> > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > @@ -251,7 +251,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
> > >             return -ENOMEM;
> > >
> > >     ddata->irq_chip.irqs = ddata->irqs;
> > > -   for (i = 0; i < pdata->num_irqs; i++) {
> > > +   for (i = 1; i < pdata->num_irqs; i++) {
> > >             ddata->irqs[i].reg_offset = i / pdata->num_irqs;
> > >             ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
> > >     }
> >
> > This doesn't look right either.
> >
> > First, the loop is never executed if num_irqs is zero.
>
> The point of the patch is that 0 entries are never processed.
>
> However, what I appear to have overlooked is that BIT(0 % x) is not 0,
> it's 1.

Yes.

>
> > Second, the current code looks bogus too as reg_offset is always set to
> > zero and mask to BIT(i)...

Now the result is correct, since all PMIC irq mask bits are in one
register now, which means the reg_offset is always 0 can work well.
But I think the logics still can be improved if our PMIC irq numbers
are larger than 32 in future.

>
> Heh.  I wonder if/how this was tested.
>
> I'm going to wait to hear from the authors before attempting to fix
> this again.
>
> Baolin, Could you please clarify this for us please?

Yes, see above comments.

-- 
Baolin Wang
