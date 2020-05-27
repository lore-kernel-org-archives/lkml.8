Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E46C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8E42100A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SKkdpxYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgE0Wct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:32:49 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17990 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgE0Wcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:32:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eceea3b0000>; Wed, 27 May 2020 15:31:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 May 2020 15:32:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 May 2020 15:32:46 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 22:32:46 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 22:32:46 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.87.74]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eceea8d0006>; Wed, 27 May 2020 15:32:45 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] mm/gup: frame_vector: convert get_user_pages() --> pin_user_pages()
Date:   Wed, 27 May 2020 15:32:43 -0700
Message-ID: <20200527223243.884385-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527223243.884385-1-jhubbard@nvidia.com>
References: <20200527223243.884385-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590618683; bh=sWvJDniuNa0MloWGBo3nO/qwt/IUY5Pd+BokGdPrg7M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=SKkdpxYia+zl8I1G5aytJpugRzjxOPugRFmINeXYNJyvv2wNBDukmddpHstDNZ4PQ
         1aCOw+8GDWZlXhZ6C6i8g+UjIArzo16lNFuKbFNWekzRe/N8w81kArI55DnWNoL0T0
         rLUBTUj/hTu0eUsJvN/PGKFmgeRYL5rfhiVj5mc/nPCgedQ/oxsx2yQUM89zK5D2vP
         pJN16iaiiJEnWDZ6X5TiRvTVAH010Vq1eMjMeEsdgRND8BChBrF9EVbvxscaHNSnrl
         j5H2FprhjqxJiUHAIrJmCHYDtFX/PZaizEr2Ia0lMrc88NVFRh3zYRloXamQQ28K2B
         mBQehtwhjhZfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages*(), and all of the callers so far
were in a "Case 2" scenario (DMA/RDMA), using the categorization
from [1]. That means that it's time to convert the get_user_pages*() +
put_page() calls to pin_user_pages*() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/frame_vector.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index c431ca81dad5..4107dbca0056 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -72,7 +72,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr=
_frames,
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
 		vec->got_ref =3D true;
 		vec->is_pfns =3D false;
-		ret =3D get_user_pages_locked(start, nr_frames,
+		ret =3D pin_user_pages_locked(start, nr_frames,
 			gup_flags, (struct page **)(vec->ptrs), &locked);
 		goto out;
 	}
@@ -122,7 +122,6 @@ EXPORT_SYMBOL(get_vaddr_frames);
  */
 void put_vaddr_frames(struct frame_vector *vec)
 {
-	int i;
 	struct page **pages;
=20
 	if (!vec->got_ref)
@@ -135,8 +134,8 @@ void put_vaddr_frames(struct frame_vector *vec)
 	 */
 	if (WARN_ON(IS_ERR(pages)))
 		goto out;
-	for (i =3D 0; i < vec->nr_frames; i++)
-		put_page(pages[i]);
+
+	unpin_user_pages(pages, vec->nr_frames);
 	vec->got_ref =3D false;
 out:
 	vec->nr_frames =3D 0;
--=20
2.26.2

