Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D763C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0373D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CEc4ffcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHSA7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgHSA7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:59:06 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF223C061389;
        Tue, 18 Aug 2020 17:59:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BWTtr0fKMz9sPC;
        Wed, 19 Aug 2020 10:59:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597798740;
        bh=4R1l+tyt/uWsbFfdfD+Jzgkl29sH+Q8avz4jxgvUAL8=;
        h=Date:From:To:Cc:Subject:From;
        b=CEc4ffcUgv1ty1ksdgmGcXWPNoP28NcYWch+tdVe8YVDJQJmRhV/jbVQFK10Y6DdV
         FJH1wAY5/PQEcj9rm+DlDOo3LYJmPYRNsqzSYIa9yZQ4VyytQdgFvmOMfRtz/Q9P64
         Rw3tA0LyG4ryunya/qgI6hr2N2vRwS39ddB+XGFTY++5KUD26KLv1Fu+/kHR03Qv7s
         JkEcJONzIRZpWHa0UxhT9ciBllR3yROcRUnS5mh43Jk4ob8ZkDm/C84XO02CJMktHQ
         HIhVj3hK+dKTOFsHNSHYtj6T5n0qsYoaY/ZYrN+nfxcIFUoPvbbHPtshBjTJCUsP3o
         PZtPkNr2CUh/Q==
Date:   Wed, 19 Aug 2020 10:58:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: linux-next: manual merge of the v4l-dvb tree with the kspp-gustavo
 tree
Message-ID: <20200819105859.53cdcdf0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=slSg9.PwmHiVKvdH5KEsDB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=slSg9.PwmHiVKvdH5KEsDB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb tree got a conflict in:

  drivers/media/platform/pxa_camera.c

between commit:

  58e813cceabd ("treewide: Use fallthrough pseudo-keyword")

from the kspp-gustavo tree and commit:

  ebb965acddac ("media: pxa_camera: Use the new set_mbus_config op")

from the v4l-dvb tree.

I fixed it up (the latter removed the code updated by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/=slSg9.PwmHiVKvdH5KEsDB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl88eVMACgkQAVBC80lX
0Gzodwf7BR7rFKoYhNqEzxnqG7DLwsDHkFOU/ZM6edfs5NJ8gAviM3jE0tm6lUtU
c9ssCZXmw2CrY4sLxpT4zDC3gB8CrMaaxJHVJd6k09IbF0Y4uxNFi8u346pgtuIx
bYOtGe+K86igz5JMHia6PtEFdZJwIGoXYiLq6WmuThpfxmwYl+NmxBtSLujmeft2
tc9YIG6Wo93MY6AxKSgBdVaawdnvi+yGqiwr8ODUO2j+X37nmmaWs9WXbVrDj4gc
lftvLHuVxwMkqPS56Q63TITw7jfhk/JtajDBJ1PpjQQN6SmmI3oA1WA1WjW0bCvx
hsmDW5lCK/4BByJpIuj2fdGOTPUXaw==
=yqhO
-----END PGP SIGNATURE-----

--Sig_/=slSg9.PwmHiVKvdH5KEsDB--
