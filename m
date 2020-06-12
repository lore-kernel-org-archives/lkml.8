Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ABFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27F720792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591964391;
	bh=hjOioRpR6CzVQO9Kmkf/Bb3rlRZehEC7qNK26rm7UNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eNzpe6+Y+PuhR1FCsBCfzkYZiBv6v8TxpjRqqt51o99NjUDBQzgpAwP3uBlWzkvxc
	 2/UGmuYZtrMeFI+2xJ6Svzi1SpWQbQHIkGv/KvD518lzwPXvXFFHCl8i1yEyktBCa0
	 cehXzIJmH4p1Yz7J9ne1PVzMqm0qJ/k685LeWrwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFLMTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLMTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:19:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB2120792;
        Fri, 12 Jun 2020 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591964389;
        bh=hjOioRpR6CzVQO9Kmkf/Bb3rlRZehEC7qNK26rm7UNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/v6cGd3Po7NV3PRFbyEwPAxVgGfTOYCjCsfR/y0kBi5oXXOueThfnQ8KLR4dQI/d
         TqlcWiTe8u0SrGDHF3wyxXXSm/nb7PSEpm0mW0syPQjQkpTVbmHvYtO3KmmgoJ3qW7
         W2XKp7oec8P8u3lILD/it8JIDlVY8g3mP/S96htA=
Date:   Fri, 12 Jun 2020 13:19:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
Message-ID: <20200612121946.GE5396@sirena.org.uk>
References: <s5himfxet1c.wl-tiwai@suse.de>
 <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
 <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2020 at 05:49:29PM -0700, John Stultz wrote:
> On Thu, Jun 11, 2020 at 5:13 PM John Stultz <john.stultz@linaro.org> wrote:

> >  I've bisected it down to the following commit from this pull req:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b73287f0b0745961b14e5ebcce92cc8ed24d4d52

For the benefit of readers that's "ASoC: soc-pcm: dpcm: fix
playback/capture checks".

> I don't know the backgroun again, but would something like the
> following make sense?
> https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=7e49b248db77b5ed29b2aa278268e77650c75482

That's a small out of tree test patch which has no changelog so I'm not
entirely clear what the intent or motivation is but it looks like the
goal is to change so that we only warn when a link says it supports
playback/capture but some of the DAIs lack the capability instead of
returning an error.  I'm not sure I understand how that helps, it seems
like the link is still misconfigured and we still have a warning which
isn't great?  Surely the issue is that we've flagged the link as
supporting capture when it doesn't?

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jcuEACgkQJNaLcl1U
h9Dnlgf/Q68XJY4KaYf5rX5hsaz4U8bTYcgf4nSuD9lE5C/6bPj1v+Q2f2Pl0TUS
eLZvAg4IeZWEgCCsR1ZWRygEPFvomQdIeCCJ37sy2Fjkvylpc0LvVV2huTrfIIOa
tsgMcyUvZXM4RLPE9aS2ha56l8uDerBxVG+60+OQcucn+Hua41+XLbO4BiBGK+pV
PD9vfH972bgqNIo6eCy0BXPZx8aAk570337TzrhKdaocPA/TSTRUOCIBLywbmk96
6wlz05cl7vEws1SIdRZOszz8iDwyYTyrXjY+37fV6YVVDXIJIrFCHhQVv4rciFaw
S+LndH3mCU4JxQQxLFyJfVj/Rwe7Kw==
=w0MH
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
