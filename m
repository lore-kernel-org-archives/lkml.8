Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43CFC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F73F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BgKA2hJa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h008BtY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgBYNiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:38:23 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54805 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729436AbgBYNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:38:22 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2E0387327;
        Tue, 25 Feb 2020 08:38:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Feb 2020 08:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=XHaUvlijZEsg3EFrKcfQygP/UZp
        K1ifb+/vCmhWP8Pw=; b=BgKA2hJaGKTWOjrTVF03BtGXWT9oHUx+Jj47WMj3UXV
        jdPknS2fUGKj/K4kvHW6TXNO1/ZKn81719sVWU9UptRjlItOLH/RbrLdM1tfpnib
        5rSEaeHXIsSg1L4ubTzdYcafLcXkEfxsMXp3/ZmSmAaSEEpW/sCkGmobb50ZCp7P
        2xQ/XJCQ3gSiGL6cMod2zlZlMB6ljd2VJRDsP6gcSaV7sYUYTXwXo5S1gUXfYp9w
        dJRvANgOmFBXKn87Xd8oJ16pSP1OJnxVv7mQnaWeKI2TOUACz0g7q2I2k1Qoe+mR
        8VNtLoKvGMHuNdUp+gBaHQiFRLXdhjY2SCfDsWqKBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XHaUvl
        ijZEsg3EFrKcfQygP/UZpK1ifb+/vCmhWP8Pw=; b=h008BtY19KbCXG9bwTtPsY
        fLalGqCbFUpPeXqp7DtGedL7MmxOH8e6GWa2KstF8Xr2P9qDi8JEQPsZ+r64Mz6L
        rkGs7W58pePKAXhS37CLRUWKW4Xfh8MNP9pcspIhV7iC3SUkN/0OAhGn5De5f6WB
        oBCgA1j68pvOaf/VX8WB9MESenvkfdHqxPEYQ2dCb/O8wBWxN0J+DcD5huB9iiXJ
        /mV5HICdHpFoFE/uLjAxDhHT6z8BqTi6zzLHJw8Nwqvi0GrDKJJGPfS7/AX0yzlu
        FVxwpwdaKO+qU8gMpPN4/CGNtQKii7g99qyCT0TwB8vZR2ijn9UVs7bG52fl814A
        ==
X-ME-Sender: <xms:SSNVXj106x4HTh1FwKiOrawGvpwvbaNBW0snEiQJ5aSAWUtgE8XgGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epkhgvrhhnvghltghirdhorhhgpdhkvghrnhgvlhdrohhrghenucfkphepledtrdekledr
    ieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SSNVXvku2TyTh66yP6HJEp_Iafm9x906fULQ8P_OfAIErlE8Js2yBQ>
    <xmx:SSNVXmip_uEcN6WEJC3h0XX4P3y76diGaoYRkVmiLIaY_IB-AFTDQw>
    <xmx:SSNVXuTe-Cglgsrp1bYJHXTe210gaLtqt3Sx8Mx7Ct6n7Y-KAZqkJQ>
    <xmx:SyNVXnfV79h51ErPZzTMCkle-6B6MB3HKgLlw5DyLTJi7kVR0V4c-g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89362328005D;
        Tue, 25 Feb 2020 08:38:17 -0500 (EST)
Date:   Tue, 25 Feb 2020 14:38:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>, broonie@kernel.org,
        tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        mgalka@collabora.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on
 sun8i-h2-plus-orangepi-zero
Message-ID: <20200225133815.fjc6apts3ns5zcm5@gilmour.lan>
References: <5e4b4889.1c69fb81.bc072.65a9@mx.google.com>
 <50f9ce8b-c303-3b25-313b-cfb62d7e8735@collabora.com>
 <158215618721.184098.2077489323832918966@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="36i66r5gn7suledg"
Content-Disposition: inline
In-Reply-To: <158215618721.184098.2077489323832918966@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36i66r5gn7suledg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 03:49:47PM -0800, Stephen Boyd wrote:
> Adding some Allwinner folks. Presumably there is some sort of clk that
> is failing to calculate a phase when it gets registered. Maybe that's
> because the parent isn't registered yet?

It's simpler than that :)

> Quoting Guillaume Tucker (2020-02-17 23:45:41)
> > Hi Stephen,
> >
> > Please see the bisection report below about a boot failure.
> >
> > Reports aren't automatically sent to the public while we're
> > trialing new bisection features on kernelci.org but this one
> > looks valid.
> >
> > There's nothing in the serial console log, probably because it's
> > crashing too early during boot.  I'm not sure if other platforms
> > on kernelci.org were hit by this in the same way, it's tricky to
> > tell partly because there is no output.  It should possible to
> > run it again with earlyprintk enabled in BayLibre's test lab
> > though.
> >
> > Thanks,
> > Guillaume
> >
> >
> > On 18/02/2020 02:14, kernelci.org bot wrote:
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > * This automated bisection report was sent to you on the basis  *
> > > * that you may be involved with the breaking commit it has      *
> > > * found.  No manual investigation has been done to verify it,   *
> > > * and the root cause of the problem may be somewhere else.      *
> > > *                                                               *
> > > * If you do send a fix, please include this trailer:            *
> > > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > > *                                                               *
> > > * Hope this helps!                                              *
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > >
> > > next/master bisection: baseline.login on sun8i-h2-plus-orangepi-zero
> > >
> > > Summary:
> > >   Start:      c25a951c50dc Add linux-next specific files for 20200217
> > >   Plain log:  https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.txt
> > >   HTML log:   https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.html
> > >   Result:     2760878662a2 clk: Bail out when calculating phase fails during clk registration
> > >
> > > Checks:
> > >   revert:     PASS
> > >   verify:     PASS
> > >
> > > Parameters:
> > >   Tree:       next
> > >   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >   Branch:     master
> > >   Target:     sun8i-h2-plus-orangepi-zero
> > >   CPU arch:   arm
> > >   Lab:        lab-baylibre
> > >   Compiler:   gcc-8
> > >   Config:     multi_v7_defconfig
> > >   Test case:  baseline.login
> > >
> > > Breaking commit found:
> > >
> > > -------------------------------------------------------------------------------
> > > commit 2760878662a290ac57cff8a5a8d8bda8f4dddc37
> > > Author: Stephen Boyd <sboyd@kernel.org>
> > > Date:   Wed Feb 5 15:28:02 2020 -0800
> > >
> > >     clk: Bail out when calculating phase fails during clk registration
> > >
> > >     Bail out of clk registration if we fail to get the phase for a clk that
> > >     has a clk_ops::get_phase() callback. Print a warning too so that driver
> > >     authors can easily figure out that some clk is unable to read back phase
> > >     information at boot.
> > >
> > >     Cc: Douglas Anderson <dianders@chromium.org>
> > >     Cc: Heiko Stuebner <heiko@sntech.de>
> > >     Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> > >     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > >     Link: https://lkml.kernel.org/r/20200205232802.29184-5-sboyd@kernel.org
> > >     Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> > >
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index dc8bdfbd6a0c..ed1797857bae 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -3457,7 +3457,12 @@ static int __clk_core_init(struct clk_core *core)
> > >        * Since a phase is by definition relative to its parent, just
> > >        * query the current clock phase, or just assume it's in phase.
> > >        */
> > > -     clk_core_get_phase(core);
> > > +     ret = clk_core_get_phase(core);
> > > +     if (ret < 0) {
> > > +             pr_warn("%s: Failed to get phase for clk '%s'\n", __func__,
> > > +                     core->name);
> > > +             goto out;
> > > +     }

The thing is, clk_core_get_phase actually returns the phase on success :)

So, when you actually have a phase returned, and not an error, you end
up with a positive, non-zero, value for ret.

And since it's the latest assignment of that value, and that we return
ret all the time, even on success, we end up returning that positive,
non-zero value to __clk_register, which in turn tests whether it's
non-zero for success (it's not), and then proceeds to garbage collect
everything.

I guess we're just the odd ones actually returning non-zero phases at
init time and in kernelci.

I'll send a patch

Maxime

--36i66r5gn7suledg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlUjRwAKCRDj7w1vZxhR
xXDtAP9b8T02oSuEhYCHu4pRnLvlbOzVVLv+yrH96OD/76ivzAEAoXZ6tx7R81ZF
dHtemdtSh6+UbDVjmKYL94RSfqOIiwM=
=4lXL
-----END PGP SIGNATURE-----

--36i66r5gn7suledg--
