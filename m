Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E319DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE084206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595855273;
	bh=AMi2gLfyvz4Pzyz9YDmdVT9VjepzkPLuNlEIsAaH8BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D++gNwiDmGf3jKsn1qDfq0WaqJQpxfRw1RhDa1KAxm9EuM+dp2oaUoBXXEa6xjYJz
	 9BGr/DM4ODZiYv67guFqENKbnlrBl33pZhB2ulRVvaj5KdlDptk53+Wm5+zSdDE51V
	 9ubkazHfe6OhZgVqzUHZuYGpEbXO0y66vSlRTnDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgG0NHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbgG0NHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:07:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0363206D8;
        Mon, 27 Jul 2020 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595855271;
        bh=AMi2gLfyvz4Pzyz9YDmdVT9VjepzkPLuNlEIsAaH8BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu31vcATjTnv0NP8lHz08cxLsQPSaYLW4iYAv6mxr3RFeDNSNGfxWDyJX7piWPIzN
         ih6hB3pWOjzdlrbaL5J+qnSY+sMc28wF38/pShr+R7K9evW1IlBIVnZJoWao+ue2Ld
         /117aEdG7Xeh8NKJxF3cw9Q8RYnh8J5CBsbTOnHc=
Date:   Mon, 27 Jul 2020 14:07:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <SteveS.Lee@maximintegrated.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "steves.lee.maxim@gmail.com" <steves.lee.maxim@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: max98390: update dsm param bin max size
Message-ID: <20200727130734.GD6275@sirena.org.uk>
References: <20200724085644.9837-1-steves.lee@maximintegrated.com>
 <20200724105059.GA5664@sirena.org.uk>
 <MWHPR11MB204753BF80DED8923AD3BEA292720@MWHPR11MB2047.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <MWHPR11MB204753BF80DED8923AD3BEA292720@MWHPR11MB2047.namprd11.prod.outlook.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 02:00:09AM +0000, Steve Lee wrote:

> > I'm missing patches 1-2 and have no cover letter - what's the story with
> > dependencies?

>  I will re-send patch ang please ignore this patch.=20
> DSM init param is extended to cover more register so that DSM MAX PARAM S=
IZE value is changed.

I applied these on Friday having found the other two patches (you're not
sending things as a thread so they get lost, for example if someone
sends a big series at a similar time like what happened on Friday) so
your new version won't apply, please resend whatever change you want to
make as an incremental patch against current code.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8e0ZUACgkQJNaLcl1U
h9Aqawf9HopZUMhCAwGV7wiVa1eQ8XQk/OPZHjlLzQJWkumo48KLX9suSNS9hLM7
jiovx41l0JOBC1VXNa9PvWE+rl52Ugry0xNmYeGYTtk5aPj+7ugIA2qxtrKfXjen
QM1UrXRJjLv6LX7m+fF/YLa7ltOm81D6WJs6qt+vgBQJz0GjAx9ctk6Hx8ZqBylV
0IiGhsxIEzuPxipTKhu/F9KNRuCKcewTAZCOY9eATGIapp8JTx5YjelS6D6+Nd1G
366Zi9knBZBdZOrgM0wl19mw35BNG4RKhp1IrKjNzagiG19EMDnaGXuaX7awFyYH
lg2Y6n9jSDhN2VDYH9qdObYl+iZCtA==
=bS9e
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
