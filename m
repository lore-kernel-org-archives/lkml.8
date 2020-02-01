Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A72C3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 12:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4089B20679
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580644845;
	bh=NJ8KQgSJTEBJ1TtD9Rr3dpMRZkr/JGA2pg9DegILm6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HiiepY/kwjjDhwk3axy6M03mA0KaYZg/WTfT2HRrUvQ5XuOQSoz0Gg8gyus2ZWkdF
	 HL66zU2AdolJ93aQ/cZ2afeuc8L/7xg/5pASXJW1rdNugxq42EuvHJYBW9hh+WiKB9
	 WNsVplXj2S0yidQ5tWS4wcChUqy1fEdWrivT3OV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBBMAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 07:00:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56910 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBBMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 07:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lPzWLn9eAfmZaZgtVXbLGbwWmlBqlL7DYMSG6vEQjls=; b=j2L+e5NWwaUMC1fJqOVZJeRG8
        XVGp3fN6jeeunuFTJSB9WS2gzfhB8Gbv+c0gkve1Wt1jr0168A+4s48YFgWBwaMBsau1tHQ0vJr7b
        ekSgPubB5dwhee3telxcBpJwTaufw8PLUnWclHshCCBDYId+if/b4myzi4nBTvVNdjs6Q=;
Received: from [151.216.144.116] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iyDvT-0006pl-Dn; Sun, 02 Feb 2020 12:00:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A94DED00AD7; Sat,  1 Feb 2020 11:03:58 +0000 (GMT)
Date:   Sat, 1 Feb 2020 11:03:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 11/17] ASoC: cros_ec_codec: Use cros_ec_send_cmd_msg()
Message-ID: <20200201110358.GR3897@sirena.org.uk>
References: <20200130203106.201894-1-pmalani@chromium.org>
 <20200130203106.201894-12-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYQNNDjzvANyiJW1"
Content-Disposition: inline
In-Reply-To: <20200130203106.201894-12-pmalani@chromium.org>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYQNNDjzvANyiJW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2020 at 12:30:56PM -0800, Prashant Malani wrote:
> Replace send_ec_host_command() with cros_ec_send_cmd_msg() which does
> the same thing, but is defined in a common location in platform/chrome
> and exposed for other modules to use. This allows us to remove
> send_ec_host_command() entirely.

I only have this patch, I've nothing else from the series or a
cover letter.  What's the story with dependencies and so on?

--mYQNNDjzvANyiJW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl41WxkACgkQJNaLcl1U
h9CH4gf/QSLdGaGwrm8clz1CuyNmPEKvX4LsDa9tkoPrV22OkRCgy31n3b+n4x3S
9KJtgvF1lFaFdo9Wprt0h8mTSBHlChsmiC8pe0n6qFOS6v7VcjRmY0boiO6W9nz2
lO9C1ZI5tlRXX8ipBnJiugQDn/7zanjYSm1O1wZyxJt1dWuY/KqTDIbZput0vmAS
Gbeq/152zVWRCjjLMteZ+2O2GYiasRvriSsEu9rnQzO1+6pbpF897W8EgHhtA3kn
h92YKhAv1UYVkWhV6JBjhv9yfmaMymr1UQ6x6yVsr4Ioppx7i8+a7wSY8AT80ra2
pdXC0uvO4dIp8fE01StcLOYZQ/lZAQ==
=kCyu
-----END PGP SIGNATURE-----

--mYQNNDjzvANyiJW1--
