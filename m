Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D7C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9CA20735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="tCJ10biH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTrpxUvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDVJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:23:06 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51725 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgDVJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:23:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 620035C00C7;
        Wed, 22 Apr 2020 05:23:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Apr 2020 05:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=1iiAxI87Jk6J/8UmvUUTFd23t4R
        KFlVM9d53BckbYUA=; b=tCJ10biHAYsxSq9tpQ5YUelEtK0uTKnYesz6jRvllMy
        DzJfyJIkbHiojXUKVZK2gcEWm64vB/XHmPf5C8chjW5yf0Sy25y5kXfOmpLlVgKX
        CDRjtQ87c8ZQkZPJ6rWDlHQqH3NXakI3C6Gi2erHVVcfm/k58vAa444b1Y3F911f
        fkponJTw290yzLGFsuWeflhGQnEpnOfyHr4wCPd4HyN5w2lO8L9DUWATVgtwPFZX
        XsXUhvZSVZdBmsCUObubSo8b7wsIutEGzYSnJwRdnajVI7HCktbseWHMROHMPIFC
        dNMmSdefPtpXEyzRCxD5HeTgn77P+QHIHiyBWocWJ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1iiAxI
        87Jk6J/8UmvUUTFd23t4RKFlVM9d53BckbYUA=; b=rTrpxUvlaG57zQcEhbyQFR
        scLw5q/EBcPPiUYQYfv+TtQuDl5tQMM6y4ayy0mBaVJxSYe+ab49aUtUF8djRdnD
        wz8MTg3iZrn2b0MUhAxmF/cR5MVSk00hJmglARw4gUWDgAI2OH0aN6/hilZ1bsa+
        WCehGCXHWg2xaDd0flxXiYGPbWgR/iqLN3filaQ9Vn8m1OWu60V0RJ0A3+lJ2VDE
        +WxB3pU+2IHT7HuEl7kcm7n54t2cpOVM4u6pnjWKTknpcRaOJppxDAHegoaUuZ0W
        i7TAu1O30MAmCelWj6vvr14FKKJjdz60K35OroglaBCx6TV/3KzZzT6QeVR3GLZg
        ==
X-ME-Sender: <xms:9gygXuqLxcV5RXac6UmfFUoxTMx4ol2ao0DU9zLR_7UWLNliJ6KSsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9gygXrHqeGRYE1TOf9xQZXIaO7WhEwB5wjF4oRJxGiO3-XayqZAFZQ>
    <xmx:9gygXgln_YBRSKIp1ZsxKemoxMtHFLS6jFUvGzTpUH3Ge4DHMLWmLQ>
    <xmx:9gygXhF6YxauogiZdvGUX96GqVef5Ou98xuARGrbdnZlZyb8otNf5A>
    <xmx:-AygXpf7ik1bc3QstrzMM91isWv_alFcPn0oKiQ0E9TZMWt2ScbOOw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A19B3280059;
        Wed, 22 Apr 2020 05:23:02 -0400 (EDT)
Date:   Wed, 22 Apr 2020 11:23:00 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: hdmi ddc clk: Fix size of m divider
Message-ID: <20200422092300.444wcaurdwyrorow@gilmour.lan>
References: <20200413095457.1176754-1-jernej.skrabec@siol.net>
 <1742537.tdWV9SEqCh@jernej-laptop>
 <20200415104214.ndkkxfnufkxgu53r@gilmour.lan>
 <1785843.taCxCBeP46@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7oskm5d3tnjhoykn"
Content-Disposition: inline
In-Reply-To: <1785843.taCxCBeP46@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7oskm5d3tnjhoykn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 15, 2020 at 07:52:28PM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 15. april 2020 ob 12:42:14 CEST je Maxime Ripard napisal(a):
> > On Mon, Apr 13, 2020 at 06:09:08PM +0200, Jernej =C5=A0krabec wrote:
> > > Dne ponedeljek, 13. april 2020 ob 16:12:39 CEST je Chen-Yu Tsai=20
> napisal(a):
> > > > On Mon, Apr 13, 2020 at 6:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > > On Mon, Apr 13, 2020 at 5:55 PM Jernej Skrabec
> > > > > <jernej.skrabec@siol.net>
> > >=20
> > > wrote:
> > > > > > m divider in DDC clock register is 4 bits wide. Fix that.
> > > > > >=20
> > > > > > Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> > > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > >=20
> > > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > >=20
> > > > Cc stable?
> > >=20
> > > I don't think it's necessary:
> > > 1. It doesn't change much (anything?) for me when reading EDID. I don=
't
> > > think it's super important to have precise DDC clock in order to prop=
erly
> > > read EDID. 2. No matter if it has "Cc stable" tag or not, it will be
> > > eventually picked for stable due to fixes tag.
> > >=20
> > > This was only small observation when I was researching EDID readout i=
ssue
> > > on A20 board, but sadly, I wasn't able to figure out why reading it
> > > sometimes fails. I noticed similar issue on SoCs with DE2 (most
> > > prominently on OrangePi PC2 - H5), but there was easy workaround - I =
just
> > > disabled video driver in U- Boot. However, if A20 display driver gets
> > > disabled in U-Boot, it totally breaks video output on my TV when Linux
> > > boots (no output). I guess there is more fundamental problem with clo=
cks
> > > than just field size. I think we should add more constraints in clock
> > > driver, like preset some clock parents and not allow to change parents
> > > when setting rate, but carefully, so simplefb doesn't break. Such
> > > constraints should also solve problems with dual head setups.
> > I disagree here. Doing all sorts of special case just doesn't scale,
> > and we'll never have the special cases sorted out on all the boards
> > (and it's a nightmare to maintain).
> >=20
> > Especially since it's basically putting a blanket over the actual
> > issue and looking the other way. If there's something wrong with how
> > we deal with (re)parenting, we should fix that. It impacts more than
> > just DRM, and all the SoCs.
>=20
> I agree with you that automatic solution would be best, but I just don't =
see
> it how it would be done.

> Dual head display pipeline is pretty complex for clock driver to get it r=
ight
> on it's own. There are different possible setups and some of them are hot
> pluggable, like HDMI.

Do you have an actual scenario that is broken right now?

> And there are also SoC specific quirks, like A64, where for some reason, =
MIPI
> DPHY and HDMI PHY share same clock parent - PLL_VIDEO0. Technically, MIPI=
 DPHY
> can be clocked from PLL_PERIPH0 (fixed to 600 MHz), but that's not really
> helpful. I'm not even sure if there is any good solution to this - certai=
nly
> HDMI and MIPI can't claim exclusivity and somehow best common rate must be
> found for PLL_VIDEO0, if that's even possible.

IIRC the DSI DPHY needs a clock running at 297MHz, which is pretty much wha=
t the
HDMI PHY should need too (or 148.5, but that's pretty easy to generate from
297). So which problem do we have there?

> I was sure that HDMI PHY on A64 can be clocked from PLL_VIDEO1, which wou=
ld
> solve main issue, but to date, I didn't find any way to do that.
>=20
> That's pretty off topic, so I hope original patch can be merged as-is.

It does, sorry

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--7oskm5d3tnjhoykn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqAM9AAKCRDj7w1vZxhR
xTmVAP9kvmX4WaSBtV/XQiF2vUsWwoTSx6VEdAN+fmPtFRk1AAEAmRVLotyUAtrH
emjt+9TNkeEsYLIWoTgSrr6rcGDv8QQ=
=JYMX
-----END PGP SIGNATURE-----

--7oskm5d3tnjhoykn--
