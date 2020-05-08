Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A47C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1381C21841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a66yDCyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHF2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:28:38 -0400
Received: from ozlabs.org ([203.11.71.1]:38673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgEHF2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:28:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49JJlR68jPz9sSk;
        Fri,  8 May 2020 15:28:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588915716;
        bh=dQc43ogTgSb8NPgTzBm/D7KQjb0ycLXQsSyJCR301ZE=;
        h=Date:From:To:Cc:Subject:From;
        b=a66yDCydRrudsOc7jI5grRLoXAQgJfeNogtTdGSt9MPgHDe/yMxZenaYLHgONJRst
         deTnzErClPdLgUpbKMnO4m6acFr3GHX1rkZEZbWS+7gOnBj2tJUNFV7nlM9caxN/in
         7QkbqkJvOXXOX/MZJwFb3I8f8R2vMF5gP4FhggbrfRR3f4PV1PdQ2n6JLrRxvGjVoz
         jKTrdxPQYLW1V1XlRQbiUmwCUsrUmKfNHBvGHXZW0eE8ZqsxtU9V/2uXLqkSSxH3Sn
         +d9R/auMCClWXA6RnzFm+p3uLQpovFqDW2563I9sevgIvkAMTRh6D7wOUXESacjAL4
         AIfj6EUkwMV8A==
Date:   Fri, 8 May 2020 15:28:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20200508152833.7e840076@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hmqVjdEB8aFiTqUt97aKeGF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hmqVjdEB8aFiTqUt97aKeGF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/kernel.h:15,
                 from include/linux/list.h:9,
                 from include/linux/module.h:12,
                 from block/bfq-iosched.c:116:
block/bfq-iosched.c: In function 'bfq_set_next_ioprio_data':
block/bfq-iosched.c:4980:5: error: implicit declaration of function 'bdi_de=
v_name'; did you mean 'blkg_dev_name'? [-Werror=3Dimplicit-function-declara=
tion]
 4980 |     bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
      |     ^~~~~~~~~~~~

Caused by commit

  0f6438fca125 ("bdi: use bdi_dev_name() to get device name")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 8 May 2020 15:23:50 +1000
Subject: [PATCH] bdi: bdi_dev_name() needs backing-dev.h

Fixes: 0f6438fca125 ("bdi: use bdi_dev_name() to get device name")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 block/bfq-iosched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4d4fe44a9eea..3d411716d7ee 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -123,6 +123,7 @@
 #include <linux/ioprio.h>
 #include <linux/sbitmap.h>
 #include <linux/delay.h>
+#include <linux/backing-dev.h>
=20
 #include "blk.h"
 #include "blk-mq.h"
--=20
2.26.2

--=20
Cheers,
Stephen Rothwell

--Sig_/hmqVjdEB8aFiTqUt97aKeGF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl607gEACgkQAVBC80lX
0GxdIwgAo98U9fDp3r4sqmd92szVIhSq/U9RqtWdGJg07HB7y6C9OAX2naNnyEDF
P79BpmaaoBkcmI+yc1VhhcNW7YRCUPOJ98PY92lqiWy9fw+oAJAwOUwTnFH70X9W
UMri2AqD6OCJma1Y7KTrLkJ3e1pLqMPBE/dAVq96KAuhNo+1XlpPOqL9+LxbHPm3
yPDt1mUUQFsMG78eyKmJoZEMPUXWV/f11LhfiG4li9CsPHpeWiSk171PT3WAtP3s
z3fq6DioiMCMSYk7dvEYzoRBCumpcTyVsslPwNJjbG2DCaPuYU73L7HGzYYqWVx2
JbgFMzt4gun5Ck3vdqqSPyuWqXBWkA==
=T44d
-----END PGP SIGNATURE-----

--Sig_/hmqVjdEB8aFiTqUt97aKeGF--
