Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B4C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C827420727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583773162;
	bh=67DkKdAVgEUj3KBjcJhQLPmd4hXFcYtY7iLdRbCse/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gIHKZ2AhUJ7OW2L310rqcXkI6eUrHgiEV2Rn3IP0dBWJwoVE7L+TgT9hL+2md1GWY
	 cRwIAmi5dIxKtwKqzwkBe6GYdDexlHkZxteEYKKWVZOHcLVY9g0ePGwhiOqUBGpkMR
	 qrr4E1sQ7yq6FMSxJMm76F0xnA8G5F8KM/HDRXn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgCIQ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:59:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgCIQ7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:59:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E48A41FB;
        Mon,  9 Mar 2020 09:59:20 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68E9A3F534;
        Mon,  9 Mar 2020 09:59:20 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:59:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jbrunet@baylibre.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/meson: fix irq leak in error path
Message-ID: <20200309165918.GI4101@sirena.org.uk>
References: <20200309162912.GA21498@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline
In-Reply-To: <20200309162912.GA21498@amd>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 05:29:12PM +0100, Pavel Machek wrote:
> Irq seems to be leaked in error path. Fix that.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mdeYACgkQJNaLcl1U
h9CCoAf/Tg1V9NN7lBma6RAUr7lr0CLFWaDKyjqFXtwx7isnFIrUOkc4mXutsnch
oDQPhuU/xFmiASiebvnpQfRl0OV/76zo9EE05eoDSJ2cxlZvoi21bPBQzJGmPpMW
AYKwHtxF74xlqW93UdNk+ldRhSAkYg8piOt4vhKDEacLZXFhfWzbewCtsWkg5sER
+6cIAlYelohDbZCjKgxvyO1xCKNx2XM5LBhSZ3YZNABVR6Ft9hPPySv+8/qBDj4u
bhbO5FaCY23DGdsylPzCHvg3IabQCWuc1GVSRGLrJcPWcaw9FD2uoMWfA3C4+eHw
V1NnOlUZCmbhbesMUHZg1nVEtO+gdg==
=71Fr
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
