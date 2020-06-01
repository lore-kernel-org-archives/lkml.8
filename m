Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B424AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8475720825
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UYb0Cmt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgFAXMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:12:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgFAXMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:12:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49bWDL5vz6z9sVl;
        Tue,  2 Jun 2020 09:12:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591053171;
        bh=LzS7nuY8BJQmxYHS+02GTVSxFCtHF4MXmeusRwGayMk=;
        h=Date:From:To:Cc:Subject:From;
        b=UYb0Cmt+OCZxL46OZ0a5NL4zEBC2t4kv/bmaP5c/H2AyGtxaE1dXbjjDrlJbJQIzP
         KlHtpKnPFEsUUSJeFsMF5IRLJMmEf/P96uKNh8FmzxgtH6YssuVbs+8oufS5XG8eiI
         bT2cDaWzCpmjo0gtNvdEtxdjlRRbbfjMQYtCv322plNtPqz6+dIM8MiQsci5hk77YB
         T7iwWoSXlIUxOqcPsRbPssv4g+wUnWTG+D2Ev0dL9n/z5PbD5zoCrqOM5rBjKWUZEt
         9uIgSY4n92bPFrvJHH5ZBDWeUTgyoMNOPBAiq8BguzQdmLaiecGX6ECzycPhFY6BEj
         8Jn7edXDS4VvA==
Date:   Tue, 2 Jun 2020 09:12:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ayush Sawal <ayush.sawal@chelsio.com>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20200602091249.66601c4c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2Ibb4YXMdSz33=52mhBDgso";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2Ibb4YXMdSz33=52mhBDgso
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  055be6865dea ("Crypto/chcr: Fixes a coccinile check error")

Fixes tag

  Fixes: 567be3a5d227 ("crypto:

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/2Ibb4YXMdSz33=52mhBDgso
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Vi3EACgkQAVBC80lX
0GzU+ggAhEH96xVlcyX5yFI48YhPi26kZU6W85Q0lkFlcF/nQHDNaILsmW3DKure
PqG7vsGgdURPP5kBFPWqZBsFONbLVPcpIKUAUNTXUuwZPZpxxq+Pa8kEpymod+Z+
6qPGgS311eguAw2gg+FAe4B1bH4bNoHebsZks4/3eadqHc/MubvnTs7f4CvhH4v1
JuyQiaU4n+j8/3pOWEasRiHWMoYpgrRhYaKlDNKlPhssKEzrPHnCSkC8wYHXq0RV
iYfkDNiqt0MoQYk1Y4GPVyTVrzasC1Qg4Hmw66bPqjMoMTZoPpSGZtfNgd5M5ZwI
o5o2N9CZB24SbM3gWAnZgJF9qQiagA==
=pFce
-----END PGP SIGNATURE-----

--Sig_/2Ibb4YXMdSz33=52mhBDgso--
