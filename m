Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB77C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69832072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582544650;
	bh=KmxduwQKZjZKSqFWNovrd741QLsrLPnBuv2/ssSA9Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vvucNE0eyEih0CwVnSsmcXVOT0pWAqCDPBrgrvjrMWI8CfhGeCYYenl4+8qyNw7Au
	 GDkXW1uMY5hz/H2dZ295bf5cxK0y50Lljx5mzRhXeTxuKHXUOVeEYztdwkMuflHx/C
	 +S/EjBmNykfZ12Gz61h0ysyw/O5bQxQKaSn0JGq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBXLoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:44:09 -0500
Received: from foss.arm.com ([217.140.110.172]:35786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgBXLoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:44:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9580A30E;
        Mon, 24 Feb 2020 03:44:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92EF3F703;
        Mon, 24 Feb 2020 03:44:07 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:44:06 +0000
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
Message-ID: <20200224114406.GB6215@sirena.org.uk>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
 <20200221130005.GD5546@sirena.org.uk>
 <316ce0d5-318d-0533-ef06-bd7e8672f893@nvidia.com>
 <20200221165535.GG5546@sirena.org.uk>
 <47f94534-e997-d56c-5793-ae832fb2add4@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <47f94534-e997-d56c-5793-ae832fb2add4@nvidia.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2020 at 11:28:57AM +0000, Jon Hunter wrote:
> On 21/02/2020 16:55, Mark Brown wrote:

> > The ideal thing in a component model would be to represent those sample
> > rate convertors directly to usrspace so the routing and rewriting is
> > explicit.

> I assume that it would be OK for the sample rate converter itself to
> expose mixer controls to configure its input and output rates so the
> user could configure as needed?

I don't think so, I'd not expect the individual drivers to be doing
anything user visible here - if we know what a digital transformation
looks like the framework should be offering anything that's needed to
users (and hiding controls that don't have any practical control in a
given system).

> > Is there any *need* for these to be user configurable?  What's normally
> > happening at the minute is that either the external DAIs are fixed
> > configuration and the DSP just converts everything or there's no format
> > conversion done and things get passed through.

> I can see that in most cases there are a finite set of configurations
> that the end user may use. However, we would like to make the
> configuration flexible as possible and this also allow us to test lots
> of different configurations for verification purposes as well.

Internal testing often requires things that can't be exposed to users,
the extreme examples are things like battery chargers with health and
safety issues if the full range of control is available.

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5TtwUACgkQJNaLcl1U
h9Crqgf/ZrHdav/H3sg+ks8XPns3tfhmaN7zdKxLkEl7rclyGrxXkz0hGGNflA0b
ZmCq+byMf1McM1Ay4GqHsIP6kYxwqqZzKPpoV1tOZRHrH85RoI3qrofsZAuEYGMP
KZ36BR55I1oIZXa6NxuOM/Fdrg4hcNanuK43zaXWS9mM3UweiIlXCmvBiWZR4koK
dArroM9BXo7ZXuWWVbhmAfnu6Mi/ZUk3uGauKjlP1Odo7N9B4aRvhV686h3Baaq1
zeLawuT/y9N6G623+AkUKTuuEUfLfk/fhE16y2SsrCxgxrRvBqKDNZLjO9YkiiD9
vcfUOJKsjpBy/LOF4JV2iwHc5xC+wA==
=rFOB
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
