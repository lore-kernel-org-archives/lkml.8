Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69302C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E27A206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gqdyRZJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgDAHSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:18:15 -0400
Received: from ozlabs.org ([203.11.71.1]:38405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbgDAHSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:18:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48scx04fspz9sR4;
        Wed,  1 Apr 2020 18:18:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585725493;
        bh=GaMxXD0xEK28380G3gYltCDH4MUfZ3GYqHxVk07UhgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gqdyRZJJViSabetKgIH/gR8d/PZKC3pFKcoxx390awf5m04cnKvwiO9fGfrr9Nurt
         71XQTeOv4icqFddOxPVwQ0Jnoril2qoLxsEs1lmDLNc19OWUhX1MzFzd6gMYQcOyjq
         D0EmcXEJBd6bxHq4dcBRdWDv8KNhdg/vDQHBfoCbif0v5Yp5LzDt6WT3F4Ri9DnyZE
         NfqR7hUsxSVba3hv01NAF2D9WP4X2wBb++SF+3niGzf6oilRsCH41mvC/W8uzqdZWc
         zq6kcuqdyjHGmv7gw0b8Hi9VO5k+tpjLAs5SNmPDdgEk/Viid8qt2MBYkEx5iCrcQZ
         y4EZ4lF/o00rQ==
Date:   Wed, 1 Apr 2020 18:18:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>, Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 drivers-x86 tree
Message-ID: <20200401181810.14792d60@canb.auug.org.au>
In-Reply-To: <CAHp75VdoMpA4tDg57UND5hnWXV60EGaThPxLnTpKT6wG7bdYYQ@mail.gmail.com>
References: <20200323143816.345b3d54@canb.auug.org.au>
        <20200401141113.21014665@canb.auug.org.au>
        <CAHp75VdoMpA4tDg57UND5hnWXV60EGaThPxLnTpKT6wG7bdYYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//whQZcOwmol39H8h1YR5sz8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//whQZcOwmol39H8h1YR5sz8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, 1 Apr 2020 09:47:20 +0300 Andy Shevchenko <andy.shevchenko@gmail.co=
m> wrote:
>
> On Wed, Apr 1, 2020 at 6:11 AM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
>=20
> > This is now a conflict between the drivers-x86 tree and Linus' tree. =20
>=20
> PDx86 is in Linus tree already with conflict resolutions.

Great.

There is always a bit of a lag with what I see during the merge
window i.e. Linus continues to merge stuff after I have taken my daily
snapshot of his tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//whQZcOwmol39H8h1YR5sz8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6EQDIACgkQAVBC80lX
0GznXAf/RFdYRWIAQLm/83TP8+AE92ZO2720S56gAOYFGBXncGp7xK9W6wF+e6s3
5Bha2/KyfnifWlLv+mnuJ1FlKgBP7TXdHNdWJm1ibmPYWQRLS/ufyv2hujmQlL5G
qNbmc+FNsdhhTsaqnAfCkBoWxg/ZC8DggbeBFjoiM0Y0dHu86qZjRX2tLrMzgyn7
XNeuj5/as0ZVXLGTHN3BsLdypp9vpXAsp5dH09DEqXOACm7BANvTLraz0fYAh+Ou
0GmX0j3WDCN3xan7U1u6UA2OyXo3S8D9CeHyplbHFu/wIdyVxNk6jtil+y+IsU1b
vheBiB/90jlZfYmTSwlFaXQhEs7mmA==
=631S
-----END PGP SIGNATURE-----

--Sig_//whQZcOwmol39H8h1YR5sz8--
