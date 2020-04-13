Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8ECC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E494A2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npxCaDZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgDMOcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgDMOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:31:59 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB7C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:31:58 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i75so8592672ild.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LJjW0jg34djl0NCnmcUl1R4YbkdUgQm5sPohoKtv2lQ=;
        b=npxCaDZj0IDLUZsBM8Hr2dIx1dBUmnfDg2i+iaRWANcSKNoy4xYFZPSoR1waBxhhKW
         X2++SUAmW1t11y6rkLD9BRN/iw/wdquHDqgUfkYliUtSjMtVDoC8EGTC/KKF2BQpNnLT
         ZSKFsWnYKMJTV+GQljgrT9do1KDoU8AUMqwasaob+l3gQRKHuTszhBUBaOFz2Z4sF09J
         jwXlVeioeAOk4InW2A+9gQEKExfDGQsTR4peUEU2MhEHBcTz5wvVieE3LWyASyctG0yV
         7W4ym7tFN9wUFo1+wz9HQecsqNPhB9SQo1SV18b0zw5y1rOcWDYqMZJeofuqB7tXJARp
         4rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LJjW0jg34djl0NCnmcUl1R4YbkdUgQm5sPohoKtv2lQ=;
        b=e43ZEipKaAx0wRGFvdGi4rTL3Q2VXiSuz2kJ5c6i+p6h/HE6v0pSiaRvxqvBjwJqLA
         GLpH+KbS4n/I57nO+/ioD+/Ai1jAWJuuuq2+bhDhLGrUMkatkThsow+IIIf80uUaCaGw
         v0VDpxYU9SsQ89Go8bMNmySG4C8tG6XC9mZOY4c7GaAI2DXPit8xwCwz9ig6AuL2LNqS
         PPngOF8pnQw10OgY12v+oleW83pt8Q6r4c4e0TSVCZgmW7EFrLuU750yakQcYeCgh1VT
         m+fzvZbXAHrGL/+NOOrfLmkSmLpq3/XHFR9cDfTIwJHOJtrMBT8GGCSTCPn6a/zTFRw9
         VXIA==
X-Gm-Message-State: AGi0PuZWhaaDnIoAC82oE3DEYnPrlXMoMLJmBSUO2rD8gdxk/hoAPkKD
        ntUqOUDy+RNUQ1RtF7Gunof59wSE3vWi5ZdRjec=
X-Google-Smtp-Source: APiQypJeXnWOs4a+lDUWsfhH7am8MRlkDpDuNrv6ocvWdP4jBedvu3PhZbNHpaxYmvGxWxybkEMrmeQTxkh9KYXR32w=
X-Received: by 2002:a92:540f:: with SMTP id i15mr5801231ilb.59.1586788317468;
 Mon, 13 Apr 2020 07:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
In-Reply-To: <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 13 Apr 2020 16:31:46 +0200
Message-ID: <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Apr 2020 at 16:18, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Steven,
>
> On Mon, 13 Apr 2020 at 15:18, Steven Price <steven.price@arm.com> wrote:
> >
> > On 11/04/2020 21:06, Cl=C3=A9ment P=C3=A9ron wrote:
> > > OPP table can defined both frequency and voltage.
> > >
> > > Register the mali regulator if it exist.
> > >
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++=
---
> > >   drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
> > >   2 files changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gp=
u/drm/panfrost/panfrost_devfreq.c
> > > index 62541f4edd81..2dc8e2355358 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > > @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device =
*pfdev)
> > >       struct device *dev =3D &pfdev->pdev->dev;
> > >       struct devfreq *devfreq;
> > >       struct thermal_cooling_device *cooling;
> > > +     const char *mali =3D "mali";
> > > +     struct opp_table *opp_table =3D NULL;
> > > +
> > > +     /* Regulator is optional */
> > > +     opp_table =3D dev_pm_opp_set_regulators(dev, &mali, 1);
> >
> > This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add
> > support for multiple regulators") which is currently in drm-misc-next
> > (and linux-next). You want something more like:
>
> Thanks for you review, indeed I didn't see that multiple regulators
> support has been added.
> Will update in v2.
>
> >
> >      opp_table =3D dev_pm_opp_set_regulators(dev,
> >                                            pfdev->comp->supply_names,
> >                                            pfdev->comp->num_supplies);
> >
> > Otherwise a platform with multiple regulators won't work correctly.
> >
> > Also running on my firefly (RK3288) board I get the following warning:
> >
> >     debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' alread=
y
> > present!
> >
> > This is due to the regulator debugfs entries getting created twice (onc=
e
> > in panfrost_regulator_init() and once here).
>
> Is it a warning that should be consider as an error? Look's more an info =
no?
> What should be the correct behavior if a device want to register two
> times the same regulator?

Or we can change the name from vdd_XXX to opp_vdd_XXX ?
https://elixir.bootlin.com/linux/latest/source/drivers/opp/debugfs.c#L45

>
> Link to original discussion:
> https://lore.kernel.org/patchwork/patch/1176717/
>
> Thanks,
> Clement
>
> >
> > I have been taking a look at doing the same thing (I picked up Martin
> > Blumenstingl's patch series[1]), but haven't had much time to focus on
> > this recently.
> >
> > Thanks,
> >
> > Steve
> >
> > [1]
> > https://lore.kernel.org/dri-devel/20200112001623.2121227-1-martin.blume=
nstingl@googlemail.com/
> >
> >
> > > +     if (IS_ERR(opp_table)) {
> > > +             ret =3D PTR_ERR(opp_table);
> > > +             if (ret !=3D -ENODEV) {
> > > +                     DRM_DEV_ERROR(dev, "Failed to set regulator: %d=
\n", ret);
> > > +                     return ret;
> > > +             }
> > > +     }
> > > +     pfdev->devfreq.opp_table =3D opp_table;
> > >
> > >       ret =3D dev_pm_opp_of_add_table(dev);
> > > -     if (ret =3D=3D -ENODEV) /* Optional, continue without devfreq *=
/
> > > -             return 0;
> > > -     else if (ret)
> > > -             return ret;
> > > +     if (ret) {
> > > +             if (ret =3D=3D -ENODEV) /* Optional, continue without d=
evfreq */
> > > +                     ret =3D 0;
> > > +             goto err_opp_reg;
> > > +     }
> > >
> > >       panfrost_devfreq_reset(pfdev);
> > >
> > > @@ -119,6 +133,12 @@ int panfrost_devfreq_init(struct panfrost_device=
 *pfdev)
> > >   err_opp:
> > >       dev_pm_opp_of_remove_table(dev);
> > >
> > > +err_opp_reg:
> > > +     if (pfdev->devfreq.opp_table) {
> > > +             dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> > > +             pfdev->devfreq.opp_table =3D NULL;
> > > +     }
> > > +
> > >       return ret;
> > >   }
> > >
> > > @@ -126,7 +146,13 @@ void panfrost_devfreq_fini(struct panfrost_devic=
e *pfdev)
> > >   {
> > >       if (pfdev->devfreq.cooling)
> > >               devfreq_cooling_unregister(pfdev->devfreq.cooling);
> > > +
> > >       dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> > > +
> > > +     if (pfdev->devfreq.opp_table) {
> > > +             dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> > > +             pfdev->devfreq.opp_table =3D NULL;
> > > +     }
> > >   }
> > >
> > >   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu=
/drm/panfrost/panfrost_device.h
> > > index 06713811b92c..f6b0c779dfe5 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > > @@ -86,6 +86,7 @@ struct panfrost_device {
> > >       struct {
> > >               struct devfreq *devfreq;
> > >               struct thermal_cooling_device *cooling;
> > > +             struct opp_table *opp_table;
> > >               ktime_t busy_time;
> > >               ktime_t idle_time;
> > >               ktime_t time_last_update;
> > >
> >
