Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57795C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E4D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HCVXQcAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbgFRPmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:42:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38510 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbgFRPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154026euoutp021a3b7c70513c986f5e6a60cd3dfe29f8~ZrZtzkJDZ1470214702euoutp02I
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200618154026euoutp021a3b7c70513c986f5e6a60cd3dfe29f8~ZrZtzkJDZ1470214702euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494826;
        bh=nbh13/xRlTnDhOSh+Kxv0NXU5d6Pqt7iXPYs90aE1m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCVXQcAVK6irV3YTdHDxj9XFYB5BB8lZZSYC1d0VzrQFyQE8LcQ4/PVgBxP/lyxf2
         wlpp+AbnAQqwn5yKOTY8fOtzxE7zHHmgcG7JXLcLwulAiucKu23HzHIqPva93xSYVI
         fnRHJ2SP4x/Wb6uP/Mjxnp6M1cQzYEKU9v3vHQBA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200618154026eucas1p2ce5e89ebc9c9113e06f620c9c8b5e34f~ZrZtcL2ic0501005010eucas1p2f;
        Thu, 18 Jun 2020 15:40:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B6.60.60698.9EA8BEE5; Thu, 18
        Jun 2020 16:40:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154025eucas1p1cf27282556c145b4a59527141a340574~ZrZtHADSG1755717557eucas1p1M;
        Thu, 18 Jun 2020 15:40:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200618154025eusmtrp16ec981cf5bf255088963d1a07964c8aa~ZrZtGW6dO2169821698eusmtrp1d;
        Thu, 18 Jun 2020 15:40:25 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-33-5eeb8ae9bd6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.E9.07950.9EA8BEE5; Thu, 18
        Jun 2020 16:40:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154024eusmtip1e733628c569e66612e73eb95a145512a~ZrZsY---J0709107091eusmtip1v;
        Thu, 18 Jun 2020 15:40:24 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH v6 17/36] drm: radeon: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 17:39:38 +0200
Message-Id: <20200618153956.29558-18-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SazBUYRieb8+es4esOZbJN5iatqFoIkPTmTQmph+n6Q+mXzVk44Rhl/ag
        1I/EMFqXqUyl1UVmta5hF7HKZaMltVPLCLnGDGKryaVxb9ch/r3P8z7P+7zvNx+OCEZQBzxK
        Ek9LJaIYIWbJrXu/pD86LZsJOWYoOklm6zs55MPBRpQsqrzNI6vzKlHSOGKCG3X3ELJn4RdG
        lpS1c8iCZh9yvmeMQ6rGe1GyW/MEIyvahnhk6+8J9LQ1lWZYw6jyZ+WAertYwKVeL46i1Eim
        jkOpFbeob+vjCJXbpwRUY38yRuXUlAJqTrUvYM8Fy1PhdExUIi318A21jPwyq8TilHuv18qO
        JIM+gQxY4JDwhpMNLRwZsMQFRDGA/e1/ERbMA6hpbEdZMAfg6HgzZ9siy9UCtqEEcGhFhu1Y
        UtYRswojPKHMaG5Y4HZEGoAd2VZmEUIoEKgYbOKaG7ZEEJzqHd0cyyWc4fLzcmCu+YQvVP+Z
        BGzcflhW1bI51MLEd+nSUFZjAzsfT2zOQUya1Nr8zcUhscaDTYYVhDWfgS8W2nlsbQt/6Gq2
        aifYlZvFZQ2pAI7pK3gsyAKwOyVvK9oHDuqXTTfgpghXWKnxYGk/aKzKRM00JKxhn9GGXcIa
        3q97hLA0H2akb72wC5TrXv2Pbf1s2FqNggNvynl3wQH5rnPku86R7+QWAKQU2NMJjDiCZrwk
        9DV3RiRmEiQR7mGxYhUwfbuudd1CPWhavawFBA6EVvyp8zMhAlSUyCSJtQDiiNCO7/+pK0TA
        Dxcl3aClsZekCTE0owWOOFdoz/cqnA4WEBGieDqapuNo6XaXg1s4JIOwgfSnh7UBKeO1TgqV
        Il2Q73rnSotzSRWWseKsXi+S/dQgUV9p1xNno4vV53qLum+6TAWXdpBeMNMWCa13Kz30cbZN
        3FtfdvUg47Hg3yp/Fzgc6P1y6UPKMO52vHBsPijJ78HFnpELTbFKSXbOEr1a/b1kcDm4RzDb
        4Bi4ETcq5DKRIk83RMqI/gFAiE4McgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7ovu17HGfz/q2TRe+4kk8W0O7tZ
        LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
        cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
        zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mu4+GY5W8FysYqtXdoNjDeEuhg5OSQETCS6Jh9i7GLk4hASWMooceHga3aI
        hIzEyWkNrBC2sMSfa11sEEWfGCU2r5zLBpJgEzCU6HoLkRAR6GSUmNb9kR3EYRZYwyxx7/ty
        sFHCAgESu9c8ZASxWQRUJX7NXwNm8wrYSWz+9JwRYoW8xOoNB5hBbE6g+OnjrWCrhQRsJZ5/
        aGODqBeUODnzCUsXIwfQAnWJ9fPAXmAGam3eOpt5AqPgLCRVsxCqZiGpWsDIvIpRJLW0ODc9
        t9hIrzgxt7g0L10vOT93EyMwgrcd+7llB2PXu+BDjAIcjEo8vC9CXscJsSaWFVfmHmKU4GBW
        EuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBrE5mlRJPzgcklryTe0NTQ3MLS0NzY3NjMQkmc
        t0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo53o3srvaR903+bdzuOS2LJbxsRx06O9L6aHTfxl
        /Tq9KVtV2frSW5vrp16tiHHbpvN3ofE+aTEvm77053oH/J9Hvy2//y43T2rn78cPTpkzrZX4
        bB964kuBOvN6NtE3nb5Ms6z8Yk6XnLxs3qhio/Y78EGTV7D6jOkVx9hDZ05WOSIw78wEfiWW
        4oxEQy3mouJEALhs/Nf2AgAA
X-CMS-MailID: 20200618154025eucas1p1cf27282556c145b4a59527141a340574
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154025eucas1p1cf27282556c145b4a59527141a340574
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154025eucas1p1cf27282556c145b4a59527141a340574
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154025eucas1p1cf27282556c145b4a59527141a340574@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
returns the number of the created entries in the DMA address space.
However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
dma_unmap_sg must be called with the original number of the entries
passed to the dma_map_sg().

struct sg_table is a common structure used for describing a non-contiguous
memory buffer, used commonly in the DRM and graphics subsystems. It
consists of a scatterlist with memory pages and DMA addresses (sgl entry),
as well as the number of scatterlist entries: CPU pages (orig_nents entry)
and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg()
function.

To avoid such issues, lets use a common dma-mapping wrappers operating
directly on the struct sg_table objects and use scatterlist page
iterators where possible. This, almost always, hides references to the
nents and orig_nents entries, making the code robust, easier to follow
and copy/paste safe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5d50c9edbe80..0e3eb0d22831 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -481,7 +481,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct radeon_device *rdev = radeon_get_rdev(ttm->bdev);
 	struct radeon_ttm_tt *gtt = (void *)ttm;
-	unsigned pinned = 0, nents;
+	unsigned pinned = 0;
 	int r;
 
 	int write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
@@ -521,9 +521,8 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	if (r)
 		goto release_sg;
 
-	r = -ENOMEM;
-	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	r = dma_map_sgtable(rdev->dev, ttm->sg, direction, 0);
+	if (r)
 		goto release_sg;
 
 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
@@ -554,9 +553,9 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* free the sg table and pages again */
-	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
+	dma_unmap_sgtable(rdev->dev, ttm->sg, direction, 0);
 
-	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->nents, 0) {
+	for_each_sgtable_page(ttm->sg, &sg_iter, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		if (!(gtt->userflags & RADEON_GEM_USERPTR_READONLY))
 			set_page_dirty(page);
-- 
2.17.1

