Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C3DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB822B48
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nR+RD2hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgG3C7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:59:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgG3C7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:59:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHFVd2QzRz9sR4;
        Thu, 30 Jul 2020 12:59:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596077945;
        bh=4mCVNzof32ENbznJmA/smGybo47PtWuzbXw60FX7K7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nR+RD2hvbudtG58WWmODlBSKtnYRaPYOe31YM9sD3anyATpq50kKdO65pjRkiadyq
         5xoZyc1NUTai4nBBaA9Po6/kgtCZTl/c3RM28DtqYXmZhO7X+ehcXRxzDCeNz1u5d8
         txf/S4sGm7XESWaEFqfZka6Y7NfuR3eqlF/9AJK8o6viBgX2Mi8EPm1mn33XWgK/2H
         IPa2zaX3ACsnDWfduw1kUaGg2o58pD0y0MMqikHh1upTZbVyeZpNfkMaIz+FyJEu0N
         6/APbrOaPV4zUsLD/4S1nYUcVxqZQGBjsBU8K7soHRiixkWXCMUxcWtKa6+sXkALJG
         dW6Tcv1dmV89g==
Date:   Thu, 30 Jul 2020 12:59:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Morris <jmorris@namei.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the security tree
Message-ID: <20200730125904.4d20b4e6@canb.auug.org.au>
In-Reply-To: <alpine.LRH.2.21.2007301233210.3625@namei.org>
References: <20200708140034.546298ff@canb.auug.org.au>
        <20200713120419.33cf7a87@canb.auug.org.au>
        <20200730093500.334c56cb@canb.auug.org.au>
        <alpine.LRH.2.21.2007301233210.3625@namei.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LW_h+4MxPn8UErcYVod6_j3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LW_h+4MxPn8UErcYVod6_j3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, 30 Jul 2020 12:35:03 +1000 (AEST) James Morris <jmorris@namei.org> =
wrote:
>
> On Thu, 30 Jul 2020, Stephen Rothwell wrote:
>=20
> > > I am still applying the above patch ... =20
> >=20
> > The merge window is coming up fast ... is anything happening about this
> > failure? =20
>=20
> A new patch is coming, but I'm not sure this code has had enough review=20
> from the core VFS folk.
>=20
> Please drop secure_uffd_v5.9 for the time being.

You just need to remove/revert it from your security tree
(git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git#n=
ext-testing).
--=20
Cheers,
Stephen Rothwell

--Sig_/LW_h+4MxPn8UErcYVod6_j3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8iN3gACgkQAVBC80lX
0Gw/4Qf/V/2Hbkji5AM7i6R6i9dLO/xrVd2ALFCZZeRejaV0kEIpEpmujf6/09FF
WZjiSGF86bIAWnF2pNJUgdHAxkPuHk9Tj2TtO5Puxd5iD6ah5aCJWKglQdW23dt3
vizkIKfSgdsOLm8hDM6ZUtZuMOiZDoXirzZyecqHAxLTpaTchek33UDuI7H6ueFm
I5njilovu5b6H6uLfJd5V7XvHyWW3NGefgNKLk/79BB4oHZurwOAmeu2F/nAO4Af
mix8/5U7BdeBxGocib9RtLBiLRbM/NpN8JYGWAeqQt/NcoynYzmS99DP/lciZ7iM
Pn/SKVooz8FKGXnMQnd1lr8p4/xAQA==
=xH+w
-----END PGP SIGNATURE-----

--Sig_/LW_h+4MxPn8UErcYVod6_j3--
