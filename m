Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0389CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA473205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6Iuv0AR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgCPMzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:55:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50861 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731136AbgCPMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584363300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4Qyb2MdN0LHuNYPnyEAGuni/fmEz9gabyL6ZPulh44=;
        b=L6Iuv0ARCHjidbzA3NIJ80D+FPNQAAG+xobhX2hYMtv+OwBybESrOtv1PF+/n9dLBnLS6y
        BrEdOKfXsKp7NFowdsmj2BVCbiGsU0mKM6n+8otOZNL4jeB16i4iozyZN9YbgHPCuN4cG9
        6hKN3d0+3XwCKg8tCU2m6LuqAlGM5xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-38hwzJ6MMqqjkEIByTaYYQ-1; Mon, 16 Mar 2020 08:54:58 -0400
X-MC-Unique: 38hwzJ6MMqqjkEIByTaYYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9953DB70;
        Mon, 16 Mar 2020 12:54:56 +0000 (UTC)
Received: from localhost (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C98EC19C4F;
        Mon, 16 Mar 2020 12:54:53 +0000 (UTC)
Date:   Mon, 16 Mar 2020 20:54:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com, willy@infradead.org, richard.weiyang@gmail.com,
        vbabka@suse.cz
Subject: [PATCH v5 1/2] mm/sparse.c: Use kvmalloc/kvfree to alloc/free memmap
 for the classic sparse
Message-ID: <20200316125450.GG3486@MiWiFi-R3L-srv>
References: <20200316102150.16487-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316102150.16487-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/sparse.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index e747a238a860..3fa407d7f70a 100644
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
+				   PAGES_PER_SECTION), GFP_KERNEL);
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

