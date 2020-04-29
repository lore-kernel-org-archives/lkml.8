Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15774C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20942137B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588165124;
	bh=li6Xj3PSlgcABYGV0eO2IHr8jMH0aES6+8vgJv4vSkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MUWdBxbqlmv37eauNwVsGxaEDARZYtc5O2+rmxkXMnDBtUlMfbWu4pK9vYXtcWJp+
	 Z89RSfFbrpHi9dmO2Tdt5ivdQghJO8gdQ8YDg8PJPVsK+gaEpNu8twQuP4WTsRSyJN
	 YUrFbIujy3p+dxQ06CCJGEpoRR3x64pj92J/3djg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgD2M6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgD2M6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:58:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BECFE208FE;
        Wed, 29 Apr 2020 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588165123;
        bh=li6Xj3PSlgcABYGV0eO2IHr8jMH0aES6+8vgJv4vSkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKeaL7cuw9y28v4bTwmHN6XU7HARFAAxv4aps3Yd06f8jH0/Y+RsPKEBJCJBMjhpX
         VRkS2NDskyNYR6JPa/7nlbQSFeslZelyy7YN8eFeF4pQ7oZ1GRxuNzeGSfqmRz41hY
         rV2l4ace0KSWvUGU3dxPnu7Z8/Nc6BW7vgTVST4I=
Date:   Wed, 29 Apr 2020 13:58:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        sound-open-firmware@alsa-project.org,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
Message-ID: <20200429125840.GK4201@sirena.org.uk>
References: <20200428212752.2901778-1-arnd@arndb.de>
 <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
 <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
 <f91c9a68-7641-beb8-a23e-bd1b9b8d0acb@linux.intel.com>
 <b784c008-7094-05cb-6200-6b246ff39bb8@linux.intel.com>
 <CAK8P3a3vri_-tdEy3x6tRGUjb_k-+Mc+Jt9bQpgFvqm2RN+cJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3vri_-tdEy3x6tRGUjb_k-+Mc+Jt9bQpgFvqm2RN+cJA@mail.gmail.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2020 at 10:24:45AM +0200, Arnd Bergmann wrote:

> I looked at the bigger picture again and found that the more fundamental
> problem is the dependency reversal in sound/soc/sof/sof-of-dev.c, where
> you have common code that knows about and links against a hardware
> specific driver. This is something we try hard do avoid in general in the
> kernel, as it causes all kinds of problems:

This is a legacy of this being factored out of the x86 code, since ACPI
is not really fit for purpose when used to describe at least the audio
hardware on modern laptops essentially all the enumeration is quirk
based.  It really needs cleaning up for the non-x86 SOF users.

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pef8ACgkQJNaLcl1U
h9DFqgf7Bk+odcTlRMvglULBd8JVvvVNug3HsTUJZY0nAIJ8yvEYcing+rV9QnY6
WwoxEdaADURcX9ZNcW/nwguxgd87xkc2rLeasBXq5aJTtTQlfRkym+rc6ws53+7v
BD6eD5RXHgYz8tTAiPKQZg1pS2mgneX0Akpg5Txl7UGKaffA32meh9iz3f6JvGPe
OUg6IYwkMHEz/2x8Wd46205Ygp0R96/FuUMo3Io6TgJOX9L9lf/2flb+B3yyeHpG
lPtFxgiPutWxduMDbxiAHJL1xgzL1GQScnfQWOgho9egVaaYrW1q7VGRNrBLwHr1
uhwjh/jEoitjH3YvQCM4wI4gOvLmyw==
=qi/x
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
