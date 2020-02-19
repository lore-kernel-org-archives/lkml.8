Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1BFC34054
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689952067D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582129204;
	bh=qa0SngggUG9j6SbMXWmBqvIR3ZgD2NVPzIFlBs3AIjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AteVC4paM5zyPWGkJVnrr8kxukUiXB67/6ZOGPdvGVVAoD9rlBTJe8xwNgZ/rpPHv
	 S5TWEbPikY+u3rQFqlzw4P8OX2eefn6p/bSh9lyYFxhSnQ1JfrXAjxL6rcUZ+AdFRQ
	 MB4wIaZGAH9+ohWsnAW3fLlVxUs5U5eB9+RM21tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgBSQUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:20:03 -0500
Received: from foss.arm.com ([217.140.110.172]:52188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSQUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:20:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732EB1FB;
        Wed, 19 Feb 2020 08:20:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB43A3F703;
        Wed, 19 Feb 2020 08:20:01 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:20:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 2/2] ASoC: meson: add t9015 internal DAC driver
Message-ID: <20200219162000.GF4488@sirena.org.uk>
References: <20200219161625.1078051-1-jbrunet@baylibre.com>
 <20200219161625.1078051-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
In-Reply-To: <20200219161625.1078051-3-jbrunet@baylibre.com>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 05:16:25PM +0100, Jerome Brunet wrote:

> +	SOC_SINGLE("Playback Mute Switch", VOL_CTRL1, DAC_SOFT_MUTE, 1, 0),
> +	SOC_DOUBLE_TLV("Playback Volume", VOL_CTRL1, DACL_VC, DACR_VC,
> +		       0xff, 0, dac_vol_tlv),

Sorry, that should just be plain "Playback Switch" - this can be used by
applications to present a combined mute/volume control together with the
Volume control (though as in this case there's no per-channel control it
is possible some applications will struggle with that).

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5NYC8ACgkQJNaLcl1U
h9CDuQf/fGT0VVRm9yQYse0qUFwaPpa/Nb3byf+rdC0Bisg4EtnyYM2uHFn0C1Mg
PEDPJX9wIjjelZpQn6pNnQjo5jcZvbnoUK4ok+t+L2+wn0qS1u9sdZHqDO0/85tB
vLFJutTkhsVu/0Ky+ejH12I+uJqIcSrWHxLdWfhOpXYoqFe+C3Jzr8WlhijxnlaR
GW5b0bdf3lS4LDOYTDCHKnPXX6PiTf80RHHqoF5ZS/JyH5E1zob3FGPSzoo/8RIN
PG/sz5w9+YJvlPHomclX1ZyMG+pnw3AdOrvtlvfkjiui7OPe8u/Z7BEoSVbKSxEF
T2IfZRw1euojF6XagOVhMMpiBoShKg==
=DBLh
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
