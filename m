Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9985C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B922820732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/LBYyT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgFVUXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:23:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728372AbgFVUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592857417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=09H//9zX7bsIJ9e/s6dCG6RDIhWPY+AfL8sPKg/K0oc=;
        b=D/LBYyT4Yi7sgAuyS5uNON76sCS2fvrWat6yR/VpzFFJQGgXDkHfg58Oh+13u8bT8g7ifp
        f++f5zzuOdhVlfcYSboblnjHAI4BvEdGHJSo27l9bGTcQJjNdOkLS0uNdwHclm/SIfvgeu
        PBkcEC9PcyZUmSqpQOKS4AYJqjv5kU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-YcOXdOaaN6uzom3IqOeHRw-1; Mon, 22 Jun 2020 16:23:35 -0400
X-MC-Unique: YcOXdOaaN6uzom3IqOeHRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 841A71883604;
        Mon, 22 Jun 2020 20:23:33 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF45F1802B;
        Mon, 22 Jun 2020 20:23:25 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        jean-philippe@linaro.org, bbhushan2@marvell.com
Subject: [PATCH] dma-remap: Align the size in dma_common_*_remap()
Date:   Mon, 22 Jun 2020 22:23:20 +0200
Message-Id: <20200622202320.1331-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 kernel/dma/remap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index e739a6eea6e7..a3151a9b0c08 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -24,7 +24,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 {
 	void *vaddr;
 
-	vaddr = vmap(pages, size >> PAGE_SHIFT, VM_DMA_COHERENT, prot);
+	vaddr = vmap(pages, PAGE_ALIGN(size) >> PAGE_SHIFT, VM_DMA_COHERENT, prot);
 	if (vaddr)
 		find_vm_area(vaddr)->pages = pages;
 	return vaddr;
@@ -37,7 +37,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
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

