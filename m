Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BD9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A802078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d8HtFsfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgH0EuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:50:24 -0400
Received: from ozlabs.org ([203.11.71.1]:59767 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgH0EuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:50:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BcVf35t9Gz9sSP;
        Thu, 27 Aug 2020 14:50:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598503819;
        bh=k3XRZKjyQdR8rrlEFNPcOxcxfyB8GnsWFLVwqNTjU6Y=;
        h=Date:From:To:Cc:Subject:From;
        b=d8HtFsfMTOYRqfcfiFZMbpXcxTcJRB1lqkz7GzzmROthY4CspWwpfJ43y+YSBZ6BF
         JnIU2h8Kfkxbhz7wcAcxI4qtvZFuMXa9wOGL8xA44x7szAFp5KOaxonjCGkHlKePFO
         7u/fncx4ZOV79dmmACTR2xJKz1j7xjgucX8Bsgz4zqQ+lqKubHLLF2Tns2URpZxZr2
         blDd957iAGpi70fj9P5NZCkkUdSmJ8C3V/r1d3D1HSJwcuZKcSGBAcRJuGuk9Yg229
         WIOoUjt+aB6Oit9/xe28ToxGjZIgKOFc3ztmCEfnrEo5t8e58kDo8U6VbfIrVlinu6
         ZQVNgCcz28PZQ==
Date:   Thu, 27 Aug 2020 14:50:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after upgrading sphinx
Message-ID: <20200827145017.47c16c73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D961xeeLGddtmpIjrnMb.xQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D961xeeLGddtmpIjrnMb.xQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today I upgraded ot sphinx v3.2.1 and got the following error from
"make htmldocs":

Running Sphinx v3.2.1
enabling CJK for LaTeX builder

Extension error:
Could not import extension cdomain (exception: cannot import name 'c_funcpt=
r_sig_re' from 'sphinx.domains.c' (/usr/lib/python3/dist-packages/sphinx/do=
mains/c.py))

I have downgraded to version 2.4.3 and await suggestions/patches :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/D961xeeLGddtmpIjrnMb.xQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9HO4kACgkQAVBC80lX
0Gxdjwf/RxG6KPaKRlrdpxq9VgDfpWu2yPZF94SQldbr6CrKQh80CmI5BNqGYrq1
c2U5VNUeqMgKkYlWp+rhb48BFPtPi6xiURd2IKAR7eAeqgkvaP8A5eBdqRAXnVBZ
6TnZOn7hpiw+rLFJ/ARqo6MyBOboGfduiMY2tyYm48f/8bNnikRt1hDrPAAVZvTD
BYmQPJHQE2vPOwmynb/Cmq9Z5VgthPw70lgVpEpeoucDf8RXqQYALEaNrozxACMO
zwkQp3eJeA9T21kE6jTS0ZoFZ1gv0b6KJDMOrtoG98V4pbwPac2JE5IipHivx4Rb
TDUMlS2HjC+0/qTXQ05G2viwwmv6sQ==
=iAOp
-----END PGP SIGNATURE-----

--Sig_/D961xeeLGddtmpIjrnMb.xQ--
