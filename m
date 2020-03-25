Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA6C54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C6F206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KKwLcLpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYDIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:08:50 -0400
Received: from ozlabs.org ([203.11.71.1]:34145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYDIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:08:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48nCkS06Kmz9sR4;
        Wed, 25 Mar 2020 14:08:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585105728;
        bh=84M3aCyHg7ihqTzCAccbry4vzVPbTZx649eckN6ELtw=;
        h=Date:From:To:Cc:Subject:From;
        b=KKwLcLpuLampgN4EV3dEJKp7g6pJK8FP3eP1XLXi3lszfO9XBfV30q7hqyOscjRnk
         PIMNpfcHNbfXpwsT39YTJll77y4V3kxuIkhtUsfWK0uzLCbJemtcPcVVaD0c3MbtMb
         1cR4CWmkpLmpUyAi+UpXsbIEJ4WbBDnJo9cSCNyGw+4ohgSUmMICDlAL3Z7vJY3VD+
         iW6b2+hHoHAZsMIiICuHoKQXX6sH7oir8TXB9QIEqfJivoyDN5X3KzEQM7IP/KDqMX
         8/o8RQxIOI/0d5Ih4OJxi+gYtpTm2mNjL9J///NlJ2af1O5JWHYBNHbFVjuLKN9EZJ
         ON8py7YcU7hBA==
Date:   Wed, 25 Mar 2020 14:08:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20200325140845.5705b515@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wp3IF.h/ib6h6UGxkoT=UYF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wp3IF.h/ib6h6UGxkoT=UYF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got conflicts in:

  lib/Kconfig.kcsan
  kernel/kcsan/report.c
  kernel/kcsan/kcsan.h
  kernel/kcsan/debugfs.c
  kernel/kcsan/core.c
  kernel/kcsan/atomic.h
  include/linux/kcsan-checks.h

between a series of commits from the tip tree and the same series of
patches (but different commits) in the rcu tre (followed by some more
changes in the rcu tree).

I fixed it up (I just used the rcu tree versions of these files) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

Please clean up the rcu tree WRT the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/wp3IF.h/ib6h6UGxkoT=UYF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl56yz0ACgkQAVBC80lX
0GwV8gf9H9on3YVlkqf4Brvi8lDNPvuz4LoWpeQHixe7Ux37yLhOBhM2xupfJzKw
C0VgomwWhCZMWUh8AuIMPb9usOrulbJ8SqkvZ8NB3guWc6M3XU8quUW2ORb9v7M/
CxoulNvJmXGRp5q8+qAgZkSSg9svJkYfYSiDOCdbOgjoNqo0tAuCR3x6TQNk1jre
ZFLM21p2rS53TqjMemK+6jC3zKprkkyBrFz0+MFuVadttIFoYTclomSOSrgLsIkS
GLp8gcMzDyLbRStFa2GUZxd3GUDCntpbczwsTouxjUIX1q3R6/7LB9kWbOOPkMiS
kwh64vJRC+WsKRpY1e1b3FnaRhPpgw==
=zyl7
-----END PGP SIGNATURE-----

--Sig_/wp3IF.h/ib6h6UGxkoT=UYF--
