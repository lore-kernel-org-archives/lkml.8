Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70667206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="k2Fec3Kd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZOnKnpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgGGIy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:54:58 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35995 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgGGIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:54:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 147D0B4A;
        Tue,  7 Jul 2020 04:54:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Jul 2020 04:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eW75ERrLMdE6WpKO+nt3dXk6D5K
        YxlcA1E0IptRa+SU=; b=k2Fec3Kd5rpHc8INkqB53cfw2+8QGuKO2tqoTqRBw7+
        C1JaYfOpo07HrF2QPPjFaIvCCsnt5xzjl5r1YQ1V1nVhnquUdqFzS+OrjCeUs88N
        SPRWGh9hKSN9P4es4PP/N1zMfViEz17MRQmb8lTYW/XN8GVeBURtyiGePnBBCJmc
        cWLngot7LgHG39NnG/Isvtkr63LB+iff5QZzS1yvkvvJQ4n9PMHwajhEmiXy9xtx
        CSOOzv0iC+CMfBT6lns1BZ9DqiCpG14vcuglUSVuBzDVQbyJmXr8/R5WpUTXU9Pb
        U+UqeHN4oDomGXu7RQHYBY0+E4bS198J6/1rnv0XQDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eW75ER
        rLMdE6WpKO+nt3dXk6D5KYxlcA1E0IptRa+SU=; b=ZZOnKnpNTA5l+wMnNdhBSv
        XgKNPniiSg7+URH6wS5W9KPfZ7Zbd9TijP6XVH3xgZJRwVU6VFPbwVbpG9UZ2rx0
        YJaH8hhUea9D24ifw+YqaxG4rC6X2O+mtcm6atX7CuJgGHkORUAYRoXrdJyLiBtG
        sjDqXUKO4nT0qV33XCxoioLyc4DNbTIhycIkfx5BNNxwbeG2EnTK5bkkTVmluxRl
        TvCWXYdyFI5SvU7RBNm49BzToj6U+xokgBGvI7+jWby9+euY/g1qMEstRZPD1qf8
        B7DBQwBXwzfRnyJYy+ZW8Lk9qVbW3tG2odrRTqlL5SnOpVY9zf8vEFqu1JWn6sDA
        ==
X-ME-Sender: <xms:WzgEXzSc0lzD7AiEwh8kMLxjqyavy7wtaQXDcWuear2e3GYHsbLyBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WzgEX0xW6R0J4tjTHq9Gr28jhWdE1my3yK6Pyu53RJYkYIHJpQaDcw>
    <xmx:WzgEX41eUs35G839bg02RU_Sitk9X5jLGTn5g9MsPMP7GaWhNF7Mfg>
    <xmx:WzgEXzBc5CFZy1lk_2f8LMkTG14iA1dXF6Uf_4hy9jYlm2PkVUGMQg>
    <xmx:XzgEX3V2rymmuFcmtt8QVaIotldV5fgf0BwsLIQvTqJxraTF_aiBmg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1FBFF3280059;
        Tue,  7 Jul 2020 04:54:51 -0400 (EDT)
Date:   Tue, 7 Jul 2020 10:54:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Anholt <eric@anholt.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v4 0/9] drm/vc4: Turn the TXP into a CRTC
Message-ID: <20200707085448.f36cmkrjuh2eggly@gilmour.lan>
References: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
 <20200630082509.puuzneiipalvrxup@gilmour.lan>
 <CADaigPXSaZ8K2m_fyq2dFwf-X76LpYMagjXqA01b0ST6QYzE2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jqd42sbh6b7yxf6g"
Content-Disposition: inline
In-Reply-To: <CADaigPXSaZ8K2m_fyq2dFwf-X76LpYMagjXqA01b0ST6QYzE2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jqd42sbh6b7yxf6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2020 at 05:51:29PM -0700, Eric Anholt wrote:
> On Tue, Jun 30, 2020 at 1:25 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi Eric,
> >
> > On Thu, Jun 11, 2020 at 03:36:45PM +0200, Maxime Ripard wrote:
> > > Hi,
> > >
> > > This is another part of the rpi4 HDMI series that got promoted to a
> > > series of its own to try to reduce the main one.
> > >
> > > This rework is needed since the bcm2711 used in the rpi4 has a more
> > > complex routing in the HVS that doesn't allow to use a fairly simple
> > > mapping like what was used before.
> > >
> > > Since that mapping affects both the pixelvalves and the TXP, turning =
the
> > > TXP into a CRTC just like pixelvalves are allows to deal with the
> > > mapping in the CRTC states, which turns out to be pretty convenient.
> > >
> > > Let me know what you think,
> > > Maxime
> > >
> > > Changes from v3:
> > >   - Stripped the patches out of the main HDMI series
> > >   - Change the bind order of the HVS to avoid a compatible check
> > >   - Added Eric's tags
> > >   - Rebased on top of drm-misc-next
> > >
> > > Maxime Ripard (9):
> > >   drm/vc4: Reorder the bind order of the devices
> > >   drm/vc4: crtc: Move HVS setup code to the HVS driver
> >
> > Could you review those two patches? You haven't reviewed them yet and
> > it's holding back the rest of the patches.
>=20
> LKML email workflow is the worst, the patches never came through to me
> so I didn't see them until you linked me the patchwork.  Patch 2,
> commit message should say "We'll need the HVS to be bound before the
> TXP", but other than that, r-b.

I've fixed the commit message and applied, thanks (and sorry for the troubl=
es).

Maxime

--jqd42sbh6b7yxf6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwQ4WAAKCRDj7w1vZxhR
xQLgAQCPHb+oyf0Dpp31VCgMq1FZ/q2dYIn1C9v1egi1m+IJnQD/TR5vF/IqjYcC
Z4dgaxdrxiy+ZojLoVAcBM3aBu1UFQE=
=YSwm
-----END PGP SIGNATURE-----

--jqd42sbh6b7yxf6g--
