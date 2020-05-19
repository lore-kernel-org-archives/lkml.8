Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDA1C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FE920873
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Gqj1Eegd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgESAVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:21:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5636 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgESAVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:21:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec3263d0000>; Mon, 18 May 2020 17:20:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 17:21:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 17:21:31 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 00:21:29 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 May 2020 00:21:28 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.55.90]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec326870002>; Mon, 18 May 2020 17:21:28 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/4] drm/i915: convert get_user_pages() --> pin_user_pages()
Date:   Mon, 18 May 2020 17:21:24 -0700
Message-ID: <20200519002124.2025955-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519002124.2025955-1-jhubbard@nvidia.com>
References: <20200519002124.2025955-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589847613; bh=TYbuD5RgYulyxagO4AixT7wa6RlCT1nu+LHkKhXb+U4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Gqj1Eegdl4gP6WKGR/AfRzVgeB1rieQnkY/5QKS1v17W3pTdlbPatr7P0KRNamUJ1
         trfX9G86fGzJ8KIRUpetIf/3+vFjAwj6rv7NIk0Pw3rLdIXgPRDG6mYpN85oPGlWSz
         1+8oi0L/H8w2qox/LNkCIsZecujkQzxG33hzU5exEodgLgOs9xo84w2XpvtZBuO0yr
         XL+ZM83TH7J7hI2YgMZR0MLmb33DqQVMwPH7nBcAUx7O0cfgbGt1zzNpyrqq68QpY0
         +bhCLH0VRb8ZJDkAL5YGTQ78ccRofCa9tZ19PmfqSa52Rikx4UIfo0NSGLpyCqMQp/
         6gFhc7WikkWtg==
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
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 7ffd7afeb7a5..b55ac7563189 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -471,7 +471,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct =
*_work)
 					down_read(&mm->mmap_sem);
 					locked =3D 1;
 				}
-				ret =3D get_user_pages_remote
+				ret =3D pin_user_pages_remote
 					(work->task, mm,
 					 obj->userptr.ptr + pinned * PAGE_SIZE,
 					 npages - pinned,
@@ -507,7 +507,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct =
*_work)
 	}
 	mutex_unlock(&obj->mm.lock);
=20
-	release_pages(pvec, pinned);
+	unpin_user_pages(pvec, pinned);
 	kvfree(pvec);
=20
 	i915_gem_object_put(obj);
@@ -564,6 +564,7 @@ static int i915_gem_userptr_get_pages(struct drm_i915_g=
em_object *obj)
 	struct sg_table *pages;
 	bool active;
 	int pinned;
+	unsigned int gup_flags =3D 0;
=20
 	/* If userspace should engineer that these pages are replaced in
 	 * the vma between us binding this page into the GTT and completion
@@ -598,11 +599,14 @@ static int i915_gem_userptr_get_pages(struct drm_i915=
_gem_object *obj)
 				      GFP_KERNEL |
 				      __GFP_NORETRY |
 				      __GFP_NOWARN);
-		if (pvec) /* defer to worker if malloc fails */
-			pinned =3D __get_user_pages_fast(obj->userptr.ptr,
-						       num_pages,
-						       !i915_gem_object_is_readonly(obj),
-						       pvec);
+		/* defer to worker if malloc fails */
+		if (pvec) {
+			if (!i915_gem_object_is_readonly(obj))
+				gup_flags |=3D FOLL_WRITE;
+			pinned =3D pin_user_pages_fast_only(obj->userptr.ptr,
+							  num_pages, gup_flags,
+							  pvec);
+		}
 	}
=20
 	active =3D false;
@@ -620,7 +624,7 @@ static int i915_gem_userptr_get_pages(struct drm_i915_g=
em_object *obj)
 		__i915_gem_userptr_set_active(obj, true);
=20
 	if (IS_ERR(pages))
-		release_pages(pvec, pinned);
+		unpin_user_pages(pvec, pinned);
 	kvfree(pvec);
=20
 	return PTR_ERR_OR_ZERO(pages);
@@ -675,7 +679,7 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *=
obj,
 		}
=20
 		mark_page_accessed(page);
-		put_page(page);
+		unpin_user_page(page);
 	}
 	obj->mm.dirty =3D false;
=20
--=20
2.26.2

