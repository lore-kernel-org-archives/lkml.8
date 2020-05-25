Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248ACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97322071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cp9XtId8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbgEYXts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 19:49:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4998 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbgEYXts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 19:49:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecc59900000>; Mon, 25 May 2020 16:49:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 May 2020 16:49:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 25 May 2020 16:49:48 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 May
 2020 23:49:47 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 25 May 2020 23:49:47 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.58.199]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecc599b0000>; Mon, 25 May 2020 16:49:47 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <etnaviv@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] drm/etnaviv: convert get_user_pages() --> pin_user_pages()
Date:   Mon, 25 May 2020 16:49:46 -0700
Message-ID: <20200525234946.512848-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590450576; bh=C3o3eympRzwR7c/b70BhXHJjaTleTxgbsTFGbme4xwE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=cp9XtId8piYPKy0k91vDh1oN7UUmAfRRRnaC9WZ+kxzR3hGCRc4fn3sjSBs1PUBiA
         ROZX9BwckP+dqa3nPdjNHOrfzxDW7jx3aBhnrsQNLKdZv1oKFquRrHFMeyGJeiQ1DM
         Vm1VIJqcLAi8LZZRR8s1W+1ZzPgzDxvPakgH/A8F/1bV9/zuMA6pwanKJrkEJwVL6e
         7OIfsGldpXQpeymtJWixdgO22WKCcZF0nLOQZQLeAixXHAn6nG86N9dRAWlAr4XLYy
         vCJywMUv1K6Aw2KT5d3ZQM/jTTHYfgfGzgZLzdbszaPKRCoiq4RzwNg/2pf+3+xZzZ
         qunVFDmPMQUEg==
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

Changes since v1:

* Rebased onto Linux 5.7-rc7

* Added: Lucas Stach

thanks
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

