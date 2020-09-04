Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1539C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8BF20795
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599236679;
	bh=NAOttNi68dxtCKh5TVKg8sTqUmu57wOh79f7YPBx69A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bwZ7pyUI2/PXCo4EcbZrGfCnta/vmsa1kdOTUVT1+EJpIuF2D50St1DTDMDJ9LGgC
	 RMHWoHfOHmg8a0n3PQfXiaGxOBsKBeeGiqnobGja8IrUEu9hS7tnVtJ46YZb3h1eGe
	 uOPVCW4eT3EpMEX1YWAkLqnccg/LA6u71h7S5T2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIDQYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDQYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:24:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C209D2067C;
        Fri,  4 Sep 2020 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599236677;
        bh=NAOttNi68dxtCKh5TVKg8sTqUmu57wOh79f7YPBx69A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYBhS4JDiuXs0mCoO/vaMRF73YWXpersz+FpF0smRVDdj7C9Ct+RwCWCL3X2yFNpp
         7RuUQEAMeqFGccOyhwlo/nsrxfWtbcHDQIrarHS1M3nKpBWnXBaE8LuoBBGgKq6XxP
         NCq1YqJ3YwJNIFyhB0NyeT4pw3aHQdww+TdLgZFw=
Date:   Fri, 4 Sep 2020 17:23:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, peron.clem@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [linux-sunxi] [PATCH 05/16] ASoc: sun4i-i2s: Add 20 and 24 bit
 support
Message-ID: <20200904162355.GA49830@sirena.org.uk>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-6-peron.clem@gmail.com>
 <1e320dfd-9388-54b2-dba9-7def0bf4bbad@sholland.org>
 <9148679.oVN3Z7rve9@kista>
 <fd714cb6-3650-1eb9-616d-33c00f1442eb@sholland.org>
 <20200903074023.jccqp45br3er4h3g@gilmour.lan>
 <20200904161649.GL10899@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20200904161649.GL10899@ediswmail.ad.cirrus.com>
X-Cookie: Restaurant package, not for resale.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2020 at 04:16:49PM +0000, Charles Keepax wrote:

> My understanding is physical_width refers to the in memory
> representation, but shouldn't be used to control the slot width
> on the bus. If not specified otherwise (say through the set_tdm
> callback), and if the appropriate BCLK is supported, then the slot
> should be just large enough to hold the data.

Indeed.  The framework isn't great here in tying the memory and wire
formats together, ideally there would be more support for them being
unrelated without DPCM.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SahoACgkQJNaLcl1U
h9Aivgf9FE+zKg/2HauJXtYNKTV6F5tpg9YlM9zZm1mgrfejgquDBl3k34Y9d14k
4p2wjhqoKPTGoY7Y33weRBkyBmk9KcLMfQaZRO84B1W0h1/AgaTVY8hgUbucsDld
X0x3qA/ejP71NUBv1yNuMVVmhwISIg7WLJONku57+1KvdsciUFLgqcK1lesXV/hO
lpemO67BlytBjZKc71yFEQtFEelOOdZmbe1GGDQtDP6wEtlzzbuJuyw9qLQBAfwC
Ron6ds5hgj+K0tk7jdrtOzoW5GGN2U3d+cXn0gmQax72PwEefzjIBAR7n0TAAPcV
Mh3pFSi3xyQSRAv64SY2qiJFAt8TBw==
=ZBOH
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
