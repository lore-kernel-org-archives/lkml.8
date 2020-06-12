Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE1EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB6820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591979415;
	bh=4LlTrbnAzIZFR6wHuayLVFm49WeLNfWz+dPx3QjZKGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEw2F5Qp8ArKdT4MX5lOJwve9tglhGw9SxE01AAt+i9GfHWRlIzgLj9M3OEOMRVh4
	 soqF2mkhLcAKNluAdKEX4bOTeY2p2PFd+OL1qxPChko0lE5pm5FIopGJB4pLiGyK9O
	 IkGjHvh+GhfvgtNu9GSqrtaveGIbMit9nQHsMC8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLQaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:30:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3802207ED;
        Fri, 12 Jun 2020 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591979413;
        bh=4LlTrbnAzIZFR6wHuayLVFm49WeLNfWz+dPx3QjZKGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0hq5uQLQbmGvIYSOXCy/asfYb3eBKTjQLU4Y6u76hjB69bblP6aJqrUF12KvLU9k
         Kd/+Rm8om3D8SXw8qJU0MQLi60Gp9Dp68ggohmcSGDShQmmmFezvzUQqvbe04WKTJG
         9IzmQh40CeIGEx/CjsZD5Ba9lFtXE5wCBPKEcj84=
Date:   Fri, 12 Jun 2020 17:30:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: tas2562: Update shutdown GPIO property
Message-ID: <20200612163009.GN5396@sirena.org.uk>
References: <20200612160603.2456-1-dmurphy@ti.com>
 <20200612160603.2456-2-dmurphy@ti.com>
 <20200612160922.GL5396@sirena.org.uk>
 <0e482167-71c2-a128-b8b4-a054557d30e9@ti.com>
 <20200612162200.GM5396@sirena.org.uk>
 <432c41fe-8afa-2ccb-8917-fd64f4895144@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Content-Disposition: inline
In-Reply-To: <432c41fe-8afa-2ccb-8917-fd64f4895144@ti.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 11:27:04AM -0500, Dan Murphy wrote:

> Well should we then just revert back to the non-standard name and just fix
> up the code?

> Or should we support both properties?

Either option is fine for me, supporting both is a little nicer.

--v541l457l4DThMFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jrZEACgkQJNaLcl1U
h9Bs4gf/YK7aSgRQxpt8N+GOcjobdxj76wwkgcRjsIHbJr8OYMe1r0Rgo3zU+IQ4
JirWgd4e4e5JP2JyZv1g856echYxneyYRwShozq+U/mtpu6VSPa11xF+wTRh+6hl
s7FTPn1EAEDEPyo91CHy5Abgx37H0BYbJg2sEdVnyvYogFaRmlGGfeBvvNnyP2Cw
8FSxlIziTxNGz8e7x5VK9nC3xGtG/Cuc1MjDfdjVcDi9/pKmPok6G0DeY5R7/pfJ
KcwJUOToL+QsPcbZYM3sCyDyWIcgvYX2Zn81yaCepoe8441HR+0awU17Y+etOB2e
cvCErmPpmmhnjbsnYZhI5QC+vlZp5Q==
=qJK+
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
