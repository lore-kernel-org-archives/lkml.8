Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95388C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE812072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adJ67/s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgDMQfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731558AbgDMQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:35:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C993C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:35:35 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b12so9943201ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8sqX19cKLRZEs4UkUnCQ2kQv2g8+YoFcNjNVuM8O2kQ=;
        b=adJ67/s1+CyO4xnndcjPcPXTmXBDUBrejTxddwjhL3Iq7kEvbV3OSjK3vT1j+Gtl+v
         Vsk3VSUZSs+PLnIhtkDJzB52BS5h1l4DZGNjFTBSd+E8+GYLFQSOo8zEbIU/vM0n1IC4
         0A9eZWXcgI44h/q4QAsNUXWGuivCedl4GwtsrVsww1SZADKQNL0pSSytEvKJvjAg+LB8
         6HGEWUNWURvrEJ6qoViiG5dx1VAU+NGQPHsmwype1UD5FIr6WHktO2sa3D63YtCrNa0+
         q23fAAt8V/IxvrtOPFG9O4xwjDsxcFodwolcP2QGleACOTSeEvwBIL2yUfo1cG1K2bNB
         72NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8sqX19cKLRZEs4UkUnCQ2kQv2g8+YoFcNjNVuM8O2kQ=;
        b=FOUSJlpcbFdfapTyWZddvy3uPnFA1bEDxumagYH3obvtmkZc5iYGEhoeH9wy8c8UB9
         Up/s/CDh6N2JDGwEAxlLcgDxR3nqoicKFRn27uE8PBqlQUo33WedNimIKAURSZggx41R
         Z316sA/eotDyApjXgU6xy0++TZDLR9tN3P63379B9GQxc7yL2kkmxkPSZb+Cannau0mY
         Nn08zrGKN2TnWh56tJID2GOgg/0LuFXtb3wGGzAIVsmyTHdwppTUiG4SwVVwLg8L7plp
         BKkDnRZZjVikqyJnvDbmGxC/iNVq1406s94cHPQvlk1hchsuoBDfw/TPgoCMg+HR71eO
         KJ8A==
X-Gm-Message-State: AGi0PuZ32qDYeWpt960JnX9xbnt9JJmxSKb8pYXBHRE7CM2x51Q/FB9O
        IRaxFOUrU32lcNtGd8LfyRwRaaC32JjeGZpIxOE=
X-Google-Smtp-Source: APiQypL9OM4cxON/ZjCb6YFq62C+scAbNM4g/Yf4PVR93wCxiDfal6C4bIsJsVTBJSmeKzNEqRqNc9sP4jXGN3BMiIE=
X-Received: by 2002:a02:2944:: with SMTP id p65mr16109022jap.89.1586795734257;
 Mon, 13 Apr 2020 09:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com> <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com>
In-Reply-To: <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 13 Apr 2020 18:35:23 +0200
Message-ID: <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
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

On Mon, 13 Apr 2020 at 17:55, Steven Price <steven.price@arm.com> wrote:
>
> On 13/04/2020 15:31, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > On Mon, 13 Apr 2020 at 16:18, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >>
> >> Hi Steven,
> >>
> >> On Mon, 13 Apr 2020 at 15:18, Steven Price <steven.price@arm.com> wrot=
e:
> >>>
> >>> On 11/04/2020 21:06, Cl=C3=A9ment P=C3=A9ron wrote:
> >>>> OPP table can defined both frequency and voltage.
> >>>>
> >>>> Register the mali regulator if it exist.
> >>>>
> >>>> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >>>> ---
> >>>>    drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++=
++---
> >>>>    drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
> >>>>    2 files changed, 31 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/g=
pu/drm/panfrost/panfrost_devfreq.c
> >>>> index 62541f4edd81..2dc8e2355358 100644
> >>>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> >>>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> >>>> @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device=
 *pfdev)
> >>>>        struct device *dev =3D &pfdev->pdev->dev;
> >>>>        struct devfreq *devfreq;
> >>>>        struct thermal_cooling_device *cooling;
> >>>> +     const char *mali =3D "mali";
> >>>> +     struct opp_table *opp_table =3D NULL;
> >>>> +
> >>>> +     /* Regulator is optional */
> >>>> +     opp_table =3D dev_pm_opp_set_regulators(dev, &mali, 1);
> >>>
> >>> This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add
> >>> support for multiple regulators") which is currently in drm-misc-next
> >>> (and linux-next). You want something more like:
> >>
> >> Thanks for you review, indeed I didn't see that multiple regulators
> >> support has been added.
> >> Will update in v2.
> >>
> >>>
> >>>       opp_table =3D dev_pm_opp_set_regulators(dev,
> >>>                                             pfdev->comp->supply_names=
,
> >>>                                             pfdev->comp->num_supplies=
);
> >>>
> >>> Otherwise a platform with multiple regulators won't work correctly.
> >>>
> >>> Also running on my firefly (RK3288) board I get the following warning=
:
> >>>
> >>>      debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' alr=
eady
> >>> present!
> >>>
> >>> This is due to the regulator debugfs entries getting created twice (o=
nce
> >>> in panfrost_regulator_init() and once here).
> >>
> >> Is it a warning that should be consider as an error? Look's more an in=
fo no?
> >> What should be the correct behavior if a device want to register two
> >> times the same regulator?
> >
> > Or we can change the name from vdd_XXX to opp_vdd_XXX ?
> > https://elixir.bootlin.com/linux/latest/source/drivers/opp/debugfs.c#L4=
5
>
> Yes, I'm not sure that it's actually a problem in practice. And it may
> well be correct to change this in the generic code rather than try to
> work around it in Panfrost. But we shouldn't spam the user with warnings
> as that makes real issues harder to see.
>
> Your suggestion to change the name seems reasonable to me, but I don't
> fully understand the opp code, so we'd need some review from the OPP
> maintainers. Hopefully Viresh, Nishanth or Stephen can provide some insig=
ht.

Agree, I will send a v2 with the rename and see if OPP Maintainers agree.

Regards,
Clement

>
> Steve
