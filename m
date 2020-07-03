Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50034C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BA221548
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593790362;
	bh=E5WBMBWpc0DU8roMGj9Z8eOIghgWwVOfWI+Jkv8oYHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s6rElS2/rLvU3Qu7isQZQUJS+P6gPPpaLLdHg3/UhC0uvZHsTI8MySV87HQNVmfrA
	 GEbD3K1gW95Akely9E2KMt9BWtBMe/8VL8bA0ZNa3EI8bMFZEHllWXoJ+J2GpbwtYs
	 Dq0vrOiKNTNLVqtp4GjGHB2k0G4BhszYKCrB+vSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGCPcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCPck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:32:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D6F208C7;
        Fri,  3 Jul 2020 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593790360;
        bh=E5WBMBWpc0DU8roMGj9Z8eOIghgWwVOfWI+Jkv8oYHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NbF7K+rP+Lo7TK7VAT8lb6KkN5ajc8sINPfixyJa21OL3wnZEL5eag5gC7uqJkddx
         ZAyrCNVXLTqcjI9X9xFQbNqTSFQjvyc+xZnxCOrhwQ45IAzfPMuwXTARz0dgB4jAq4
         nVsqvwd2vB3bG/qxclE1tWY187qwflM5vN2SNO0M=
Date:   Fri, 3 Jul 2020 16:32:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alsa-devel@alsa-project.org, Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] ASoC: core: Remove only the registered component in devm
 functions
Message-ID: <20200703153237.GA16747@sirena.org.uk>
References: <20200703074935.884736-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20200703074935.884736-1-maxime@cerno.tech>
X-Cookie: Without fools there would be no wisdom.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2020 at 09:49:35AM +0200, Maxime Ripard wrote:
> The ASoC devm_ functions that register a component
> (devm_snd_soc_register_component and devm_snd_dmaengine_pcm_register) will
> clean their component by running snd_soc_unregister_component.

This doesn't apply against current code, please check and resend.  Looks
like a genuine issue and sensible fix :/

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7/T5UACgkQJNaLcl1U
h9CblQf8Cyrz/i6w3dI9uFuMBRAn8YEfVAoLAnWIIdNku8olQBF8OVzq8h6luaBy
EqFNggt9cdVR146AImJEXdxJZgwig1sC9li1fMtSSiNKW35/5+IZsH28Pi+/7BTJ
Y2mJbLi0s7gpd1XsNj7UsGuR/JELG+bpVPhf4vy+LcCbjJsFYniybNlzElYR/uux
5YTbnzPGgXK3uMUHRnA5c2ehu+af7V/TgVnrtlbyQAA/8d0IPAyXQ1nYzX8NRslV
4i2lF859MNZROH8t5J6eApiecWQprbXADzzvXqO63G4Cc0Qj6/b2wEj/p2W9chwe
mULcSb4O9IOPOEcQpU1fs12HfHYD0A==
=5nPY
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
