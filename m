Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85AFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15E320776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as9DdhAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgE2MhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgE2MhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:37:16 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E20C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:37:16 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 9so2209743ilg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fb+W3gmU5L5sIfBg+Srp3Nm9jSCqSskItiXjvtBQMeg=;
        b=as9DdhASixL2BD+vWAWuMWXlgnW5ZOaAr/TpJELhlv3XMbLE/NUkIEG6Ni3EgQvQGV
         Lo14n5BvxRFUCOv1onoLOfWjUYa11xq5aVMSl6XBa2d2g5fBMq+mLJI6uyBGqLPCIJia
         2tU8tAlCvQvKXQqNBfbjbZWuHseT0ecJhJIza6zSeIihDqYDThvMyduVlEJkXesay3m0
         q1cKdSrnvAug7uPFIzIqL3ISlgpxswwEIlxY0lBycr7h4DKQXj9assshgsYJp9t2F7Pi
         /HJetSckNvFkjiqC0Lgv/jjy1B80WSrrrpsqDBcUcZg1XgmeWnwA6jIuYf1a8BUFGGcb
         v1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fb+W3gmU5L5sIfBg+Srp3Nm9jSCqSskItiXjvtBQMeg=;
        b=hNzb44YweKZjsMdztzwdUDYzha5OVbd45x4brIN2EmErmwcSKRQ3o4Ed2IEgbdK4+q
         U//u2XCizu4jalh+DGCNALNMOMv2Sb8ky/SjQNNIP9lWReBPJ1yhahSlYV9XadhmQtEl
         qZmXtiMmOBq/ZQYNQUka9dRr0F1XN0ybxD9KNeFZ8J1SVoXZQSw14YqnNphAIx7ANyrC
         3LerZf6exU/tPh9HjgRI+ydF5fweYZWFkwzZ+WptzgxkfQ81bjGK82DVyMDlJSzH6BI3
         va0ZzLBcgKP9cbsIlbO/1dvCY+RqwsapNceF012MmWtq6xGAzSM/n5CuslK7vp1rvEek
         zNBw==
X-Gm-Message-State: AOAM531FMDRd05lkADcwRKKkxYH4u4h4HKJXHzlFS4T5p6WDVBKw6uSr
        ZbZXE8LVYFQE67soWPB8iAVzs23WoX0gZQpSChc=
X-Google-Smtp-Source: ABdhPJxxEfv6IvdL+8cTmPKajhIN/6WuoIqhPyobZ8GRAjXV7kfity+v9VBcksLLW2KTaXA0nH8HYLdUF7l3M4YjN2E=
X-Received: by 2002:a92:d64f:: with SMTP id x15mr7066090ilp.118.1590755835306;
 Fri, 29 May 2020 05:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200510165538.19720-1-peron.clem@gmail.com> <20200510165538.19720-11-peron.clem@gmail.com>
 <2f0d2cd6-481c-26ce-fcef-ee5b4fdb249b@arm.com>
In-Reply-To: <2f0d2cd6-481c-26ce-fcef-ee5b4fdb249b@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 29 May 2020 14:37:04 +0200
Message-ID: <CAJiuCccL+rv3jMX33CwqcJyiFeAy9Ur=1Z2644k8-SJ5cgh8Dw@mail.gmail.com>
Subject: Re: [PATCH 10/15] drm/panfrost: add regulators to devfreq
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

On Thu, 28 May 2020 at 15:23, Steven Price <steven.price@arm.com> wrote:
>
> On 10/05/2020 17:55, Cl=C3=A9ment P=C3=A9ron wrote:
> > Some OPP tables specify voltage for each frequency. Devfreq can
> > handle these regulators but they should be get only 1 time to avoid
> > issue and know who is in charge.
> >
> > If OPP table is probe don't init regulator.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> This looks like it should work - thanks for doing this!

Yes but I'm not really happy how it's implemented.

Looks like a bit a workaround but didn't found a better solution.

Thanks for your review,
Clement

>
> Reviewed-by: Steven Price <steven.price@arm.com>
>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 19 +++++++++++++++++++
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
> >   drivers/gpu/drm/panfrost/panfrost_device.c  | 11 +++++++----
> >   3 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/=
drm/panfrost/panfrost_devfreq.c
> > index fce21c682414..9ffea0d4a087 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -93,6 +93,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfd=
ev)
> >       unsigned long cur_freq;
> >       struct device *dev =3D &pfdev->pdev->dev;
> >       struct devfreq *devfreq;
> > +     struct opp_table *opp_table;
> >       struct thermal_cooling_device *cooling;
> >       struct panfrost_devfreq *pfdevfreq =3D &pfdev->pfdevfreq;
> >
> > @@ -102,6 +103,19 @@ int panfrost_devfreq_init(struct panfrost_device *=
pfdev)
> >
> >       spin_lock_init(&pfdevfreq->lock);
> >
> > +     opp_table =3D dev_pm_opp_set_regulators(dev, pfdev->comp->supply_=
names,
> > +                                           pfdev->comp->num_supplies);
> > +     if (IS_ERR(opp_table)) {
> > +             ret =3D PTR_ERR(opp_table);
> > +             /* Continue if the optional regulator is missing */
> > +             if (ret !=3D -ENODEV) {
> > +                     DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n=
");
> > +                     goto err_fini;
> > +             }
> > +     } else {
> > +             pfdevfreq->regulators_opp_table =3D opp_table;
> > +     }
> > +
> >       ret =3D dev_pm_opp_of_add_table(dev);
> >       if (ret) {
> >               DRM_DEV_ERROR(dev, "Couldn't add OPP table\n");
> > @@ -157,6 +171,11 @@ void panfrost_devfreq_fini(struct panfrost_device =
*pfdev)
> >               dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> >               pfdevfreq->opp_of_table_added =3D false;
> >       }
> > +
> > +     if (pfdevfreq->regulators_opp_table) {
> > +             dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table=
);
> > +             pfdevfreq->regulators_opp_table =3D NULL;
> > +     }
> >   }
> >
> >   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/=
drm/panfrost/panfrost_devfreq.h
> > index add203cb00c2..347cde4786cf 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> > @@ -8,12 +8,14 @@
> >   #include <linux/ktime.h>
> >
> >   struct devfreq;
> > +struct opp_table;
> >   struct thermal_cooling_device;
> >
> >   struct panfrost_device;
> >
> >   struct panfrost_devfreq {
> >       struct devfreq *devfreq;
> > +     struct opp_table *regulators_opp_table;
> >       struct thermal_cooling_device *cooling;
> >       bool opp_of_table_added;
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/d=
rm/panfrost/panfrost_device.c
> > index 67eedf64e82d..8b17fb2e3369 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -222,10 +222,13 @@ int panfrost_device_init(struct panfrost_device *=
pfdev)
> >               goto err_out0;
> >       }
> >
> > -     err =3D panfrost_regulator_init(pfdev);
> > -     if (err) {
> > -             dev_err(pfdev->dev, "regulator init failed %d\n", err);
> > -             goto err_out1;
> > +     /* OPP will handle regulators */
> > +     if (!pfdev->pfdevfreq.opp_of_table_added) {
> > +             err =3D panfrost_regulator_init(pfdev);
> > +             if (err) {
> > +                     dev_err(pfdev->dev, "regulator init failed %d\n",=
 err);
> > +                     goto err_out1;
> > +             }
> >       }
> >
> >       err =3D panfrost_reset_init(pfdev);
> >
>
