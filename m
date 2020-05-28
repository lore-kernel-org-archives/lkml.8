Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E738FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F702075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kBEm+Lar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgE1IbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:31:20 -0400
Received: from ozlabs.org ([203.11.71.1]:33933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgE1IbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:31:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Xgs20GpXz9sSF;
        Thu, 28 May 2020 18:31:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590654678;
        bh=TcuCLidhBGrqpz8f7Da8lwxBBe2IKefCUZaDVklYjzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kBEm+Lar6Bl/Z6Qt/i+uKgN9/IbMKnOmLm5z1NixPDFdj4opJO/LcirQIPQqiaVFP
         kOhC9Hns2QHxvWVAB6BO/pTqUmbuOWfudtHfEBr09kmBCYD3ZVA3i1bkubKbn8wrKx
         zXmoNKXKUqvWDpE5PKX4NBS85UetwOmCEDNZHC3JRx2cf9i9pdmgkwfMyPbYTzWYc9
         fqgqHJLQPWL4Hj0iQ3ZNsEeGGNcBVAYWAG1p3OHx+8QnLEzlekEXyWsGDEtWzp9Bco
         wvGiWPVwRT3cGk/35tCT/jGXaYp4KOfiaZyJUTBRKQaoTQW3a7/BgQf4Q53ZTdc52i
         x499tyFYoFneg==
Date:   Thu, 28 May 2020 18:31:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] checks: Improve i2c reg property checking
Message-ID: <20200528183115.05b2519a@canb.auug.org.au>
In-Reply-To: <20200528072037.1402346-3-joel@jms.id.au>
References: <20200528072037.1402346-1-joel@jms.id.au>
        <20200528072037.1402346-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B8RJ8yx8LlQ3KMb_xSLNXNQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B8RJ8yx8LlQ3KMb_xSLNXNQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Thu, 28 May 2020 16:50:37 +0930 Joel Stanley <joel@jms.id.au> wrote:
>
> =20
>  #define I2C_OWN_SLAVE_ADDRESS	(1 << 30)
> +#define I2C_TEN_BIT_ADDRESS	(1 << 31)
> =20
>  static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, stru=
ct node *node)
>  {
> @@ -1057,10 +1058,13 @@ static void check_i2c_bus_reg(struct check *c, st=
ruct dt_info *dti, struct node
>  		reg =3D fdt32_to_cpu(*(cells++));
>  		/* Ignore I2C_OWN_SLAVE_ADDRESS */
>  		reg &=3D ~I2C_OWN_SLAVE_ADDRESS;
> -		if (reg > 0x3ff)
> +
> +		if ((reg & I2C_TEN_BIT_ADDRESS) && reg > 0x3ff)

Shouldn't this be

		if ((reg & I2C_TEN_BIT_ADDRESS) && ((reg & ~I2C_TEN_BIT_ADDRESS) > 0x3ff))

--=20
Cheers,
Stephen Rothwell

--Sig_/B8RJ8yx8LlQ3KMb_xSLNXNQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7PdtQACgkQAVBC80lX
0GyV8Af9F1S4vT1OP+5Ba9ZY+iXYNXYFe8vwj3rPqVNTfFjtinquTwP6Z+NhWyfP
rsRE/HeOAqyD1Pjt6KNrg+guz2GRFZ69DMMeKwidf9KNVxQbf1IHr0TP9Dhk9kiI
fbTYi5mpE/DNgfOC4HQa04kryp9Jrz/e1xNxNyi2NKQtU+h7K4AaFoayonUBxuXt
4FqIxa7i3QuRYyBuwmM+mIOf06RJJSGz18f/gLGO6Db3xQNqEY0jaEoC7c7p1Hyn
SO2DcIZpv411HXmgpCip6e8u4Lv/lCZf12mPX9t8pDkoppZuxVnl5/bmDYDMgtks
Y24XQYMY50Q5d1QG7ifIETNVwWc+Og==
=qhJ5
-----END PGP SIGNATURE-----

--Sig_/B8RJ8yx8LlQ3KMb_xSLNXNQ--
