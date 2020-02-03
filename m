Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B0AC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 00:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B20B2073C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 00:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VGAJ0MTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgBCAEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 19:04:31 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBCAEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 19:04:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 489p3H70lHz9sRh;
        Mon,  3 Feb 2020 11:04:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580688268;
        bh=tcS71z/0GWmowIg5o7L/X7n3pR9UYX7ERG7fepo7dVw=;
        h=Date:From:To:Cc:Subject:From;
        b=VGAJ0MTMTz1P6qu66LxUuDOOQBAyaLPI3ngCo87iBAuTo2bTg8Y3R3L0yVzoe6gV1
         Z3ZXyZ0xUhsMYY3qC/TptOdRO+et8nyUFXJxXnYcAOCjf9Q/Jn+xva8cl0Lm3kshzf
         e8Y8jP/McrImdk+soZ4XYmlJ2KLnKOYGngIzWiTk0Pv3f8OYXB2aPtEYDHRNPYw4Yd
         XV9X/5fXmfWDf27gVVYCVBNHiyYCDaqXFiknNHABQK979nFfQJdvX5G/sM6vSTny81
         PfImfqrC1vHuJS5zgReT73tCNvOYc1E/F2jINEK7in0pz7f8jAcOYynFqb5U5rQZ5N
         mf7nsAilM6dnQ==
Date:   Mon, 3 Feb 2020 11:04:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20200203110426.6ceca414@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sMt7r46TAOWkHLL5pPR9qXT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sMt7r46TAOWkHLL5pPR9qXT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from drivers/vhost/vhost.c:13:
include/linux/eventfd.h:43:22: error: unknown type name 'eventfd_wake_count'
   43 | DECLARE_PER_CPU(int, eventfd_wake_count);
      |                      ^~~~~~~~~~~~~~~~~~
include/linux/eventfd.h: In function 'eventfd_signal_count':
include/linux/eventfd.h:47:9: error: implicit declaration of function 'this=
_cpu_read' [-Werror=3Dimplicit-function-declaration]
   47 |  return this_cpu_read(eventfd_wake_count);
      |         ^~~~~~~~~~~~~
include/linux/eventfd.h:47:23: error: 'eventfd_wake_count' undeclared (firs=
t use in this function); did you mean 'eventfd_signal_count'?
   47 |  return this_cpu_read(eventfd_wake_count);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       eventfd_signal_count
include/linux/eventfd.h:47:23: note: each undeclared identifier is reported=
 only once for each function it appears in

Caused by commit

  9a9f718763cf ("eventfd: track eventfd_signal() recursion depth")

I have used the block tree from next-20200131 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/sMt7r46TAOWkHLL5pPR9qXT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl43Y4oACgkQAVBC80lX
0GwBFggAjDOY3xHh/zDK7mPorje1srkW5wHKlSpuW5eZW6UTjkcY0Ne6Y9uiFzJE
lseS8X0xxg0hpSQtHCyuag3fZhcNSMotQeEc9YHHIBDRoQFur9U29PZ/6NPRadYS
62htCqZAeX87+T0eD17JqGg86m0VXKaAO3fCvVWj819tAX8djPF2XEyIVmTyk4Kd
MRUDo82EFm3dx1oAMPCyXjNN1yNXw+AqLmCdJ45H8vVSWu5rXkCK3eJqJBdZwD2Z
tMcjMbtZ2sXBDkSsVI3/mjiFlJgC0bdLnq2Q02/NJgGjpl0Au6JsYvtDu/JlxmZw
3ei5qUqzZtZWe9rSf+QBbzD1Q+3GYA==
=KSeT
-----END PGP SIGNATURE-----

--Sig_/sMt7r46TAOWkHLL5pPR9qXT--
