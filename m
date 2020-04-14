Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51946C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350D02074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586890530;
	bh=D4uD8lJngE4r0vCQv58R/Cgz9fWEBtk9Yx3Wo3ClZqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dSlzArf/YZj0waJvGveqBvPjKsJ8uxl0cdxXgEbrCXq+bKgPYwKZ+JrD3wFuqxMCy
	 1jMbWmgc1xqmmEpU1aFBAR2pkGhnARi5dj82nqPQz4fU7AorVNqsS9WDuBsdEdzbEs
	 eS9/XX7vxvuXzSuVIHKy8VxCNn9zzLG7BzpypAmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504507AbgDNSz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732445AbgDNSz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:55:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420B42074D;
        Tue, 14 Apr 2020 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586890525;
        bh=D4uD8lJngE4r0vCQv58R/Cgz9fWEBtk9Yx3Wo3ClZqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUBphm2Rb7rh1cocNFCF1O3d+uVd8Mn+1KwUOvaIashLzhYAJJs6WNDl3X86yG9DI
         9aLh5UjxG3LWYb5CqkQZi3z3ge5ZDoA2lJw2UnrACJBojsjTRDcGYSATVnqgk+gwd7
         hv1wN/PhGiKOWf6tqhg7U4DyL5tiqkU8Ii2fGoQY=
Date:   Tue, 14 Apr 2020 19:55:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Steven Price <steven.price@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
Message-ID: <20200414185523.GO5412@sirena.org.uk>
References: <20200411200632.4045-1-peron.clem@gmail.com>
 <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com>
 <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com>
 <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
 <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WoqaC9TUMqqIOlla"
Content-Disposition: inline
In-Reply-To: <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WoqaC9TUMqqIOlla
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 08:20:23PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Liam and Mark,

You might want to flag stuff like this in the subject line, I very
nearly deleted this without opening it since most of the email I get
about panfrost appears to be coming from me having sent patches rather
than being relevant.

> We are having an issue with Panfrost driver registering two times the
> same regulator and giving an error when trying to create the debugfs
> folder.

> Could you clarify if it is allowed for a device to register two times
> the same regulator?

> I check Documentation/power/regulator/regulator.rst but this point is
> not specified.

We don't actively prevent it and I can't think what other than debugfs
might run into problems (and that's just a warning) but it does seem
like a weird thing to want to do and like it's pointing to some
confusion in your code with two different parts of the device
controlling the same supply independently.  What's the use case here?

--WoqaC9TUMqqIOlla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6WBxoACgkQJNaLcl1U
h9AufQf/b6efImc7LvBHGoIjbHuK7UiFNve0LJJqjKwvdUwdpOp/m+WzrHWaNAvO
5JNbL9U5h7T5oGh5A9AiToEysk1Fo7St5WLmbEJBXqD8Nhg9yQU/3OtCTgHi+2LP
gx3nA1upkwg3OVkAt5RO1jX70kRXebrAPGy4FgGUyiLhNKnK6Nqf8FXnVzhy6Szl
wH1/jGJlNphErY6s9t9nQLHSY8uS2h2AVvRHA8m5TJeGCGVcfr9iH8r/lLgfIWZI
9SiBZkDSSPsqPOaUylAF2QPyGRx8hNQrJX0Ih4MFsuts0JW1YUO1iNTW6HGj7gL9
8c4/u0KEtqVMiq2q6PnG7cfk2XlkNA==
=+uTF
-----END PGP SIGNATURE-----

--WoqaC9TUMqqIOlla--
