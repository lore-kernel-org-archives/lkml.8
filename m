Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A60C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9D2208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582304139;
	bh=S/BpOi5B7fUj5UR+I6/VosoOE7/wYYHXw7HeqdF4ZJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F5aMP6s9fTX7pCFYVBwy+vYM8iItP3A7PmusmjyYW4do9m6t341FDAldNaObT8Kus
	 eSDur8YklHs0Kl/OQi4LMjxby3vp9V+fO8ga5EvxSP52EAaqL4wb2FgRCpTHlSYWPC
	 iAoyqTEDjdGMifpY/NMKnf3vcdlsedQzdP5jWs+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBUQzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:55:38 -0500
Received: from foss.arm.com ([217.140.110.172]:43652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUQzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:55:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B070830E;
        Fri, 21 Feb 2020 08:55:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 266203F68F;
        Fri, 21 Feb 2020 08:55:37 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:55:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        digetx@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
Subject: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
Message-ID: <20200221165535.GG5546@sirena.org.uk>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
 <20200221130005.GD5546@sirena.org.uk>
 <316ce0d5-318d-0533-ef06-bd7e8672f893@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <316ce0d5-318d-0533-ef06-bd7e8672f893@nvidia.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2020 at 02:31:05PM +0000, Jon Hunter wrote:
> On 21/02/2020 13:00, Mark Brown wrote:

> >> +	srate = params_rate(params);
> >> +	if (dmic->srate_override)
> >> +		srate = dmic->srate_override;

> > How does this work for userspace?  If we just ignore the sample rate we
> > were asked for I'd expect that the application would get upset.

> Tegra has a hardware sample rate converter (though driver not yet
> upstream or part of this initial series) and if using the sample-rate
> converter, then the actual rate captured by the DMIC interface could be
> different from the resulting sample-rate.

The ideal thing in a component model would be to represent those sample
rate convertors directly to usrspace so the routing and rewriting is
explicit.

> So we want a way to indicate to the DMIC it is capturing at rate X,
> while the resulting sample-rate is Y.

> I am not sure if there is a better way to do this? Ideally, the DMIC
> would query the rate from the upstream MUX it is connected to, but I am
> not sure if there is a way to do that. So right now it is a manual
> process and the user has to configure these which are not ideal.

Is there any *need* for these to be user configurable?  What's normally
happening at the minute is that either the external DAIs are fixed
configuration and the DSP just converts everything or there's no format
conversion done and things get passed through.

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5QC4YACgkQJNaLcl1U
h9BuAQf9FRu14PuOOZ+O9sauEIcPzDlfRncn0yonqpoiOL8kSVmvII1P6SzUxVjG
KFT1ryG8Jk6CHEYPsfj5meLFRtbk+gB/l/j4+UoVvLdEy6SGGuadmkktdEJucjRG
FOHdt2hfaLzIAZKebaESc7yfGhrQ+2B6W1+FW+SxxpZrN4J8FeugjB31LOhCaKZo
ZGxy4cHJYjQRWAPKz5fHsjOkHU7Es0ZpqZ+jKq3j/IGQtaNy/T+j+x2kQohcWN7f
Bt3DpnlXTOy+iKdk2+7kvWZdo7Cqwydu8IuzvE9cyJc6xsLecENvaOdcbAPwtwvy
AScUw0aer+7MukF/p0KS8880tO3ilw==
=lUQu
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
