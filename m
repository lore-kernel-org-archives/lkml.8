Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0353C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE3420702
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592832697;
	bh=pLENTLPeVroG+On1y8UoBO5nhRFMAm48TrmuocJI5Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YrYVJogSY8aQvG/VKLD9BLMqV71eejewldArzyZOqG9pLxlJooN5/pBjMaQqd7gil
	 sAzsDmLL1y7BSC0ZMVU6O1wgoII3rBckUGxbyxTH7nVDIqDjLzk2j0PVi5QNwBCEkg
	 L6DsMHGWkXeQCZVPGrbU7ANDQmHu8AhQ0otyfmcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgFVNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbgFVNbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:31:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8860206D7;
        Mon, 22 Jun 2020 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592832695;
        bh=pLENTLPeVroG+On1y8UoBO5nhRFMAm48TrmuocJI5Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWnP2/GXM7lzszi0oY8pTZz+2T8jjbEcTplJWlzAfj7QP7+h06iUJCNEUaxvu0JnW
         z951jXlTvWaTK82PV86nqORX7eZJOfy6y0fajWcjvwYnMt4OTtB8Z96gCx1cCEMwSK
         K7Kk+ZZjAIMHy7QSnEEghyP426johQ05MlzHUeJc=
Date:   Mon, 22 Jun 2020 14:31:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [RESEND v2 3/4] regulator: mt6359: Add support for MT6359
 regulator
Message-ID: <20200622133132.GI4560@sirena.org.uk>
References: <1592808050-14260-1-git-send-email-Wen.Su@mediatek.com>
 <1592808050-14260-4-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Content-Disposition: inline
In-Reply-To: <1592808050-14260-4-git-send-email-Wen.Su@mediatek.com>
X-Cookie: laser, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 02:40:49PM +0800, Wen Su wrote:
> From: "Wen Su" <wen.su@mediatek.com>
>=20
> The MT6359 is a regulator found on boards based on MediaTek MT6779 and
> probably other SoCs. It is a so called pmic and connects as a slave to
> SoC using SPI, wrapped inside the pmic-wrapper.

Acked-by: Mark Brown <broonie@kernel.org>

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7wsrQACgkQJNaLcl1U
h9Djwgf6AmEftO99uS8cYEjMpPbS8Ok0R+XH/YDPD2t3hiska3+L/e5zFNZz4lGO
0cLGtC6n7tXEm6SiX019tvoxMLw+3wLOMaxaYLDKW72XSlVeqHO5qKaQZRrKElEi
VdKmM8Ddbo+a8g5okY/JFtlDeuN/80DH6evYdoFs6PYH8XGG0kn+pn3tcC0w629j
+pYS4gDrCMZ3uzXLkLpr3KIVE+IIQgnhAGDRE3ETO7ojW7F/HnF47q5Pf1DbSO2F
2VWYGEPPmZ3wyWBGooDwHftAgUop3G2lonszzKzjdmSpLza/Q/W13CHDKCg7Gc2O
AMTnQxMR0LCo/BU5faCLLLR059lIjA==
=FkFR
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
