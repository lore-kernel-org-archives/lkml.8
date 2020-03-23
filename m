Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96382C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6210F2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gj67rIhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgCWJFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:05:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35476 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgCWJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:05:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id u12so13655653ljo.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UeQUAcdMZxn26RtbUmldtq49KvGfHbMzwTxg6ahzu8Q=;
        b=gj67rIhc9xmtkaXHqF2aKuKpPzYsq6nRprfC6gX/IIfe2bFxncqRx4LENZfh1WRp3Q
         OD6IItiqpkArFZmgK3PCQKt0vuhkduXH9aRT1J30TeWACtsHmjVjB+jefTtkmyXe/svS
         IUOwswoEXf+4gP8/NR1KJqeG6PZs1vnX1Q6KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UeQUAcdMZxn26RtbUmldtq49KvGfHbMzwTxg6ahzu8Q=;
        b=GtaqNozDWSmsLoAXvMgHQ34RJ7jqPAyMs1AAohrqfzfgjE2+fay/hu5DJji/v8rQKX
         pyN4/nK22FM2cn21fCk0C6TO+uixZWEv4PEDXbN+JOcw+jLqLHVTPJBlqf+2lYdzuPP0
         OngV4esZquZxpTpPx0GUM+nQgPdNlCnC7bo9bTTJmbsduzJZ8jnFWaodgaerGluzz3Gz
         dAx4QnS8E62cM0vWi2B6lRf6u03TKA1YMp6JU9O+pHBXOUWbZsJ+1FCoW9TF7gYnwCjk
         DXF/jl7f7c61WNVvTEye9ZwhHf7o+CBYvkC/UT3pYQzteBOZIq04n4wNXmfC2wU/QRQK
         wi9w==
X-Gm-Message-State: ANhLgQ1dkyWDDL7CI2w1StJw8MrSjTYTOO84Tc5A+ykl/UDODldWYwy2
        fMoQKcwIPNm6EtdDrVdFgESxamvhvcFu9RGqWPYOTg==
X-Google-Smtp-Source: ADFU+vsThDf7qqsHDVU9kt7C92bwqzK+m2HTPz3VsgWRN3a2xVl/c7U7hQNsOxfPHdo8nHSIOPur05m8x4B3/bbbdgs=
X-Received: by 2002:a2e:a483:: with SMTP id h3mr8739201lji.264.1584954338871;
 Mon, 23 Mar 2020 02:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com> <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
In-Reply-To: <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Mon, 23 Mar 2020 14:35:27 +0530
Message-ID: <CAHO=5PFBcgmnpA8D6prEo4WCu235Mr9jh8=_Y6pdM8R9=ShfXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pwm: bcm-iproc: handle clk_get_rate() return
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 1:55 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Mar 23, 2020 at 12:23:17PM +0530, Rayagonda Kokatanur wrote:
> > Handle clk_get_rate() returning <=3D 0 condition to avoid
> > possible division by zero.
>
> Was this noticed during a review and is more theoretic. Or does this
> (depending on pre-boot state) result in a kernel crash?

This is reported by internal coverity tool.
>
> > Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controlle=
r")
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> > index 1f829edd8ee7..8bbd2a04fead 100644
> > --- a/drivers/pwm/pwm-bcm-iproc.c
> > +++ b/drivers/pwm/pwm-bcm-iproc.c
> > @@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> >       else
> >               state->polarity =3D PWM_POLARITY_INVERSED;
> >
> > -     value =3D readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> > -     prescale =3D value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
> > -     prescale &=3D IPROC_PWM_PRESCALE_MAX;
> > -
> > -     multi =3D NSEC_PER_SEC * (prescale + 1);
> > -
> > -     value =3D readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
> > -     tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > -     state->period =3D div64_u64(tmp, rate);
> > -
> > -     value =3D readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm=
));
> > -     tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > -     state->duty_cycle =3D div64_u64(tmp, rate);
> > +     if (rate =3D=3D 0) {
> > +             state->period =3D 0;
> > +             state->duty_cycle =3D 0;
> > +     } else {
> > +             value =3D readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> > +             prescale =3D value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm=
);
> > +             prescale &=3D IPROC_PWM_PRESCALE_MAX;
> > +
> > +             multi =3D NSEC_PER_SEC * (prescale + 1);
> > +
> > +             value =3D readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->h=
wpwm));
> > +             tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > +             state->period =3D div64_u64(tmp, rate);
> > +
> > +             value =3D readl(ip->base +
> > +                           IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
> > +             tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > +             state->duty_cycle =3D div64_u64(tmp, rate);
> > +     }
>
> The change looks fine.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
