Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3695CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119F5206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0r/f0dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgE2MpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgE2MpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:45:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFFDC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:45:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so2103457iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r7UrsGfrrB/vHkjSY/mF0dPH3VfmRDjaMhCcaEN7Oro=;
        b=C0r/f0dYZuUL3gtrgb341aeH+a3RRbFgDN8WABIDMQ4CWOg0oUOEWV44SFWs91MrD3
         l+v1XHlA3qT+zSg8N3ZMtNe8AynwbfZ2sz34jS/oYopc528jqn7GMQ0QItbrGnl+ZnXx
         rMAeHhGlmNCulmea83iFMYAN13+NxAhfCbzcKWcdivAoKqFjhVurnRuEd97Uhrq989pH
         QRlCPlybXXfx1Z2IqoluFEB/slBKEjdXKJP5ZvyWlkM2RUVpahjp1LWZKhmZUYTWS11i
         i7WZ/oEv2JQFoAJy30va82fvaIsC4GH69VjoyDknDfXwa/zR6UpAguyCcjXn8s6t6kAD
         KOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r7UrsGfrrB/vHkjSY/mF0dPH3VfmRDjaMhCcaEN7Oro=;
        b=Z/FoqrUW4Mmo2njkfNWYYx7i2+xmp8ldl7fGpz90eNC3NavL52oVIyG7zNB+hFeDVk
         5vkskQyGewEgSjqBKbdTS2sAU7M7+BI0WJ0wPlqeuEvolX0TUtSdCWqN8cFWY5CLR2YE
         BDowaFUj6TlU8GgqfaYkqPdJkj9qbc6w3vZJSyNscnW90e29LKxr5MsVoHi9rb2hbLmn
         MX9R37zV0J8oOl4NOkQqzqTa5treXwoR7k5T/amBmD4aohFPAdfjSvp/POfOxPY3A6Fz
         ob/E6FHIDWp4lz6JjhHWyWDrFjP5SXbn6oRmQZqSV6/Mnr4fQcZnnRk/IEmmeofHIaFC
         HQeQ==
X-Gm-Message-State: AOAM531t72hasWdI2udbCpDWWDw4g+QZghN2QWkt5c8Bp0pn/j6wLJNE
        cR2+6fRxV/o180NGJjFOwaTHgkEtGyzHsKFHuW8AY627
X-Google-Smtp-Source: ABdhPJwQN7PrsvBPgSXBXTv22bRouiS21NBduFpKqOYI96L9PLyEwcQxFBcRZlVWcv10lm9jwrJXrH+ncv06l+AZAwg=
X-Received: by 2002:a6b:1543:: with SMTP id 64mr6528705iov.123.1590756315926;
 Fri, 29 May 2020 05:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200510165538.19720-1-peron.clem@gmail.com> <20200510165538.19720-8-peron.clem@gmail.com>
 <2f7a41d6-325d-3731-0a6a-fa2e41d4e33a@arm.com>
In-Reply-To: <2f7a41d6-325d-3731-0a6a-fa2e41d4e33a@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 29 May 2020 14:45:05 +0200
Message-ID: <CAJiuCcfJnBxh6McsNLKJ=HegS6dCVNVOChCOrcPGWobU3G8KKg@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/panfrost: use device_property_present to check
 for OPP
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, 28 May 2020 at 15:22, Steven Price <steven.price@arm.com> wrote:
>
> On 10/05/2020 17:55, Cl=C3=A9ment P=C3=A9ron wrote:
> > Instead of expecting an error from dev_pm_opp_of_add_table()
> > do a simple device_property_present() check.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> I'm not sure I understand why this is better. We seem to have more code
> to do roughly the same thing just with the hard-coded
> "operating-points-v2" name (if there's ever a 'v3' we'll then have to
> update this).
>
> Is the desire just to get an error on probe if the table is malformed?
> Have you hit this situation? If so this sounds like something which
> would be better fixed in the generic OPP code rather than Panfrost itself=
.

The idea was to avoid calling devfreq if there is no opp table.
But I think you're right we don't have to check for malformed
device-tree in the driver.

I will drop this patch,

Regards,
Clement


>
> Steve
>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/=
drm/panfrost/panfrost_devfreq.c
> > index d9007f44b772..fce21c682414 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -96,15 +96,19 @@ int panfrost_devfreq_init(struct panfrost_device *p=
fdev)
> >       struct thermal_cooling_device *cooling;
> >       struct panfrost_devfreq *pfdevfreq =3D &pfdev->pfdevfreq;
> >
> > -     ret =3D dev_pm_opp_of_add_table(dev);
> > -     if (ret =3D=3D -ENODEV) /* Optional, continue without devfreq */
> > +     if (!device_property_present(dev, "operating-points-v2"))
> > +             /* Optional, continue without devfreq */
> >               return 0;
> > -     else if (ret)
> > -             return ret;
> > -     pfdevfreq->opp_of_table_added =3D true;
> >
> >       spin_lock_init(&pfdevfreq->lock);
> >
> > +     ret =3D dev_pm_opp_of_add_table(dev);
> > +     if (ret) {
> > +             DRM_DEV_ERROR(dev, "Couldn't add OPP table\n");
> > +             goto err_fini;
> > +     }
> > +     pfdevfreq->opp_of_table_added =3D true;
> > +
> >       panfrost_devfreq_reset(pfdevfreq);
> >
> >       cur_freq =3D clk_get_rate(pfdev->clock);
> >
>
