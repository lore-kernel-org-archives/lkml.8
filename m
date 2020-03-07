Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4757DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8492073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMWTVDli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCGInN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:43:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53455 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgCGInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583570591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=sqCI2BvhQCJu+cPbshTHX5pDVL6+7oOjdthUCpkDcYg=;
        b=KMWTVDliPQPwF21JSVnkEtPLmhFKeSqPZYbFY0PeNEPig49Y/5F4DUEKauzYv1NMIg+cPB
        axspg7V6SJeuY0s2WHqD5vTkcOQ0iVffGeXiedRnkmWewo97TXp6SQ5Z+QYm60yrmN0iK5
        Jk9gD4SrglZqRMZ36ybpWQM1UAbhFDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-WNqoA4ORPDKCNFMxQFxLRw-1; Sat, 07 Mar 2020 03:43:07 -0500
X-MC-Unique: WNqoA4ORPDKCNFMxQFxLRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E60BA13EA;
        Sat,  7 Mar 2020 08:43:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1DEC5D9CA;
        Sat,  7 Mar 2020 08:43:02 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com,
        bhe@redhat.com
Subject: [PATCH v3 7/7] mm/sparse.c: Use __get_free_pages() instead in populate_section_memmap()
Date:   Sat,  7 Mar 2020 16:42:29 +0800
Message-Id: <20200307084229.28251-8-bhe@redhat.com>
In-Reply-To: <20200307084229.28251-1-bhe@redhat.com>
References: <20200307084229.28251-1-bhe@redhat.com>
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
index fde651ab8741..266f7f5040fb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -735,23 +735,19 @@ static void free_map_bootmem(struct page *memmap)
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

