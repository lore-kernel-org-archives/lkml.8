Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D50C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34F6206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q8Kn7uZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgEaXli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 19:41:38 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6010 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgEaXlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 19:41:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed440a00000>; Sun, 31 May 2020 16:41:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 16:41:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 16:41:34 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 31 May
 2020 23:41:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 31 May 2020 23:41:32 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.56.10]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed440ac0002>; Sun, 31 May 2020 16:41:32 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/2] mm/gup: frame_vector: convert get_user_pages() --> pin_user_pages()
Date:   Sun, 31 May 2020 16:41:31 -0700
Message-ID: <20200531234131.770697-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531234131.770697-1-jhubbard@nvidia.com>
References: <20200531234131.770697-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590968482; bh=u/IEFLNJA/oJfZri/00pv0J+slptUmIo4kllStA2qdc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=q8Kn7uZFM5Id08VQ3w3dIyZSEygIqJHBl6vzO0TGPwOBlQMwgWSnb2p2Jluf+HHi3
         Iw1Sduery5c2/ZpgjcS9j5WyD3v2ZutYj+MgbQMZbzEEIU4YJ+v6NNV01Jqe8PWCgJ
         S4z1GKS0Rqnw9PumwuYRU6w1iUq/AGu0zN2hhycBtiCwa5oo+9xmc2D9/oNpfJKGq4
         yWaadM4v1srPD6LgAX2ANnqujMTixF1T6vhRvZF1RaQUGZRTnyKuRXoOkML4hacBqj
         rjLcugy0c1Hkk3XDhq/D1kW7s7C5f4KU/56ts1rMCccYW10HN91wgQEUO4E/VuBK1h
         ZdyBfw5SnGp4w==
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

Cc: David Hildenbrand <david@redhat.com>
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

