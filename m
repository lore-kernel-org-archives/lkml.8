Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C82C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C539B20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590079148;
	bh=d1LNfflc2xncKAMYKDK3/akbZicrB/VqCYFFRCJWhn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qbsse4eMbZE6VU3ugCdLldVizfCGcGi52LFMCulWBbg07PuhNdLClIGxPU2Lu/ZIK
	 GGM4Y4z9eMS5IiJ3qi4ga/MMMkkSllQexkCKAU54fI/QXSn5h22Tu4HpAppnMKYE9G
	 CHuUn2BB2L4MfRNSK2ol4g+eHyAzz94MiN3ulcYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgEUQjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgEUQjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:39:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3982072C;
        Thu, 21 May 2020 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590079147;
        bh=d1LNfflc2xncKAMYKDK3/akbZicrB/VqCYFFRCJWhn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TE5HNonA6//A6to+71Mf+4I7jptBHdR05iodEwYKCIWVdc0qq3g/x+EOxeXQ8DrEP
         /mGpITDcHqQPLlUl9rf1vWjb33vXv6GutJWPi92KiOqkbRqT0b67zmpYwWMB9LxTvL
         /MidcaVFaealb/QkwqNgBOl0W3PpLK1WswNHr/dU=
Date:   Thu, 21 May 2020 17:39:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
Message-ID: <20200521163904.GF4770@sirena.org.uk>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com>
 <20200521121228.aqplh6eftylnys3p@mobilestation>
 <20200521155143.GE4770@sirena.org.uk>
 <20200521155804.qgaaqc23h2nll7r3@mobilestation>
 <CAHp75VcY9HG3=wft9VFWKJD9PG6TiSbmOyjgYZyue+z3PW_eCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <CAHp75VcY9HG3=wft9VFWKJD9PG6TiSbmOyjgYZyue+z3PW_eCQ@mail.gmail.com>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 07:02:32PM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2020 at 6:58 PM Serge Semin

> > Let's leave the patch as is.

> Mark, should I send a partial revert afterwards in this case?
> I'm not fully satisfied with it.

That might be a suitable way to keep the peace here.  You are clearly
both much more passionate about this choice than I am.

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7GrqcACgkQJNaLcl1U
h9D6rwf/fACnRPPiV00dxVVND5ILBPJ1KzpV9NsThKr1PvqPTsJn7f0pKyas63Sf
eoygJfneMKi3kZlj2wQJMKD8bCs4hXF4NeKPlUAMgN+rTHrC++vj509B7sNSLgDR
r4Knt6+ur9iFTXvYggP7mbmAqFfbsVDTlCHViHgjXmRMoqT4lrPVhC6EcvwlUoaI
ykrGzD+C6olEFbneErNLY2mIJhTcs8s90YT5VpccRx0oWLkVL0eQo8gBrSrQc+10
nwQpIJVsIf/XFhvz/SPEank//XrgjOY6E2w+yN5d9AzpywJuqRQ8tILg5Y5KRqOL
dQU19zRqFgoB6lKbX1KTFzX2GFNoXg==
=jRLZ
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
