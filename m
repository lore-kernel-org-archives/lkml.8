Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031BEC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69AE24676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+JjR+SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBTEeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 23:34:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24984 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbgBTEeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582173256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=WBTkH8NFztz9hV99W9A9KyCR3kKGKSPFetvSYFlBOK4=;
        b=U+JjR+SRWurzsjjw2UUiGgelx1EiiI8apnj5j3hSlID18RJbNaCNBuH3XmLq1poDHT7X3I
        Kg+nuX0cN4ClAVbXCa69gSX/AGam7D6xUPPsIizDWIbYl/r0XKtMAoai4d1kIXFxv3eewx
        JiDOIDsa09FWyL1OZDiU/7nsi72gZEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-9XzCVf-KMBCXGMKnWeEqWA-1; Wed, 19 Feb 2020 23:34:10 -0500
X-MC-Unique: 9XzCVf-KMBCXGMKnWeEqWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C866800D53;
        Thu, 20 Feb 2020 04:34:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2356C5DA60;
        Thu, 20 Feb 2020 04:33:59 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, bhe@redhat.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: [PATCH v2 7/7] mm/sparse.c: Use __get_free_pages() instead in populate_section_memmap()
Date:   Thu, 20 Feb 2020 12:33:16 +0800
Message-Id: <20200220043316.19668-8-bhe@redhat.com>
In-Reply-To: <20200220043316.19668-1-bhe@redhat.com>
References: <20200220043316.19668-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the unnecessary goto, and simplify codes.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/sparse.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 053d6c2e5c1f..572b71bd15aa 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -754,23 +754,19 @@ static void free_map_bootmem(struct page *memmap)
 struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	struct page *page, *ret;
+	struct page *ret;
 	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
 
-	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
-	if (page)
-		goto got_map_page;
+	ret = (void *)__get_free_pages(GFP_KERNEL|__GFP_NOWARN,
+				get_order(memmap_size));
+	if (ret)
+		return ret;
 
 	ret = vmalloc(memmap_size);
 	if (ret)
-		goto got_map_ptr;
+		return ret;
 
 	return NULL;
-got_map_page:
-	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
-got_map_ptr:
-
-	return ret;
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
-- 
2.17.2

