Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC78C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DEA20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mLpjo5WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHMWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:07:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgHMWHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:07:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BSLJz20Jqz9sTF;
        Fri, 14 Aug 2020 08:07:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597356436;
        bh=O90B6lPgDbctD7DTLOixetS5SEhrzQ35jkHhZCRy+/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=mLpjo5WOrz0/70Oi8Dx8l/LlsKMCkIbWO/zb9uPqVzRXkHS5/AinqEXnOpZmQ3DqT
         cqWyeDAM/IkyrRqP9654DnFlAofd72coChEsr68RAJ3M+LW32CLgtmjoCKTgAmIWns
         BQKpojE9XgIGI8T+H1j0ZWvNGYjepuRJtuYisb2iJpQ4T4Wq6w21rIm/UZsLI5LjWO
         /at+uZOZnX5eSmClgc/7waqIJeLaCSVJ+0S51kImQsdo39/xrDFFFHiuMBVmC6ILE6
         c++oFnx4RfmYGa746f0OWCQ8mWeObac6XzNzIjNucweLEFZAVXoLLggkOR+brchABw
         OSnr4YqCVH39g==
Date:   Fri, 14 Aug 2020 08:07:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: linux-next: Fixes tag needs some work in the xen-tip tree
Message-ID: <20200814080714.6aa441cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MhZ8wxdqyR2_58Uq9lvmpR4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MhZ8wxdqyR2_58Uq9lvmpR4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  14dee0586104 ("drm/xen-front: Fix misused IS_ERR_OR_NULL checks")

Fixes tag

  Fixes:  c575b7eeb89f: "drm/xen-front: Add support for Xen PV display fron=
tend"

has these problem(s):

  - missing space between the SHA1 and the subject
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display fronten=
d")

Also, please keep all the commit message tags together at the end of
the commit message.

Not worth rebasing over, just to remember for next time, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/MhZ8wxdqyR2_58Uq9lvmpR4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl81uZIACgkQAVBC80lX
0Gx0EAgAixJH9UPNrwekGE13e/05L03RxpI+G04md3cJ2kk44qGeGtK+qiTjHpZh
sPsD4q2b4tyljqbRo8x3G3Z/ekS1t/a324NznDn9fAfyEY2ZHsqjjm4E+szpYINb
v720/bnq6/hQ+6chniPGufY7Cv/ZRcw7DRT10VWHeEV+HIH2RuHiUdVqX4cHKtGj
mH6Yn+x9MoT3XxoBngmMwCDTaBsmCbw1tQOVF1eW6/OelD6cX9fvXmh+O0mZNDo+
NY85c2zvgyPqB9+9pQiErAmhTDDJvqDryIKgjGeV6jhPTb1hp+smfuscho2YZjDP
ewBtoupmn40opBvAvUQM02PXx8LpNA==
=1asd
-----END PGP SIGNATURE-----

--Sig_/MhZ8wxdqyR2_58Uq9lvmpR4--
