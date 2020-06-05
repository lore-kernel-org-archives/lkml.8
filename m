Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C17C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A3B207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CrEYqaqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFEGCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgFEGCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:02:51 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB14C08C5C2;
        Thu,  4 Jun 2020 23:02:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49dXB161NMz9sT8;
        Fri,  5 Jun 2020 16:02:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591336970;
        bh=anx3z5h2d0G8sMfBUTI50AEh/Ayr6FHMV9G9yOXzx/A=;
        h=Date:From:To:Cc:Subject:From;
        b=CrEYqaqJqxrv8ApLzbEdYXdVbpnMXjAKSBxFxrPh7GEPTQrCLQ0iqH/qWLVBSLGlA
         Q9Z6pRUzgwT1O0+OYEaQPqyjXOwCvcBYO5dwpYk7NMLur9bZVfMqkDP3W9+e+Z5hzZ
         c1BaGtJ73wTH6B5z0GimpKwu5UIuTOv0oF6HQK3TTQzxXprASq+FCE2V1xb5uVjFBb
         eHgs5PuWlF/40DfH14atScUQfW5yWzEz/jjRXDGbKZ2iFqBZtwEZMvD8xbTTeXe4TD
         C3FThUwL1jK8kNlTiyAr+YVLLILeiCUDWI4A/q/4zb1Uposlr5StNKEd+drMUiGUOq
         dCPHN4Mu+cHMQ==
Date:   Fri, 5 Jun 2020 16:02:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rich Felker <dalias@libc.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: linux-next: manual merge of the akpm tree with the sh tree
Message-ID: <20200605160249.0db09812@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2mVmru75hDPIlkzZdTfVif0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2mVmru75hDPIlkzZdTfVif0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/sh/include/asm/pgtable_64.h

between commit:

  37744feebc08 ("sh: remove sh5 support")

from the sh tree and patch:

  "mm: consolidate pgd_index() and pgd_offset{_k}() definitions"

from the akpm tree.

I fixed it up (the former deleted the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/2mVmru75hDPIlkzZdTfVif0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Z4AkACgkQAVBC80lX
0GwETwf+LnNmFjrlvR5UvjnsmjgsSa81vKXjzYY3gfgfSQnYtoijToHqHJ97NM7m
LZxI+49QMAtd2F8xb5kRd+uola2qHMaNo30P5tIgG0gzMKO4rpoeKkFBIE5t+FS5
fkh4WsfSdCc5itvLZFADMPuMXvUFvY8pXzve4XCh1dY/r53FVpjlyprbQ4uSoYNb
U/l4LZzQUxZ3D+nqXxPn+2PelSSbBRZ7mk+AxXSR2GI+jMHnbroKlJX+12MxM3Uz
OqxRxD9xLACRYKf97j5DBFLacosRC9uPfqt61aXWqwnrzc3Dk3kD7mpBM1Dy+Yui
6G/USLwYKYisUJ3VsAbbeo3bxenMnA==
=UMoY
-----END PGP SIGNATURE-----

--Sig_/2mVmru75hDPIlkzZdTfVif0--
