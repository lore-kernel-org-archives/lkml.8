Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95756C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8502070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZPCV0HEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgG0Nye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgG0Nye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:54:34 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8664C061794;
        Mon, 27 Jul 2020 06:54:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFhBJ0X94z9sPB;
        Mon, 27 Jul 2020 23:54:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595858072;
        bh=RnY2bmxZCaMj2sq6R8j9Kiu19OP6YSL8pnxUOMPEECU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZPCV0HEmPdAgFm2cOrrnNfhPzq6NADZ6Rw8hiynji92a+xzclHBL6SiOlAE+RaadA
         Q1Tt36wAFzlJbiyB6AM7JvDKLeenc07zH0U+AVy1t0XPAUracV9iIG53SUEDP4SVJo
         EZ7Ge+r2lyggk6WeU9j3Inx3WujqRDaal0rDhS7pnTRpKj3Saqo9NjH63tUuWRidfm
         pJBELbWRoUPdz4b8lRn1RqhsLee0V9sFVfHZQe04WuWb1P2OUm3O3SyVg3eFUTF8NJ
         j4BkYQt9u6/Od48XF+y/ecgroVd0HfjcbNGIKBsupYcdIMbm11CxGZdfuFyAZ0ayrs
         WLyJuGFl7Ibeg==
Date:   Mon, 27 Jul 2020 23:54:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm tree with the fsinfo tree
Message-ID: <20200727235431.01e77f03@canb.auug.org.au>
In-Reply-To: <2814724.1595856998@warthog.procyon.org.uk>
References: <20200727224626.463ffeaf@canb.auug.org.au>
        <2814724.1595856998@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SaNcrhBiXwrPH+HtcbX0zF_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SaNcrhBiXwrPH+HtcbX0zF_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 27 Jul 2020 14:36:38 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > The notificiations tree has been rebased to remove a new syscall and
> > the fsinfo tree rebased on top of that, so the syscall numbers have all
> > changed again :-( =20
>=20
> Would it make it easier it if I just left a hole for the syscall I droppe=
d for
> the moment?

Not now, as I have done the necessary updates in the akpm tree.

Unless, you think it may come back and go away again :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/SaNcrhBiXwrPH+HtcbX0zF_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8e3JcACgkQAVBC80lX
0GyAAAf+KJ0bsLhlsNposebk/zJ2tELWAU+jBuVyxyExulbsF57Xg9lfa5oCTs9i
ZniUYKhdz8ggjqUbpAFEp61Q8fHXKlvBXd5f+Cp1Hxy3QuWD1+WpX79qTj1ctISu
jzUt1KtQjE60faOale16DcII51lKLKi++t3ZHvWsdPW7p2P0c9WlVYYtk2MKWkrH
UL3POeL/mL+aqGRZNXiXbs0Pyzc/6eHBPwUGMaIa7KRzEDCB1QOjmuIq5808XI8g
+hnTf0FL5o0fC6FPHr9t3y56tKkczX9rnEawOcZAPCDidtjG4Tn48fc/LT6ckWx6
9BIiZUh0moHU9Md9MFOoaDR6I/B0Tw==
=k6dQ
-----END PGP SIGNATURE-----

--Sig_/SaNcrhBiXwrPH+HtcbX0zF_--
