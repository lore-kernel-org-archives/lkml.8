Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD08207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A5Z+llWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgFCHnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:43:00 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801B3C05BD43;
        Wed,  3 Jun 2020 00:43:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49cLVS5Jrqz9sT5;
        Wed,  3 Jun 2020 17:42:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591170177;
        bh=IckQhhES8zBib6U8gKLAIsAkLyYn3U8IcA3AvL8JLVg=;
        h=Date:From:To:Cc:Subject:From;
        b=A5Z+llWPwu3EG9ASOwmgmhAFl86SwwrPO+QKJQUfO+EF2k4LUIiCvp0Cs+CgIg8tS
         s23Qc0HtktBOlfc/Gl74IcK3yR++DdNan714R3sfafqc1JzES6bzJ1pHqtAsoxND04
         aLntPfV5VnrI3UlCj2EyX2rgp90LRcR4O9fBR5z5aqUfJ3vOgpjNtegUYBslxJsX18
         Ptw0Rx6RFKelaexqX/QYG4TMNCfixoPWWsscruMXBXsE1ouiSEwxJhED3tAIO3aDMR
         7Mv8Rwv/8SXmjFQunDjqVoueD5bN6OM1eg2qzM3Lj10BWGU+kSw1pB2hvWzAYmbmuM
         cj0rdv1pbTljA==
Date:   Wed, 3 Jun 2020 17:42:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: linux-next: build failure after merge of the ftrace tree
Message-ID: <20200603174253.60deace5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I4R33YNDdItszcPI1+o_FA8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I4R33YNDdItszcPI1+o_FA8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (htmldocs)
failed like this:


Sphinx parallel build error:
docutils.utils.SystemMessage: /home/sfr/next/next/Documentation/trace/histo=
gram-design.rst:219: (SEVERE/4) Unexpected section title.

.
.

Caused by commit

  16b585fe7192 ("tracing: Add histogram-design document")

I am running a slightly out of date version os sphynx (2.4.3) ...

--=20
Cheers,
Stephen Rothwell

--Sig_/I4R33YNDdItszcPI1+o_FA8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7XVH0ACgkQAVBC80lX
0GxOJgf/cZ3x5I2CZOftdgMzisJiYOLJUgvO16mEn6nH5D30C9j+KMgNjprGWJTB
whmDNyvRu7T6kefYC50eUDYP2/JsVgxcZkKvwA5BDebx7+asMV7mG514zoBbKu7u
VgJtRNp1XQLAbAm9KBR0csPqnVgOdM6QBjY/TP0mrEjXFN+6tvJFwnGH5CuuX7sL
vcGmEhnstBNlPt9ir+PKYu8IVkkLYHGdzJiFSWERHQc6MMqkqQ2HLog6fUqORATV
g5c/JAL1XZfA5aOB5Oq6DBbN0r1t6F2T8LOlUt9XEVRAlIXlM4juyOH1/szxTbB+
6Z5WT3k1z/sKPDMuTep6TwMG+3/vcQ==
=Y4B+
-----END PGP SIGNATURE-----

--Sig_/I4R33YNDdItszcPI1+o_FA8--
