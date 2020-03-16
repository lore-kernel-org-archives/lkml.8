Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED811C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A1F2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVJrQU0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgCPKWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730497AbgCPKWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584354127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9AuoExRKnoesKH6vkEtuwhs5DyeCR7/IOYAGKhOXPhw=;
        b=SVJrQU0sRUGnj7UIF21i446p1xlhFuef71lVVjq75fIfba3vYGAlmywo3sLG7slFjXT5WE
        dCair2XKJe1Yb1gm5KBJdduKKE7oFPWBGaLFO4FJRLBiZVrr8hNIaw7ibwaDV/Y9fw6Jep
        8fynuN5kMePMWAmgKnEpWlUJ0vBksHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-TXJpbww_P46sqjAT3PWRHw-1; Mon, 16 Mar 2020 06:21:59 -0400
X-MC-Unique: TXJpbww_P46sqjAT3PWRHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 152C2DBAB;
        Mon, 16 Mar 2020 10:21:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AFCD93536;
        Mon, 16 Mar 2020 10:21:52 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com, willy@infradead.org, richard.weiyang@gmail.com,
        vbabka@suse.cz, bhe@redhat.com
Subject: [PATCH v4 1/2] mm/sparse.c: Use kvmalloc/kvfree to alloc/free memmap for the classic sparse
Date:   Mon, 16 Mar 2020 18:21:49 +0800
Message-Id: <20200316102150.16487-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes populate_section_memmap()/depopulate_section_memmap
much simpler.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v3->v4:
  Split the old v3 into two patches, to carve out the using 'nid'
  as preferred node to allocate memmap into a separate patch. This
  is suggested by Michal, and the carving out is put in patch 2.

v2->v3:
  Remove __GFP_NOWARN and use array_size when calling kvmalloc_node()
  per Matthew's comments.
http://lkml.kernel.org/r/20200312141749.GL27711@MiWiFi-R3L-srv

 mm/sparse.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index e747a238a860..d01d09cc7d99 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -719,35 +719,14 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
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
+	return kvmalloc(array_size(sizeof(struct page),
+			PAGES_PER_SECTION), GFP_KERNEL);
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

