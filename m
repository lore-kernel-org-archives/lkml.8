Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD08C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1ACE20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593005245;
	bh=Uvzn5GGmX3qulKFklqhuFpDaBfwgpNZzFNj7oeuicfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YBrw+3OTUmxmIH255yKwF/Nh+e3V5fgMg5YcbXjEBxwmysTWkbJeHE4enYYbKdhnq
	 xvjzIY+4X0YXJL+d7e6v6raW7hMYqV0SzldeYojUU7NC/JW6eXUvIpSf+yhCuDdCw0
	 IIeJ0Dp/C4qRapx2Bqb7MwVxF+pfNCrDfD5oKuxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbgFXN1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388365AbgFXN1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:27:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BE620738;
        Wed, 24 Jun 2020 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593005236;
        bh=Uvzn5GGmX3qulKFklqhuFpDaBfwgpNZzFNj7oeuicfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfCE+6p7BklpNaLNzQGhFErdJ9GEeuS7AoSebSPlnZJF5jsAgVtdGk7vUEwnjQGgM
         Fn2nQQELoj20anBdPArhIYnmlCcO2McCZEr2SrlB22cC8+EVhVWDkjq3ApDnPNuzAW
         6nsZgily1LPUOeIOBI2Li9olPjFfkoKLlrTYAVm0=
Date:   Wed, 24 Jun 2020 14:27:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
Message-ID: <20200624132714.GD5472@sirena.org.uk>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
 <20200624114127.3016-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20200624114127.3016-2-a.hajda@samsung.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 01:41:23PM +0200, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This

As I said down the thread that's not a great pattern since it means that
probe deferral errors never get displayed and users have a hard time
figuring out why their driver isn't instantiating.

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zVLEACgkQJNaLcl1U
h9ATPwgAhY22sy/BHlt091VyG8FAdVlhbYN6mk0lzhvHH7Vi9lhuFnpv4CoWIPp9
H3U6sE0bCKLDG8crEhrVfxSMYy8XdDafn37Ua0NYY/gKj3xKfLvZ6SgYAxKN9ljb
Fsr2TgqJzAlbV3h5wI9HX8GOzK3YU6qD0lv8QzWu4UU0zkgXD1ty2jIwAa/zv4F0
BvCMvOshZd7pXBg0unqxP0vm3dbOUbC3dup88YjidkmYYYQl8IHbPlrwtDlhVrk3
Eq3t9t69041O+cB6Rg6QIvKAumr/d5BmCqbajAXowB67NKvxxqzOhCIntTqKEiVw
U7DHVCCkPY49rXIH1tKz1ahQhgdu5w==
=XUqJ
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
