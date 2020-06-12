Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2992083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591977986;
	bh=UjJtFUryNP2TfJoK7XZIrmSz3ZmZvBDsoJb0rLk8EY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g+gzIQ7utXhFpnW9RLpDODTAH4VTkPLKgf+pTKn3bkHUcEsTg3z32yvQkyeS1yoLZ
	 KBPGxOqIziXYyHLNRCIFuIb4AyU2qo4kWbjUltaAUWs2O2n+u3ZfCn8sz9GfuOnNAo
	 3St3f/GQJ+IhiQ+/drTf3Y4qSDIw6nsCMR1aMsmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:06:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30BB20801;
        Fri, 12 Jun 2020 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591977983;
        bh=UjJtFUryNP2TfJoK7XZIrmSz3ZmZvBDsoJb0rLk8EY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COsDhrpNjPhRjQp1IP+GA2CNQOwVT+YkNkJkEbucvFLBWbEd+umPkJdCtPmg4IXIx
         L6MTrc18FKrFHBlDN2melT7JEU8KOAKjBDTlAD3oOJOMBgq+SJmQVfliExmxaYNMY4
         AFco7TTy/ZJDevo0PuVugBZirC6QlZ/UOdnuHDyE=
Date:   Fri, 12 Jun 2020 17:06:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200612160620.GK5396@sirena.org.uk>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
 <20200610182322.GC21465@gmail.com>
 <20200611082616.GA4671@sirena.org.uk>
 <20200612153722.GB26807@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <20200612153722.GB26807@gmail.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 09:07:24PM +0530, Vaibhav Agarwal wrote:
> On Thu, Jun 11, 2020 at 09:26:16AM +0100, Mark Brown wrote:

> > > Kindly suggest me the preferred way to follow on this thread.=20

> > This is effectively out of tree code, until someone submits it properly
> > I'm not sure it's useful to submit incremental patches upstream.

> Thanks for the suggestion Mark. I'll create a separate patchset aligned=
=20
> to the ASoC tree in next ~2 weeks and share them separately.

Great.  If there's controversial/complicated design bits to sort out it
would probably be good to split them out so the simple stuff can go
through more easily.

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jp/sACgkQJNaLcl1U
h9BjNwf/TxHtNpRoCQSQlm7mC4/R/p3AdvljC0eznPnwUtB6vCy/VN08DiwKL9eW
9jCL9qejGDblZC/T3PRjBcTmRDNrxME5N8LD5/bQNClC8pYTlUurvzoXOrkc768s
qxme6AYqrPgChIFm6IvfQF7Uj2LppW37d3t3F920rTkDW0LDBK23caFhLo5JNEdF
gireupD5ofMp6iIZJDYL7GE0/aKk58gqBxBTVPVy6GmfZP0P76c7DFJmPj1IPg2g
8gV7sdFA+Qaf5akbdUMYMt1YQpVZrCmeGacMSL9Qk+RL/1GTN6oa1P8+Srxuf3Qb
XZbQqZcxA1kWUIAlw2gfeBn5FBtN5w==
=Vm6h
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
