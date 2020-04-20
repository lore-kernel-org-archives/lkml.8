Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFCFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040F621927
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RlbcNgDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDTK6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:58:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTK6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:58:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 495Nvm68wdz9s71;
        Mon, 20 Apr 2020 20:57:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587380281;
        bh=In7P5lUxwxjq5S0YwYME09XhaindlH+KaUGIeqQBNNY=;
        h=Date:From:To:Cc:Subject:From;
        b=RlbcNgDkEM7P2Q389cNtiz5qIu5KLpcxu0eLHqNAyjUkRstv4eQvPVoI2LMH3pHqj
         PIdfOeE+ITNOkgamYOd3OOOdu8txP1oLz1Pr19Uc6OqAhmzF6CJYR+relD0QAnJSzN
         Y9R3WYys7PgAKktpVIHitd8yrahfNrJbud4XG3VkmVdA4rgmEBOAy1/tc8bYRzAiq0
         qZZrccb8nDC1tfY0i/IuhP87QrKCM2CWl8dEwW9Jk771RxG/ueyToF8Nv1glBxTGWr
         b7ebQpk6pkGGTIiz/z7DMcvHX0NELIlIxU6iDqflw572wtW1wTjekqn4vaqJFlFm1U
         K3o2zcEdrU6Iw==
Date:   Mon, 20 Apr 2020 20:57:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antony Antony <antony@phenome.org>
Subject: linux-next: Fixes tag needs some work in the ipsec tree
Message-ID: <20200420205754.05be65d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hmE/pnI8Xp9_Qtkuyl8J+QT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hmE/pnI8Xp9_Qtkuyl8J+QT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  29e4276667e2 ("xfrm: fix error in comment")

Fixes tag

  Fixes: d77e38e612a ("xfrm: Add an IPsec hardware offloading API")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/hmE/pnI8Xp9_Qtkuyl8J+QT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6dgDIACgkQAVBC80lX
0GxpTggAjL6lcrQOHac96eIrv0JHc2MDzoHbuHIuytmsG0fPdO43U6LDIgBcsj53
AoSybH/HrFuw927eRIzj34CwetKVTnGcd+CBuDPI6DGZO2zX4OQwMwcGLS5e9Ux+
is59dtkhbt4Z6J/m6SAUnukMRfj8poYLHGT7YpOauG29XRDxtI2ULdWUsWjVrAgS
NoqMOfh1Ex91uZHvbJh7qkPIdDW7oEHf0ZTjLojzdwImWSWaOZyYTosImvrtK6yY
dAweqzyby0wF1OAbgElPEMqZetfQtN9pEs8eAAFCCPKq6xdJVw96iLNuK0J74DLM
rr2OeV9BYKfoM+xlv9pc8EfgKW2BmQ==
=IBXf
-----END PGP SIGNATURE-----

--Sig_/hmE/pnI8Xp9_Qtkuyl8J+QT--
