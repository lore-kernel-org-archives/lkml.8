Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AA1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F3B2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583414198;
	bh=89pj+/3d70mzhqJytH/tjInXpg55bX39E6fqKX/eV48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FG/6NMnpd4vamd1qTTrZpirpWvZM5b+D/nZTnrV4eitNl+1RR6ml5VlksXV+iWLrE
	 9r2Ztf+H3Su0z+RiY/JXrhXSrbs44Oq5Szm82alEFL5/4dMxdM+7HVtizLGvML2Anu
	 oXrrHdFSzFv6ynu25uYLCsPeQPYSG2gf1UgM8nhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCENQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:16:37 -0500
Received: from foss.arm.com ([217.140.110.172]:48452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCENQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:16:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531AE1FB;
        Thu,  5 Mar 2020 05:16:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAD263F6CF;
        Thu,  5 Mar 2020 05:16:35 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:16:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Esben Haabendal <eha@deif.com>, angelo@sysam.it,
        andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times
 as necessary
Message-ID: <20200305131634.GD4046@sirena.org.uk>
References: <20200304220044.11193-1-olteanv@gmail.com>
 <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk>
 <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
 <20200305130448.GC4046@sirena.org.uk>
 <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag@mail.gmail.com>
X-Cookie: When among apes, one must play the ape.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2020 at 03:13:53PM +0200, Vladimir Oltean wrote:
> On Thu, 5 Mar 2020 at 15:04, Mark Brown <broonie@kernel.org> wrote:

> > That's mostly all true but it's still better to pull fixes like this (or
> > the patch limiting the size) forwards and not have to think if it's safe
> > to not apply them as a fix, it's less effort all round.

> So do you want me to do something about it now?

No, it's fine for now but please bear this in mind in future.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g+7EACgkQJNaLcl1U
h9CuIgf8CPmhlqhfcee9Ci1AvSvSQ6xlsVV5/vgUDE46caYf+o0lvc3iJNPqnLvK
a0ZXaSs9mpkONPWpmXfsgk+BVbAb+4ykuipEHVp0G9py+KOxkzcXQRXiyjCGlqn/
PTGIhIq/gjJaN1CwSELFoL2MTNWWh64H+yCISBRIKMU6ttcKKpQ830LTWbdpTohP
Fgai52ynNFsOKA/JwfLrUcgjSNWXXSm+Bec2UcBWPWjrgYGkdQafoyjGCjfzSFL4
Ezrm3ye7do1VRFf/UJ6v02miFG4o+lEZv+FyVvCI/SWD2nu8m3yAVBdnWcZM5LVV
+E0vjsXEtwJu/XSCCQ2g2ao20+oveA==
=Ct73
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
