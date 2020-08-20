Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F28C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B875020724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597944062;
	bh=t11Q2B8gNs/BHWlXaLDMNfYXQ7MdTZ/zSsSJIT0qDLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKd+ne/x8rEqitSPFULNhCjtVKdnDKtJwgP2C17o2QJY4SmhQwHy43uRWJjurmxw6
	 8/dH4KxTofYIPzHL6FBBuSfdECn7xqLcTyi4M0PyvzGGsjPOrRO43a0yhlsEY3Jba/
	 f6dzQopx0MeLbs5jeuF3VjZwtxLJFpbnAtpZvlBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgHTRU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbgHTRUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:20:52 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA66206B5;
        Thu, 20 Aug 2020 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597944052;
        bh=t11Q2B8gNs/BHWlXaLDMNfYXQ7MdTZ/zSsSJIT0qDLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsBoGf7bOiP5PxcQ+aFPd0ZnbFiTTS9HvUgExTvDzkgg67z74IRJZ/VDgeLUstrOv
         UhsaiGXtv4Y/RHf4C3Oq6UPxyqv6W2xa+bBbqQJJQw3b8KNJqq1SfMBKu0PhWKJhkL
         LCUEfyhZZXn0Hzf54+kgcx9t+3y4z/dnxxM5gheA=
Date:   Thu, 20 Aug 2020 18:20:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, robh+dt@kernel.org, arnd@arndb.de
Subject: Re: [PATCH 7/7] eeprom: at25: Split reads into chunks and cap write
 size
Message-ID: <20200820172019.GJ5854@sirena.org.uk>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-8-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Content-Disposition: inline
In-Reply-To: <20200820170228.42053-8-eajames@linux.ibm.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 12:02:28PM -0500, Eddie James wrote:
> From: Brad Bishop <bradleyb@fuzziesquirrel.com>
>=20
> Make use of spi_max_transfer_size to avoid requesting transfers that are
> too large for some spi controllers.

This is an unrelated patch to a separate subsystem and should be sent
separately to the maintainers of that subsystem.

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+sNMACgkQJNaLcl1U
h9AuNAgAg1e7ZlaXvoOk26VhOr7gGEElMYOMIAa4CU1KOtI3gxgNLCtHIrkH1ac3
0gM7mod2WHVDITRwyYzb9ERGRvVf49QQVMOu9M78o6xwPSX//cSnPFufi9TzZ7vN
ZzFszKJkBas2MuabYcKxmy5irtkbsvKoLLANSCVgIo0D5R7NqoLN9tPqOcYbZ9ek
nY/8khN7ab9mORUea+x0CpCjxOpycp5P/vYIQSYAiLngz9D6xFXodgmppu2PeP5G
knpktpiAFkkVAMbpqLPQEMjor7trFjRpVWSmcq9JQEY+abMof9zBkVug2Hvhtjku
kNezA1WSubWIvS7bmfwKvWnR8KfRHQ==
=kZp7
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
