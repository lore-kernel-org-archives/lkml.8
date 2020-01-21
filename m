Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23632C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B7621835
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579631573;
	bh=IX3oif6PMnePk1OMSAVfPFaKVeSvGDfYbzHIwMvyHFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0k9F23VelhMAhUmWnUy61Aw6Zjw6VxYUNrDTkVFuvJuJe1+Qw7ZD0UG5osQ25BTQU
	 C0DQPtEhiVQTW5z/0kxbZqim7/Umu2CSNNpNGsybNUC0XV+IlRHyioJfjkaovGQIbA
	 5y2Vdf1VfL3DVwbvhBaOF89QvyNkzFuHN/pK8/SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAUScw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:32:52 -0500
Received: from foss.arm.com ([217.140.110.172]:47280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUScv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:32:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DC861FB;
        Tue, 21 Jan 2020 10:32:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7533F6C4;
        Tue, 21 Jan 2020 10:32:50 -0800 (PST)
Date:   Tue, 21 Jan 2020 18:32:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/2] drm: sun4i: hdmi: Add support for sun4i HDMI
 encoder audio
Message-ID: <20200121183247.GL4656@sirena.org.uk>
References: <20200120123326.30743-1-stefan@olimex.com>
 <20200120123326.30743-3-stefan@olimex.com>
 <20200121182905.pxs72ojqx5fz2gi3@gilmour.lan>
 <20200121182937.2ak72e4eklk4za2u@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
In-Reply-To: <20200121182937.2ak72e4eklk4za2u@gilmour.lan>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 07:29:37PM +0100, Maxime Ripard wrote:

> > Mark, our issue here is that we have a driver tied to a device that is
> > an HDMI encoder. Obviously, we'll want to register into DRM, which is
> > what we were doing so far, with the usual case where at remove /
> > unbind time, in order to free the resources, we just retrieve our
> > pointer to our private structure using the device's drvdata.

> > Now, snd_soc_register_card also sets that pointer to the card we try
> > to register, which is problematic. It seems that it's used to handle
> > suspend / resume automatically, which in this case would be also not
> > really fit for us (or rather, we would need to do more that just
> > suspend the audio part).

There's a drvdata field in the snd_soc_card for cases like this - would
that work for you?

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nQ84ACgkQJNaLcl1U
h9DTsQf/ZXhHyM/3fgvqMJFm1rMy0RUSq2MP43zhb1/fioi7vxLOoPvc5jQzGwUw
0WCUnqbv87LZXwtMbvIx1TS2xVzFt1EvAuRX+XwwVYlmTP2svfRkN+pjdNGscEcY
Y9dO1Klqekk2WyzZsQ9fkDM8hoJtjXZ0oFRrPlUsae9jbmymykgqmK48XLVKFd3x
AaeVd0BuUIXA+6jlFqTBgaIA35TffdliRrgSxjwxoy3Jk+wrW562WgM/isGD2qjK
Jn+alQQhlwRYsN3Xmuni7Fd4P9zf5r7o8twcyijEOH/Um76H8d+vSjrwI2tCJfAm
c0+F7U3m8NTne3fCjVXvL4/ipHzMGQ==
=km+F
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
