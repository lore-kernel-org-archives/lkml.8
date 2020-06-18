Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A876C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593DD2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592478102;
	bh=uojSHgSubx3hK7KyZszmKecAZ2fxoo+s+cuvPCxsTh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iE1xLoYEJCG+hkUTmTFv+I8xqJRh9R7brL+lB1iJ7BIKz2S0iAhKop9Bi8L0KSf4H
	 0wTnLVb6pCCBU/k/LJDmoD3+RW0sl3XQUV/lp5tT9G7pCg8QDBDqcINbxvejm7ivnu
	 w/R16FXgXDAtr0I2OF1ngBtqCio4vWSCXecvkQX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgFRLBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbgFRLB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:01:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E1320885;
        Thu, 18 Jun 2020 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592478089;
        bh=uojSHgSubx3hK7KyZszmKecAZ2fxoo+s+cuvPCxsTh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xiT+CFT6qnWMSDWTrRxP5zxZwz+qHwawf9Z68AqKEb8vyy6mpLDoIONXlZP2WZ+d0
         0B92++CGCGimj0kBymBR2T5rHzkHJRTHZL+vpt6r2/0fnawrXeR//2Of43fk6WBmzX
         h9bOluaq26GXblSodft7tB5zFP40jK4xuUdpXS84=
Date:   Thu, 18 Jun 2020 12:01:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.7 055/388] ASoC: SOF: Do nothing when DSP PM
 callbacks are not set
Message-ID: <20200618110126.GC5789@sirena.org.uk>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-55-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20200618010805.600873-55-sashal@kernel.org>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 09:02:32PM -0400, Sasha Levin wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> [ Upstream commit c26fde3b15ed41f5f452f1da727795f787833287 ]
>=20
> This provides a better separation between runtime and PM sleep
> callbacks.
>=20
> Only do nothing if given runtime flag is set and calback is not set.
>=20
> With the current implementation, if PM sleep callback is set but runtime
> callback is not set then at runtime resume we reload the firmware even
> if we do not support runtime resume callback.

This doesn't look like a bugfix, just an optimization?

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rSYYACgkQJNaLcl1U
h9As0Af7BPVT1E+OmFZJ2fmGTIygx1ScRtYWAs0iknMEs/lkyrWtWtGAKCMxp3F+
yTbJiBrGj6KGCZvc02UISISUaxtSbHNPNMcjeGeBwM8li9rAjXMJMQcDmxjPB4nV
F+EeRtpZZ5uMhIQk5B3wU4/EgBU7nrCNJUwTMsuwoVWaTRdFPSFLt5EBCxWW8X88
sGadYKYd9aJzuRDce3mbLz88dlEb7OXG9we18xnl9Zy+umNwgRyGzdLTvXisbdGb
rADcI2b33lFMRkHH/ymVLXlvoQ1nISmwpkhxBU0pJspOpIIZ5gjuezx7aViPcTkw
Src3w3xN5i64dl5LQI1ssMAIZe2/LA==
=HpMZ
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
