Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4EAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A54214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586442440;
	bh=f52tv12CKi3hPcTqTZtkaLkme9rieuxIx0S/7m+utEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S1myin1t+iCW9DZoMqFX3VhMJh/IbkRoLLA4H6iZ6CiRssxI0vzqbUTrRZwRa1R6f
	 rZ6U/AfrmCOOT4sNBqWjADXgEkR+fGMYZYTmTDSY4oomXfvDjE6FKqsjaLTyBvmyX2
	 VMcL/PU1sdNqGRn+OTsa3HmI46uRI7Ju4vwSQf9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgDIO1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgDIO1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:27:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C44A5208FE;
        Thu,  9 Apr 2020 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586442438;
        bh=f52tv12CKi3hPcTqTZtkaLkme9rieuxIx0S/7m+utEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSLIIjvO6UjGlZmSCZlzlyQBkZE8ByVHZcS00h4bVKxeKZI2svF/qg+WkMj/0+ii8
         9ZBfJYpXABitNOl8t6onNbNYbaft/UM4k7TUuLMXvK35n99MB9FEEkrUQNewCwWmR6
         tqKqP/ofzRAh/aqch/ql/msKI4TiAfL3jF57SJPc=
Date:   Thu, 9 Apr 2020 15:27:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] mfd: syscon: Add reg_update_bits() callback
 support
Message-ID: <20200409142715.GF5399@sirena.org.uk>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
 <759f7471d03946ae273a06f7bcca8a54528ec08c.1586422035.git.baolin.wang7@gmail.com>
 <20200409104802.GB5399@sirena.org.uk>
 <CADBw62oh6juAqUR1-U1D73H0oeW1x0gk0XJ01h47ko_Dxy7eEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <CADBw62oh6juAqUR1-U1D73H0oeW1x0gk0XJ01h47ko_Dxy7eEQ@mail.gmail.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2020 at 10:13:58PM +0800, Baolin Wang wrote:
> On Thu, Apr 9, 2020 at 6:48 PM Mark Brown <broonie@kernel.org> wrote:

> > > +     int (*reg_update_bits)(void *context, unsigned int reg,
> > > +                            unsigned int mask, unsigned int val);

> > This is fine, we already have this operation for buses, but why is this
> > munged in with the MFD patch?

> Originally I want to show a example usage of the new callback, but I
> can spilt them into 2 patches as you suggested. Thanks.

Yes, it's good to have an example user - just not as part of the same
patch!

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6PMMMACgkQJNaLcl1U
h9A9wgf+Jc6tx2qiednYwS1jkTBZj78MElmgKS659xV4M89wyuZsOgy3X0abKOOx
/uebtp84zgOJP97ZmGJtiT19GungspwyqMFghDZVmOw0YtrvJD3jNFU021jkmguy
42kRT+TByrolwmO/q7+A+dRMESc/nO5jXYIYE95dy8I1TRQCs3kPcfIu6ooe35VI
OfiOiDGkxhEU+GvFiy79mvHQMurtX15l9nKoim27HaC6nGqyGCcdb2Ur/YRW0oqd
rAoFmzyig9AKZ+T9nQpQ2UoI54SEjqoNqiLwxCD+FAifXOIw66zIRBqn9wk8JlHX
p4gZNqbYUpOIc8Ar9mq+FmI2ertcLA==
=wXEn
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
