Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE83BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B395320836
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591978925;
	bh=iJeNYjBay9kPP4A5LTAR5DZ94856kkb6aQkDg7EUEfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tIb9JKoeHNfMXkjMXUPd8OH8DsCI5z6JSPiafDvgYLWMu6ZWTMdgZyA15QsBa/4wX
	 7w+DxnEPkAJOmhcMn7MZ7iArrwyaY2zjrnPjlSBdWnNhLsNefo4o1qaLVSGT9BfZxY
	 WUwQw6MRpYXWusLIshzVUHtf34HqxFuwKeSvcc3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLQWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:22:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A7B207ED;
        Fri, 12 Jun 2020 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591978923;
        bh=iJeNYjBay9kPP4A5LTAR5DZ94856kkb6aQkDg7EUEfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sk3O96U4XvJlnvDc10zG5h0qO97oovjIMj5ZHNllLE+H5pV7ownE7rCmPGrVzmnZl
         bFstBMTBUq9TZO6SypcCDjb3Jm0BbD7umz+5aUPJefTS3FIXcFl9CGtRVjOCGisyj3
         r++pZU6refOpamxe+bNDxvg1lidFT1r/BWkzpUA8=
Date:   Fri, 12 Jun 2020 17:22:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: tas2562: Update shutdown GPIO property
Message-ID: <20200612162200.GM5396@sirena.org.uk>
References: <20200612160603.2456-1-dmurphy@ti.com>
 <20200612160603.2456-2-dmurphy@ti.com>
 <20200612160922.GL5396@sirena.org.uk>
 <0e482167-71c2-a128-b8b4-a054557d30e9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Content-Disposition: inline
In-Reply-To: <0e482167-71c2-a128-b8b4-a054557d30e9@ti.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 11:18:57AM -0500, Dan Murphy wrote:
> On 6/12/20 11:09 AM, Mark Brown wrote:
> > On Fri, Jun 12, 2020 at 11:06:03AM -0500, Dan Murphy wrote:

> > > -	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
> > > +	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
> > >   						      GPIOD_OUT_HIGH);

> > This also changes the name from shut-down to shutdown which will be
> > incompatible (IIRC we do try -gpio as well as -gpios).

> Yes the non-standardish name was highlighted by Rob[1].

Yes, but we released with it so it's an ABI now and we should still
support the old name.

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jq6gACgkQJNaLcl1U
h9BzxQf/QiA93xBEhd9/ppWpJGvrGk7h7PnHwz0Sfj31AjXhepYvMgj4suWMGwKA
Gi3rynuB3Qgx2+7DRRDKCGvTtplJCym0LG8RFDUpHn5vxd2MVAoM1EH9dmt9K38V
8I365oLxycOvMDytNH5fy2B9W2FBCtTBvixRmiTma1qz4LkkL5AyCZBmnQ00siy2
uY/JnhaAReVRgfsD+bTnENMhfNnWMxZr7eOxSW2kVZ6Fcwi7NqRL/Sq4JcCJ0oTR
uL7P8k0/FlL2b90dEMTsnkKgkIYA6WoyRWFhInHHAi6fvARLTCqRnvD6YA0d07H/
sWYx88BFU626JK4hLyFMJOCZA+d7gw==
=pT/J
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--
