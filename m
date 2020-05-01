Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B321C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A60620757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H21fGJg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEAAY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:24:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgEAAY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:24:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49CtLH0qsJz9sSG;
        Fri,  1 May 2020 10:24:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588292696;
        bh=2zzAFv3zB/fa2STEFwr4KC6VTjy3v4D10Ec7PDKbu3k=;
        h=Date:From:To:Cc:Subject:From;
        b=H21fGJg3T+kdkp66NjMxzFbJqv7brsM2TUX2lvBHr3BXKs+Ml71bfaIGU+pNvzQCG
         jJcrd2qRuIfJ9Ha40fXQ+6+Jv/f9lo/YvnKpLma4BaTe9/9n9b5kmJxAJSkwW7XNgp
         EZRsQeB2UeIBUAVa5bawmJkxP7KkCmAAipW+JREEqBC/UYYk1d9scQiGZMxjQPwetL
         I6S+Lmhv3OL15RsbPWaBO8WX3Jwap7VErngYfYYUDSyjKblZs22sJZvmVexRCcteaO
         Du1Z/GVzjXnIFO2Eu7r69YUdrfBH4pxWJXSuA5fxFHLCiogR1FN0lM1wCy3+tPvA2Z
         Rn2ntVThRJYqw==
Date:   Fri, 1 May 2020 10:24:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20200501102453.4b80d290@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yte3s_M5Kdj=Sxjb47zP7MD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yte3s_M5Kdj=Sxjb47zP7MD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/transaction.c

between commit:

  fcc99734d1d4 ("btrfs: transaction: Avoid deadlock due to bad initializati=
on timing of fs_info::journal_info")

from the btrfs-fixes tree and commit:

  f12ca53a6fd6 ("btrfs: force chunk allocation if our global rsv is larger =
than metadata")

from the btrfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/transaction.c
index 2d5498136e5e,e4dbd8e3c641..000000000000
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@@ -666,15 -674,17 +672,26 @@@ got_it
  		current->journal_info =3D h;
 =20
  	/*
 +	 * btrfs_record_root_in_trans() needs to alloc new extents, and may
 +	 * call btrfs_join_transaction() while we're also starting a
 +	 * transaction.
 +	 *
 +	 * Thus it need to be called after current->journal_info initialized,
 +	 * or we can deadlock.
 +	 */
 +	btrfs_record_root_in_trans(h, root);
 +
+ 	 * If the space_info is marked ALLOC_FORCE then we'll get upgraded to
+ 	 * ALLOC_FORCE the first run through, and then we won't allocate for
+ 	 * anybody else who races in later.  We don't care about the return
+ 	 * value here.
+ 	 */
+ 	if (do_chunk_alloc && num_bytes) {
+ 		u64 flags =3D h->block_rsv->space_info->flags;
+ 		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
+ 				  CHUNK_ALLOC_NO_FORCE);
+ 	}
+=20
  	return h;
 =20
  join_fail:

--Sig_/yte3s_M5Kdj=Sxjb47zP7MD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6rbFUACgkQAVBC80lX
0GzCvgf8DJ2YK1vRdeGMxyY/JY8M46pxi9LQWTvwVrpZ2AK1FZNMyxFHYApHgpTk
I0JSMfut8zhkgR4ato23C+vYqIlxN4J/RfRj9q6PmyN7mxKGXQtbGvdpEnP254DG
7fDASQWzoPpB4AUxrWh+D8wAArNwUxn+tgV4Ljtb0JrOUvKcOyR9pPiZdjXOVgcB
cPXqgbniNj8tSlIi8osz/BFV+Luz9Y6j57+Oy9BXbygazVilyK3/wmSEqyKQ/lJi
JsoRMju2W3rc/VqdGmQpA5hpOf/I9w8n+y3qTO7ytsgq3a/Eho63bz8ZeytsXbQn
oIS2T5+erCQV7JgVyA67nvvC1C3l/w==
=841x
-----END PGP SIGNATURE-----

--Sig_/yte3s_M5Kdj=Sxjb47zP7MD--
