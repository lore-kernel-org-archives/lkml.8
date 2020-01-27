Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A26C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD66324679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oLzZhzWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA0WvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:51:11 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53919 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgA0WvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 17:51:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4864jR5fKQz9s1x;
        Tue, 28 Jan 2020 09:51:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580165468;
        bh=VSBkhr/XLsXrgaXpHr5fE7Rgrri0D0nkVh/o94M42zw=;
        h=Date:From:To:Cc:Subject:From;
        b=oLzZhzWW4rkrHJWBAqHgX0dSCETYzx3lX24WDUcilzzglJNZVLpwtks7Pk3slZMNS
         4CjJ6SVknU8bF+hePn9di5ARUoYL3hlSfiK5rBSlnAx8eWhRLLH5ZtQVEcrlqXg/+l
         nTQH5IZj6ZYmb/UIM+ykhEGBFVQAgmLggsB1QSr15ypnol5tyy8I62fynXWPrYZMVF
         xa4US+OMB5PmI8Jlp7ztwYDKPagOyK1cJFIjZLQX3OmlmqYtcnbC5mzEVvCYtkjKTT
         xkYaXoMTt3UOoYS88ufYFLpJT4od6ynb/i7LrYh6UTjTLC3F3zVAy90k1ratjBbjkd
         LVQj+o3ru9GdQ==
Date:   Tue, 28 Jan 2020 09:51:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: linux-next: manual merge of the vfs tree with the ext4 tree
Message-ID: <20200128095101.717dbfa5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gLig0MvwziaJrhE1YADxWrv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gLig0MvwziaJrhE1YADxWrv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/jbd2/journal.c

between commit:

  7f6225e446cc ("jbd2: clean __jbd2_journal_abort_hard() and __journal_abor=
t_soft()")

from the ext4 tree and commit:

  79decc2b6ea4 ("fs: Enable bmap() function to properly return errors")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/jbd2/journal.c
index 60bf8ff78913,01fa5d247e39..000000000000
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@@ -804,8 -806,12 +805,12 @@@ int jbd2_journal_bmap(journal_t *journa
  					"at offset %lu on %s\n",
  			       __func__, blocknr, journal->j_devname);
  			err =3D -EIO;
 -			__journal_abort_soft(journal, err);
 +			jbd2_journal_abort(journal, err);
+=20
+ 		} else {
+ 			*retp =3D block;
  		}
+=20
  	} else {
  		*retp =3D blocknr; /* +journal->j_blk_offset */
  	}

--Sig_/gLig0MvwziaJrhE1YADxWrv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4vaVUACgkQAVBC80lX
0GyhpAgAhfN8oLodgM9bJPkzAjDpFViA9WnmDyx6Ye4OdwnuX4eau/SIwjkexoRD
eDn2Mxu9jcUlK7FwL3QUAHg713eC2SY76CAJUB38oseCZUFjri1Kx3+mFS1MIdCZ
MEYBl2FtRnBpwOScdNSjh3dId6gWo8MRZwa3e6oTQwF1OXd4d8Hy5Kzai1r0awKU
Jud4ssLQfpqxnPjtFpmGbZJZYBwSvqdGYMcyPCFeQfVgC14z1mcllZgiVpsk9EFY
KxfNvjZHhXnG9IuNHD3TP2roYmofOVYtpq2xdEvif7pGU1UD45QJxgXSJKHySlX7
xtIwPLLv3RiKUKnNSlfC3MvGsyElMQ==
=/vkD
-----END PGP SIGNATURE-----

--Sig_/gLig0MvwziaJrhE1YADxWrv--
