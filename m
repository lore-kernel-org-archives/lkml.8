Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E32BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E2F2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6pKp6wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCLMoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:44:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31944 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727193AbgCLMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584017075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9PXhNxPi/CfCvCFsszvCkwjev77Xv7Ik9WAVL6qcxUU=;
        b=g6pKp6wkCvP0J01SG6dVOq+AcVzQtNEKA0dV72Jwre3ea3ttiGRZ4lFLUSvpUfZvAl3qpz
        RTzDmN2IGXYcLK8B06YGztdDEFXyLgwb/eVDssE5NetDus7Y9s0OykTXCQGPOkRXOQ/LEx
        T4M/TbFifAuaf4bX32HRx1QiBieBGig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-aHxmy7g4PRiCYjWFfOOQxA-1; Thu, 12 Mar 2020 08:44:34 -0400
X-MC-Unique: aHxmy7g4PRiCYjWFfOOQxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 111AF100550E;
        Thu, 12 Mar 2020 12:44:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43CB68AC34;
        Thu, 12 Mar 2020 12:44:29 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richard.weiyang@gmail.com,
        dan.j.williams@intel.com, bhe@redhat.com
Subject: [PATCH v4 3/5] mm/sparse.c: only use subsection map in VMEMMAP case
Date:   Thu, 12 Mar 2020 20:44:12 +0800
Message-Id: <20200312124414.439-4-bhe@redhat.com>
In-Reply-To: <20200312124414.439-1-bhe@redhat.com>
References: <20200312124414.439-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, to support subsection aligned memory region adding for pmem,
subsection map is added to track which subsection is present.

However, config ZONE_DEVICE depends on SPARSEMEM_VMEMMAP. It means
subsection map only makes sense when SPARSEMEM_VMEMMAP enabled. For the
classic sparse, it's meaningless. Even worse, it may confuse people when
checking code related to the classic sparse.

About the classic sparse which doesn't support subsection hotplug, Dan
said it's more because the effort and maintenance burden outweighs the
benefit. Besides, the current 64 bit ARCHes all enable
SPARSEMEM_VMEMMAP_ENABLE by default.

Combining the above reasons, no need to provide subsection map and the
relevant handling for the classic sparse. Let's remove them.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h |  2 ++
 mm/sparse.c            | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 42b77d3b68e8..f3f264826423 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1143,7 +1143,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
+#endif
 	/* See declaration of similar field in struct zone */
 	unsigned long pageblock_flags[0];
 };
diff --git a/mm/sparse.c b/mm/sparse.c
index 0be4d4ed96de..117fe4554c38 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -209,6 +209,7 @@ static inline unsigned long first_present_section_nr(void)
 	return next_present_section_nr(-1);
 }
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 		unsigned long nr_pages)
 {
@@ -243,6 +244,11 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
 		nr_pages -= pfns;
 	}
 }
+#else
+void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
+{
+}
+#endif
 
 /* Record a memory area against a node. */
 void __init memory_present(int nid, unsigned long start, unsigned long end)
@@ -726,6 +732,7 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
@@ -752,6 +759,17 @@ static bool is_subsection_map_empty(struct mem_section *ms)
 	return bitmap_empty(&ms->usage->subsection_map[0],
 			    SUBSECTIONS_PER_SECTION);
 }
+#else
+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
+{
+	return 0;
+}
+
+static bool is_subsection_map_empty(struct mem_section *ms)
+{
+	return true;
+}
+#endif
 
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
@@ -807,6 +825,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		ms->section_mem_map = (unsigned long)NULL;
 }
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
@@ -828,6 +847,12 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 
 	return rc;
 }
+#else
+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
+{
+	return 0;
+}
+#endif
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap)
-- 
2.17.2

