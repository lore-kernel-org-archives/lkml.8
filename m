Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED5F20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593593312;
	bh=lq/4+OG0fC6iAl0vc7OsWzVpC3Q0SvhNHIdHbVQPdGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pm3CXDsHhzfYBmdrSq0P7c5DhiRNfvFmIPbF+0AC/gSc/EtreGEJPb3+AMkgiKSGk
	 QgihEyBQ6fYnUxgn8oaBimAxDhLYuh3G8io1rZPBe1xuTrfdnNmcgyRBomjnX9SB7T
	 g2Cs3aBViPDyYgzKt4hNvBQlvrWuzz/TGDE11Qt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgGAIsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGAIsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:48:30 -0400
Received: from localhost (p54b334c2.dip0.t-ipconnect.de [84.179.52.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415E420747;
        Wed,  1 Jul 2020 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593593309;
        bh=lq/4+OG0fC6iAl0vc7OsWzVpC3Q0SvhNHIdHbVQPdGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bovqI3HFRMXcNWnSKNnqQKjS8A7Il7hvWo+LZxlLvjCpbQnEm2WO+fC0sz+bUInBR
         aWyvUSsJd/tY5EIvRhcjSMakCu/BV0rVodzzp6YtHbiMtJRxzcxFPsGdNUcEnIlq9V
         BdLOmPOR/vniMj1R5AGSOWOGqkrHQHDhsFHOGBuY=
Date:   Wed, 1 Jul 2020 10:48:26 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 26/30] misc: eeprom: at24: Tell the compiler that ACPI
 functions may not be used
Message-ID: <20200701084826.GA2261@ninjato>
References: <20200701083118.45744-1-lee.jones@linaro.org>
 <20200701083118.45744-27-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20200701083118.45744-27-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 09:31:14AM +0100, Lee Jones wrote:
> ... as is the case when !CONFIG_ACPI.
>=20
> Fixes the following W=3D1 kernel build warning:
>=20
>  drivers/misc/eeprom/at24.c:228:36: warning: =E2=80=98at24_acpi_ids=E2=80=
=99 defined but not used [-Wunused-const-variable=3D]
>=20
> Cc: Wolfram Sang <wsa@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Please CC the maintainer (Bartosz Golaszewski
<bgolaszewski@baylibre.com>) and the I2C list. get_maintainer.pl will
help you doing that automatically. Please also mention if this is
planned to go in via a specific tree and want acks or if you want the
patches to be picked up individually.

> ---
>  drivers/misc/eeprom/at24.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 9ff18d4961ceb..2591c21b2b5d8 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -225,7 +225,7 @@ static const struct of_device_id at24_of_match[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, at24_of_match);
> =20
> -static const struct acpi_device_id at24_acpi_ids[] =3D {
> +static const struct acpi_device_id __maybe_unused at24_acpi_ids[] =3D {
>  	{ "INT3499",	(kernel_ulong_t)&at24_data_INT3499 },
>  	{ "TPF0001",	(kernel_ulong_t)&at24_data_24c1024 },
>  	{ /* END OF LIST */ }
> --=20
> 2.25.1
>=20

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl78TdYACgkQFA3kzBSg
KbZTixAAkjDs8FYp3FZvQGjNwYUl3z9IFXXzVyvMAsMMH2YOBxhdbJBgMriPCUQS
2QAG1pcZfgyO4Wmj9DiaTT65HfooL1sSNybPtx3Vm+Dz/yUNcxL8lcWOV5mcTnJ7
pYw5pjLWONoO2wAbwntSYyirCpgKis38386UW9vpf7gmyWFgtDLVzWBbqRs6Wwbm
C9qh1sxejOPJcb8ZWqAxGdgtsp6L9hgMsGdohPelEoctWSb3xT2WqyzrmXBaUFCi
xOKdB6HihKs/M10TrwSKG/wrKQZXVfeQLeckT5ww6WfOmT2RcOGUVdZW27aNe3Cl
xEbJqXgRHcjflezh9EiocFD6t0pCT6gJBmzEs5Gn0e6EA1hGQNeomlMw4+oySelL
ZlNvDf/ySehx1C7GRRUHCVbhXzbhg+PbOdxOIeBCbqJ+qTtIYItAJri9OOkLKRnL
Ic3v6+gl2UH7j8Jgm+NYCXV1G/8w2ljLSOpM64CNnnrtLb4tTwesaCxFFVc20gyt
Fkh76rHEzUQukZuK31XhRNyKTH5Z82EhnynBaFDUqrg1vdO3Pa142VRf6N2njovC
BZK+dh37eNd0XL1scoLOrgx4xXiWnYwbR4FfWBbmKvEqFW/O4EMYU7W8pxhfYSna
4k7bddIrP1pOdXgX/WPJD0hvC8xKkHzarSOvxVT8bfqjoH/FdFA=
=3Jsi
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
