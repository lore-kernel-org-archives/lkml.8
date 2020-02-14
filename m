Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C2EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAECE222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Z38/5FwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKi+uOWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgBNHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:52:24 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37045 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbgBNHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:52:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C1F1722116;
        Fri, 14 Feb 2020 02:52:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 14 Feb 2020 02:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=FfWukEscDXi4AiOAUwFnISerJNT
        2ulBjdIfmoaDjhfE=; b=Z38/5FwBT6wIDGSePzDRMo4642ClZld+yNMGR+vLRsU
        i//MH128GCl2EtPqPWssIZtyhUta6Lw3Wo4ML3zsXaYLjdgUh/xNqotb6ulJj7Oj
        ZaI7JPGJ+ZhcJbQaYrSqmPBJnCvTAc9I31cBKDM3KI9TbnyQaLrj1uRdyoKgPxqW
        x0bw+3KIkKsztIzi1aOFr0AzETpp/qhh7n6vPKg9cFeTIdGCkiO9Ew8fIZyq53HA
        yf4X4Q+pK2lLRYCakC52ZHY1WlQvtUC7hztnclpIBUZkSC41Rpw6V6A/rwWU9Zvx
        onXwUPrzr+SPawEUEPMRsNFwuEi4/ey4Emo9cFlVVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FfWukE
        scDXi4AiOAUwFnISerJNT2ulBjdIfmoaDjhfE=; b=NKi+uOWDuThMPIsLcRNOoE
        pS45sqNDvq/FkiQsUlp3x7GL3fXbid8Lf6Twi3KWAOqzQ2yS9bg/A5aJyLjn40Vl
        9rNx2u+tevyM+/VWRYMfC3uOCtMrpOnma/9u3fA9+nnGTGXUlC+fQUc1EtVfL7Q4
        hfZudf8aRpKr4J4NFoYNwgmMBKsfxnHG1MAzMF8ypK0E3Dl3KLkfpsLtB4kQ1a4K
        JqP6q/rxcVyWFVt5KmrCE4fdWwQXcARiWuHavWUGJbaWYcRcHGmxUELLuza0FoB+
        0u7Gek7FOTABf7sl+ud1ty6KqpCz8c2aDV+KTeHCuRLa/XoF/jDHiJtzs6anzAJQ
        ==
X-ME-Sender: <xms:tFFGXkpA1pzCRTjqvFgfaRva6i4lwuyCJbVIZvPMBCW62UBf7O6Qpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tFFGXhNgSQ0iQpv9OGOEJ9A-R0hYHZn5-IGI6hKLnQkheCGLD25Dog>
    <xmx:tFFGXmqDL0f1yuNg8MzbGYMnPazFMFH-sSXv3mquJ4AAXF1GVu8bZA>
    <xmx:tFFGXsETKERymYp8JggfZEbg-xP5EPPbomwoGFk_1eJd_c6aTPK4HQ>
    <xmx:tlFGXpbe3nccuQN2oSfBiDUIqwk5IRAeB6NPDoZmwGd0H_qTP64QSg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 249683280066;
        Fri, 14 Feb 2020 02:52:20 -0500 (EST)
Date:   Fri, 14 Feb 2020 08:52:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH v2 2/2] ARM: sun7i: dts: Add LVDS panel support on A20
Message-ID: <20200214075218.huxdhmd4qfoakat2@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200212222355.17141-2-andrey.lebedev@gmail.com>
 <20200213094304.hf3glhgmquypxpyf@gilmour.lan>
 <20200213200823.GA28336@kedthinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x5jathax6z2l7lsv"
Content-Disposition: inline
In-Reply-To: <20200213200823.GA28336@kedthinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x5jathax6z2l7lsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Feb 13, 2020 at 10:08:23PM +0200, Andrey Lebedev wrote:
> On Thu, Feb 13, 2020 at 10:43:04AM +0100, Maxime Ripard wrote:
> > On Thu, Feb 13, 2020 at 12:23:57AM +0200, andrey.lebedev@gmail.com wrote:
> > > From: Andrey Lebedev <andrey@lebedev.lt>
> > >
> > > Define pins for LVDS channels 0 and 1, configure reset line for tcon0 and
> > > provide sample LVDS panel, connected to tcon0.
> > >
> > > Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> >
> > And this prefix should be ARM: dts: sun7i ;)
>
> Ah, thanks, I think I've got the pattern now!
>
> > > +			/omit-if-no-ref/
> > > +			lcd_lvds0_pins: lcd_lvds0_pins {
> >
> > underscores in the node names will create a dtc warning at
> > compilation, you should use lcd-lvds0-pins instead.

It's silenced by default, but you'll get them with W=1

> You're right, I wasn't following the naming convention here. dtc doesn't
> produce any warning on this though. Fixed that anyway.
>
> > This will create a spurious warning message for TCON1, since we
> > adjusted the driver to tell it supports LVDS, but there's no LVDS
> > reset line, so we need to make it finer grained.
>
> Yes, I can attribute two of the messages in my dmesg log [1] to this
> ("Missing LVDS properties" and "LVDS output disabled". "sun4i-tcon
> 1c0d000.lcd-controller" is indeed tcon1). And yes, I can see how they
> can be confusing to someone.
>
> I'd need some pointers on how to deal with that though (if we want to do
> it in this scope).

Like I was mentionning, you could introduce a new compatible for each
TCON (tcon0 and tcon1) and only set the support_lvds flag for tcon0

Maxime

--x5jathax6z2l7lsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkZRsgAKCRDj7w1vZxhR
xVn9AP0VqLi8/MHY79s8QWyp+/otjpGvsgLBU2Zk6DQhh8ltugD+NXF9PEFDFa8/
e3b3qvGzp/u5wrJVKi3rJiHrzi/5OAM=
=c3MI
-----END PGP SIGNATURE-----

--x5jathax6z2l7lsv--
