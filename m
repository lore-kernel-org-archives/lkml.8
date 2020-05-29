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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75209C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC4120776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avs33Dos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgE2MgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2MgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:36:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F5C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:36:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q8so2109067iow.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=etVz/z0FCCoXbxju8q2TMA+/hX1IuOuxlidkT33un9k=;
        b=avs33Dos29eqzbPIer4J7wfZqsXbXJva2SA8UzJI1OPCLjhXDEF+vGOny7agxhbwYO
         s5/+6KT/fdOq1Jaz7WTDoY9Vd8aL/eFK2+tvY2z0jkKIPySamRpSBbAd0sC5NEF9ARdC
         30Nr2t6tUpO74p0iDBKDDi6/rMjHJlc7usNPdP/hNT7waZZcj6fBnMYHq5QjCXqpOUZH
         s8GeT7vOJ5RGX1jn2IrOD07VI/bmt+cINSjtganGhMbFGa6TqkF2loE/p/he9jTa16hZ
         4+d0UVw7kOrnvLn9pQ3E13QwUukFZpCC5QPj3D3BLL3er15yu63h/0pTgqzBxFR0eX5H
         imEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=etVz/z0FCCoXbxju8q2TMA+/hX1IuOuxlidkT33un9k=;
        b=Blpl2QwMzG4q5QVJM0t+wld6PxD5EfGSefMAgU1QWfWc0WGYFAhm6Trs6PI/xCMVeP
         /5Sb76EWQG01epGg6wki5xMvB4TFn1RjCztqMOy3WfSZXRRZZs/qzcuwDeU82QfqmGnE
         /1aRQpoRu4FtqyGy3ZfBgQHU4psvrxx51kOuKnA3EQp+yCveFQQNuQ627M88+JSYNIAb
         9PJ2TCyKC5GNqFF0EGOaiymAzvVYOjPGlJY8P2MPCNlzYWcs1xDPg5b6UdY2plOhMsKM
         l2D06YvQFCSQAFchr9fo3oJJ2SuWK2pzyUHUC89xy7TuV2X93BNoW9aqS9D5uEocnevC
         bR6A==
X-Gm-Message-State: AOAM5318QMYPTPKTMjzJZkJ9alpy544Na5Jg8Z2awLObbXuJKIZXjCFi
        CvbqGyauFZc6Hw7jCZREAkUxb86fuRgcI8180UA=
X-Google-Smtp-Source: ABdhPJxps5J+f5BjuG4lwLto/KMwaQ3VLsBSceOKC0vF6QwNUWHy+oJPaIsh6dbGT8NiJkG55XKwhA4wiqbLtxWWLhY=
X-Received: by 2002:a6b:1543:: with SMTP id 64mr6493948iov.123.1590755765005;
 Fri, 29 May 2020 05:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200510165538.19720-1-peron.clem@gmail.com> <20200510165538.19720-12-peron.clem@gmail.com>
 <8bc659b4-dbf9-5ae6-a677-937cab6bd798@arm.com>
In-Reply-To: <8bc659b4-dbf9-5ae6-a677-937cab6bd798@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 29 May 2020 14:35:54 +0200
Message-ID: <CAJiuCce2vb+M5Dn7FSr=N2WfrAEQrUjLPuShqFyPFxwfrdDqaA@mail.gmail.com>
Subject: Re: [PATCH 11/15] drm/panfrost: set devfreq clock name
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
> > Some SoCs have  several clocks defined and the OPP core
> > needs to know the exact name of the clk to use.
> >
> > Set the clock name to "core".
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> This is unfortunately a regression for the RK3288. The device tree
> binding doesn't require "clock-names", and for the RK3288 it currently
> isn't specified. So this breaks the platform.
>
> Adding the "clock-names" to the device tree 'fixes' it, but we really
> need to keep backwards compatibility.

Yes you're right, thanks for cathing this.

Regards,
Clement

>
> Steve
>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 13 +++++++++++++
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  1 +
> >   2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/=
drm/panfrost/panfrost_devfreq.c
> > index 9ffea0d4a087..6bf3541b4d53 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -103,6 +103,14 @@ int panfrost_devfreq_init(struct panfrost_device *=
pfdev)
> >
> >       spin_lock_init(&pfdevfreq->lock);
> >
> > +     opp_table =3D dev_pm_opp_set_clkname(dev, "core");
> > +     if (IS_ERR(opp_table)) {
> > +             ret =3D PTR_ERR(opp_table);
> > +             goto err_fini;
> > +     }
> > +
> > +     pfdevfreq->clkname_opp_table =3D opp_table;
> > +
> >       opp_table =3D dev_pm_opp_set_regulators(dev, pfdev->comp->supply_=
names,
> >                                             pfdev->comp->num_supplies);
> >       if (IS_ERR(opp_table)) {
> > @@ -176,6 +184,11 @@ void panfrost_devfreq_fini(struct panfrost_device =
*pfdev)
> >               dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table=
);
> >               pfdevfreq->regulators_opp_table =3D NULL;
> >       }
> > +
> > +     if (pfdevfreq->clkname_opp_table) {
> > +             dev_pm_opp_put_clkname(pfdevfreq->clkname_opp_table);
> > +             pfdevfreq->clkname_opp_table =3D NULL;
> > +     }
> >   }
> >
> >   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/=
drm/panfrost/panfrost_devfreq.h
> > index 347cde4786cf..1f2475e1d034 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> > @@ -16,6 +16,7 @@ struct panfrost_device;
> >   struct panfrost_devfreq {
> >       struct devfreq *devfreq;
> >       struct opp_table *regulators_opp_table;
> > +     struct opp_table *clkname_opp_table;
> >       struct thermal_cooling_device *cooling;
> >       bool opp_of_table_added;
> >
> >
>
