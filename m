Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E44C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E492082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="c9Jlcl1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZ2vf5bZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgD3PG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:06:57 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:45539 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgD3PG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:06:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AEF9C3D7;
        Thu, 30 Apr 2020 11:06:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 30 Apr 2020 11:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=3HOldL8M8SMhSFP04OdXihjEBtT
        HltI1ljKcZAb+nkU=; b=c9Jlcl1rGAZQZsRZokJHWuF0zB9rfxpkoH4HQ0LusyR
        4nzRuVu05bhdqG6EeL0AK4+0TJFJr/EeRET0GCJ77nt+u1LPbsJWaTu5FzgvhI46
        E2rCO2tfd2R7S8/kKw4YWvEhX42I+hzTTv397UEOwilQmjqqOyRWELvAbV0x8CLy
        mSIEHlu9c5rCKsZng3/oUZsomDllS4UlRujAQtmZdb8UPqPyGw/042FzVNphKdya
        5/90seI+WvLVSrr8fAKaFh2yyYCvY2Svq0LIZQaElMZcL7l4bgvx9ynqiOgwEP4w
        G2rHw+hLBDwurMLmtmHOVOB2QChDH88nKBGS7nelrBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3HOldL
        8M8SMhSFP04OdXihjEBtTHltI1ljKcZAb+nkU=; b=rZ2vf5bZBWVwnMklpPl8Bd
        vO4YGW/TMVENltc1XyknpsxocwyldTOFsWluFkN561NHL9YUCn70oZY/alr6SrtN
        pFdiKHWfGtUxViftRrtmq1cYItYknbwWxhZSJFdi7eQFua0SoiXrqqojOGdGZC8t
        M1n5892MNX0XyVW8kSMh3R377sPxR5AKTw4w8rtkKcVQTdRpM+TSLJwPr6+nL8W3
        PXqmOuZCM7L8fJE23iupC5S9ABIxjvf7dTWts4ysvfeDgmzwYjB44iL+utgFkvwa
        lQYFim8If+13p8gU8JFuktA725TBysPhZkLeBgtdaKuOapyYs2TrP4+d55kbKKFQ
        ==
X-ME-Sender: <xms:jemqXkhoKUgqmlZFMxeK0cDa90kpmrp0xhAsS7J2naiy7HyM4OgTTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieehgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:jemqXkpnDXrjC4V69PI-XyVp3mJnYjhF-ntNPpfbLCqrGOu7a4mCKw>
    <xmx:jemqXjeFFLdSCxpHmpzKYVvqadSK37vzz52J1EUYSByc8KglZIAsow>
    <xmx:jemqXvwPR3RTFuBwdbZCpRNQfFY508PK6h6eWtbbnsUtt_lUSdCq0Q>
    <xmx:jumqXgB-mzVQpjHwawS_NrFP-SQU-PYGNf_1_-qDDRQoXNpWTFuyrBItnEo>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A3D23280069;
        Thu, 30 Apr 2020 11:06:53 -0400 (EDT)
Date:   Thu, 30 Apr 2020 17:06:52 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch, matthew.d.roper@intel.com,
        noralf@tronnes.org, kraxel@redhat.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RESEND 1/2] drm/client: Dual licence the header in GPL-2 and MIT
Message-ID: <20200430150652.7rhh7zn2lqhzy4bs@gilmour.lan>
References: <20200430145439.31257-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjombykybepmtpey"
Content-Disposition: inline
In-Reply-To: <20200430145439.31257-1-manu@FreeBSD.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjombykybepmtpey
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 04:54:38PM +0200, Emmanuel Vadot wrote:
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Daniel Vetter <daniel.vetter@ffwll.ch>
> Matt Roper <matthew.d.roper@intel.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Tr=F8nnes <noralf@tronnes.org>
> Thomas Zimmermann <tzimmermann@suse.de>
>=20
> Acked-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> Acked-by: Matt Roper <matthew.d.roper@intel.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--tjombykybepmtpey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqrpjAAKCRDj7w1vZxhR
xXGwAP9Ki8H1vsg5ATj+ZH/wRTiLKXRb3PQC/kGD5BF/AvIVIgD/XC7nOwVt3iuT
6ZFDx1vpZM6X92tW1fMSxk5/v/OIQQU=
=yUcS
-----END PGP SIGNATURE-----

--tjombykybepmtpey--
