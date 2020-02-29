Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4D824688
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uup9BWov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgB2UPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 15:15:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46738 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgB2UPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:15:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id u124so6418174qkh.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 12:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AkrOHzBpT7aSQxxu38gPuAtFlmcZ6KFfZpcl7dVQr/M=;
        b=uup9BWovE5FGwg1628u7bfPLkVBD9SZqdEYgHMubCpmL63Z2e/FT5XNp9gSaoqhImR
         RLoP2Pvp0RUdtP3iIBUPTw6ce4OX7Oe8eND+OV/7aOC5VWMmod2GSMOZtGX+HxivBLkv
         XDU7H3PTOG/aiheZDXmJS585P0Wa8RvBE70sLr3tq74BydCqkZoMCMB6/tcMhkKxd9XG
         hM4yJrdFndljuU+7dxf3g2teocvJO4/wntC4cmY90OcQIPUjc1rxfg6r3p39i7TTuqve
         vY06hq2DoIi47te7BJiqAY5U2RefHs2BmEA6qV/oQLXZmGMhgBBkwB6Vjz01+LbDmIAJ
         rOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AkrOHzBpT7aSQxxu38gPuAtFlmcZ6KFfZpcl7dVQr/M=;
        b=swnwDdxipH0BCBOQ2Rb1F8ZAuw8Azcp7pfpWBNJnp0BV/lc0HPc8r/W9VzJTxwUV2Z
         7UxsDDbvb4RqWa87dsa4ieUArn4jevASob3hgd6A6gIggdWjyC9OvGpmPCK5kHE0W2jw
         6vkQ5QEo1kORJo27zuV1ZSU0OexFSz006fY6fWoW2KcKHE8q7g0AWI7PJy9SXl8iKtZF
         0sKGo8Fq6453gw8vPutsh3ITvaZZHrON9Oh6LMCKEjKe65ao0dRAqhGiJ6hEMJpxkeGM
         ePxydhNw9kcByahzTBpyokgOqVSEOu3C5O9M2fa5KMSQdyaTBhkIkFqAY8RKwR9wY/Ap
         nWHA==
X-Gm-Message-State: APjAAAX0L3jh3ZkUX/lVaakl7e3nVBp1G6C6qaxI0OcbosSgLvds0dmH
        QyMbC+NqhpGcRdz7aI3uIlhEud1yApR1pEd01KmkTSkJ
X-Google-Smtp-Source: APXvYqzkEFsbspGj5NQAyfgvc+06G3bNPskSG6F1LOR+Vx4D/xFT8f1Lvp8T1uiMCoD/QYcEJldeRaClcTK/m1tcHuA=
X-Received: by 2002:a37:4808:: with SMTP id v8mr9042223qka.263.1583007332121;
 Sat, 29 Feb 2020 12:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20200221154837.18845-1-brgl@bgdev.pl> <20200221154837.18845-4-brgl@bgdev.pl>
 <CACRpkdYtHqTBr7HW4Oex+igAbyb3PuS16uq1DXe4mK2vzxNoCw@mail.gmail.com>
In-Reply-To: <CACRpkdYtHqTBr7HW4Oex+igAbyb3PuS16uq1DXe4mK2vzxNoCw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sat, 29 Feb 2020 21:15:21 +0100
Message-ID: <CAMpxmJW2So7jNC+C4EJrnmp_heoge_biQ83Giojbx8Gnuh_vJw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpiolib: use kref in gpio_desc
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 28 lut 2020 o 23:33 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Fri, Feb 21, 2020 at 4:48 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > GPIO descriptors are freed by consumers using gpiod_put(). The name of
> > this function suggests some reference counting is going on but it's not
> > true.
> >
> > Use kref to actually introduce reference counting for gpio_desc objects=
.
> > Add a corresponding gpiod_get() helper for increasing the reference cou=
nt.
> >
> > This doesn't change anything for already existing (correct) drivers but
> > allows us to keep track of GPIO descs used by multiple users.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I'm having some trouble figuring out if we might be reinventing
> a wheel here.
>
> A while back there was a proposed patch to add device links
> between GPIO producers and consumers, so that a GPIO
> chip won't be dropped while there are active consumers.
>
> (I don't remember who sent the patch.)
>
> We have a similar functionality in pin control if the
> .link_consumers property is set on the pincontrol device.
> I was thinking about making that compulsory at one point.
>
> The device links use a kref already existing in struct
> device and would in this case be the kref in the struct
> device for the struct gpio_device.
>
> So if that existed, gpiod_ref could just grab another
> device_link_add().
>

I was always under the impression that device links are aimed mostly
at runtime PM.

> Maybe we should just add device links between all
> GPIO consumers (devices) and struct gpio_device:s
> struct device and implement it like this so we don't
> have to back out of this later?
>
> C.f. commit
> commit 036f394dd77f8117346874151793ec38967d843f
> pinctrl: Enable device link creation for pin control
>

Yes, definitely looks like it's done with PM in mind. Maybe we should
do what nvmem does? Define a struct device_type for GPIO chips with an
appropriate release() callback and use get_device() and put_device()?
Although nvmem seems to use kref for cells and device reference
counting somewhat separately - maybe that's something to address too.

> (...)
> > @@ -81,6 +81,7 @@ struct gpio_descs *__must_check gpiod_get_array(struc=
t device *dev,
> >  struct gpio_descs *__must_check gpiod_get_array_optional(struct device=
 *dev,
> >                                                         const char *con=
_id,
> >                                                         enum gpiod_flag=
s flags);
> > +struct gpio_desc *gpiod_ref(struct gpio_desc *desc);
> >  void gpiod_put(struct gpio_desc *desc);
> >  void gpiod_put_array(struct gpio_descs *descs);
>
> You forgot to add a stub for the case where GPIOLIB is not
> compiled in I think? (Lower in the same file.)
>
> Yours,
> Linus Walleij

Yeah this is fixed in the next version (with a different subject since
it no longer concerns nvmem that much).

Bart
