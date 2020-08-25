Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20D420738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lRfCNWSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHYBb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHYBb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:31:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C85C061574;
        Mon, 24 Aug 2020 18:22:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BbB7c6BLcz9sR4;
        Tue, 25 Aug 2020 11:22:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598318573;
        bh=OaLt4HqV3d9zbIPep2UkkAhYp07BwIaQ9BGWEtyT1I8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lRfCNWSgEYLKe909MSpT/WVlFPLpGeAgQtjIHoNLmYj/3sFCOs+dGsLZ9gfe0fIbl
         2nmIgYHeU2vZpuSKsIvQiKUfd91D/esQuQi57MqDFcjLjxgGj5ZhaGD5vnIBMtjr1P
         yrcitV4NkkTR1/K/YkR9MXZaXgXIV0M5n2+vsdagvqFeB9KuvjEwRNSy4zT5X3SKF2
         Fkd0iHCZouc7UU3smrsWzKt6lnopQuSpIZsGdjYmYk1ATIlq1LtBijkTLiUxkuAaXb
         BBwvVtPkTauIvKZqp4rSkKPYV4Rt2wBCnSbUOejwhAa0s+w5LhntummmPkJQ4SbsF6
         8f6dtQPg6iLuQ==
Date:   Tue, 25 Aug 2020 11:22:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: linux-next: manual merge of the reset tree with the
 kspp-gustavo tree
Message-ID: <20200825112251.042bfeb7@canb.auug.org.au>
In-Reply-To: <20200819102819.63c9aa50@canb.auug.org.au>
References: <20200819102819.63c9aa50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ecRTqe0yGx.TYLu72r/9Y=S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ecRTqe0yGx.TYLu72r/9Y=S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 19 Aug 2020 10:28:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the reset tree got a conflict in:
>=20
>   drivers/reset/reset-imx7.c
>=20
> between commit:
>=20
>   58e813cceabd ("treewide: Use fallthrough pseudo-keyword")
>=20
> from the kspp-gustavo tree and commit:
>=20
>   2983e2385ff6 ("reset: imx7: add the cm4 reset for i.MX8MQ")
>=20
> from the reset tree.
>=20
> diff --cc drivers/reset/reset-imx7.c
> index e8aa8691deb2,b60534a1e0ef..000000000000
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@@ -232,12 -235,13 +235,13 @@@ static int imx8mq_reset_set(struct rese
>   		break;
>  =20
>   	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
>  -	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
>  -	case IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N:	/* fallthrough */
>  -	case IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N:	/* fallthrough */
>  -	case IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N:	/* fallthrough */
>  -	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
>  -	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
>  +	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:
>  +	case IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N:
>  +	case IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N:
>  +	case IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N:
>  +	case IMX8MQ_RESET_MIPI_DSI_RESET_N:
>  +	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:
> + 	case IMX8MQ_RESET_M4_ENABLE:
>   		value =3D assert ? 0 : bit;
>   		break;
>   	}

This is now a conflict between the reset tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ecRTqe0yGx.TYLu72r/9Y=S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9EZ+sACgkQAVBC80lX
0GzAlAf9EPQIvQKi2989Eax9MB/EUpoxxpU5136AgPhXTxiaeGo6Wa9tR5h9YwYQ
7yxBnNaNedymX8nnSar4qB8Ae8ad7qx7YP50OF26ZoMDTrnkHEYusueCCguu6sXC
SeXLG+Te/2Wklhz3GIQxA8DhqZZEX5bXyLwvrgVhLcTF4ClyuvtowWw4aoIZT8ST
zhR0MYXuAxbdQj42ielzMtMtfiVfHSv1mjHhjEE/5a2UZUf38e6r5f0Xr8UqqjLB
IVzRJw751QvfjChm8nCV0uBnfm8NDxSlLNxeyMOfYl28S3cCqhSdPGPbpa+xACd5
+KqeEZImIP4piwaJw4/rC3za/eDOBw==
=Q+7u
-----END PGP SIGNATURE-----

--Sig_/ecRTqe0yGx.TYLu72r/9Y=S--
