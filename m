Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C877C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BF220708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597404623;
	bh=2ZcProTPztj1mqGDcB3GcIKDFcA67IHT7VtxSattYz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FmUgn3DjbTagFb05zs4lFj0VfLF+fUOoMkumuJttuq8Ciq6bLEQ10nVO3BvCdfIhL
	 KFVE3To+kxGh6Je1k2E/NUJc64GT/b3WCG/5vkm0aaEzcm1x5rj4zJ3QG/XYgM++dP
	 GmfszkJMcCcLItHy0tDYhz8Ftfj25z2TsdHQG3HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHNLaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgHNLaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:30:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE5F720708;
        Fri, 14 Aug 2020 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597404621;
        bh=2ZcProTPztj1mqGDcB3GcIKDFcA67IHT7VtxSattYz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyBJKuNRU0n8Xf6rS6b4Dfrus9IG+nkcLyBNrJ42+5nYnrxM4+TqNKlObGEmsaMyB
         CsRQSuF1UMf9jeYzIEPr2Vge9KiDmYJo7UBcdX0E5V34aHOrrRkxMLTSwipm09Frzx
         vze7kTpmRqlrnUYFQBsZKQ2nmkUwfTgTUcbuTk4c=
Date:   Fri, 14 Aug 2020 12:29:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, cy_huang@richtek.com,
        gene_chen@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: Add support for RT4801 Display Bias regulator
 driver
Message-ID: <20200814112952.GA4783@sirena.org.uk>
References: <1597384773-18078-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <1597384773-18078-1-git-send-email-u0084500@gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 01:59:33PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with a=
n I2C
> interface. DSVP/DSVN can provide the display panel module for the positiv=
e/negative
> voltage range from (+/-)4V to (+/-)6V.
> ---

You need to provide a Signed-off-by - see submitting-patches.rst for
details on what that is and why it is important.  I can't do anything
with this without one.

>  .../regulator/richtek,rt4801-regulator.yaml        |  80 ++++++++
>  drivers/regulator/Kconfig                          |   7 +

The DT bindings should be in a separate patch.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl82da8ACgkQJNaLcl1U
h9DuKAf+I610U2U0dt5tHT7uwKK7XguyPYO5a/4/mjZ2KXiFjSURo6VQ67JybCHk
d9IWM8c1i639s0aVQjBFKn0sLE0MiMA7TT4PyPWgAufWjcPPl5a6bJEqYXiw7uhb
SqGL7kwdtwKjz6qgfAhE3rYhZdljmPDpY4y1wi04GI2JIVFv/hMFN/jQtmVZB9ot
iTdX5eK+XG+1IR6jbVHj/CjWdfSoo7dL4jTMYCGbm5yC53ksZ2OcdZjKy3oes/iB
1dHfsBTkpG7HXE2pcLoZYOLWx07D3dhmnlhmGpjUf8CRDSaCeBLZp+X23oZKnP/T
XEk6gfXrAuZWMIJyhSvrlbq/g2H70A==
=FWmV
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
