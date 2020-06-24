Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107BDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EFB206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593011078;
	bh=sjyWN89n2WVn1nir58rJre28qTxK1Z7LKlW6WPjB498=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ajGDTGUYa59CC89MkNfCGJZoMryGHMIA2DNEWLIgaSyhLtqBKrjUxxjFx9EDlIEcK
	 hITb/61FretqQ8WCPEA7tBFc9o+4Yqe3bOmDLTUqc2wopXVUMUvQGYICVhtk1UOIyz
	 RmM62wrRDuP1iTq0k6ZYeVo6afnJ9h49dGg/cVPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404107AbgFXPEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403833AbgFXPEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:04:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F352C2070A;
        Wed, 24 Jun 2020 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593011076;
        bh=sjyWN89n2WVn1nir58rJre28qTxK1Z7LKlW6WPjB498=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuktBilcZV/yDm2z+dLzle3X5u04XthtuHlAreC1y/MG37F7osJCt8BQdho0fFtnr
         Zbqy05zYZlwITMtBKJjdgZIWp5dN5nafQF6fts3sxdifBfIuD3LxBGLbx0T8m0No9r
         Vs25zXTH+3WgSZPmxueQywLc30VHf7n177WG8R10=
Date:   Wed, 24 Jun 2020 16:04:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
Message-ID: <20200624150434.GH5472@sirena.org.uk>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-4-a.hajda@samsung.com>
 <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
 <CAHp75VfpP1cGK3FvTL0hBudRY2N_7GpXYRuUHUCipz7X2sMLmQ@mail.gmail.com>
 <be755825-b413-e5c1-7ea4-06506b20d1f0@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline
In-Reply-To: <be755825-b413-e5c1-7ea4-06506b20d1f0@arm.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 03:25:33PM +0100, Robin Murphy wrote:

> And yeah, anyone who pipes up suggesting that places where an ERR_PTR value
> could be passed to probe_err() could simply refactor IS_ERR() checks with
> more uses of the god-awful PTR_ERR_OR_ZERO() obfuscator gets a long stare of
> disapproval...

We could also have a probe_err_ptr() or something that took an ERR_PTR()
instead if there really were an issue with explicitly doing this.

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7za4EACgkQJNaLcl1U
h9ADKQf/bUGsVZLtJzgP2M/GIXNWTFrshhTPYFVHuKWmwRJL79fSW758BKdmbzdF
fYDZdgI3NMUnfpBaL7MmdmAlazwJ97Mci7lVIckChwBKZWo7QT/oe8RZlp+mGlbr
6kSNJDIQgTdBEtx1T6VYHhEnZgjn5KRgZHTp2SVd1SaJ6StGr2w29XvLABxfekXl
OLdDcSIHN0eUWZoLx/fjDrB3Wic9JzbEzj7rFZ6Zfr5py3VxUseRexpXikjW9YEa
VejUE8Z0brYa021cZqMymq0G++v+JeATDEzCsYMJ3VGsHgBfSVJrIHfxtx9dJHv+
dHEFhwK7rmIkGPziGlBbph8Bncxuhg==
=wsw7
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
