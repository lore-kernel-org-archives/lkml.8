Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D5C7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9649D2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582156190;
	bh=7nGfN2ZIcbajdQOWwV23BCstmz2w3d12JAcJoXWf9zc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=F+fvWV2vZm+Hex9UhWgsU5vyO2gCtBsiKGXWdyKP/FXeyBx2Qmsq10/sgSGtNCbkp
	 NPoiY7SUqG0FvJQam2QCVlTgt3HJ5D1GH7gsSfsioOG99H/PQYyrt+Uhllk43RWxwQ
	 5kyMrezVdORYwKDoAuFTCZTMwiFNBT/q0ux49RI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgBSXtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgBSXtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:49:49 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF7A2465D;
        Wed, 19 Feb 2020 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582156188;
        bh=7nGfN2ZIcbajdQOWwV23BCstmz2w3d12JAcJoXWf9zc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aYRiLk2xVJqyJHgyqCsGbakOYSNsgGX//YSfRHtITVg/Ua7xhx28LW7zJt7Nq+Ew8
         PcbXDPERCcgTp6c0i7mWHMBT2HY/6ByzozS0rycQQHJztdn+kPdOkR9cY8tzuXYOR1
         OpwmqCp8TzJMS5aP44zzk/+u9fB1ehSVnFh8pIz8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <50f9ce8b-c303-3b25-313b-cfb62d7e8735@collabora.com>
References: <5e4b4889.1c69fb81.bc072.65a9@mx.google.com> <50f9ce8b-c303-3b25-313b-cfb62d7e8735@collabora.com>
Subject: Re: next/master bisection: baseline.login on sun8i-h2-plus-orangepi-zero
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     broonie@kernel.org, tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        mgalka@collabora.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 19 Feb 2020 15:49:47 -0800
Message-ID: <158215618721.184098.2077489323832918966@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding some Allwinner folks. Presumably there is some sort of clk that
is failing to calculate a phase when it gets registered. Maybe that's
because the parent isn't registered yet?

Quoting Guillaume Tucker (2020-02-17 23:45:41)
> Hi Stephen,
>=20
> Please see the bisection report below about a boot failure.
>=20
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
>=20
> There's nothing in the serial console log, probably because it's
> crashing too early during boot.  I'm not sure if other platforms
> on kernelci.org were hit by this in the same way, it's tricky to
> tell partly because there is no output.  It should possible to
> run it again with earlyprintk enabled in BayLibre's test lab
> though.
>=20
> Thanks,
> Guillaume
>=20
>=20
> On 18/02/2020 02:14, kernelci.org bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >=20
> > next/master bisection: baseline.login on sun8i-h2-plus-orangepi-zero
> >=20
> > Summary:
> >   Start:      c25a951c50dc Add linux-next specific files for 20200217
> >   Plain log:  https://storage.kernelci.org//next/master/next-20200217/a=
rm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-ze=
ro.txt
> >   HTML log:   https://storage.kernelci.org//next/master/next-20200217/a=
rm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-ze=
ro.html
> >   Result:     2760878662a2 clk: Bail out when calculating phase fails d=
uring clk registration
> >=20
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >=20
> > Parameters:
> >   Tree:       next
> >   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
> >   Branch:     master
> >   Target:     sun8i-h2-plus-orangepi-zero
> >   CPU arch:   arm
> >   Lab:        lab-baylibre
> >   Compiler:   gcc-8
> >   Config:     multi_v7_defconfig
> >   Test case:  baseline.login
> >=20
> > Breaking commit found:
> >=20
> > -----------------------------------------------------------------------=
--------
> > commit 2760878662a290ac57cff8a5a8d8bda8f4dddc37
> > Author: Stephen Boyd <sboyd@kernel.org>
> > Date:   Wed Feb 5 15:28:02 2020 -0800
> >=20
> >     clk: Bail out when calculating phase fails during clk registration
> >    =20
> >     Bail out of clk registration if we fail to get the phase for a clk =
that
> >     has a clk_ops::get_phase() callback. Print a warning too so that dr=
iver
> >     authors can easily figure out that some clk is unable to read back =
phase
> >     information at boot.
> >    =20
> >     Cc: Douglas Anderson <dianders@chromium.org>
> >     Cc: Heiko Stuebner <heiko@sntech.de>
> >     Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> >     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> >     Link: https://lkml.kernel.org/r/20200205232802.29184-5-sboyd@kernel=
.org
> >     Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index dc8bdfbd6a0c..ed1797857bae 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3457,7 +3457,12 @@ static int __clk_core_init(struct clk_core *core)
> >        * Since a phase is by definition relative to its parent, just
> >        * query the current clock phase, or just assume it's in phase.
> >        */
> > -     clk_core_get_phase(core);
> > +     ret =3D clk_core_get_phase(core);
> > +     if (ret < 0) {
> > +             pr_warn("%s: Failed to get phase for clk '%s'\n", __func_=
_,
> > +                     core->name);
> > +             goto out;
> > +     }
> > =20
> >       /*
> >        * Set clk's duty cycle.
> > -----------------------------------------------------------------------=
--------
> >=20
> >=20
> > Git bisection log:
> >=20
> > -----------------------------------------------------------------------=
--------
> > git bisect start
> > # good: [11a48a5a18c63fd7621bb050228cebf13566e4d8] Linux 5.6-rc2
> > git bisect good 11a48a5a18c63fd7621bb050228cebf13566e4d8
> > # bad: [c25a951c50dca1da4a449a985a9debd82dc18573] Add linux-next specif=
ic files for 20200217
> > git bisect bad c25a951c50dca1da4a449a985a9debd82dc18573
> > # bad: [5859c179b7ed01050641bd565959a2c4571923da] Merge remote-tracking=
 branch 'swiotlb/linux-next'
> > git bisect bad 5859c179b7ed01050641bd565959a2c4571923da
> > # bad: [ecf5a6e1ec22ecbe1c9086f40130188f31e37a38] Merge remote-tracking=
 branch 'xtensa/xtensa-for-next'
> > git bisect bad ecf5a6e1ec22ecbe1c9086f40130188f31e37a38
> > # good: [e475ff54b7d62c550768ce36617e8c8fec72cfc0] Merge remote-trackin=
g branch 'reset/reset/next'
> > git bisect good e475ff54b7d62c550768ce36617e8c8fec72cfc0
> > # bad: [9e86f8cc2d2f464e27c172127e02641fe77eccea] Merge remote-tracking=
 branch 'sh/sh-next'
> > git bisect bad 9e86f8cc2d2f464e27c172127e02641fe77eccea
> > # good: [1752d66d86600e9cb508612ded6984774b72321d] Merge remote-trackin=
g branch 'tegra/for-next'
> > git bisect good 1752d66d86600e9cb508612ded6984774b72321d
> > # bad: [0ecb83df935b058a2c3727716a7fab539dbaba88] Merge remote-tracking=
 branch 'csky/linux-next'
> > git bisect bad 0ecb83df935b058a2c3727716a7fab539dbaba88
> > # bad: [898fe3af935a45236cbfd053e79ae01506ae7aa2] Merge branch 'clk-for=
matting' into clk-next
> > git bisect bad 898fe3af935a45236cbfd053e79ae01506ae7aa2
> > # bad: [0d426990beac93127a4ee37cc056fce928466f7d] Merge branch 'clk-pha=
se-errors' into clk-next
> > git bisect bad 0d426990beac93127a4ee37cc056fce928466f7d
> > # good: [6e37add6b938941f755928159ede3c9855307066] Merge branch 'clk-qc=
om' into clk-next
> > git bisect good 6e37add6b938941f755928159ede3c9855307066
> > # good: [5d98429bbebc5dc683ea6919d9b9e6e83e8c8867] Merge branch 'clk-fi=
xes' into clk-next
> > git bisect good 5d98429bbebc5dc683ea6919d9b9e6e83e8c8867
> > # good: [768a5d4f63c29d3bed5abb3c187312fcf623fa05] clk: Use 'parent' to=
 shorten lines in __clk_core_init()
> > git bisect good 768a5d4f63c29d3bed5abb3c187312fcf623fa05
> > # bad: [2760878662a290ac57cff8a5a8d8bda8f4dddc37] clk: Bail out when ca=
lculating phase fails during clk registration
> > git bisect bad 2760878662a290ac57cff8a5a8d8bda8f4dddc37
> > # good: [0daa376d832f4ce585f153efee4233b52fa3fe58] clk: Move rate and a=
ccuracy recalc to mostly consumer APIs
> > git bisect good 0daa376d832f4ce585f153efee4233b52fa3fe58
> > # first bad commit: [2760878662a290ac57cff8a5a8d8bda8f4dddc37] clk: Bai=
l out when calculating phase fails during clk registration
> > -----------------------------------------------------------------------=
--------
> >=20
>
