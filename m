Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2627E2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593699918;
	bh=fIv6KhWcY90lOm99p6vzIc3gJje6cz5azcmmqihbq+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hfjIoC+SdH3sSSrV7RUN5DaxwAGzDejBJs1xvT3dOHESiqr1lWAEYmOxDuvM9G/7f
	 TZWxiLnyfJ8v/HQNFUumj+5nEGIWVj/iPqw2acgDNFXL4Z54OG0uJx/JD2O073V0Sz
	 /Ansh6EsiaMOrKUnfyW9uS52wBLrQG5RcFdogSps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgGBOZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:25:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA69207D4;
        Thu,  2 Jul 2020 14:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593699914;
        bh=fIv6KhWcY90lOm99p6vzIc3gJje6cz5azcmmqihbq+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaBjXyMZ3wtwuRUCeQF3k6Eqq3eSkrkGF026aS7/UJIW7AIyzqSytmJqG1PvUtYT/
         7BToIt/ftzWEpoOSOG8Y9AowrK575DA3HjM5E6P1ny262dI3G23mLatnavSxgr8JlI
         wd8saNesWYnjsRp611TnZd7QGgLCvDzXHY9IDWdw=
Date:   Thu, 2 Jul 2020 15:25:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200702142511.GF4483@sirena.org.uk>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <20200702141846.7752-1-frieder.schrempf@kontron.de>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2020 at 04:18:46PM +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Allow external SPI ports on Kontron boards to use the spidev driver.

I'd have expected this to require loading a DT overlay for whatever's
attached?

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl797kcACgkQJNaLcl1U
h9BXDgf/YXWTeAKOyhNP9dNccDlETXMQ0jNpvL7iXYd9ZGM7BC0Mq2FCCif5cnal
l3DXEtr2Zuw/bCmU89LOdtxTJX4U4i+a0BKU6HahaXaBWp0Pw433pO6/Eo+hJzDW
bnx1O7zQ9cG/KJA+lK0FvwtHKzr9EDlcH395QF+q5QyoxlKZOT71TfqUiNhVIMEI
KndSn/RKct6WinNUUhKzUHbyJ/4I8MbZNOSARuZPF2XjLZAQw+csAFhnEWNRMrno
XYQc6Oh5AT+P52Yv6mQsqpTcWjPkkWyFxQY/K0FAqw16r1R5ZowvkI9TJN8QS5Ea
kbW2LWzmR8L9td0hoC3oOoGNaW6fgA==
=v0p5
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
