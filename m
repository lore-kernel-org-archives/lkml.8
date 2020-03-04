Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6117C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B439B21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583341851;
	bh=Y3N6v1eXSWDKtxFUsYiH6yeX4gKM9HVi+Q1kuGDr5BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vADz7lIB+JJgX26UlZmSw/6j8nkZm7FbZPJYKk2wdjuQj4+zq0f7jGH84FML5sPOC
	 4OwwXPPbOR8UrEh89TUX+2ghbePXz9ouG/ExHOJI5a4GD3jkpZuKzw5YkuNCc6Emcv
	 nRLn4mif5Ahdfc4qTL8YrWv0cq6tBR1YNY3jG0LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgCDRKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:10:50 -0500
Received: from foss.arm.com ([217.140.110.172]:37374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDRKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:10:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8DF031B;
        Wed,  4 Mar 2020 09:10:49 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0173F6CF;
        Wed,  4 Mar 2020 09:10:49 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:10:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: convert rockchip spi bindings
 to yaml
Message-ID: <20200304171047.GD5646@sirena.org.uk>
References: <20200122224555.6845-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20200122224555.6845-1-jbx6244@gmail.com>
X-Cookie: Tomorrow, you can be anywhere.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 11:45:53PM +0100, Johan Jonker wrote:
> Current dts files with 'spi' nodes are manually verified.
> In order to automate this process spi-rockchip.txt
> has to be converted to yaml. In the new setup
> spi-rockchip.yaml will inherit properties from
> spi-controller.yaml.
>=20
> Add document to MAINTAINERS.

This doesn't apply against current code, please check and resend.

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5f4RYACgkQJNaLcl1U
h9AUJQf+NIBVp/NuXcA8ap1DTnZKngd1ChQwtZBK7j45Ck2jg/rcwmKK8WT3Dd89
tlhn7yP8Ad1Bx7jxd7w76jpBVuPE3K9z0EjZeI6nnxxMdv15bW5+Rcrp8QetP0qA
Yn5L8jNUSpFS97y7ACecT98AkKB8C6mExQ84U4s9qxjl5rZqzzlPmJBJASt9rgF4
Ox/eSAEqdiv85KsmMGzqc5171uhicslVUvjCw5YFB0RVhm+fZw8G3PFpdJdQGt1w
KRQkMrkEyLUU/znr92Ggk6ehIdMu4gzoLSk3Qe6DihtXVQPyE9LuY5PUZi81RpVZ
GyDX0FN7FIBIO0xBFkF+V1cPyGtWPA==
=JWON
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
