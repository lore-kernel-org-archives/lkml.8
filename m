Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82070C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E8B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591728461;
	bh=uCUPSy3LHC5NpBWjYwABGrcETfQmegBMc7n+u3jXo5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDu7JVYs8nnxlzD4dFsNnxFbnux0M5AntkToVrrAnyuh2tiCx4jrlkg78ehDxInCw
	 t0VpHBDEINiUJf3zZZ8PbbSIhwR2rI+CsdeMn7I008oXJ9jlcqxzkPVu/9+WE7/Rfe
	 aBK1hpWj+JHgMdzJI/3I/fxiu4lMzfBVY+5dzDJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbgFISrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgFISrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:47:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76DB520737;
        Tue,  9 Jun 2020 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591728457;
        bh=uCUPSy3LHC5NpBWjYwABGrcETfQmegBMc7n+u3jXo5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjqZkmD59drnpt66B3AiMrUEFDamsUUadN8nTRe2dZuviEldMp/gylnJXMc0evNq3
         VsShA3bQiprNZIaobB1SPaT9wDmYV1nablAHV9pbAYXicU9ovABBDwqYj9CrWU17Dq
         lGxdoq7nSDB4TdNGoCCsTHMrRHN14lhpwLfSIInY=
Date:   Tue, 9 Jun 2020 19:47:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200609184734.GS4583@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com>
 <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pa4xkLBhPDIhDLv1"
Content-Disposition: inline
In-Reply-To: <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pa4xkLBhPDIhDLv1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 01:06:50PM -0500, Dan Murphy wrote:

> I could make a default as you suggested to include i2c address and bus in
> the name.=A0 But the TAS2563 does not need the firmware to operate and the
> 2562 does not have a DSP.

That's fine, the driver can just use the compatible string to check this
and not offer any of the DSP related stuff (it should do this regardless
of the method used here).  I'm guessing the regmap configs should also
be different.

> What if there was an ALSA control instead that passed in the firmware name
> from the user space instead of using the DT?

> Then the control can load and parse the firmware and wait for the user to
> select the program.

> This would solve a user from having ot update the DT to use a firmware.

That's really not very idiomatic for how Linux does stuff and seems to
pretty much guarantee issues with hotplugging controls and ordering -
you'd need special userspace to start up even if it was just a really
simple DSP config doing only speaker correction or something.  I'm not
sure what the advantage would be - what problem is this solving over
static names?

--Pa4xkLBhPDIhDLv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7f2UUACgkQJNaLcl1U
h9B2rwf/YFbqDdxSX14Y6RPwmFML2pjKw2MuRY9938rKnwgtQ37Os922ucZ6N6uq
+WvyT864PZsYY8N01/dkmmPd8B+8lV/85PlWg+K+O9BNDLtLY5jnHE4a9xMdaYyB
zyKzaKlKti2ZpEAJ6fgQY3ja05YEBGKSPtL0PORFHmSKgaQie91AFWRPbbv7Prqb
FSB4J45Z7rUQ9OTz6qLlxixQbjMjXTx/zXUl9AptuKUvCO3ei2VP9Kx7M1vN7EFn
ava9TCr/Zex1DfGtLGR2xj48m3UYHcp+r2STuTW3L185w09c9oU3pduzQcF+qd7+
wngrO/PscDnJ+YLElOOVyQJOcZhFEQ==
=/Hdd
-----END PGP SIGNATURE-----

--Pa4xkLBhPDIhDLv1--
