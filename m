Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FA1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103E5206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AGf4hNM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgEQCIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 22:08:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12575 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 22:08:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec09c510000>; Sat, 16 May 2020 19:07:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 16 May 2020 19:08:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 16 May 2020 19:08:30 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 17 May
 2020 02:08:30 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 17 May 2020 02:08:29 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec09c9d0002>; Sat, 16 May 2020 19:08:29 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>
Subject: [PATCH] oradax: convert get_user_pages() --> pin_user_pages()
Date:   Sat, 16 May 2020 19:08:29 -0700
Message-ID: <20200517020829.856731-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589681233; bh=XuRV06lShXX0mEEPxDvd+aeuC8h5utZZzMaYdY4ajCA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=AGf4hNM+Hifu2oHtMx1No3HpgirZ8E3C//643LsAa2WPrXWuKELF4Icoa4Kbtzday
         S9Cnaz7rPJVHC9Ult3l8VmEilT7ZO8da2Nexc90RtVkKCDzSAlZHeg8BeZqJdz1ECJ
         W7hXD7NkKjDQKErQJV4xA3659jO9NCbzu5NUMUFo4FgDKqkOIwdoGxL0S6ciGDx5Uu
         WXxhlYAp3CMoOIacLqwTt7d0POwcvwDyOt6r1jo67shqGeHwiekD7u4GUFYlko0Dts
         aeZ+LKH9CHcnkckthYL8gp3fHLycl/dDdjzgeFhuSu9oVprMxHuqjzatJ1kjwfbkpF
         EmD+wIi+5lI+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages_fast(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages_fast() + put_page() calls to
pin_user_pages_fast() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/sbus/char/oradax.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 8af216287a84..21b7cb6e7e70 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -410,9 +410,7 @@ static void dax_unlock_pages(struct dax_ctx *ctx, int c=
cb_index, int nelem)
=20
 			if (p) {
 				dax_dbg("freeing page %p", p);
-				if (j =3D=3D OUT)
-					set_page_dirty(p);
-				put_page(p);
+				unpin_user_pages_dirty_lock(&p, 1, j =3D=3D OUT);
 				ctx->pages[i][j] =3D NULL;
 			}
 		}
@@ -425,13 +423,13 @@ static int dax_lock_page(void *va, struct page **p)
=20
 	dax_dbg("uva %p", va);
=20
-	ret =3D get_user_pages_fast((unsigned long)va, 1, FOLL_WRITE, p);
+	ret =3D pin_user_pages_fast((unsigned long)va, 1, FOLL_WRITE, p);
 	if (ret =3D=3D 1) {
 		dax_dbg("locked page %p, for VA %p", *p, va);
 		return 0;
 	}
=20
-	dax_dbg("get_user_pages failed, va=3D%p, ret=3D%d", va, ret);
+	dax_dbg("pin_user_pages failed, va=3D%p, ret=3D%d", va, ret);
 	return -1;
 }
=20

base-commit: 3d1c1e5931ce45b3a3f309385bbc00c78e9951c6
--=20
2.26.2

