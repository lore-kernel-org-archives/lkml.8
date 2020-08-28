Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD95C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B515C20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXA18EFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgH1MRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgH1MQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:16:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0143C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:16:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b16so980170ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NwqTh91+ICIu5X0KSUWIkFsurn3pcQhxwL3HOW3tCSE=;
        b=XXA18EFsvtJiywdHttlyfwZxFSrj+DGNLRcqrBel3BSUI5KqBhvujvperRs/lAlz71
         erSdhCnPqdQdl/JPhpT6QUD0KoeZussNEFqqb/yazU0qCMFu6VEQIPbJYL5UFnTrFsNY
         Yizo5zUBP6bVODKz9d3XK+tdUwStnPOfuNWbPJkFemWMS8J1mkBwDn4S7TNwd1T42QKG
         lobxQjN3im+nVBhUK1QIQhBwwwyd0W88qYlcFu6PKFcXw/v3mRtepMGZffE3eEYTO1hl
         IH9ANHsdrbSn/ZvMsME6tE3GL4kAYC/UGyWat43oMFPeyKaHn7UNEdgDLcH+4kCG71F4
         0heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NwqTh91+ICIu5X0KSUWIkFsurn3pcQhxwL3HOW3tCSE=;
        b=iRAej3nuHNGmzHNHDUuuH1CAJ4WumAZ2ANcSzD1Vv+us7MGqIK0F6c0v4rRjTg53Wc
         jrwn4Dw5Umn0x6msG6kwcOInsygnPniQthsyXBJNemhxnojQNL3DsipwrTq6Rr/Rd8/3
         D2B3dlb0DA9D98Pe6aLgzb8NhGRYGX08iriBu58B+KEFBa23NSZtGJE8KPJUPceuvlWe
         KjPOMVsA3BMPfTsnojMQXtj1RrWiZsqCWkdCDBoVJi146gF95EN5Y5NSyn/tydygYVfm
         1HI0KC0R9P531jAehbUX9M5XXMXq3fx3YxbPz4ShyCCYae9rX1lfU5Ni4uA601ikJ8Um
         Yl+Q==
X-Gm-Message-State: AOAM530yhHPZZguJs5FhUAUGQI4Ltj357ulcTYMsyXC3hCN/x5ZdNmox
        QoQ1TgNX+D4C3y2QvxLWk8RFDbI7uuP3d0zOkkg=
X-Google-Smtp-Source: ABdhPJw6CrvkrJNDrTdRaxvtfUOkseBaKpv90pRJqI6TSsGonrIVheXNQifQ2rFcQB7Ubmfdzcq1n38wrKsLpYjh6NM=
X-Received: by 2002:a5d:9701:: with SMTP id h1mr1077882iol.36.1598617007799;
 Fri, 28 Aug 2020 05:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200704102535.189647-1-peron.clem@gmail.com> <20200704102535.189647-14-peron.clem@gmail.com>
 <20200704121301.jfd3m3jnlghmddg4@gilmour.lan> <CAJiuCceMS__bNVO54E2OYnqnaOAL9pGkxRo4XAABiyqagaEtmw@mail.gmail.com>
 <CAJiuCce58Gaxf_Qg2cnMwvOgUqYU__eKb3MDX1Fe_+47htg2bA@mail.gmail.com> <20200824131133.hp3resve6c3r3xqq@gilmour.lan>
In-Reply-To: <20200824131133.hp3resve6c3r3xqq@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 28 Aug 2020 14:16:36 +0200
Message-ID: <CAJiuCce=Oh-vtR8u-RvAvtAb2ZqSfK6jY+cQ6wBBh7maN30Wfg@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add
 GPU OPP table
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 25 Aug 2020 at 15:35, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Clement,
>
> On Mon, Aug 03, 2020 at 09:54:05AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime and All,
> >
> > On Sat, 4 Jul 2020 at 16:56, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.=
com> wrote:
> > >
> > > Hi Maxime,
> > >
> > > On Sat, 4 Jul 2020 at 14:13, Maxime Ripard <maxime@cerno.tech> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sat, Jul 04, 2020 at 12:25:34PM +0200, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > > > > Add an Operating Performance Points table for the GPU to
> > > > > enable Dynamic Voltage & Frequency Scaling on the H6.
> > > > >
> > > > > The voltage range is set with minival voltage set to the target
> > > > > and the maximal voltage set to 1.2V. This allow DVFS framework to
> > > > > work properly on board with fixed regulator.
> > > > >
> > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > >
> > > > That patch seems reasonable, why shouldn't we merge it?
> > >
> > > I didn't test it a lot and last time I did, some frequencies looked u=
nstable.
> > > https://lore.kernel.org/patchwork/cover/1239739/
> > >
> > > This series adds regulator support to Panfrost devfreq, I will send a
> > > new one if DVFS on the H6 GPU is stable.
> > >
> > > I got this running glmark2 last time
> > > # glmark2-es2-drm
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >     glmark2 2017.07
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >     OpenGL Information
> > >     GL_VENDOR:     Panfrost
> > >     GL_RENDERER:   Mali T720 (Panfrost)
> > >     GL_VERSION:    OpenGL ES 2.0 Mesa 20.0.5
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >
> > > [   93.550063] panfrost 1800000.gpu: GPU Fault 0x00000088 (UNKNOWN) a=
t
> > > 0x0000000080117100
> > > [   94.045401] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> > > config=3D0x3700, status=3D0x8, head=3D0x21d6c00, tail=3D0x21d6c00,
> > > sched_job=3D00000000e3c2132f
> > >
> > > [  328.871070] panfrost 1800000.gpu: Unhandled Page fault in AS0 at V=
A
> > > 0x0000000000000000
> > > [  328.871070] Reason: TODO
> > > [  328.871070] raw fault status: 0xAA0003C2
> > > [  328.871070] decoded fault status: SLAVE FAULT
> > > [  328.871070] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> > > [  328.871070] access type 0x3: WRITE
> > > [  328.871070] source id 0xAA00
> > > [  329.373327] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> > > config=3D0x3700, status=3D0x8, head=3D0xa1a4900, tail=3D0xa1a4900,
> > > sched_job=3D000000007ac31097
> > > [  329.386527] panfrost 1800000.gpu: js fault, js=3D0,
> > > status=3DDATA_INVALID_FAULT, head=3D0xa1a4c00, tail=3D0xa1a4c00
> > > [  329.396293] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> > > config=3D0x3700, status=3D0x58, head=3D0xa1a4c00, tail=3D0xa1a4c00,
> > > sched_job=3D0000000004c90381
> > > [  329.411521] panfrost 1800000.gpu: Unhandled Page fault in AS0 at V=
A
> > > 0x0000000000000000
> > > [  329.411521] Reason: TODO
> > > [  329.411521] raw fault status: 0xAA0003C2
> > > [  329.411521] decoded fault status: SLAVE FAULT
> > > [  329.411521] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> > > [  329.411521] access type 0x3: WRITE
> > > [  329.411521] source id 0xAA00
> >
> > Just to keep a track of this issue.
> >
> > Piotr Oniszczuk give more test and seems to be software related:
> > https://www.spinics.net/lists/dri-devel/msg264279.html
> >
> > Ondrej gave a great explanation about a possible origin of this issue:
> > https://freenode.irclog.whitequark.org/linux-sunxi/2020-07-11
> >
> > 20:12 <megi> looks like gpu pll on H6 is NKMP clock, and those are
> > implemented in such a way in mainline that they are prone to
> > overshooting the frequency during output divider reduction
> > 20:13 <megi> so disabling P divider may help
> > 20:13 <megi> or fixing the dividers
> > 20:14 <megi> and just allowing N to change
> > 20:22 <megi> hmm, I haven't looked at this for quite some time, but H6
> > BSP way of setting PLL factors actually makes the most sense out of
> > everything I've seen/tested so far
> > 20:23 <megi> it waits for lock not after setting NK factors, but after
> > reducing the M factor (pre-divider)
> > 20:24 <megi> I might as well re-run my CPU PLL tester with this
> > algorithm, to see if it fixes the lockups
> > 20:26 <megi> it makes sense to wait for PLL to stabilize "after"
> > changing all the factors that actually affect the VCO, and not just
> > some of them
> > 20:27 <megi> warpme_: ^
> > 20:28 <megi> it may be the same thing that plagues the CPU PLL rate
> > changes at runtime
>
> I guess it's one of the bugs we never heard of...
>
> It would be a good idea to test it on another platform (like Rockchip?)
> to rule out any driver issue?
>
> What do you think?

I can't exclude a bug in the driver, but if it was the case LE
community or Panfrost maintainer would have heard of that.

Megi's explanations match what I observed.
NKMP drivers seem the perfect guilty here or maybe it's a combination of bo=
th...

Jernej sent me this patch to test:
https://github.com/clementperon/linux/commit/56bde359beaf8e827ce53ede1fe4a0=
ad233cb79b
But it didn't fix the issue, If someone want to have a look at it :)

Regards,
Clement

>
> Maxime
