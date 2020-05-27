Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5CAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B44720EDD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590573074;
	bh=0vToCKDKiiwhvCQ/ZH06T4deAF0FOse4LBq9EGr0Hdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zVGmKVQMTTNlTLSvYcSUhVRupD/snDtPTFZ++Hk6uUzJysR7880G4mR02zPuBryvg
	 WJaqq5u7Gsc8C3sJQtLLoGd+KilxXi+0a7Icgr2RGd4+gBoLLC9BBZDry+nBPpiPe+
	 Uyr+MfEOBPNpIHAZ4kzVm3V/EaXIJcs1bGDm3kXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgE0JvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 05:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgE0JvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:51:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B3520B80;
        Wed, 27 May 2020 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590573071;
        bh=0vToCKDKiiwhvCQ/ZH06T4deAF0FOse4LBq9EGr0Hdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVI+eY/sUvYRSX+c+Adp5mbuGsFalnf0pXTPCNoiZDzr18dCfz9a0UVW1SQjVdQOT
         +GPqBAiQlp1MZCLnbvrTSC1VicjdfKmeCzHwVVwfMOOVW1nCw1H+fYqzrff1b1L/MY
         tRakSOtkBjQYqVrvvfLbmRmqcEhRvThMG5/cDsK4=
Date:   Wed, 27 May 2020 10:51:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        andy.shevchenko@gmail.com, noralf@tronnes.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com
Subject: Re: [PATCH v6 8/9] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
Message-ID: <20200527095109.GA5308@sirena.org.uk>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-9-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <1590564453-24499-9-git-send-email-dillon.minfei@gmail.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 03:27:32PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
>=20
> in l3gd20 driver startup, there is a setup failed error return from
> stm32 spi driver

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7OOAkACgkQJNaLcl1U
h9BjiAf9Ffv3ggcuNoWfvMQqMqMQaCF/81yq+JEuOCOw+nSFwBift/d6Q7Z7HWCh
k0/gPFT+7ED90XyQWUYuDOrUuQWiqQn8UP5p2IhQDAbvY9Zr3jnDTScTPx4FSf9m
xGGbKV0iWy7z78mHngcLf++zQtDzzZLjhK+U4CxVz5htfuOkTdDeIorLUZJnYdBH
tZKEYJ92tDX3perBnTRtca5zIEIo7JWv6ITSh6UTFELxx0D44W6NOS7z2W3kZ7HO
KeUa7lsUfxWs5hF11j959HVj5BG0CFVa/cA4o2dGd5aaDwXjeASUzngGM0DqNPhY
KPzFjTZ70Yj4eNCZVnKrXNGoe9KAoQ==
=8sEd
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
