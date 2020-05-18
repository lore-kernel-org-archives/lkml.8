Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E2FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2971D2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CsBeFnJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgERBwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:52:42 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18724 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgERBwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:52:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec1ea1c0000>; Sun, 17 May 2020 18:51:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 17 May 2020 18:52:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 17 May 2020 18:52:41 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 01:52:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 18 May 2020 01:52:41 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec1ea680003>; Sun, 17 May 2020 18:52:40 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] genwqe: convert get_user_pages() --> pin_user_pages()
Date:   Sun, 17 May 2020 18:52:37 -0700
Message-ID: <20200518015237.1568940-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589766684; bh=8+QRGV+R9yBACKFygsmXJhzujsCS4WK3hn0lWKiFxDU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=CsBeFnJtvkuZB1mqnKp/CFmVHB52SrPZhF6sfZ69HvK/+RO2uHpRS1cGV/u9jGkd5
         sYYQ6eEl2wbX9HQISAgBgB6Gbg5jZhulgfahYN9Qx1QTz1pRUYFmviT/IC9vb/LI+x
         +aOEZ7ysiwAa9YaMP6Ci5oI9XAhZ3huTn3i94+mM7SpC3x9wK8GO9ekDPYbHZhWMKE
         XgbJ6+V16psnnLRUliTJQvwnRCuXSA2x1KiuGAgZS8SE/eWMi6GfGTOsgMulujm7yM
         ntuMCMoe+P038hU7I9kC6o14HotKuqDolyBZg5hm1XOaV3yVBN8Dz6iMCK7AJ+GxYj
         1PhzxJoM8U1+w==
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

Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

Note that I have only compile-tested this patch, although that does
also include cross-compiling for a few other arches...but it only
seemed to be supported on x86_64 and sparc, for those.

thanks,
John Hubbard
NVIDIA

 drivers/misc/genwqe/card_utils.c | 42 +++++++-------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_ut=
ils.c
index 2e1c4d2905e8..60460a053b2d 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -514,30 +514,6 @@ int genwqe_free_sync_sgl(struct genwqe_dev *cd, struct=
 genwqe_sgl *sgl)
 	return rc;
 }
=20
-/**
- * genwqe_free_user_pages() - Give pinned pages back
- *
- * Documentation of get_user_pages is in mm/gup.c:
- *
- * If the page is written to, set_page_dirty (or set_page_dirty_lock,
- * as appropriate) must be called after the page is finished with, and
- * before put_page is called.
- */
-static int genwqe_free_user_pages(struct page **page_list,
-			unsigned int nr_pages, int dirty)
-{
-	unsigned int i;
-
-	for (i =3D 0; i < nr_pages; i++) {
-		if (page_list[i] !=3D NULL) {
-			if (dirty)
-				set_page_dirty_lock(page_list[i]);
-			put_page(page_list[i]);
-		}
-	}
-	return 0;
-}
-
 /**
  * genwqe_user_vmap() - Map user-space memory to virtual kernel memory
  * @cd:         pointer to genwqe device
@@ -597,18 +573,18 @@ int genwqe_user_vmap(struct genwqe_dev *cd, struct dm=
a_mapping *m, void *uaddr,
 	m->dma_list =3D (dma_addr_t *)(m->page_list + m->nr_pages);
=20
 	/* pin user pages in memory */
-	rc =3D get_user_pages_fast(data & PAGE_MASK, /* page aligned addr */
+	rc =3D pin_user_pages_fast(data & PAGE_MASK, /* page aligned addr */
 				 m->nr_pages,
 				 m->write ? FOLL_WRITE : 0,	/* readable/writable */
 				 m->page_list);	/* ptrs to pages */
 	if (rc < 0)
-		goto fail_get_user_pages;
+		goto fail_pin_user_pages;
=20
-	/* assumption: get_user_pages can be killed by signals. */
+	/* assumption: pin_user_pages can be killed by signals. */
 	if (rc < m->nr_pages) {
-		genwqe_free_user_pages(m->page_list, rc, m->write);
+		unpin_user_pages_dirty_lock(m->page_list, rc, m->write);
 		rc =3D -EFAULT;
-		goto fail_get_user_pages;
+		goto fail_pin_user_pages;
 	}
=20
 	rc =3D genwqe_map_pages(cd, m->page_list, m->nr_pages, m->dma_list);
@@ -618,9 +594,9 @@ int genwqe_user_vmap(struct genwqe_dev *cd, struct dma_=
mapping *m, void *uaddr,
 	return 0;
=20
  fail_free_user_pages:
-	genwqe_free_user_pages(m->page_list, m->nr_pages, m->write);
+	unpin_user_pages_dirty_lock(m->page_list, m->nr_pages, m->write);
=20
- fail_get_user_pages:
+ fail_pin_user_pages:
 	kfree(m->page_list);
 	m->page_list =3D NULL;
 	m->dma_list =3D NULL;
@@ -650,8 +626,8 @@ int genwqe_user_vunmap(struct genwqe_dev *cd, struct dm=
a_mapping *m)
 		genwqe_unmap_pages(cd, m->dma_list, m->nr_pages);
=20
 	if (m->page_list) {
-		genwqe_free_user_pages(m->page_list, m->nr_pages, m->write);
-
+		unpin_user_pages_dirty_lock(m->page_list, m->nr_pages,
+					    m->write);
 		kfree(m->page_list);
 		m->page_list =3D NULL;
 		m->dma_list =3D NULL;

base-commit: b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
--=20
2.26.2

