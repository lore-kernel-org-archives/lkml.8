Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF00C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694F820787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pGHATikA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgERGBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:01:44 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6164 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:01:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec2247a0000>; Sun, 17 May 2020 23:00:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 17 May 2020 23:01:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 17 May 2020 23:01:44 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 06:01:44 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 18 May 2020 06:01:43 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec224c70000>; Sun, 17 May 2020 23:01:43 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        <devel@lists.orangefs.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] orangefs: convert get_user_pages() --> pin_user_pages()
Date:   Sun, 17 May 2020 23:01:39 -0700
Message-ID: <20200518060139.2828423-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589781626; bh=L/5D60XFGdPvaS3NAfsHyW+VMUpnFlIrCbHG4lt9M0U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=pGHATikAs0+QHO2iJmt6ltZqaafiRAQeW/4IlWtoQODiUtQhge30yUQp3ETfwV4Eb
         uFdPYRzQPJ/1jEOjNZ1U1Hu9eVx7PWV33MwpWsJ4tU4LrL4iEqIm0C2P0ck7hoHc9R
         GD2rebyRcb/7eZtFeryBE83On6pcjDfRoeKjRmrCpdhHiLyZ1cJFTX8XBlq+vIhMLj
         1wEW8QJfHmzOCfjuzxlmUo7O07QNwaAx6edCElbvdwyVeDF7Yx3ugAKEimv1ETjSqZ
         lfo+/w+WvZHSa0Ep7PpcTDzeakZqE/hJzhgrHtNIEAv7lAdr6aljDM9SYZFoITs4AP
         WhaIij0KjOgIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages*(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages*() + put_page() calls to
pin_user_pages*() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

 fs/orangefs/orangefs-bufmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 2bb916d68576..538e839590ef 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -168,10 +168,7 @@ static DEFINE_SPINLOCK(orangefs_bufmap_lock);
 static void
 orangefs_bufmap_unmap(struct orangefs_bufmap *bufmap)
 {
-	int i;
-
-	for (i =3D 0; i < bufmap->page_count; i++)
-		put_page(bufmap->page_array[i]);
+	unpin_user_pages(bufmap->page_array, bufmap->page_count);
 }
=20
 static void
@@ -268,7 +265,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
 	int offset =3D 0, ret, i;
=20
 	/* map the pages */
-	ret =3D get_user_pages_fast((unsigned long)user_desc->ptr,
+	ret =3D pin_user_pages_fast((unsigned long)user_desc->ptr,
 			     bufmap->page_count, FOLL_WRITE, bufmap->page_array);
=20
 	if (ret < 0)
@@ -280,7 +277,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
=20
 		for (i =3D 0; i < ret; i++) {
 			SetPageError(bufmap->page_array[i]);
-			put_page(bufmap->page_array[i]);
+			unpin_user_page(bufmap->page_array[i]);
 		}
 		return -ENOMEM;
 	}
--=20
2.26.2

