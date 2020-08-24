Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E0AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6E92067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e6ZtLOXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHXA4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 20:56:14 -0400
Received: from ozlabs.org ([203.11.71.1]:44479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHXA4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 20:56:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BZYbG3hd5z9sPC;
        Mon, 24 Aug 2020 10:56:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598230571;
        bh=L5t+n4JGDroWkDNI4OlDTo6emTnCBirIO23wR0myZYg=;
        h=Date:From:To:Cc:Subject:From;
        b=e6ZtLOXaccoW44ZpbE7RSfSGjV4rvkwSOw1fvhSU7acMV71bJSLKv3yJiP613FKQs
         JIVA8bCh5TdunoPam3WzGTO4w10hor40KrDkSExrvvdFxgAa6UctfqLjt3co+RsZn+
         7UeoT7Y8Pr/667svUj/lNgPqHyPuEE6WVX8/vn/IMGPp/HaDI/1vTJhpXq9tJB+cfY
         n0dYiOcW6cwUliBYCalIvKPA9+y3IOcyjpnzeOG90iUNbXL5RmEV2I0F2czsWJAeEr
         xqOquzZPIs8VZ1sUcoE1mgEJW7+rPYrP/3WWKciFdIuF/vzFBj9CkIOUV4N14noVXM
         8UkWnPL8PvtHw==
Date:   Mon, 24 Aug 2020 10:56:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQt?= =?UTF-8?B?SsO4cmdlbnNlbg==?= 
        <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>
Subject: linux-next: manual merge of the bpf-next tree with Linus' tree
Message-ID: <20200824105609.0e54b498@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BKQ+mydrAeI5zrOaN145QGT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BKQ+mydrAeI5zrOaN145QGT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/lib/bpf/libbpf.c

between commit:

  1e891e513e16 ("libbpf: Fix map index used in error message")

from Linus' tree and commit:

  88a82120282b ("libbpf: Factor out common ELF operations and improve loggi=
ng")

from the bpf-next tree.

I fixed it up (the latter included the fix from the former) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/BKQ+mydrAeI5zrOaN145QGT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9DECkACgkQAVBC80lX
0Gz34AgAmXbSB0tOZMp04iBVJvqUxGEoUReGeHbQLAW/JgqgDosvK8KkOuSQa6dp
sdUMwmLKogPq1iPFI9AmumHNKvmHVqs5I+zNV5KESi4K8yHBeYcENYS9SsQTn4G+
/4wMZyRFtdzVWLJVsKqMPAfzPuEvjB5Cxq7tksfWs3FAcVNDeDzIiRChfbiWQ68L
K0RJ/Z/aM2kMb+2dCv2haSP0RoGeDQw5Mx94bwbbLWh/c7UFiQVqbKbLXhGq0WKK
m5cgYcZl1zUbiUzdmrLFsZpt1BAhujQ60+AFZLSw4hyDg/6/YYnuKV+pg7oPwmEH
lZZhktOa3FUFk6f7j5s3YQJo09aw3w==
=JVa+
-----END PGP SIGNATURE-----

--Sig_/BKQ+mydrAeI5zrOaN145QGT--
