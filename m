Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B418C35254
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C92080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESovpFUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgBIKsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:48:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727716AbgBIKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581245329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=cyQkz0IDAp8YMg8SL+7hb0Hu6kCeVjMVDG1Pwv2+n44=;
        b=ESovpFUo8ThkEJzCFo9aEQ6kVfN3L9jBdRv2drbJx8dtkoPAjUam20d+3KGwByzf64oI5z
        DBRG+njqL+eLqk7ZxDezKmufhNdMDi0wO+FrRPryhP8zOl3tUAS6Ux6RLxCs7G2AR4yxAp
        ni/5bN3UPpRkCU7FNVc7Zg7CxFStMPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-nuHf9OQHP6e8st3LnJLrKw-1; Sun, 09 Feb 2020 05:48:47 -0500
X-MC-Unique: nuHf9OQHP6e8st3LnJLrKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE4A6107ACC4;
        Sun,  9 Feb 2020 10:48:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E54510013A7;
        Sun,  9 Feb 2020 10:48:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH 4/7] mm/sparse.c: Use __get_free_pages() instead in populate_section_memmap()
Date:   Sun,  9 Feb 2020 18:48:23 +0800
Message-Id: <20200209104826.3385-5-bhe@redhat.com>
In-Reply-To: <20200209104826.3385-1-bhe@redhat.com>
References: <20200209104826.3385-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the unnecessary goto, and simplify codes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index cf55d272d0a9..36e6565ec67e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -751,23 +751,19 @@ static void free_map_bootmem(struct page *memmap)
 struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	struct page *page, *ret;
+	struct page *ret;
 	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
 
-	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
-	if (page)
-		goto got_map_page;
+	ret = (void*)__get_free_pages(GFP_KERNEL|__GFP_NOWARN,
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

