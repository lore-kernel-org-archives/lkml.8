Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E377C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3BD2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y8OzVbBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgERFnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:43:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5395 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERFnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:43:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec220270000>; Sun, 17 May 2020 22:42:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 17 May 2020 22:43:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 17 May 2020 22:43:17 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 05:43:17 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 18 May 2020 05:43:16 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec220740002>; Sun, 17 May 2020 22:43:16 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <etnaviv@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] drm/etnaviv: convert get_user_pages() --> pin_user_pages()
Date:   Sun, 17 May 2020 22:43:15 -0700
Message-ID: <20200518054315.2407093-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589780520; bh=Nw/n11knSNrp8BRVAAf0yZA96pwzBUISJeQpKg/G4dc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=Y8OzVbBUzW9w/9M2Wg03/k4DFOeTeW4XJIAYKYx24E2BSAh2InaXI3chth31KBebn
         lUcWz5ZaKYceDrBL1IHvIVaOHxmoBsTn3TEs95oCFOUX9A52yqKzaDww8i029K+b6P
         Y3FidGcZZpH+C/U79Fownhl7VNNTogejGlc6MgA+i5ajT9RVCnRZ6EfS8op0fmH9sP
         QIJofhVM9SmAicaoEj7NSfzcb+qYfRLgnm4pCjBy0AbbxSn/MiiwO4VT/jlWmDD99o
         u4Qf/CI+JzYMdIlhzasehts4HJ3mE1n1X0LU6rlaKtP06hRnCXhHFfDCh88xa5XJff
         GVW/CDgkRIg3Q==
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

Hi,

Note that I have only compile-tested this patch, although that does
also include cross-compiling for a few other arches.

thanks,
John Hubbard
NVIDIA

 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnavi=
v/etnaviv_gem.c
index dc9ef302f517..0f4578dc169d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -675,10 +675,10 @@ static int etnaviv_gem_userptr_get_pages(struct etnav=
iv_gem_object *etnaviv_obj)
 		uint64_t ptr =3D userptr->ptr + pinned * PAGE_SIZE;
 		struct page **pages =3D pvec + pinned;
=20
-		ret =3D get_user_pages_fast(ptr, num_pages,
+		ret =3D pin_user_pages_fast(ptr, num_pages,
 					  !userptr->ro ? FOLL_WRITE : 0, pages);
 		if (ret < 0) {
-			release_pages(pvec, pinned);
+			unpin_user_pages(pvec, pinned);
 			kvfree(pvec);
 			return ret;
 		}
@@ -702,7 +702,7 @@ static void etnaviv_gem_userptr_release(struct etnaviv_=
gem_object *etnaviv_obj)
 	if (etnaviv_obj->pages) {
 		int npages =3D etnaviv_obj->base.size >> PAGE_SHIFT;
=20
-		release_pages(etnaviv_obj->pages, npages);
+		unpin_user_pages(etnaviv_obj->pages, npages);
 		kvfree(etnaviv_obj->pages);
 	}
 }
--=20
2.26.2

