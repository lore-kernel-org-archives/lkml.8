Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D4FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD9F2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587638404;
	bh=DJrwxV1CteilAyNbnpDxy4pVpFE/V0iDtEse9XqxW7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GkjJ+z8iCTF1lCmvOYfMk6gvmuCSaQELfFX8BUAx+rgj2XnYI8huJK/dmJs76t3RX
	 6wMmmXSLSPwe4aRqvmPPHrN1vIBTD9xWypBZ//bEW3OKjyQS2URWRsMFwBVjTNFY6Z
	 lRCdcLC2hLBwCdGt33NBpLdhGQtjjgVGdOoOFMGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgDWKkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgDWKkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:40:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4AE20857;
        Thu, 23 Apr 2020 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587638403;
        bh=DJrwxV1CteilAyNbnpDxy4pVpFE/V0iDtEse9XqxW7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXH8k7YYtHTeDgrX6stnMRK5CYXgWnbUvKzpNRvYRFS7xVxtsqPfoCLIEjlMYjnIp
         1/8e22g2lQPTzQ1J2bODauQku9OLnacH9tEFbiZb092AV338itzshIzRmTYhQ1kMRI
         CO+hfULCoccd4Zbi7T7Iu7Z4tQnOi2scRUjgVcsY=
Date:   Thu, 23 Apr 2020 11:40:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     peng.fan@nxp.com
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Subject: Re: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Message-ID: <20200423104000.GD4808@sirena.org.uk>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 01:46:31PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> use clk_prepare at the very beginning will invoke pm runtime resume,
> if the clk is binded with a power domain. This will cause runtime
> power high. Let's use clk_prepare_enable and clk_disable_unprepare
> when read/write to avoid the runtime power issue.

This will mean that we're doing clk_prepare() during I/O which isn't
good since for MMIO regmaps we support I/O operations in atomic
contexts.

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6hcH8ACgkQJNaLcl1U
h9C17Qf/fo2ZNApBE+9ZJmGgA/okKIKMIRmlk4OQFFeJsttGsP7t5k28YoZr5OAp
lRXBkQIeYbA2SmqQmAm0MCowjHv+bX+dUCoZvPr8ghk0j5zSAPfdCe1pXyEBASQl
bpBuqx2qr5e75sCnxZ57URuJnSPyHtWF0RYlSW+uTt3OJ9Zz2PNHaWA4Bg6WXxgj
qGqEsjpsplrI5Qt88+/nF32NgBENkHUI4glAthZQDirrjzu7dH3z6L+LDwtUTWeG
nd9mY3Z6atKt6B4EjRtIlny9JEvETiLpHepdAWJ8oprkHWuDtYRO27n89DyEJVch
EJT65ClClqHV9p/sUNO2Uu0QIUtpPg==
=DT/v
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
