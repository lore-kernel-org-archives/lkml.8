Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08975C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84EF20735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crec7vuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbgDMR3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732781AbgDMR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:29:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DBC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:29:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b12so10151900ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GM+yN/jrRse2ioNNBGH5SQs0AMwRsnLkkraZtwr6CoY=;
        b=crec7vuGJUFCG6HZ8oF3y83LTntbWyX/4L3lni+1zG/o8PgBmLyzOfBzHz6qnL6tSj
         l+l9LpJa679B/LnAqWaJbhsxb0d64hdqsZynPhb15VhGNyDcRY1PXsrHUhtdjUmWVg8Q
         BoLClymw6kYrW57hEemjU1COZwxtRQblFLIk3pQ/9niAAjic0MmlV1XKp3uVhmTOztSm
         RVtNmVRhhkhq9mv5/2jadImmx1g3pbw5HgNahHuaR0pgx62+o8zJbvUPEd32xhCzpPhp
         0JZOomS+hLdgBCw5s+ilGopXLcC2B/SNRaDgAANB1wwl859qVd5EE5qE3lvt23NCS+8j
         wPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GM+yN/jrRse2ioNNBGH5SQs0AMwRsnLkkraZtwr6CoY=;
        b=Ej3OuMZ0/BryG8o11psThFsjx2esZ+GBJIS2pf8GreXgl49DBWaB5KnaBL4l4qNEYh
         gBqEoz1QwLULfvtGgNe7O0UI91er4ULtqtiC+8FLtun6hPAf6ez33RwRKDrAokoUA0m0
         W75Kxq7wAHPQPEFbv7B/mpZ09OjveyPsNi53loFKIYweKgK4DnOcnwDvYE7bLpcd7KHN
         tW8YQxb9kQpcXkXHIF7C+1eMcI0UGzozcMFZRXf5DxjcWDAdqtSJ2hJf344m2fwhOgg8
         zTYuAcH7+9nZwQ5bKzWdRuPLaSItaoPFneaO4fdnlsUfYjxOxLgkUE+nEtvcjWH8eTRU
         dumA==
X-Gm-Message-State: AGi0Pubnlvpd/NOndMV+0Xk1MfVJKivC+yTc/Qj1SsqeqTQXdfvHr/wD
        hvOGggl6r9y1MQjVQ6yK+hdRgVgl9Uvc5kKmP3U=
X-Google-Smtp-Source: APiQypKD2Hi/qjbQxc6mLnbTEZOd0gAygUhDFJ/V70Ab1dMABhoQoHZbNNKFfSGHsAh5K6aqiqL9tKd0WPc9fHRfcWw=
X-Received: by 2002:a5d:9494:: with SMTP id v20mr17384079ioj.101.1586798944353;
 Mon, 13 Apr 2020 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com> <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
In-Reply-To: <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 13 Apr 2020 19:28:53 +0200
Message-ID: <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
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

Hi Steven,

On Mon, 13 Apr 2020 at 18:35, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Steven,
>
> On Mon, 13 Apr 2020 at 17:55, Steven Price <steven.price@arm.com> wrote:
> >
> > On 13/04/2020 15:31, Cl=C3=A9ment P=C3=A9ron wrote:
> > > Hi,
> > >
> > > On Mon, 13 Apr 2020 at 16:18, Cl=C3=A9ment P=C3=A9ron <peron.clem@gma=
il.com> wrote:
> > >>
> > >> Hi Steven,
> > >>
> > >> On Mon, 13 Apr 2020 at 15:18, Steven Price <steven.price@arm.com> wr=
ote:
> > >>>
> > >>> On 11/04/2020 21:06, Cl=C3=A9ment P=C3=A9ron wrote:
> > >>>> OPP table can defined both frequency and voltage.
> > >>>>
> > >>>> Register the mali regulator if it exist.
> > >>>>
> > >>>> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > >>>> ---
> > >>>>    drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++=
++++---
> > >>>>    drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
> > >>>>    2 files changed, 31 insertions(+), 4 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers=
/gpu/drm/panfrost/panfrost_devfreq.c
> > >>>> index 62541f4edd81..2dc8e2355358 100644
> > >>>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > >>>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > >>>> @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_devi=
ce *pfdev)
> > >>>>        struct device *dev =3D &pfdev->pdev->dev;
> > >>>>        struct devfreq *devfreq;
> > >>>>        struct thermal_cooling_device *cooling;
> > >>>> +     const char *mali =3D "mali";
> > >>>> +     struct opp_table *opp_table =3D NULL;
> > >>>> +
> > >>>> +     /* Regulator is optional */
> > >>>> +     opp_table =3D dev_pm_opp_set_regulators(dev, &mali, 1);
> > >>>
> > >>> This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add
> > >>> support for multiple regulators") which is currently in drm-misc-ne=
xt
> > >>> (and linux-next). You want something more like:
> > >>
> > >> Thanks for you review, indeed I didn't see that multiple regulators
> > >> support has been added.
> > >> Will update in v2.
> > >>
> > >>>
> > >>>       opp_table =3D dev_pm_opp_set_regulators(dev,
> > >>>                                             pfdev->comp->supply_nam=
es,
> > >>>                                             pfdev->comp->num_suppli=
es);
> > >>>
> > >>> Otherwise a platform with multiple regulators won't work correctly.
> > >>>
> > >>> Also running on my firefly (RK3288) board I get the following warni=
ng:
> > >>>
> > >>>      debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' a=
lready
> > >>> present!

I try to reproduce but it can't
regulator is mount at :
./regulator/vdd-gpu
whereas OPP is mount :
./opp/soc-1800000.gpu/opp:756000000/supply-0/

I see that firefly as 2 regulators with the same name :
vdd_gpu from syr828
(https://github.com/mopplayer/Firefly-RK3288-Kernel-With-Mali764/blob/maste=
r/arch/arm/boot/dts/firefly-rk3288.dts#L453)
vdd_gpu from rk808_dcdc2_reg
(https://github.com/mopplayer/Firefly-RK3288-Kernel-With-Mali764/blob/maste=
r/arch/arm/boot/dts/firefly-rk3288.dts#L841)

So i think the issue is from the firefly device-tree.

Regards,
Clement

> > >>>
> > >>> This is due to the regulator debugfs entries getting created twice =
(once
> > >>> in panfrost_regulator_init() and once here).
> > >>
> > >> Is it a warning that should be consider as an error? Look's more an =
info no?
> > >> What should be the correct behavior if a device want to register two
> > >> times the same regulator?
> > >
> > > Or we can change the name from vdd_XXX to opp_vdd_XXX ?
> > > https://elixir.bootlin.com/linux/latest/source/drivers/opp/debugfs.c#=
L45
> >
> > Yes, I'm not sure that it's actually a problem in practice. And it may
> > well be correct to change this in the generic code rather than try to
> > work around it in Panfrost. But we shouldn't spam the user with warning=
s
> > as that makes real issues harder to see.
> >
> > Your suggestion to change the name seems reasonable to me, but I don't
> > fully understand the opp code, so we'd need some review from the OPP
> > maintainers. Hopefully Viresh, Nishanth or Stephen can provide some ins=
ight.
>
> Agree, I will send a v2 with the rename and see if OPP Maintainers agree.
>
> Regards,
> Clement
>
> >
> > Steve
