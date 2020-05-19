Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1465B2081A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgESMTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:19:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48724 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgESMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:19:09 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9EF7B1C0261; Tue, 19 May 2020 14:19:07 +0200 (CEST)
Date:   Tue, 19 May 2020 14:19:07 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 41/80] netfilter: nft_set_rbtree: Introduce and use
 nft_rbtree_interval_start()
Message-ID: <20200519121907.GA9158@amd>
References: <20200518173450.097837707@linuxfoundation.org>
 <20200518173458.612903024@linuxfoundation.org>
 <20200519120625.GA8342@amd>
 <20200519121356.GA354164@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20200519121356.GA354164@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-05-19 14:13:56, Greg Kroah-Hartman wrote:
> On Tue, May 19, 2020 at 02:06:25PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > [ Upstream commit 6f7c9caf017be8ab0fe3b99509580d0793bf0833 ]
> > >=20
> > > Replace negations of nft_rbtree_interval_end() with a new helper,
> > > nft_rbtree_interval_start(), wherever this helps to visualise the
> > > problem at hand, that is, for all the occurrences except for the
> > > comparison against given flags in __nft_rbtree_get().
> > >=20
> > > This gets especially useful in the next patch.
> >=20
> > This looks like cleanup in preparation for the next patch. Next patch
> > is there for some series, but not for 4.19.124. Should this be in
> > 4.19, then?
>=20
> What is the "next patch" in this situation?

In 5.4 you have:

9956 O   Greg Kroah =E2=94=9C=E2=94=80>[PATCH 5.4 082/147] netfilter: nft_s=
et_rbtree: Introduce and use nft
9957     Greg Kroah =E2=94=9C=E2=94=80>[PATCH 5.4 083/147] netfilter: nft_s=
et_rbtree: Add missing expired c

In 4.19 you have:

10373 r   Greg Kroah =E2=94=9C=E2=94=80>[PATCH 4.19 41/80] netfilter: nft_s=
et_rbtree: Introduce and use nft
10376 O   Greg Kroah =E2=94=9C=E2=94=80>[PATCH 4.19 42/80] IB/mlx4: Test re=
turn value of calls to ib_get_ca

I believe 41/80 can be dropped from 4.19 series, as it is just a
preparation for 083/147... which is not queued for 4.19.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7DzrsACgkQMOfwapXb+vJb2ACglnpWTOFVsrEVvlkVxMWeJZSG
F5kAoK+QLdn4SjARq123iklM6CKMTQKz
=cmmv
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
