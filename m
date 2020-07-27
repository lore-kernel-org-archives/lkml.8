Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1895FC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E119820775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595866200;
	bh=w72uQXMP5YHY08KIGqAqx53HT7rk/vkevwYe+3HCPz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F+WacfU0UnV2IW+SJSIMrqO2lD/ZWaWBD+ggbHEdbcGl9cckTRxsDPd/2iqw1Okz3
	 98HDJG0Mejrx+Jmd33f84qfQ6FlFcuryDwR0v/q+3uGkKvfU/vvRPISSrKX39fT9fa
	 sD8XdfYDvITxC7pgUgQqqm6SsqBDqIzrR+bhUR5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgG0QJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgG0QJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:09:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9322075A;
        Mon, 27 Jul 2020 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595866198;
        bh=w72uQXMP5YHY08KIGqAqx53HT7rk/vkevwYe+3HCPz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4Sucanw2Q6ekKNN4eVTk3rhHV7r7potA+wJqIcZMTxM0W1czFkkL48Ahjiu5agax
         G41HUN2vdItQkhfi2Si1Ju6gXOTwCVoyNZvW0ezCJnkO7maTJiEPG6Os/m4RYd/dFv
         yZWvqZAIURw993uSvhhqaRrwut4LtHEdjhd4sxl8=
Date:   Mon, 27 Jul 2020 17:09:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alexander.Deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
Message-ID: <20200727160941.GE6275@sirena.org.uk>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
 <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2020 at 10:31:24AM -0500, Pierre-Louis Bossart wrote:
> On 7/27/20 9:58 AM, Ravulapati Vishnu vardhan rao wrote:

> > changing SND_SOC_RT5682_I2C to SND_SOC_RT5682 because,
> > This flag which was previously set as SND_SOC_RT5682
> > used to build rt5682 codec driver but by changing into
> > SND_SOC_RT5682_I2C is preventing to build rt5682 codec
> > driver and machine driver fails to probe.So Reverting the changes.

> The split between I2C and SoundWire means you have to choose the I2C or SDW
> mode. Selecting the common part looks very strange.

Right, and I can't understand the commit message at all.  What's the
actual issue here and how could this fix it - in what situation wouldn't
you need one of the bus modules?

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8e/EQACgkQJNaLcl1U
h9CKXgf6AvYkL/VifAwuI6fufCCqohAgwDo9/Sn+16ySmm6jOodTnLwgOBpZdbe9
bVop3W0j0q+YF3H8fkqlaxWM29d/LRRRj8mjqZ8MfMwOIieCFsGcnsMtlQjx1a/w
l564OVBpTazkcHPBeQv/B3czqvKGqi69b4UEm0YkiNtzpY1VFakDkiBFp5Vk0wEE
OqUIzNxL4GyW5GGX7XMxIpDlYAd3XwLDUlzy2q/6nqbpINwTPRLx9iG/NHCCa8sD
Cdkev+6SsslKfKcni65VGqacIutXl5ynN1WDsFhLylWSl6YnD1HEti9t14j6YQP3
fwLkcF533X5G/OLy2KmhiWxvB14zkw==
=4bQQ
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
