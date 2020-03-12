Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC1C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359532067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/fHN0LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCLMog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:44:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23913 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgCLMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584017074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=wNQMq0tJhfEpUBfN6GJNtCjLNm44UAy0bJ7LkswePGw=;
        b=D/fHN0LPoZpoCuUaHfYr4/WXmc+ISXgBjrM2/RFd3TWFBT8pj2n8XclTszWoOnDND1agdK
        hK5eqTvRmGVdh/r8/q445h6Fby/b6emHnmjdtiSrW+PIW+BuAeaF0KnQ0YTSnrte4YqW3O
        /VibYFINs66KKR9FWK3A/PtsQhImcYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-a3cWeK5cMCSrDbKXIkBcaQ-1; Thu, 12 Mar 2020 08:44:31 -0400
X-MC-Unique: a3cWeK5cMCSrDbKXIkBcaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B46CB13F5;
        Thu, 12 Mar 2020 12:44:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C649B8FBF9;
        Thu, 12 Mar 2020 12:44:26 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richard.weiyang@gmail.com,
        dan.j.williams@intel.com, bhe@redhat.com
Subject: [PATCH v4 2/5] mm/sparse.c: introduce a new function clear_subsection_map()
Date:   Thu, 12 Mar 2020 20:44:11 +0800
Message-Id: <20200312124414.439-3-bhe@redhat.com>
In-Reply-To: <20200312124414.439-1-bhe@redhat.com>
References: <20200312124414.439-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code which clear subsection map of one memory region from
section_deactivate() into clear_subsection_map().

And also add helper function is_subsection_map_empty() to check if
the current subsection map is empty or not.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/sparse.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 5919bc5b1547..0be4d4ed96de 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -726,15 +726,11 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
 	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
 	struct mem_section *ms = __pfn_to_section(pfn);
-	bool section_is_early = early_section(ms);
-	struct page *memmap = NULL;
-	bool empty;
 	unsigned long *subsection_map = ms->usage
 		? &ms->usage->subsection_map[0] : NULL;
 
@@ -745,8 +741,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
 				"section already deactivated (%#lx + %ld)\n",
 				pfn, nr_pages))
-		return;
+		return -EINVAL;
 
+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
+	return 0;
+}
+
+static bool is_subsection_map_empty(struct mem_section *ms)
+{
+	return bitmap_empty(&ms->usage->subsection_map[0],
+			    SUBSECTIONS_PER_SECTION);
+}
+
+static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap)
+{
+	struct mem_section *ms = __pfn_to_section(pfn);
+	bool section_is_early = early_section(ms);
+	struct page *memmap = NULL;
+	bool empty;
+
+	if (clear_subsection_map(pfn, nr_pages))
+		return;
 	/*
 	 * There are 3 cases to handle across two configurations
 	 * (SPARSEMEM_VMEMMAP={y,n}):
@@ -764,8 +780,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 *
 	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
 	 */
-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
-	empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
+	empty = is_subsection_map_empty(ms);
 	if (empty) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
-- 
2.17.2

