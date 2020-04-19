Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F60C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB27721974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTS24IdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDSJZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgDSJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:25:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D3C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:25:21 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id u5so6656946ilb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IVfVaIgVGlSNv1IAtMUZwjF1hn02HfUDYJcRcSDSIrU=;
        b=kTS24IdLWHMBDGq+NpCb4YCezSTjPOT3lXb0FhNdXiPmK5NrZGGK52haVSfXEU6Ndj
         4hqhpbZlaYEpA9yzxLFB17W3ye3e1gJd7soL0Qs8lKKAzvTCpLm3LmK/xTymwN9/4+so
         GQPQEUYla4HxNT/DwhdhoM7vjrjuFQojP2ml5em2pgpWQVeT+36kc3XwZxjS+XX19ezH
         IlszYdd8hFN8ApV/RdQwbzGA3kZYPM7svi5cJnEAfqpYuwiZEq1uXeujAk3kezStnPBC
         kOpKxevP79//eZH2QTfm7mX2wFGQlugSyw2JTgQ7lV1oQEGugBOxxJEjT1DhSw9R38xZ
         0shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IVfVaIgVGlSNv1IAtMUZwjF1hn02HfUDYJcRcSDSIrU=;
        b=ip8SBgENkj1wmugU6XdE9OVCWRiHxqaNXfBx3ZbK2Auw/syWZTU0Y/kETXYZILVTxe
         fkkWR0gvIICFJeXKppXxOMz0xjXCkuUzGpw/qk+ikO7hA8R9JZM846L9kseKT3aIRwvU
         y2fPWyiliuaUHZEDBsPMj7K1Zv2M0N7ahj3P132cTItUBL1U79+MuTUxePu6brturbba
         Ag5mIbjhfz8PnDQtVqxq2clitT7Xzo+RytPYTpVH6NWfuDrjRyfL/D7l22T/Mry2VQJg
         O230HwY6KTiqpzhi+g+Mh6pMQphJrm2LUCfc3wTjGTBYb3Xu7BGQfaIqapvMtbHedEG5
         J3BA==
X-Gm-Message-State: AGi0Puax/avgRwj6oZSYCiWBimLGKHoYQUGcDv9HCMkls8mzoD4KX2Sm
        k7/TgxoT+cfYpkfBSYORhU6/fhI0qgeOQLoCVfg=
X-Google-Smtp-Source: APiQypJBoKtsP+3E2TKCkI9VLQhvM6cPmwbZtxSn9QoLSzwFZyzeWjXdAytf78HSH+qeMUpvBnp3KUuWObpUallXbAA=
X-Received: by 2002:a92:d8ca:: with SMTP id l10mr131258ilo.118.1587288319958;
 Sun, 19 Apr 2020 02:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com> <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com> <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
 <20200414185523.GO5412@sirena.org.uk> <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
 <5e15e7ac-1d9c-d614-8fd9-27525c88cafb@arm.com> <5290a7a8-2a0a-cb89-9d62-270393123054@arm.com>
 <CAJiuCccm4gTAUWhTy+gK0kt4of=8yWcz2n_JtnmeAJofcpBKeQ@mail.gmail.com>
In-Reply-To: <CAJiuCccm4gTAUWhTy+gK0kt4of=8yWcz2n_JtnmeAJofcpBKeQ@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 19 Apr 2020 11:25:08 +0200
Message-ID: <CAJiuCceECTKqTecq5KGayzNqOvQfOctR8RqnncKU66ieU7hH1w@mail.gmail.com>
Subject: Re: Multiple regulators for one device [was drm/panfrost: add devfreq
 regulator support]
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 17 Apr 2020 at 14:33, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Robin,
>
> On Fri, 17 Apr 2020 at 13:10, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2020-04-16 2:42 pm, Steven Price wrote:
> > [...]
> > > Perhaps a better approach would be for Panfrost to hand over the stru=
ct
> > > regulator objects it has already got to the OPP framework. I.e. open
> > > code dev_pm_opp_set_regulators(), but instead of calling
> > > regulator_get_optional() simply populate the regulators we already ha=
ve?

Just saw that a Lima devfreq[0] has been also introduced with I think
exactly the same logic.

Is this something that hasn't been triggered by Maintainer or I am
missing something?

I will backport some remarks made on the lima devfreq to improve panfrost o=
ne.
They are almost identical.

Regards,
Clement

0: https://cgit.freedesktop.org/drm-misc/commit/?id=3D1996970773a323533e1cc=
1b6b97f00a95d675f32

> > >
> > > The other benefit of that is it would provide a clear hand-over of
> > > responsibility between Panfrost handling it's own regulators and the =
OPP
> > > framework picking up the work. The disadvantage is that Panfrost woul=
d
> > > have to track whether the regulators have been handed over or not.
> >
> > Sounds like the most logical thing to do is to shuffle things around so
> > we start by trying to set up an OPP table, then fall back to explicitly
> > claiming clocks and regulators if necessary. Then we can easily make th=
e
> > devfreq decision later in probe based on how that turned out.
>
> Ok I will propose a new serie with this behavior,
>
> Thanks
> Clement
>
> >
> > Robin.
