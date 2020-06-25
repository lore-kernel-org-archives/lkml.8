Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B93C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7725020775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593106187;
	bh=Mdn554FBmeGZkZ8w0k+GDwEHMYXU9SfEnzckAyKcffQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0kMawTD5Bge39YBMyr8924h0JY6tk6nYRTZwxO1xHp/INIkXKytGbzmxqPTEYad01
	 tf36ODRL/VlDX+zCph3A4x0dFFu3CpTKp8L17nQK048BttwM1GSQmecnvesUyHF/LQ
	 nlXIy2JP+vLdyTy75yTKvHkbO9m9RyWE4w3lbdrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406764AbgFYR3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404761AbgFYR3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:29:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FD920773;
        Thu, 25 Jun 2020 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593106184;
        bh=Mdn554FBmeGZkZ8w0k+GDwEHMYXU9SfEnzckAyKcffQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pfi4/R3h4rhDiYYZp43UX5d1BcnGqlLUKkHLObAL+9rEPeuAIZfN6GMBvfPDE/atR
         YhXskWG6tnVBiC6rlyiNB8MsK/EWj2ZnJxaH20bcxpXFIX1XvD2wfip4cBcSiNu837
         dmnqoTGAR9Hl5K3M6SqYTZnEj7doWX1CljgpbEIQ=
Date:   Thu, 25 Jun 2020 18:29:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] regulator: of_regulator: Add missing colon for
 rdev kerneldoc argument
Message-ID: <20200625172942.GE5686@sirena.org.uk>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
 <20200625163614.4001403-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20200625163614.4001403-4-lee.jones@linaro.org>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 05:36:07PM +0100, Lee Jones wrote:
> Kerneldoc validation gets confused if syntax isn't "@.*: ".
>=20
> Adding the missing colons squashes the following W=3D1 warnings:

>   * of_check_coupling_data - Parse rdev's coupling properties and check d=
ata
>   *			    consistency
> - * @rdev - pointer to regulator_dev whose data is checked
> + * @rdev: - pointer to regulator_dev whose data is checked

It shuts up the warning but are you sure this is going to get formatted
well by the tools?  We now have a - as the first character in the
description which I'm guessing the tools are going to render which won't
look great.

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl703wUACgkQJNaLcl1U
h9A8uAf/Rel1Tx+AQgdsbZJ8O0V7u7igu9aZsU9svS7GeDlFFcEBJfwIZGGGVlx7
XLipyUPDILWL2myXYjOnM96S+HcxAhKI8vK95a8FYFyzKRLbjqgWuIpspP7SOFHo
vPg+08LnnLNY0e0fB9nLbHw8bOTyWaM7UDdZfCiMULtjasznA78wIy/C02qOqQad
aHuRnmZ6c75CBdBlMyabTE9d0ub2VsxvhL6O3543kAJ+bhmqKdzFOYRWiLbvsWdU
Yaqak/YOoIObijZ7583LpLPwIYp2DCB/ns1lSC3KqviakEjvbVQ2OZulWoM9gsT7
9it71Cn7YhvsbYbUBQY0gJNU5SDngQ==
=g378
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
