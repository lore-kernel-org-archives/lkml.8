Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6532C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A420650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2SczuLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgCLOSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:18:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727123AbgCLOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584022681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PN0+tYX8KgdXWCv+Nrp54IwoeQaAKQFLSzluDVTcMDI=;
        b=a2SczuLbNuc3CqPcWncwvdgM2Z4WarstP52Xapw715cvDomDJB4kYnJNROH1uXFMPDDRYE
        SMrM7L24Vcl8j/cIUuVnZP9IYvkyCvc+fV9RmCdaS3Ebu/cpzLH+GuOYQMgX1ciIycVm3E
        10xtliXIEsVluookI/gZSN1NW3ohecE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-w_4FET2HN6WwRo9LTTW1pw-1; Thu, 12 Mar 2020 10:17:57 -0400
X-MC-Unique: w_4FET2HN6WwRo9LTTW1pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237758017DF;
        Thu, 12 Mar 2020 14:17:56 +0000 (UTC)
Received: from localhost (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDE4B19925;
        Thu, 12 Mar 2020 14:17:52 +0000 (UTC)
Date:   Thu, 12 Mar 2020 22:17:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com, richard.weiyang@gmail.com
Subject: [PATCH v3] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200312141749.GL27711@MiWiFi-R3L-srv>
References: <20200312130822.6589-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312130822.6589-1-bhe@redhat.com>
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
---
v2->v3:
  Remove __GFP_NOWARN and use array_size when calling kvmalloc_node()
  per Matthew's comments.

 mm/sparse.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index bf6c00a28045..bb99633575b5 100644
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
+	return kvmalloc_node(array_size(sizeof(struct page),
+			PAGES_PER_SECTION), GFP_KERNEL, nid);
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

