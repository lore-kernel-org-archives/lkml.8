Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC80C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDAB2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ufI0TCkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgFRPmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:42:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38373 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbgFRPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154035euoutp0266807056c59817beb7890028c80f252a~ZrZ2KwJi71476714767euoutp02J
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200618154035euoutp0266807056c59817beb7890028c80f252a~ZrZ2KwJi71476714767euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494835;
        bh=aaZTZ5x9zU33iQSvUdNimV6zB4azWieuKqbzqgFwTCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufI0TCkIkyWEsTKrzhfm7RtRWwrCv9j4fMUgZas4UHEgmUfqI1ptxcc6fuNprex39
         cMPs+wHvXa8xvlTDENwoEQPExP17LNBh9ygPnka8RDv/hwH5d/t60XlVzPdYtCivWq
         GGv4S6JzdBYmrLD6Rhukuxl2mIYXIXRWuE2uzpmI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200618154034eucas1p2223ae48782e68091f46f6b558930c866~ZrZ1u8puc0501005010eucas1p2w;
        Thu, 18 Jun 2020 15:40:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FC.60.60698.2FA8BEE5; Thu, 18
        Jun 2020 16:40:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154034eucas1p1f76546f76920c48a8407bb6737a41fb8~ZrZ1auw851949419494eucas1p1P;
        Thu, 18 Jun 2020 15:40:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618154034eusmtrp2313bf3889ca98a5f7c8a5c7c72a686c5~ZrZ1Z9UrW0370403704eusmtrp2t;
        Thu, 18 Jun 2020 15:40:34 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-48-5eeb8af24791
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.FE.08375.2FA8BEE5; Thu, 18
        Jun 2020 16:40:34 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154033eusmtip1382c83db1d245c08d12c5a28e46cbfdf~ZrZ0hRlje0864308643eusmtip1N;
        Thu, 18 Jun 2020 15:40:33 +0000 (GMT)
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
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org
Subject: [PATCH v6 29/36] staging: ion: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 17:39:50 +0200
Message-Id: <20200618153956.29558-30-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUyNURzHnee9O9cet7bOYmu7ZEIlsZ2NtV6MsxkzbDXj6tKzXHWr3aeQ
        f1xCdpVUNq2JkEI3vdCNSrmJW9LVqJRKkVGSK72MovT0ePnv8/t+v7/zO7+zw5GqYdqN00XH
        CYZobZSaUVCWJz+ee30zDWpW1r9ejVLsDQRy/OphUElmEY2OfVmEpi1pJKp6NsGiljEHgxKv
        FTHoZsFjAuXUrEV5Rg90s+o7gUZb3hKotK+NRi8rLjKosK6bRRazkUbWr+9p9LR7hEU5bRNs
        gAu2VFpobL5kBvhX9jCJ31Q/ovCD8RwKX/k2RuOutioGl4/30rgm28zinjM2At/JPYo7p/pI
        nNGeD3Blh5HBjupWBp+9ewtsnb9TsS5ciNIdFAw+/mGK/ZPnW8nYoXWHU+3nSSNIX2UCThzk
        V8OqznzSBBScir8BYEN7OSEZKn4UwJ7kYNkYAbAlt4A1AW6246MxVNbzAezNus7IxUxDR2cT
        K3UzvC80DZkYiV34kwDWp8yVQiSfTMOB4uJZw5nfDj8MPqQkpngPOFWaR0us5P1hV10ZLd/P
        HRYUPyQldprRG20naekgyF/hYHJZ65/Qenj/UzclszP8ZLvLyrwQTt+/TMgNiQC+tReycpEM
        4MvjmUBOrYVd9glGWo7kPWFRhY8sB8LHpgFG3nkebB+aL8nkDKZbLpCyrISnT6nk9BKYZbv9
        b6y1+QUpM4ZWaxIlv1AagKnmz/Q54J71f1gOALeAqxAv6iME0S9aOOQtavVifHSE974YfSmY
        +YiNU7axe6D6595awHNAPVfZv2NQo6K1B8UEfS2AHKl2UQY1NWpUynBtwhHBELPHEB8liLVg
        AUepXZV+Vwd2q/gIbZwQKQixguGvS3BObkbgUeK2u2R54PQW9zyl36jujG5NW2BGqLapTB3j
        um1paLZi8aPPW/So0HpoMax73ezVsils6Z5KlOAWEly04WnAaN+iwQ+bd+nyHOGec/xSMxs1
        4cZTaXtHepPGiXpH64lJr/KGXa8y++veXXAOWbXRYN8nalbcUcMDkcNXdwaFlYeqKXG/1ncZ
        aRC1vwFfrLEnhAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7qful7HGWx9pmDRe+4kk8X7v/fZ
        LDbOWM9q0fhO2eL/tonMFnvO/GK3uPL1PZtF8+L1bBYrVx9lsliw39piWYOqxco9P5gsvlx5
        yGSx6fE1VovLu+awWaw9cpfdYtuaBlaLgx+esFqcuvuZ3WLBtV/sDiIe23ZvY/VYM28No8ff
        uR+ZPe7tO8zisffbAhaPhZ++snrcubaHzWP7twesHvvnrmH3uN99nMlj85J6j9v/HjN7TL6x
        nNFj980GNo/3+66yefRtWcUYIBilZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
        qqRvZ5OSmpNZllqkb5egl/F7ylXmgrc2Ff3npjA3ME4y6mLk4JAQMJF43hDRxcjFISSwlFHi
        y6rZrF2MnEBxGYmT0xqgbGGJP9e62EBsIYFPjBK3TkqB2GwChhJdb0HiXBwiAp2MEtO6P7KD
        OMwCM1gl1h24xw5SJSwQKLGm5xPYJBYBVYl/m5aB2bwCdhJ3jmyF2iAvsXrDAWYQmxMofvp4
        KyvENluJ5x/a2CYw8i1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGJ/bjv3cvIPx0sbg
        Q4wCHIxKPLwvQl7HCbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQUROZ
        pUST84GpI68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PAOcNN
        rr+FrfKLkkT7T/QpKWz69fRSkeb3FcoLTZcseZbGdqt0hkGt2uEfAVXVFtbBX4uYuio+zv0/
        4/qx1C+3mBkzvlsZ9aed2qouf/Rpxt2bc29ePL3KOVj4+Obwk5VKl5f81bYIPb20fEnN59Zr
        3X/mcQY492/SuvSZ70LRUda3iuKtBSJKLMUZiYZazEXFiQBoGbGY5QIAAA==
X-CMS-MailID: 20200618154034eucas1p1f76546f76920c48a8407bb6737a41fb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154034eucas1p1f76546f76920c48a8407bb6737a41fb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154034eucas1p1f76546f76920c48a8407bb6737a41fb8
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154034eucas1p1f76546f76920c48a8407bb6737a41fb8@eucas1p1.samsung.com>
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
---
 drivers/staging/android/ion/ion.c             | 25 +++++------
 drivers/staging/android/ion/ion_heap.c        | 44 ++++++-------------
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 3 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 38b51eace4f9..3c9f09506ffa 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -147,14 +147,14 @@ static struct sg_table *dup_sg_table(struct sg_table *table)
 	if (!new_table)
 		return ERR_PTR(-ENOMEM);
 
-	ret = sg_alloc_table(new_table, table->nents, GFP_KERNEL);
+	ret = sg_alloc_table(new_table, table->orig_nents, GFP_KERNEL);
 	if (ret) {
 		kfree(new_table);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	new_sg = new_table->sgl;
-	for_each_sg(table->sgl, sg, table->nents, i) {
+	for_each_sgtable_sg(table, sg, i) {
 		memcpy(new_sg, sg, sizeof(*sg));
 		new_sg->dma_address = 0;
 		new_sg = sg_next(new_sg);
@@ -224,12 +224,13 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 {
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct sg_table *table;
+	int ret;
 
 	table = a->table;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
-		return ERR_PTR(-ENOMEM);
+	ret = dma_map_sgtable(attachment->dev, table, direction, 0);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return table;
 }
@@ -238,7 +239,7 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sgtable(attachment->dev, table, direction, 0);
 }
 
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
@@ -296,10 +297,8 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	}
 
 	mutex_lock(&buffer->lock);
-	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
-				    direction);
-	}
+	list_for_each_entry(a, &buffer->attachments, list)
+		dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
 
 unlock:
 	mutex_unlock(&buffer->lock);
@@ -319,10 +318,8 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 	}
 
 	mutex_lock(&buffer->lock);
-	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
-				       direction);
-	}
+	list_for_each_entry(a, &buffer->attachments, list)
+		dma_sync_sgtable_for_device(a->dev, a->table, direction);
 	mutex_unlock(&buffer->lock);
 
 	return 0;
diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 9c23b2382a1e..79f27949edda 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -20,8 +20,7 @@
 void *ion_heap_map_kernel(struct ion_heap *heap,
 			  struct ion_buffer *buffer)
 {
-	struct scatterlist *sg;
-	int i, j;
+	struct sg_page_iter piter;
 	void *vaddr;
 	pgprot_t pgprot;
 	struct sg_table *table = buffer->sg_table;
@@ -38,14 +37,11 @@ void *ion_heap_map_kernel(struct ion_heap *heap,
 	else
 		pgprot = pgprot_writecombine(PAGE_KERNEL);
 
-	for_each_sg(table->sgl, sg, table->nents, i) {
-		int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
-		struct page *page = sg_page(sg);
-
-		BUG_ON(i >= npages);
-		for (j = 0; j < npages_this_entry; j++)
-			*(tmp++) = page++;
+	for_each_sgtable_page(table, &piter, 0) {
+		BUG_ON(tmp - pages >= npages);
+		*tmp++ = sg_page_iter_page(&piter);
 	}
+
 	vaddr = vmap(pages, npages, VM_MAP, pgprot);
 	vfree(pages);
 
@@ -64,32 +60,19 @@ void ion_heap_unmap_kernel(struct ion_heap *heap,
 int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 		      struct vm_area_struct *vma)
 {
+	struct sg_page_iter piter;
 	struct sg_table *table = buffer->sg_table;
 	unsigned long addr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff * PAGE_SIZE;
-	struct scatterlist *sg;
-	int i;
 	int ret;
 
-	for_each_sg(table->sgl, sg, table->nents, i) {
-		struct page *page = sg_page(sg);
-		unsigned long remainder = vma->vm_end - addr;
-		unsigned long len = sg->length;
+	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
+		struct page *page = sg_page_iter_page(&piter);
 
-		if (offset >= sg->length) {
-			offset -= sg->length;
-			continue;
-		} else if (offset) {
-			page += offset / PAGE_SIZE;
-			len = sg->length - offset;
-			offset = 0;
-		}
-		len = min(len, remainder);
-		ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
+		ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
 				      vma->vm_page_prot);
 		if (ret)
 			return ret;
-		addr += len;
+		addr += PAGE_SIZE;
 		if (addr >= vma->vm_end)
 			return 0;
 	}
@@ -109,15 +92,14 @@ static int ion_heap_clear_pages(struct page **pages, int num, pgprot_t pgprot)
 	return 0;
 }
 
-static int ion_heap_sglist_zero(struct scatterlist *sgl, unsigned int nents,
-				pgprot_t pgprot)
+static int ion_heap_sglist_zero(struct sg_table *sgt, pgprot_t pgprot)
 {
 	int p = 0;
 	int ret = 0;
 	struct sg_page_iter piter;
 	struct page *pages[32];
 
-	for_each_sg_page(sgl, &piter, nents, 0) {
+	for_each_sgtable_page(sgt, &piter, 0) {
 		pages[p++] = sg_page_iter_page(&piter);
 		if (p == ARRAY_SIZE(pages)) {
 			ret = ion_heap_clear_pages(pages, p, pgprot);
@@ -142,7 +124,7 @@ int ion_heap_buffer_zero(struct ion_buffer *buffer)
 	else
 		pgprot = pgprot_writecombine(PAGE_KERNEL);
 
-	return ion_heap_sglist_zero(table->sgl, table->nents, pgprot);
+	return ion_heap_sglist_zero(table, pgprot);
 }
 
 void ion_heap_freelist_add(struct ion_heap *heap, struct ion_buffer *buffer)
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b83a1d16bd89..eac0632ab4e8 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -162,7 +162,7 @@ static void ion_system_heap_free(struct ion_buffer *buffer)
 	if (!(buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE))
 		ion_heap_buffer_zero(buffer);
 
-	for_each_sg(table->sgl, sg, table->nents, i)
+	for_each_sgtable_sg(table, sg, i)
 		free_buffer_page(sys_heap, buffer, sg_page(sg));
 	sg_free_table(table);
 	kfree(table);
-- 
2.17.1

