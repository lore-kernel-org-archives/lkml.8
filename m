Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D98C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8C120828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582550311;
	bh=lv1M7Ii9Kt5bXH1YXOoOMU/lPivMJ76BP24o9zQYoQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yXJoNYb0wIBvgj6XQDQganx8eXDQGwkK/FORRZJZGxRdNkeDG6pK29bsjuZ3DQPW9
	 H5C0DawQijLIjltHPd+Q/KXblKnuNXLBeND7vnJX8dWXplEd96pbiLP/riMlIEDDyK
	 6JRlu2Z8yUEsycHhYoCLPreECPgCIc87vDLyQ3fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBXNSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:18:30 -0500
Received: from foss.arm.com ([217.140.110.172]:36960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgBXNS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:18:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C53E730E;
        Mon, 24 Feb 2020 05:18:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49DE93F534;
        Mon, 24 Feb 2020 05:18:28 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:18:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        digetx@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
Subject: Re: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
Message-ID: <20200224131826.GI6215@sirena.org.uk>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
 <20200221130005.GD5546@sirena.org.uk>
 <316ce0d5-318d-0533-ef06-bd7e8672f893@nvidia.com>
 <20200221165535.GG5546@sirena.org.uk>
 <47f94534-e997-d56c-5793-ae832fb2add4@nvidia.com>
 <20200224114406.GB6215@sirena.org.uk>
 <f70c7c12-dbc0-a725-f06a-86fab868e7dc@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <f70c7c12-dbc0-a725-f06a-86fab868e7dc@nvidia.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2020 at 05:59:33PM +0530, Sameer Pujar wrote:
> On 2/24/2020 5:14 PM, Mark Brown wrote:

> > I don't think so, I'd not expect the individual drivers to be doing
> > anything user visible here - if we know what a digital transformation
> > looks like the framework should be offering anything that's needed to
> > users (and hiding controls that don't have any practical control in a
> > given system).

> Are you suggesting to have some alternate way of users configuring sample
> rates (and other params) and not use mixer control method?

I'm mainly saying the driver shouldn't be doing it directly, it should
be doing something much closer to hwparams for digital formats.

> This is a typical use case we see,
> - [stream-1] Lets say high resolution audio is playing (96kHz, 24-bit,
> stereo)
> - [stream-2] Randomly system notifications of small durations come (48kHz,
> 16-bit, stereo)
> The requirement is, both streams should be mixed and played.

Most systems like this would run the output at a fixed sample rate here
so there'd be no runtime configuration.

> Is there a better way for user to configure custom audio paths?

Fit what you're doing into DPCM.  It's not particularly great but it's
what we have at the minute.

This isn't me not understanding your use case, this is me saying that
it would be better to either work like other existing drivers or improve
the framework so that it works better for everyone.

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5TzSEACgkQJNaLcl1U
h9BAhwf/QhpoDg6KiehDe7VRnOhtmPEXAczk9wdg+IxjQr0QRsmC+kn/PQ9O+TJG
puwkmjpN5PJmU+kUECaCiZO5midMxKemgI4ITEHhtBGmuOhaRv/Fq4HwHJoYPvNu
QCgOqLmAA/A7GSMZFPKterSWZ37254QlSiiBo77wWvzBgsByJ/JaBEyvWOPHQfaJ
S+TsoKJV2hh73j8GfBxMJPzoDxoetly2+sUhudtNG7fPAlKyoX7rkRYn/JBmlFxf
Zz3VF3oq+6zyraU3o7z/Ki76E5MXclTItaA0qQ0sYKJmVdbN4VMAwmzsqBhVe1e9
fGzmk+Ai8I9CHO4TczYKw5D5YYxs8A==
=ZFLp
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
