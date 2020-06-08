Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93180C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6152076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591616454;
	bh=x4taCFMl1JSd2Q5eNsTgPag9K1UCnAlZgI2Ug8F0LTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W6McnjdZ91GPESxZh5N+eqZabLMWX3umiLHsGxhRUhCITvoAPvJomVTsS4NUUVJyO
	 jMtYmy4PWJJ8JbJ8a46Imu6dgrG0EH5aZByQt4LHwCPEEiosWsom7gtXoCXWhorxg7
	 zK6uAi/E5/ITWjyWi5VWSkT0Wrc6lAprBNwDwm/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgFHLkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgFHLkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:40:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A152074B;
        Mon,  8 Jun 2020 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591616452;
        bh=x4taCFMl1JSd2Q5eNsTgPag9K1UCnAlZgI2Ug8F0LTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIRuyu7HoF2N+aUEjIce4hAevgRqJwI+BsLOC3XtBOVLmgs9MWQKZAT5QGmDr5GKf
         fu7pg5IOce3RteJB6v7iXvzw0IRjCT8RWz4XrueqXh2wC5nzznCETcsHW8GeosgrBS
         MxsLKGoQ6TbwarH19XC95Pu9353pbL+po/cfNqx0=
Date:   Mon, 8 Jun 2020 12:40:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jbrunet@baylibre.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, khilman@baylibre.com, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] soc/meson: add missing free_irq() in error path
Message-ID: <20200608114050.GD4593@sirena.org.uk>
References: <20200606153103.GA17905@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <20200606153103.GA17905@amd>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 06, 2020 at 05:31:03PM +0200, Pavel Machek wrote:
> free_irq() is missing in case of error, fix that.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7eI8EACgkQJNaLcl1U
h9D2oAf+L+75A6sm74wpOyUZsv7DPH8rJApbMWamWaaL7Zq0ZrwKsFecGUq4jP37
FvyBa8xpKWuEbPQuvtG8XwFUMjy/VBn0FgKhjbetB7+sUrQg+erx4XzY81Nq5VcG
Ov+61cWUPIKpY8Ysnj+xH1W+b5nY5EOsBfFvjNNsE3g1JadihgZrcAGdOBK3cy/7
aS/RStZcQedRmxpIIQvKhwr4j0Am1X8D2lPjFqs7hVl+g9I3t1bvKYdW/Y679FBz
HgwoXfEOkrODZtQsuMLGAqYRbyGjYKzAesmp892xPWqM07MchsB5JaMl4I81bwkO
WndnmsoTH4bOw+HPhgwcIRVT/FOqtQ==
=yNKv
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
