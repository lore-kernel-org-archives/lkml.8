Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0005BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A2B20738
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QJGu3CLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgGHDNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgGHDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:13:08 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C3C061755;
        Tue,  7 Jul 2020 20:13:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B1krw16lMz9sSJ;
        Wed,  8 Jul 2020 13:13:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594177984;
        bh=l+bxzGYWMcNd3rl1Uz5C1PGATDAm1DMxpOeCPiA0fAI=;
        h=Date:From:To:Cc:Subject:From;
        b=QJGu3CLbfvxcU7Rs5HLTw0RMTbYkGZbmuEK0WlaUbHc41TxQ/zyKNJB8Ll6G9Slls
         mBnvPKmTixbh55VNwPSEjhI+JkkSdPC1qgFafcKBDt9ZauKmB64Eg2rdkbc51WGLfR
         QoFAjKExiXfBuraA4Cn/O3bHIp0Depcx7e8dNHGtgtA9dw6gX5Zuh5lPQ4e89poawW
         wvwKfHmKoiVOQmYgJveCF1vOlQ6a/Y1cMreBReBC0MYoOjcb0BqBVO7eLMoePlU9nd
         UuamQn1EYCwrcdYNt2gH9XxoofxAIepjXJGwnPmO7BxMEzdWbDxSzxHVMaXYcy48OP
         ZohdlL/txatbA==
Date:   Wed, 8 Jul 2020 13:13:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: manual merge of the block tree with the gfs2 tree
Message-ID: <20200708131300.2bc5585b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y_/gem6CuL6FuSahpUv+EJY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y_/gem6CuL6FuSahpUv+EJY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  mm/filemap.c

between commit:

  f0091f595dee ("fs: Add IOCB_NOIO flag for generic_file_read_iter")

from the gfs2 tree and commits:

  2e85abf053b9 ("mm: allow read-ahead with IOCB_NOWAIT set")
  dd3e6d5039de ("mm: add support for async page locking")

from the block tree.

The gfs2 tree commit has changed from the previous report.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/filemap.c
index 6a6ed95e33a2,a5b1fa8f7ce4..000000000000
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@@ -2028,8 -2044,6 +2044,8 @@@ find_page
 =20
  		page =3D find_get_page(mapping, index);
  		if (!page) {
- 			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
++			if (iocb->ki_flags & IOCB_NOIO)
 +				goto would_block;
  			page_cache_sync_readahead(mapping,
  					ra, filp,
  					index, last_index - index);
@@@ -2164,7 -2185,7 +2191,7 @@@ page_not_up_to_date_locked
  		}
 =20
  readpage:
- 		if (iocb->ki_flags & IOCB_NOIO) {
 -		if (iocb->ki_flags & IOCB_NOWAIT) {
++		if (iocb->ki_flags & (IOCB_NOWAIT |IOCB_NOIO)) {
  			unlock_page(page);
  			put_page(page);
  			goto would_block;

--Sig_/Y_/gem6CuL6FuSahpUv+EJY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8FObwACgkQAVBC80lX
0Gxjtwf+OGinXBr/kjjonhis8Ru+rYd+eKn23cmrqZhib794Nvwup9QLoAqxtOWs
t/ktzEB6kJY9dgJY95QuaE3qSYPYvTdnYkL/D5mCo1tcJptbgVl8ZMIbPsVgicd+
5LoKNKJWpZ1BkjL6zbYhewKPhin3fCA9mSb61Co+Q+TV4Fe/IBQKM3pQ9l5Zw6bK
LCYeOpCdW1L9RDCFsHlnRlRw9GGuSXOc8UmA4PGi6C8ggb7zLv98JZYnpjsabWuK
NXCyd1wrpuaqGS/pDZBb0kkvcSP5nztmb+Plx2QmX/eFlKRH9WxPfclzX/nYjFbY
IlwSJZ0GniiF3MgRYN28sfLFsl3Dpw==
=E/jX
-----END PGP SIGNATURE-----

--Sig_/Y_/gem6CuL6FuSahpUv+EJY--
