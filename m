Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D50C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59022070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SGHARrut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgFRPn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:43:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38386 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731596AbgFRPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154020euoutp022086c3a5dbe8c755cb112d9743b4827d~ZrZouBo_31250012500euoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200618154020euoutp022086c3a5dbe8c755cb112d9743b4827d~ZrZouBo_31250012500euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494821;
        bh=tj4USkT4mmzGAYtGQ+Hrc6tAZIJTZKbcemrdU4KaPkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGHARrutIRMe8nbprYciaB0qmSrtljzgNMVbJU5pYh6rTyMQUTs4/27zm93p0U0j3
         v5vDM5+zlJC1z/XLi7wUBxbBa2667fvFcMtDdOzIL7aqihMTVhD/73xECsZNQITcs+
         ebUiZLZJLmgopVqU8v7w+lPr0IuDfs0JiXnssVU0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200618154020eucas1p1fdd8a2f01d9531033041feeccd834b08~ZrZoTA22C0074000740eucas1p10;
        Thu, 18 Jun 2020 15:40:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.CE.60679.4EA8BEE5; Thu, 18
        Jun 2020 16:40:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200618154020eucas1p2b1cc0b386396bd09b735cc9d06906082~ZrZn_Vnfu0608006080eucas1p2N;
        Thu, 18 Jun 2020 15:40:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618154020eusmtrp297d2caa0103f91831151757ed2ca195a~ZrZn9Z2V40399203992eusmtrp2V;
        Thu, 18 Jun 2020 15:40:20 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-26-5eeb8ae4a465
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.EE.08375.4EA8BEE5; Thu, 18
        Jun 2020 16:40:20 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154019eusmtip1cdb1619afa0bc2257d86f26de1caacce~ZrZnRn8rQ0833608336eusmtip1O;
        Thu, 18 Jun 2020 15:40:19 +0000 (GMT)
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v6 09/36] drm: i915: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 17:39:30 +0200
Message-Id: <20200618153956.29558-10-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjmPefs7Dhcnabg19UYXUgw0yK+KKKL0Yn6oWR/Is1ZJ5V06uay
        BZErLFspU0PFUpcF1szmdZoW2rwsM7VyDUUl04JMwsoVXbTlPGr/nvd5nvd7Hl4+hpS1iJYx
        scpkXqVUxMlpCWVp/9Xj/14/HrHpcu1KnNHdQeDKfLMIuyxZJLZ/n6Dx/bI2At80VBPY2LQd
        l/aaAT+5TWCn/R2Bq0YdItzbcIvG5a1DYvz0y3sRbipwiHct5h4UPQDuyQ8jxd15PEZwdT+G
        RVxRRyj39pqN4KrvXuAG/o6SXE5fKXCN/ak0l1ljAm6yalWI51HJjpN8XOwZXhWwM1ISU2Yq
        pBKNK84W29ekgs1HDx4MYregvl92sR4kjIy9B6jKYKSFwQmo/s/EnDIJ6M03Mzm/Yh3LBUEo
        BdR8JR0WVkxDA2K3i2YDkf6znnZjbzYN0LMMT7eJZFtJ9NroALfgxYagytoaQg8MQ7Fr0c8b
        W920lN2JXgzXz6X5orKK5lnsMcN32tJE7ncQ6xCjN66vlGAKRqWtFXPYC32y1YgFvAK5HhUT
        wsIlQO+6y8XCcB1Q78V8EFzb0WD3b9rdgmQ3IHNDgEDvRmMt07PlELsI9X1e4qbJGZhtySMF
        WorSL8sE9zpUYHu4EPv05eu5/hzKcTWRwoGyADV1NVIG8C34H2YEMIEPr1HHR/PqICWfslGt
        iFdrlNEbTyTEV8HM1+r8a3PWQ8NUlBVYBuSe0o9h4xEykeKMWhtvBcSQcm/pnq7OCJn0pEJ7
        jlclHFdp4ni1FZYzlNxHurlkLFzGRiuS+dM8n8ir5lWC8ViWCsf6I6uDzLr2slw9Tty2dnV+
        ybcjfUlXRwI1Lrw3Ji8l2BDlc37J86kPSc5rg6/kbYX3ZBpT8IH+ui6/CpFlUXNGaBq4LNZp
        6rBjv1YSUKk7xLlYXbZRm+48mLH+RRgdnjRSsM+7bnPzqYGBcemrSFW4X7t/sq6wZ6k5sxgM
        ckodowj0I1VqxT8EuuQBVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7pPul7HGUxawGbRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlnMnrCZyWLBfmuL5ZfXM1rsXchk8eXKQyaLTY+vsVpc3jWHzWLt
        kbvsFgc/PGG12D/rGrsDv8eaeWsYPfZ+W8DisXjPSyaP7d8esHrMOxnocb/7OJPH5iX1Hrf/
        PWb2mHxjOaPH7psNbB59W1YxenzeJBfAE6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CXsXrVXJaCBTIV86+oNDAeF+9i5OSQEDCROPRyGiOILSSw
        lFFi5TIriLiMxMlpDawQtrDEn2tdbF2MXEA1nxglHrT2gyXYBAwlut5CJEQEOhklpnV/ZAdJ
        MAucYZb4vcEbxBYW8JN4NeM3UAMHB4uAqsSPKWYgYV4BO4kzD3YwQyyQl1i94QCYzQkUP328
        lRXiIFuJ5x/a2CYw8i1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGD/bjv3cvIPx0sbg
        Q4wCHIxKPLwvQl7HCbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQTROZ
        pUST84GxnVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTHw11z2
        6PCT685wfP8oXrLCl1lff1aXxvWdl0xc36+IELx6uOVGKOOJHZWak1y4d/daMj4NebTK8aep
        90Tu4CN8EW1qlVU7r1Xs61cTVVgi/Tnxxmm9E0wzIu6ufDHb52f8gbm6h5a7alh4Cr2c2KEQ
        EPS233VWD8ecg9P5d68/KbTMarFG010lluKMREMt5qLiRAAR+nxFtQIAAA==
X-CMS-MailID: 20200618154020eucas1p2b1cc0b386396bd09b735cc9d06906082
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154020eucas1p2b1cc0b386396bd09b735cc9d06906082
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154020eucas1p2b1cc0b386396bd09b735cc9d06906082
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154020eucas1p2b1cc0b386396bd09b735cc9d06906082@eucas1p2.samsung.com>
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

This driver creatively uses sg_table->orig_nents to store the size of the
allocated scatterlist and ignores the number of the entries returned by
dma_map_sg function. The sg_table->orig_nents is (mis)used to properly
free the (over)allocated scatterlist.

This patch only introduces the common DMA-mapping wrappers operating
directly on the struct sg_table objects to the dmabuf related functions,
so the other drivers, which might share buffers with i915 could rely on
the properly set nents and orig_nents values.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c       | 11 +++--------
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c |  7 +++----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index 2679380159fc..8a988592715b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -48,12 +48,9 @@ static struct sg_table *i915_gem_map_dma_buf(struct dma_buf_attachment *attachme
 		src = sg_next(src);
 	}
 
-	if (!dma_map_sg_attrs(attachment->dev,
-			      st->sgl, st->nents, dir,
-			      DMA_ATTR_SKIP_CPU_SYNC)) {
-		ret = -ENOMEM;
+	ret = dma_map_sgtable(attachment->dev, st, dir, DMA_ATTR_SKIP_CPU_SYNC);
+	if (ret)
 		goto err_free_sg;
-	}
 
 	return st;
 
@@ -73,9 +70,7 @@ static void i915_gem_unmap_dma_buf(struct dma_buf_attachment *attachment,
 {
 	struct drm_i915_gem_object *obj = dma_buf_to_obj(attachment->dmabuf);
 
-	dma_unmap_sg_attrs(attachment->dev,
-			   sg->sgl, sg->nents, dir,
-			   DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(attachment->dev, sg, dir, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
index debaf7b18ab5..be30b27e2926 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
@@ -28,10 +28,9 @@ static struct sg_table *mock_map_dma_buf(struct dma_buf_attachment *attachment,
 		sg = sg_next(sg);
 	}
 
-	if (!dma_map_sg(attachment->dev, st->sgl, st->nents, dir)) {
-		err = -ENOMEM;
+	err = dma_map_sgtable(attachment->dev, st, dir, 0);
+	if (err)
 		goto err_st;
-	}
 
 	return st;
 
@@ -46,7 +45,7 @@ static void mock_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			       struct sg_table *st,
 			       enum dma_data_direction dir)
 {
-	dma_unmap_sg(attachment->dev, st->sgl, st->nents, dir);
+	dma_unmap_sgtable(attachment->dev, st, dir, 0);
 	sg_free_table(st);
 	kfree(st);
 }
-- 
2.17.1

