Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAA4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AA12078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nK14RNmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436989AbgE1WWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436937AbgE1WWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:22:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5403C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:22:02 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so164620plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=zR2fG0eW95HQgLEHmYKc0XBvdKWrxCRz+Y0bsh4hA5c=;
        b=nK14RNmJZ+2gzteD6OHGX1MsDlbcZFSoVjcGLb6DDkXBtr/EOxLM6pULUZUdxS5yV+
         4Mo7UpXVv2tWJfWx+pG8Nn0kl9qVhmmZZs8TIWzNOD92AiPtn6TwASimgJ0ii5Kpu+vC
         M1EvCxJzXdr4qiAxtlgEIlzJ5/Uec7chgJUDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=zR2fG0eW95HQgLEHmYKc0XBvdKWrxCRz+Y0bsh4hA5c=;
        b=tV2Oxc3xzT7DZ0oJBDPneycp3IQFVcNtt1ENN6mRwV2VPxGlP2mVmIupNIFZN4cvVN
         DOMCmerudxsx8b2H9YYkQYyfvQP+/xddrhPp86J3LGVcHtyAgVLcZgsfJFdxajqCAH1x
         47KEEzM+F2I0QGeIe7RKFZGkebs1ayfCnxoPvi+fJE85e8T8jCK9V5C1KASEzUQxR7ZK
         RadjmtetmKi+vjOO7zL1Jd6VmnN/x3VqH1UTQuiAKB9XH4IyC+vo6KLyRK6ksbpt2gFq
         xUc+YqqRFN13/TrlcPsxHlZtSIU+s6wZsrvPR93Nv4oF1AAduSDicXpOM/4jYTjvNq5Z
         Wxsg==
X-Gm-Message-State: AOAM533gV5Y3cjFvlWlwq7OC6DydmfqgXUMNnjd6dK53fuy6GJ9gFppU
        oxhzkCdRpnlvw/WtOGwyXjObOU+3NDA=
X-Google-Smtp-Source: ABdhPJx0JT5kNpcMVzTUkxPDxiL6FXGYJtLfzLVV1TUbRyTY4BJPE9G4vAd0jIZf3PrHIpeE8pmfCg==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7mr5682983plb.91.1590704521839;
        Thu, 28 May 2020 15:22:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a85sm5470786pfd.181.2020.05.28.15.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:22:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <948defc1-5ea0-adbb-185b-5f5a81f2e28a@codeaurora.org>
References: <1590253873-11556-1-git-send-email-mkshah@codeaurora.org> <1590253873-11556-2-git-send-email-mkshah@codeaurora.org> <159057264232.88029.4708934729701385486@swboyd.mtv.corp.google.com> <4e070cda-8c22-c554-610e-172320045840@codeaurora.org> <159062812628.69627.2153485337510882984@swboyd.mtv.corp.google.com> <948defc1-5ea0-adbb-185b-5f5a81f2e28a@codeaurora.org>
Subject: Re: [PATCH v2 1/4] gpio: gpiolib: Allow GPIO IRQs to lazy disable
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Thu, 28 May 2020 15:22:00 -0700
Message-ID: <159070452036.69627.17850758520477366824@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-05-28 06:11:23)
> Hi,
>=20
> On 5/28/2020 6:38 AM, Stephen Boyd wrote:
> > Quoting Maulik Shah (2020-05-27 04:26:14)
> >> On 5/27/2020 3:14 PM, Stephen Boyd wrote:
> >>> Quoting Maulik Shah (2020-05-23 10:11:10)
> >>>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> >>>> index eaa0e20..3810cd0 100644
> >>>> --- a/drivers/gpio/gpiolib.c
> >>>> +++ b/drivers/gpio/gpiolib.c
> >>>> @@ -2465,32 +2465,37 @@ static void gpiochip_irq_relres(struct irq_d=
ata *d)
> >>>>           gpiochip_relres_irq(gc, d->hwirq);
> >>>>    }
> >>>>   =20
> >>>> +static void gpiochip_irq_mask(struct irq_data *d)
> >>>> +{
> >>>> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> >>>> +
> >>>> +       if (gc->irq.irq_mask)
> >>>> +               gc->irq.irq_mask(d);
> >>>> +       gpiochip_disable_irq(gc, d->hwirq);
> >>> How does this work in the lazy case when I want to drive the GPIO? Sa=
y I
> >>> have a GPIO that is also an interrupt. The code would look like
> >>>
> >>>    struct gpio_desc *gpio =3D gpiod_get(...)
> >>>    unsigned int girq =3D gpiod_to_irq(gpio)
> >>>
> >>>    request_irq(girq, ...);
> >>>
> >>>    disable_irq(girq);
> >>>    gpiod_direction_output(gpio, 1);
> >>>
> >>> In the lazy case genirq wouldn't call the mask function until the fir=
st
> >>> interrupt arrived on the GPIO line. If that never happened then would=
n't
> >>> we be blocked in gpiod_direction_output() when the test_bit() sees
> >>> FLAG_USED_AS_IRQ? Or do we need irqs to be released before driving
> >>> gpios?
> >> The client driver can decide to unlazy disable IRQ with below API...
> >>
> >>   =C2=A0irq_set_status_flags(girq, IRQ_DISABLE_UNLAZY);
> >>
> >> This will immediatly invoke mask function (unlazy disable) from genirq,
> >> even though irq_disable is not implemented.
> >>
> > Sure a consumer can disable the lazy feature, but that shouldn't be
> > required to make this work. The flag was introduced in commit
> > e9849777d0e2 ("genirq: Add flag to force mask in
> > disable_irq[_nosync]()") specifically to help devices that can't disable
> > the interrupt in their own device avoid a double interrupt.
> i don't think this will be a problem.
>=20
> Case 1) Client driver have locked gpio to be used as IRQ using=20
> gpiochip_lock_as_irq()
>=20
> In this case, When client driver want to change the direction for a=20
> gpio, they will invoke gpiod_direction_output().
> I see it checks for two flags (pasted below), if GPIO is used as IRQ and =

> whether its enabled IRQ or not.
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* GPIOs used for enabled IRQs shal=
l not be set as output */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(FLAG_USED_AS_IRQ=
, &desc->flags) &&
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_=
bit(FLAG_IRQ_IS_ENABLED, &desc->flags)) {
>=20
> The first one (FLAG_USED_AS_IRQ) is set only if client driver in past=20
> have locked gpio to use as IRQ with a call to gpiochip_lock_as_irq()
> then it never gets unlocked until clients invoke gpiochip_unlock_as_irq().
>=20
> So i presume the client driver which in past locked gpio to be used as=20
> IRQ, now wants to change direction then it will
> a. first unlock to use as IRQ
> b. then change the direction.

How does a client driver unlock to use as an IRQ though? I don't
understand how that is done. gpiochip_lock_as_irq() isn't a gpio
consumer API, it's a gpiochip/gpio provider API.

>=20
> Once it unlocks in step (a), both these flags will be cleared and there=20
> won't be any error in changing direction in step (b).
