Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE36C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EC62078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVn9xmls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgE1BIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1BIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:08:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F200C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:08:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so12612523pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=CL/IKWXXhgD7nYIcRM77gSNJoAiFSfa9BaKCTrGTTAY=;
        b=PVn9xmlsNpJBnmTG7486QBKPU4B72Pcbl2qmBfKYmIXiMih8cpnIr3UIEpPyUgvs2Z
         sKYYsC88fgKW9B9veGnXrBl1ICYi6SsNl5Q2Dytzu4A9uAB8LJ/qT8rYmMA54tSxalB3
         DQw+lWyS2VDPILubigwUOR2Liw263AYeZhrVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=CL/IKWXXhgD7nYIcRM77gSNJoAiFSfa9BaKCTrGTTAY=;
        b=l5Ii0HjMuMzgXnFe5sfHrNej87SnpPRYP6zfV/T3eRJwqwykxl6wEF+RtTq8BaMFs/
         AwCDfFgrID9O6d7iYp0CB8LToiUrDTwVm6hICTJyd0XNu/IOz0VoD/EjFDrU83z/j+9F
         xeOUf5OJE7edTKZPMOiZnF5npHEqe4IB2pJJgWH9RrCQrpKBQQwlHuJ+GKJC8lhMCyg0
         p9FLB7tYsO4veM/0vTNwNDQW3ZjCYwk2MD6nzq2EiKu2q8OtvUr3hY07UZOi32AbmZP8
         weviRgdH/fTOvv8sON+Ftk/0F7akrHqit0cJoVrm9XBeEonQ6Nm+gBEmruO/uaRocYTJ
         tr0Q==
X-Gm-Message-State: AOAM532fhg6npXDSk8yS9d7lyByzAABJQKTYFiWL4ZEBesBJD7X9DTY5
        Vv9lZ72Ti1w8Y4KPv0JaOV1hlVxhfdw=
X-Google-Smtp-Source: ABdhPJxIemgLPr3D6mtUM3FpmOsuWeq5aNiqkRnMIlOzQPkgTmCeYfEj0EISKOoBynt6RLBuPAu8VQ==
X-Received: by 2002:a62:e402:: with SMTP id r2mr501008pfh.300.1590628128117;
        Wed, 27 May 2020 18:08:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e1sm3033758pgj.0.2020.05.27.18.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:08:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4e070cda-8c22-c554-610e-172320045840@codeaurora.org>
References: <1590253873-11556-1-git-send-email-mkshah@codeaurora.org> <1590253873-11556-2-git-send-email-mkshah@codeaurora.org> <159057264232.88029.4708934729701385486@swboyd.mtv.corp.google.com> <4e070cda-8c22-c554-610e-172320045840@codeaurora.org>
Subject: Re: [PATCH v2 1/4] gpio: gpiolib: Allow GPIO IRQs to lazy disable
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Wed, 27 May 2020 18:08:46 -0700
Message-ID: <159062812628.69627.2153485337510882984@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-05-27 04:26:14)
> On 5/27/2020 3:14 PM, Stephen Boyd wrote:
> > Quoting Maulik Shah (2020-05-23 10:11:10)
> >> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> >> index eaa0e20..3810cd0 100644
> >> --- a/drivers/gpio/gpiolib.c
> >> +++ b/drivers/gpio/gpiolib.c
> >> @@ -2465,32 +2465,37 @@ static void gpiochip_irq_relres(struct irq_dat=
a *d)
> >>          gpiochip_relres_irq(gc, d->hwirq);
> >>   }
> >>  =20
> >> +static void gpiochip_irq_mask(struct irq_data *d)
> >> +{
> >> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> >> +
> >> +       if (gc->irq.irq_mask)
> >> +               gc->irq.irq_mask(d);
> >> +       gpiochip_disable_irq(gc, d->hwirq);
> > How does this work in the lazy case when I want to drive the GPIO? Say I
> > have a GPIO that is also an interrupt. The code would look like
> >
> >   struct gpio_desc *gpio =3D gpiod_get(...)
> >   unsigned int girq =3D gpiod_to_irq(gpio)
> >
> >   request_irq(girq, ...);
> >
> >   disable_irq(girq);
> >   gpiod_direction_output(gpio, 1);
> >
> > In the lazy case genirq wouldn't call the mask function until the first
> > interrupt arrived on the GPIO line. If that never happened then wouldn't
> > we be blocked in gpiod_direction_output() when the test_bit() sees
> > FLAG_USED_AS_IRQ? Or do we need irqs to be released before driving
> > gpios?
>=20
> The client driver can decide to unlazy disable IRQ with below API...
>=20
>  =C2=A0irq_set_status_flags(girq, IRQ_DISABLE_UNLAZY);
>=20
> This will immediatly invoke mask function (unlazy disable) from genirq,=20
> even though irq_disable is not implemented.
>=20

Sure a consumer can disable the lazy feature, but that shouldn't be
required to make this work. The flag was introduced in commit
e9849777d0e2 ("genirq: Add flag to force mask in
disable_irq[_nosync]()") specifically to help devices that can't disable
the interrupt in their own device avoid a double interrupt.
