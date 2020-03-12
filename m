Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FCBC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D287F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVDqfbe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCLNIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:08:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40613 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725268AbgCLNIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584018516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=S6bzV9J0z/IVD/ibu5hpuBEpz5XNYpk50t3w61vNfkc=;
        b=ZVDqfbe1gBtRar3+51oD0XynDDnqtK/tYcxJ1zsBYvaBU+G8FWYGvOySWpBUwE5tCIxG3F
        nsUlt7c1oaUiSLZo/gWSGrbPrQkZVcV71pziiHD38fN7J9MzGrbd/I2CKoc2qmEcv7YV2e
        0FbMIy8HTtKwyIC2B3uBuLf26jqRyO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-nM0-vi0hOVqePh4H10z_BQ-1; Thu, 12 Mar 2020 09:08:30 -0400
X-MC-Unique: nM0-vi0hOVqePh4H10z_BQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10F35107ACCA;
        Thu, 12 Mar 2020 13:08:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A678093501;
        Thu, 12 Mar 2020 13:08:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com, richard.weiyang@gmail.com, bhe@redhat.com
Subject: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free memmap for the classic sparse
Date:   Thu, 12 Mar 2020 21:08:22 +0800
Message-Id: <20200312130822.6589-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes populate_section_memmap()/depopulate_section_memmap
much simpler.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  The old version only used __get_free_pages() to replace alloc_pages()
  in populate_section_memmap().
  http://lkml.kernel.org/r/20200307084229.28251-8-bhe@redhat.com

 mm/sparse.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index bf6c00a28045..362018e82e22 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -734,35 +734,14 @@ static void free_map_bootmem(struct page *memmap)
 struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	struct page *page, *ret;
-	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
-
-	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
-	if (page)
-		goto got_map_page;
-
-	ret = vmalloc(memmap_size);
-	if (ret)
-		goto got_map_ptr;
-
-	return NULL;
-got_map_page:
-	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
-got_map_ptr:
-
-	return ret;
+	return kvmalloc_node(sizeof(struct page) * PAGES_PER_SECTION,
+			     GFP_KERNEL|__GFP_NOWARN, nid);
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
-	struct page *memmap = pfn_to_page(pfn);
-
-	if (is_vmalloc_addr(memmap))
-		vfree(memmap);
-	else
-		free_pages((unsigned long)memmap,
-			   get_order(sizeof(struct page) * PAGES_PER_SECTION));
+	kvfree(pfn_to_page(pfn));
 }
 
 static void free_map_bootmem(struct page *memmap)
-- 
2.17.2

