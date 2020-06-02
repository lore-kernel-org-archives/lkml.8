Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C04C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E124206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f45OZi6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BV685FeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFBMwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:52:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49817 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgFBMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:52:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 333E85C0060;
        Tue,  2 Jun 2020 08:52:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Jun 2020 08:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WDq+umCpTeMy9k3W0/Wp/zsjIGB
        wGG2fZVoUDuvc/6I=; b=f45OZi6d+1yiR3+fuUjVx/OffyBQzXpKlPQbYfJ2G3K
        JbM0gya4DR68naiFqT2uxODNVG5DStLzdE0iZ0Hnzxalrq2wgoa/aOXT4CymRy1o
        wmlS4dGmwPT3KP/RICQd1ql2qMZepWk1XPNZ3QnD7p3P5wzq618XIg9N+hZsTfNA
        /Pr3d6A/XzFKIFLxaADMbIIVVCjUC1SV0wuzNUvMN40DDoDN1UIfl07lvtYIpqbC
        m9WK5McK+v9DLGrh7eQaiL4t8K0EVgAUPABhuctzK69htNR4z3RvbvlyQrKNenkX
        sshBlFSNkun213PiCHeWnXf9bfPEEPiexjX5dOiOeng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WDq+um
        CpTeMy9k3W0/Wp/zsjIGBwGG2fZVoUDuvc/6I=; b=BV685FeEEZTDO3F+XTXwxI
        2oE5GEcg0f7mM0Xy3W9x6iJ4YgMAPeOCwXEhZ/oAKIBLr7G5KoT9O8zlYS/+IX/C
        njwsrJSZ1aofL9UDyXcM7T69/UBQRoRRoHvgqDD/ZX4m1YMiYQZl8J+97TvvNgXE
        Wcb5s8xAA3VM25x17aAKG6VCjAKSefFKXAFpdSYYRjFJ7pR8CHGDlz/wlIij4kVP
        q0nF2WqzdaUFSgDw6+li7l1wnI4tsCwQ34Z3bZ8eCI7d7VaumCmJWJvVZqB5TY0I
        y31iE0eqEk6RLDbCFQucAqdpR0agta7mzml3QMtrfToY9xQ7uoR8rS9yzzl/YSRA
        ==
X-ME-Sender: <xms:jUvWXlA1A9BMkxHHPwcc4ETwV_7JdBoR9eKiZ9o_AMY6HEPeZ-Rh-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jUvWXjiv-UD_m6bSp3Zfr5gqBGrPqSSjyQ89beHJzdhD2j5TIEm8qA>
    <xmx:jUvWXglDvAwYaWpwOw29Sv3u9zzRIvPIAewbDVQzL1JdcawX4c04PQ>
    <xmx:jUvWXvwMkm_EFZZphIf5wSyET12pg7TUa6yfCaKQsK8SWPpaq4NAXw>
    <xmx:jkvWXpGO6Kobml1_RcWM6NdXzzn1A0uJKD9e7b3bY8-0559rrtABfA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 027DA3060FE7;
        Tue,  2 Jun 2020 08:52:29 -0400 (EDT)
Date:   Tue, 2 Jun 2020 14:52:27 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Anholt <eric@anholt.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v3 015/105] drm/vc4: hvs: Boost the core clock during
 modeset
Message-ID: <20200602125227.fe3mt5jnqd6u4pft@gilmour>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <1aaadf9a5176591c891622cb00b0c50f42e569dc.1590594512.git-series.maxime@cerno.tech>
 <CADaigPWQdeTd2CGCK-yxq+TAU6xKMVsdZfhSVptn4RSENxpdxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ne6yctwhuf4mmo4i"
Content-Disposition: inline
In-Reply-To: <CADaigPWQdeTd2CGCK-yxq+TAU6xKMVsdZfhSVptn4RSENxpdxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ne6yctwhuf4mmo4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Wed, May 27, 2020 at 09:33:44AM -0700, Eric Anholt wrote:
> On Wed, May 27, 2020 at 8:49 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > In order to prevent timeouts and stalls in the pipeline, the core clock
> > needs to be maxed at 500MHz during a modeset on the BCM2711.
>=20
> Like, the whole system's core clock?

Yep, unfortunately...

> How is it reasonable for some device driver to crank the system's core
> clock up and back down to some fixed-in-the-driver frequency? Sounds
> like you need some sort of opp thing here.

That frequency is the minimum rate of that clock. However, since other
devices have similar requirements (unicam in particular) with different
minimum requirements, we will switch to setting a minimum rate instead
of enforcing a particular rate, so that patch would be essentially
s/clk_set_rate/clk_set_min_rate/.

Would that work for you?

>=20
> Patch 13,14 r-b.

Thanks!
Maxime

--ne6yctwhuf4mmo4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtZLiwAKCRDj7w1vZxhR
xVPmAP45n0n/bXaKZ1yE75klsmfyLSQrkPVnggB8TOLcoVWvXgEAoQBVPj7GmkAB
XoSEMSgX4zgK/n0fW6bptMqt4QaM1gc=
=P3EF
-----END PGP SIGNATURE-----

--ne6yctwhuf4mmo4i--
