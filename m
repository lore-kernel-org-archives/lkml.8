Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98682C3566F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD112467C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgBUW21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:28:27 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40460 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUW21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:28:27 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A35051C1CBB; Fri, 21 Feb 2020 23:28:25 +0100 (CET)
Date:   Fri, 21 Feb 2020 23:28:25 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 114/191] ASoC: atmel: fix build error with
 CONFIG_SND_ATMEL_SOC_DMA=m
Message-ID: <20200221222825.GB14067@amd>
References: <20200221072250.732482588@linuxfoundation.org>
 <20200221072304.590894861@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20200221072304.590894861@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 8fea78029f5e6ed734ae1957bef23cfda1af4354 ]
>=20
> If CONFIG_SND_ATMEL_SOC_DMA=3Dm, build error:
>=20
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> (.text+0x7cd): undefined reference to `atmel_pcm_dma_platform_register'
>=20
> Function atmel_pcm_dma_platform_register is defined under
> CONFIG SND_ATMEL_SOC_DMA, so select SND_ATMEL_SOC_DMA in
> CONFIG SND_ATMEL_SOC_SSC, same to CONFIG_SND_ATMEL_SOC_PDC.

4.19 code has significant differences from mainline in this area.

4.19:
config SND_ATMEL_SOC_DMA
        tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	default m if SND_ATMEL_SOC_SSC_DMA=3Dm && SND_ATMEL_SOC_SSC=3Dm
=2E..

mainline:
config SND_ATMEL_SOC_DMA
        tristate
        select SND_SOC_GENERIC_DMAENGINE_PCM
=2E..

Extra 'default m if' line in 4.19 should already prevent this bug,
additional select statements are not neccessary.

Best regards,
								Pavel

> +++ b/sound/soc/atmel/Kconfig
> @@ -25,6 +25,8 @@ config SND_ATMEL_SOC_DMA
> =20
>  config SND_ATMEL_SOC_SSC_DMA
>  	tristate
> +	select SND_ATMEL_SOC_DMA
> +	select SND_ATMEL_SOC_PDC
> =20
>  config SND_ATMEL_SOC_SSC
>  	tristate

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5QWYgACgkQMOfwapXb+vL3xwCgsnEahVgLj35jKntnGsfHqdiq
Ua4AmwX5KOLir2T1eAQHcdqj4Wy+dXbe
=6p6t
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
