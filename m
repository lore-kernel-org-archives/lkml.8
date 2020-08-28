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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BEAC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4C820848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd2SeT90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgH1NBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgH1NB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:01:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181CC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:01:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so1392692ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qmuEnH5GsTtwDHi/2A8OPOfMOnN9D7tXWOIdKXuuF20=;
        b=kd2SeT90NMZhMb6g7VQcHVKTU5VegjJu/0Y2Nj6rGO6g8gTC+oydOUQfgr2AYvuvM0
         WuwfqJSXI7TJZuP3/+Po5TjMcMpJyFHlKIRJxPio/kB30XMKTHC6nRD5shjfHRNXzGmo
         MkjnGUbrB0XX+geu9eo4d1EGJawO5S9i+Lqf10YxhO2WN17JtFa6a2yHfin35rO9ZSKA
         6NHoDM8b9yyrukt4Q8KPcIp1/+Fb6EydnBp76/cp7Xu36xo2W2PPdBGjnXfXAApiKqz1
         AVfelg4BeTaDFL9F77MDKG5k6SOZa2mSTy3iAy6InGQBC8T2fHRU9vbOLSqfaHLJpS2u
         /e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmuEnH5GsTtwDHi/2A8OPOfMOnN9D7tXWOIdKXuuF20=;
        b=RJ1MkIqcCmUmKVARuZBPVxoGXxmAucCvDXp3msr8bkkEMauZ1qP3q62ekeJyWYeN80
         bQH+1TxGXeVeilu/g/PF2O64HKnGnKesReUQzNcZDqv7410OhhGikPH8ebTrQENhWoFb
         JDtj2rfiCu1jV/lXsQ1FDrY7iAMiCCkYBiMlcM3Np5fJ5BysTc/P/Qck5RSwcxfr4J8Z
         oa+5ENqW9rBT5elHE53yf9m9Q/6mPyGD13i6WGIaRsTs+0CebXFdUIOXhZlSYnZRQrRG
         bKMgMB3fEjosMpYjVDiUQuwmrD4jgIM98yDOdYuy8305/z9gBY7YxvX/q1KXLpgalxtI
         akXA==
X-Gm-Message-State: AOAM5314T6bvnc7BmIkKayU5UfbuuBWmTO15gyCofvgDfaotxUlFjoVv
        d0iIoYFFfLVP+k9VwJjlV6o=
X-Google-Smtp-Source: ABdhPJyNJYnQYHXJE/Y9rLKgpB2/z4y7Eh1118zFmt5wle+tR3pBj6JD0wHBy0utn5Nf8SHlhBqGuw==
X-Received: by 2002:a17:906:6558:: with SMTP id u24mr1590086ejn.364.1598619683457;
        Fri, 28 Aug 2020 06:01:23 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id o7sm926978edq.53.2020.08.28.06.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 06:01:22 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     =?utf-8?B?T25kxZllaiBKaXJtYW4gPG1lZ291c0BtZWdvdXMuY29tPiwgQ2zDqW1lbnQgUMOpcm9u?= 
        <peron.clem@gmail.com>, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Fri, 28 Aug 2020 15:01:21 +0200
Message-ID: <1857384.8dBkWBLq5R@jernej-laptop>
In-Reply-To: <20200828122119.eadup4aiohnqldam@core.my.home>
References: <20200704102535.189647-1-peron.clem@gmail.com> <CAJiuCce=Oh-vtR8u-RvAvtAb2ZqSfK6jY+cQ6wBBh7maN30Wfg@mail.gmail.com> <20200828122119.eadup4aiohnqldam@core.my.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 28. avgust 2020 ob 14:21:19 CEST je Ond=C5=99ej Jirman napisal(a=
):
> On Fri, Aug 28, 2020 at 02:16:36PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime,
> >=20
> > On Tue, 25 Aug 2020 at 15:35, Maxime Ripard <maxime@cerno.tech> wrote:
> > > Hi Clement,
> > >=20
> > > On Mon, Aug 03, 2020 at 09:54:05AM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > Hi Maxime and All,
> > > >=20
> > > > On Sat, 4 Jul 2020 at 16:56, Cl=C3=A9ment P=C3=A9ron <peron.clem@gm=
ail.com>=20
wrote:
> > > > > Hi Maxime,
> > > > >=20
> > > > > On Sat, 4 Jul 2020 at 14:13, Maxime Ripard <maxime@cerno.tech>=20
wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > On Sat, Jul 04, 2020 at 12:25:34PM +0200, Cl=C3=A9ment P=C3=A9r=
on wrote:
> > > > > > > Add an Operating Performance Points table for the GPU to
> > > > > > > enable Dynamic Voltage & Frequency Scaling on the H6.
> > > > > > >=20
> > > > > > > The voltage range is set with minival voltage set to the targ=
et
> > > > > > > and the maximal voltage set to 1.2V. This allow DVFS framework
> > > > > > > to
> > > > > > > work properly on board with fixed regulator.
> > > > > > >=20
> > > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > >=20
> > > > > > That patch seems reasonable, why shouldn't we merge it?
> > > > >=20
> > > > > I didn't test it a lot and last time I did, some frequencies look=
ed
> > > > > unstable. https://lore.kernel.org/patchwork/cover/1239739/
> > > > >=20
> > > > > This series adds regulator support to Panfrost devfreq, I will se=
nd
> > > > > a
> > > > > new one if DVFS on the H6 GPU is stable.
> > > > >=20
> > > > > I got this running glmark2 last time
> > > > > # glmark2-es2-drm
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > >     glmark2 2017.07
> > > > >=20
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > >     OpenGL Information
> > > > >     GL_VENDOR:     Panfrost
> > > > >     GL_RENDERER:   Mali T720 (Panfrost)
> > > > >     GL_VERSION:    OpenGL ES 2.0 Mesa 20.0.5
> > > > >=20
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > > [   93.550063] panfrost 1800000.gpu: GPU Fault 0x00000088 (UNKNOW=
N)
> > > > > at
> > > > > 0x0000000080117100
> > > > > [   94.045401] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> > > > > config=3D0x3700, status=3D0x8, head=3D0x21d6c00, tail=3D0x21d6c00,
> > > > > sched_job=3D00000000e3c2132f
> > > > >=20
> > > > > [  328.871070] panfrost 1800000.gpu: Unhandled Page fault in AS0 =
at
> > > > > VA
> > > > > 0x0000000000000000
> > > > > [  328.871070] Reason: TODO
> > > > > [  328.871070] raw fault status: 0xAA0003C2
> > > > > [  328.871070] decoded fault status: SLAVE FAULT
> > > > > [  328.871070] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> > > > > [  328.871070] access type 0x3: WRITE
> > > > > [  328.871070] source id 0xAA00
> > > > > [  329.373327] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> > > > > config=3D0x3700, status=3D0x8, head=3D0xa1a4900, tail=3D0xa1a4900,
> > > > > sched_job=3D000000007ac31097
> > > > > [  329.386527] panfrost 1800000.gpu: js fault, js=3D0,
> > > > > status=3DDATA_INVALID_FAULT, head=3D0xa1a4c00, tail=3D0xa1a4c00
> > > > > [  329.396293] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> > > > > config=3D0x3700, status=3D0x58, head=3D0xa1a4c00, tail=3D0xa1a4c0=
0,
> > > > > sched_job=3D0000000004c90381
> > > > > [  329.411521] panfrost 1800000.gpu: Unhandled Page fault in AS0 =
at
> > > > > VA
> > > > > 0x0000000000000000
> > > > > [  329.411521] Reason: TODO
> > > > > [  329.411521] raw fault status: 0xAA0003C2
> > > > > [  329.411521] decoded fault status: SLAVE FAULT
> > > > > [  329.411521] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> > > > > [  329.411521] access type 0x3: WRITE
> > > > > [  329.411521] source id 0xAA00
> > > >=20
> > > > Just to keep a track of this issue.
> > > >=20
> > > > Piotr Oniszczuk give more test and seems to be software related:
> > > > https://www.spinics.net/lists/dri-devel/msg264279.html
> > > >=20
> > > > Ondrej gave a great explanation about a possible origin of this iss=
ue:
> > > > https://freenode.irclog.whitequark.org/linux-sunxi/2020-07-11
> > > >=20
> > > > 20:12 <megi> looks like gpu pll on H6 is NKMP clock, and those are
> > > > implemented in such a way in mainline that they are prone to
> > > > overshooting the frequency during output divider reduction
> > > > 20:13 <megi> so disabling P divider may help
> > > > 20:13 <megi> or fixing the dividers
> > > > 20:14 <megi> and just allowing N to change
> > > > 20:22 <megi> hmm, I haven't looked at this for quite some time, but=
 H6
> > > > BSP way of setting PLL factors actually makes the most sense out of
> > > > everything I've seen/tested so far
> > > > 20:23 <megi> it waits for lock not after setting NK factors, but af=
ter
> > > > reducing the M factor (pre-divider)
> > > > 20:24 <megi> I might as well re-run my CPU PLL tester with this
> > > > algorithm, to see if it fixes the lockups
> > > > 20:26 <megi> it makes sense to wait for PLL to stabilize "after"
> > > > changing all the factors that actually affect the VCO, and not just
> > > > some of them
> > > > 20:27 <megi> warpme_: ^
> > > > 20:28 <megi> it may be the same thing that plagues the CPU PLL rate
> > > > changes at runtime
> > >=20
> > > I guess it's one of the bugs we never heard of...
> > >=20
> > > It would be a good idea to test it on another platform (like Rockchip=
?)
> > > to rule out any driver issue?
> > >=20
> > > What do you think?
> >=20
> > I can't exclude a bug in the driver, but if it was the case LE
> > community or Panfrost maintainer would have heard of that.
> >=20
> > Megi's explanations match what I observed.
> > NKMP drivers seem the perfect guilty here or maybe it's a combination of
> > both...
> >=20
> > Jernej sent me this patch to test:
> > https://github.com/clementperon/linux/commit/56bde359beaf8e827ce53ede1f=
e4a
> > 0ad233cb79b But it didn't fix the issue, If someone want to have a look=
 at
> > it :)
> Not sure how that patch is supposed to work, but it seems to apply
> all factors at once to me.

It's hackish but in essence, it is what vendor clock driver does. From A83T=
 or=20
so onwards, vendor driver uses "lock_mode =3D PLL_LOCK_NEW_MODE" and this h=
ack=20
tries to mimick that locking behaviour (good enough for tests).

And yes, this code still applies all factors at once, because vendor driver=
=20
does that too on H6. Only case where vendor driver applies factors one by o=
ne=20
is for V3s SoC.

Btw, only recently I noticed following block in h6 clk driver:
https://elixir.bootlin.com/linux/latest/source/drivers/clk/sunxi-ng/ccu-sun=
50i-h6.c#L1196

Other clk drivers don't have it. Maybe it has some influence in this matter.

Best regards,
Jernej

>=20
> regards,
> 	o.
>=20
> > Regards,
> > Clement
> >=20
> > > Maxime




