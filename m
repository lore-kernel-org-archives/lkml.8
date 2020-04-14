Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77FC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D022054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgJeTU9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503783AbgDNSUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503749AbgDNSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:20:36 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03ADC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:20:35 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n20so14292692ioa.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FWHlxt6TR0qc440FmiwEpcBDgtzAAF/KvYqR8vAJbXM=;
        b=AgJeTU9jLdacG7Y9aJ2YqUmfBCDHEmIej1sRCfIvlnaU9vtO06fHxd0ybBBDmq7xti
         jNpJJqq4QHCjiDRRhRtUjgnUichU6Vp5lcTAaooqhOxT3/PZvfu+W6HibrFLDclHequv
         KdVODC0rJA1TUizEVsDpXB4obdayzsLQG/AY26sGrH7DLnkZCyENUV1BnGj7m0mDEXhD
         JNPJGLKMOfbExnt0u6TJl3S9xiQvhDI5jbex6jmY25OM+lMP6rYoSqBMLMp187nyW7vz
         XLMzwtfF8VFK//DW9J1V0lNSEUinQccyEguJK/s1DSIxGP5OVg/LTH/WvqeUknN3JEyz
         0Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FWHlxt6TR0qc440FmiwEpcBDgtzAAF/KvYqR8vAJbXM=;
        b=FMUBga6C+2HZrsvTiaCQMQ9FqCFEbglCkWirSrDOJZVgv19t3xJ0L+DGIQX1jpRA0K
         ijAq7XsIBzGCe6On45oMQWY8TZrzCp833G5rUg7J+0aKw03UwJpDqHyPWUcyLjluiCDf
         MmTikrkr7VvuDgMxdMW9RqJhEfBZaV6P+vVIxZy1ztcW0soHS+f/ztU6x21s7I3um4Yp
         ffy+X70nR5lApigXW99VrmLKl7Zgd5m63Gy1pyghLOsSlMUPNl0lVjCjwutYWHy3D/xG
         XpgMZYCOZ0ialHzIjRtKzKkoRMbm0iSeciOWIFTJmx8l+/2jss4Fo81AGU93al0G70Ry
         5DmQ==
X-Gm-Message-State: AGi0PubyNPGXAb3KXvRKDc3SbSqRGxiKLtxKXLtPLlfN3AR1Gyz3YfP8
        zGPe/5Q6EJPQNjv8dmhi467LLuLbhf2h7BJbIPA=
X-Google-Smtp-Source: APiQypKKM5xK5z4ZyJT0azf3EztG3pQ/r5wkZHcqCnqqSGl1uJh3ZcJHaDu1W9VSFmgMq076WSQMt0Ircovtjq6obig=
X-Received: by 2002:a02:2715:: with SMTP id g21mr16635706jaa.18.1586888434346;
 Tue, 14 Apr 2020 11:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com> <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com> <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
In-Reply-To: <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 14 Apr 2020 20:20:23 +0200
Message-ID: <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     Steven Price <steven.price@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
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

Hi Liam and Mark,

On Tue, 14 Apr 2020 at 15:10, Steven Price <steven.price@arm.com> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 13/04/2020 18:28, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Steven,
> >
> > On Mon, 13 Apr 2020 at 18:35, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >>
> >> Hi Steven,
> >>
> >> On Mon, 13 Apr 2020 at 17:55, Steven Price <steven.price@arm.com> wrot=
e:
> >>>
> >>> On 13/04/2020 15:31, Cl=C3=A9ment P=C3=A9ron wrote:
> >>>> Hi,
> >>>>
> >>>> On Mon, 13 Apr 2020 at 16:18, Cl=C3=A9ment P=C3=A9ron <peron.clem@gm=
ail.com> wrote:
> >>>>>
> >>>>> Hi Steven,
> >>>>>
> >>>>> On Mon, 13 Apr 2020 at 15:18, Steven Price <steven.price@arm.com> w=
rote:
> >>>>>>
> >>>>>> On 11/04/2020 21:06, Cl=C3=A9ment P=C3=A9ron wrote:
> >>>>>>> OPP table can defined both frequency and voltage.
> >>>>>>>
> >>>>>>> Register the mali regulator if it exist.
> >>>>>>>
> >>>>>>> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >>>>>>> ---
> >>>>>>>     drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++=
++++++---
> >>>>>>>     drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
> >>>>>>>     2 files changed, 31 insertions(+), 4 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/driver=
s/gpu/drm/panfrost/panfrost_devfreq.c
> >>>>>>> index 62541f4edd81..2dc8e2355358 100644
> >>>>>>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> >>>>>>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> >>>>>>> @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_dev=
ice *pfdev)
> >>>>>>>         struct device *dev =3D &pfdev->pdev->dev;
> >>>>>>>         struct devfreq *devfreq;
> >>>>>>>         struct thermal_cooling_device *cooling;
> >>>>>>> +     const char *mali =3D "mali";
> >>>>>>> +     struct opp_table *opp_table =3D NULL;
> >>>>>>> +
> >>>>>>> +     /* Regulator is optional */
> >>>>>>> +     opp_table =3D dev_pm_opp_set_regulators(dev, &mali, 1);
> >>>>>>
> >>>>>> This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add
> >>>>>> support for multiple regulators") which is currently in drm-misc-n=
ext
> >>>>>> (and linux-next). You want something more like:
> >>>>>
> >>>>> Thanks for you review, indeed I didn't see that multiple regulators
> >>>>> support has been added.
> >>>>> Will update in v2.
> >>>>>
> >>>>>>
> >>>>>>        opp_table =3D dev_pm_opp_set_regulators(dev,
> >>>>>>                                              pfdev->comp->supply_n=
ames,
> >>>>>>                                              pfdev->comp->num_supp=
lies);
> >>>>>>
> >>>>>> Otherwise a platform with multiple regulators won't work correctly=
.
> >>>>>>
> >>>>>> Also running on my firefly (RK3288) board I get the following warn=
ing:
> >>>>>>
> >>>>>>       debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu'=
 already
> >>>>>> present!
> >
> > I try to reproduce but it can't

Sorry, you're right I have indeed the same issue:
[    2.903406] panfrost 1800000.gpu: Features: L2:0x07110206
Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002821 AS:0xf
JS:0x7
[    2.913297] sunxi-ir 7040000.ir: initialized sunXi IR driver
[    2.919901] panfrost 1800000.gpu: shader_present=3D0x3 l2_present=3D0x1
[    2.920497] panfrost 1800000.gpu: Looking up mali-supply from device tre=
e
[    3.036568] vdd-gpu: could not add device link 1800000.gpu err -17
[    3.036580] debugfs: Directory '1800000.gpu-mali' with parent
'vdd-gpu' already present!
[    3.046312] panfrost 1800000.gpu: [drm:panfrost_devfreq_init
[panfrost]] Failed to register cooling device
[    3.056322] [drm] Initialized panfrost 1.1.0 20180908 for
1800000.gpu on minor 0

> > regulator is mount at :
> > ./regulator/vdd-gpu
> > whereas OPP is mount :
> > ./opp/soc-1800000.gpu/opp:756000000/supply-0/
>
> Getting a backtrace from the two occurrences, I see one added from:
>
>    (debugfs_create_dir) from [<c04633f8>] (create_regulator+0xe0/0x220)
>    (create_regulator) from [<c04681d8>] (_regulator_get+0x168/0x204)
>    (_regulator_get) from [<c04682e0>] (regulator_bulk_get+0x64/0xf4)
>    (regulator_bulk_get) from [<c04696f0>]
> (devm_regulator_bulk_get+0x40/0x74)
>    (devm_regulator_bulk_get) from [<bf00af44>]
> (panfrost_device_init+0x1b4/0x48c [panfrost])
>    (panfrost_device_init [panfrost]) from [<bf00a4d4>]
> (panfrost_probe+0x94/0x184 [panfrost])
>    (panfrost_probe [panfrost]) from [<c04ee694>]
> (platform_drv_probe+0x48/0x94)
>
> And the other:
>
>    (debugfs_create_dir) from [<c04633f8>] (create_regulator+0xe0/0x220)
>    (create_regulator) from [<c04681d8>] (_regulator_get+0x168/0x204)
>    (_regulator_get) from [<c05c1280>] (dev_pm_opp_set_regulators+0x6c/0x1=
84)
>    (dev_pm_opp_set_regulators) from [<bf00b4ac>]
> (panfrost_devfreq_init+0x38/0x1ac [panfrost])
>    (panfrost_devfreq_init [panfrost]) from [<bf00a508>]
> (panfrost_probe+0xc8/0x184 [panfrost])
>    (panfrost_probe [panfrost]) from [<c04ee694>]
> (platform_drv_probe+0x48/0x94)
>
> Both are created at /regulator/vdd_gpu

We are having an issue with Panfrost driver registering two times the
same regulator and giving an error when trying to create the debugfs
folder.

Could you clarify if it is allowed for a device to register two times
the same regulator?

I check Documentation/power/regulator/regulator.rst but this point is
not specified.

Thanks,
Clement

>
> >
> > I see that firefly as 2 regulators with the same name :
> > vdd_gpu from syr828
> > (https://github.com/mopplayer/Firefly-RK3288-Kernel-With-Mali764/blob/m=
aster/arch/arm/boot/dts/firefly-rk3288.dts#L453)
> > vdd_gpu from rk808_dcdc2_reg
> > (https://github.com/mopplayer/Firefly-RK3288-Kernel-With-Mali764/blob/m=
aster/arch/arm/boot/dts/firefly-rk3288.dts#L841)
> >
> > So i think the issue is from the firefly device-tree.
>
> I'm using the DTB from the kernel tree
> (/arch/arm/boot/dts/rk3288-firefly.dts) which as far as I can see
> doesn't contain this problem. Certainly decompiling the DTB I can see
> only one mention of vdd_gpu (in syr828).
>
> Steve
>
> >
> > Regards,
> > Clement
> >
> >>>>>>
> >>>>>> This is due to the regulator debugfs entries getting created twice=
 (once
> >>>>>> in panfrost_regulator_init() and once here).
> >>>>>
> >>>>> Is it a warning that should be consider as an error? Look's more an=
 info no?
> >>>>> What should be the correct behavior if a device want to register tw=
o
> >>>>> times the same regulator?
> >>>>
> >>>> Or we can change the name from vdd_XXX to opp_vdd_XXX ?
> >>>> https://elixir.bootlin.com/linux/latest/source/drivers/opp/debugfs.c=
#L45
> >>>
> >>> Yes, I'm not sure that it's actually a problem in practice. And it ma=
y
> >>> well be correct to change this in the generic code rather than try to
> >>> work around it in Panfrost. But we shouldn't spam the user with warni=
ngs
> >>> as that makes real issues harder to see.
> >>>
> >>> Your suggestion to change the name seems reasonable to me, but I don'=
t
> >>> fully understand the opp code, so we'd need some review from the OPP
> >>> maintainers. Hopefully Viresh, Nishanth or Stephen can provide some i=
nsight.
> >>
> >> Agree, I will send a v2 with the rename and see if OPP Maintainers agr=
ee.
> >>
> >> Regards,
> >> Clement
> >>
> >>>
> >>> Steve
>
