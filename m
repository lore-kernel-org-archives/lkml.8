Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F84C54E95
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCB720714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QTsmdUiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgELJDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:03:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34327 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgELJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:01:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200512090115euoutp01103448f9c7ba925d342f7a3efd744746~OPFnW1-vc2633726337euoutp01F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:01:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200512090115euoutp01103448f9c7ba925d342f7a3efd744746~OPFnW1-vc2633726337euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589274075;
        bh=H+PGsyjqkAzIq5fOyiAyZbqSQ8e5q8398iB2UvD4eqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTsmdUiISAy2LGwECp6R47uAtsixPV8AyYRZkGI2jdruKRHtE9BPOHm6XlwHkVmOi
         MQaXUuIsvlfZgxYk58gE9gZuQkp/TDpP48yKSUEPMk7NbkUOOBous4PrkDhlvhJU+O
         H/bL/XpgIYUfcF9fRBT97POsv6DVA/YTMCI53muk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200512090114eucas1p18f62a8c09947ee8e7518fcc04562ff72~OPFm5tgtS1182811828eucas1p13;
        Tue, 12 May 2020 09:01:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.22.60679.AD56ABE5; Tue, 12
        May 2020 10:01:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090114eucas1p1917c16e0312cfb191f327e6dad2f7808~OPFmlxlpI1613916139eucas1p1Z;
        Tue, 12 May 2020 09:01:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200512090114eusmtrp188a412e3f27d35f0c87dc9c1712c2b1b~OPFmlB6no0183401834eusmtrp1e;
        Tue, 12 May 2020 09:01:14 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-8f-5eba65da1b0d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 74.F2.07950.AD56ABE5; Tue, 12
        May 2020 10:01:14 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090113eusmtip195756e507e8573b43228078f6551a4ff~OPFl8aBFV1352513525eusmtip1G;
        Tue, 12 May 2020 09:01:13 +0000 (GMT)
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
Subject: [PATCH v4 12/38] drm: i915: fix common struct sg_table related
 issues
Date:   Tue, 12 May 2020 11:00:32 +0200
Message-Id: <20200512090058.14910-12-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGc2c60wGpjgXlBgVMEzSSyP4wCQTUGJ03MfHBkECtMBQCFNIB
        BF8kyKJlCUtkU7EWCLIUZBGwUJaylEIkCAQQJIBVIyBCBBEMQVsG5e0/3/3P/c+5uQQq7MPs
        iHBZLCOXSSJFuCWvZWBn5MIMowlyy1uwp7JGDAjVUFSPUX9aclFq4ucaTlXV9CPUk5wmhFJ2
        eVOV4/WA0r5AqM2JRYRqNE5i1LjmKU6p++b4VM/6J4zqKpnkXzxG15bWAlq7peTRZR1LCN26
        tYDRpYYb9HyGHqGbyu/Ts3tGlM6frgR0+/sknM5urgb0RqODv1WApU8IExkez8hdfW9bhrVV
        Z+MxY/YJhrV2LAkYoQJYEJD0gkW/slAFsCSE5EsAx9N7eVyxCWD/Si7GFRsArk9r+QpA7Lco
        O305Xglg4daPw47aymJgvhcn3aFiVYGbtQ2ZCuBglpXZhJJ9KBxTTu6brEl/WDb1bt/EI53g
        9ngBYtYC0hfW9n9FuAEdYc2rbtSsLUx8/vnufhokZ/iwpiGbz5muwKpnfTxOW8NlffMBPw2H
        8zMPGh4AuDii5nNFpmnV5CLAubzhh5HfuHk5lDwP6zWuHL4E976U49zOR+H06nEzRk0yr6UQ
        5bAAPkwTcu6zsERf9z+2Z3QM5TQNtVPJB8/YD2B67yCSAxxLDsOUAFQDWyaOjZIyrIeMuevC
        SqLYOJnUJTg6qhGY/tbwnn6zDWh27+gASQCRlcDN7U2QEJPEs4lROgAJVGQjSAk3IUGIJPEe
        I48Wy+MiGVYHThE8ka3AU7UUKCSlklgmgmFiGPm/U4SwsEsCoR8XsOs2dbK5q5Q4OHCWdjzT
        6aRaFn/bWeWL1alqCz3yOqPDeAKeMwQUD3ulND6KHz2pcu6aIQvCPMJaCwLeum77dpMbnyMu
        qz1Lb4VGRt88wiZIfRxWdMh3m8dDGj93VUWZXO5ncJ3gi4QqY9rOhDikuiI+6Jp7nW5oIFHE
        Y8Mk7s6onJX8BYgsda5XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7q3UnfFGVz/wGHRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlnMnrCZyWLBfmuL5ZfXM1rsXchk8eXKQyaLTY+vsVpc3jWHzWLt
        kbvsFgc/PGG12D/rGrsDv8eaeWsYPfZ+W8DisXjPSyaP7d8esHrMOxnocb/7OJPH5iX1Hrf/
        PWb2mHxjOaPH7psNbB59W1YxenzeJBfAE6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CXsWNVH1vBJdmKk+93szYwPpboYuTgkBAwkViwz66LkYtD
        SGApo8T2Q1PYuhg5geIyEienNbBC2MISf651sUEUfWKU+HtiKSNIgk3AUKLrLURCRKCTUWJa
        90d2kASzwBlmid8bvEFsYQE/iVvfLoJNYhFQlfhxeRoTiM0rYCex5ugLJogN8hKrNxxgBrE5
        geL35/9hAbGFBAolHl19yzKBkW8BI8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwBjaduzn
        lh2MXe+CDzEKcDAq8fB2GO2ME2JNLCuuzD3EKMHBrCTC25IJFOJNSaysSi3Kjy8qzUktPsRo
        CnTURGYp0eR8YHznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg
        DOy+NMU8vu9gdcX1xnNCN1dl6NpaTVD4yl10QWT+M90Ijeq/N9f+WFjlJRh8S8zAdOKLuQ+9
        2N+cFdssOGdu/F5/hf4fW02LFq7xd71/4tGn5qOqR2ceYnLyfvog54O3VFmPmtndzO/8Wfff
        1RZbZE41ityTvOuu/q6NR7kmxjqwOpxXYGWdr8RSnJFoqMVcVJwIAEw6RT63AgAA
X-CMS-MailID: 20200512090114eucas1p1917c16e0312cfb191f327e6dad2f7808
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200512090114eucas1p1917c16e0312cfb191f327e6dad2f7808
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090114eucas1p1917c16e0312cfb191f327e6dad2f7808
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
        <20200512090058.14910-1-m.szyprowski@samsung.com>
        <CGME20200512090114eucas1p1917c16e0312cfb191f327e6dad2f7808@eucas1p1.samsung.com>
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
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c       | 11 +++--------
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c |  7 +++----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index 7db5a79..6c67810 100644
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
index debaf7b..be30b27 100644
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
1.9.1

