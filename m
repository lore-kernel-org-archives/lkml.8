Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529A12072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxHcnnfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbgFWMIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:08:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23818 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732333AbgFWMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592914109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ViGxFrmAKxAjcAMItQ3yJ5NR+d/lYg2p2N4cNIacjM4=;
        b=MxHcnnfY4F1ea2reXSD/Eu7X0ORkeDlfmhzLyk7guQfxMmemJ8ZWYex/brR7jj4Ee/ZKo2
        5AiN5dugur5zVHBl5H59LfQ6lXAfW/QdCPuvNqZYWjukALxiErnIlFGO3ZIe2wFlHCAZI7
        SIfsAk8apK5/nSZZxjy5PE2+PIgz/RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-VDK155b3PuKYRbDgZ7WDrg-1; Tue, 23 Jun 2020 08:08:27 -0400
X-MC-Unique: VDK155b3PuKYRbDgZ7WDrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84AAD8035B9;
        Tue, 23 Jun 2020 12:08:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF2895DAA0;
        Tue, 23 Jun 2020 12:07:59 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        jean-philippe@linaro.org, bbhushan2@marvell.com
Subject: [PATCH v2] dma-remap: Align the size in dma_common_*_remap()
Date:   Tue, 23 Jun 2020 14:07:55 +0200
Message-Id: <20200623120755.27710-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a guest with a virtio-iommu protecting virtio devices
is broken since commit 515e5b6d90d4 ("dma-mapping: use vmap insted
of reimplementing it"). Before the conversion, the size was
page aligned in __get_vm_area_node(). Doing so fixes the
regression.

Fixes: 515e5b6d90d4 ("dma-mapping: use vmap insted of reimplementing it")
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- fix line over 80 characters
---
 kernel/dma/remap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index e739a6eea6e7..78b23f089cf1 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -24,7 +24,8 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 {
 	void *vaddr;
 
-	vaddr = vmap(pages, size >> PAGE_SHIFT, VM_DMA_COHERENT, prot);
+	vaddr = vmap(pages, PAGE_ALIGN(size) >> PAGE_SHIFT,
+		     VM_DMA_COHERENT, prot);
 	if (vaddr)
 		find_vm_area(vaddr)->pages = pages;
 	return vaddr;
@@ -37,7 +38,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 void *dma_common_contiguous_remap(struct page *page, size_t size,
 			pgprot_t prot, const void *caller)
 {
-	int count = size >> PAGE_SHIFT;
+	int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page **pages;
 	void *vaddr;
 	int i;
-- 
2.20.1

