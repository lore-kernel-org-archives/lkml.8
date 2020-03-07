Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB94BC10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C602073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8kPNkhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgCGImw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:42:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726300AbgCGImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583570570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=3I58kNMw4Ar5Co4wpTMZDuSr9j+kDye6OmidnFJxoZs=;
        b=B8kPNkhX5P11ys7qiCRc/ZoQEsEHa/vd+W9lhi3QFYa3roiPh6Gic3NXQBIkoONGQuZsS6
        v3BRP+L/7yg0q9X2CN3iwnUgIaez50s7F1pDX7qBymu7xxY4qvwdXERn6GuLcTKLWHlhE4
        yz2LYl4yXusHp9IiR8T7lmn0j/LhVoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-9Eg96WkBM2CFM5tUlM-XRQ-1; Sat, 07 Mar 2020 03:42:46 -0500
X-MC-Unique: 9Eg96WkBM2CFM5tUlM-XRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFB5513F5;
        Sat,  7 Mar 2020 08:42:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C72735D9CA;
        Sat,  7 Mar 2020 08:42:41 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com,
        bhe@redhat.com
Subject: [PATCH v3 2/7] mm/sparse.c: introduce new function fill_subsection_map()
Date:   Sat,  7 Mar 2020 16:42:24 +0800
Message-Id: <20200307084229.28251-3-bhe@redhat.com>
In-Reply-To: <20200307084229.28251-1-bhe@redhat.com>
References: <20200307084229.28251-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code that fills the subsection map from section_activate()
into fill_subsection_map(), this makes section_activate() cleaner and
easier to follow.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/sparse.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 1b50c15677d7..e37c0abcdc89 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -792,24 +792,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		ms->section_mem_map = (unsigned long)NULL;
 }
 
-static struct page * __meminit section_activate(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
-	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
 	struct mem_section *ms = __pfn_to_section(pfn);
-	struct mem_section_usage *usage = NULL;
+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
 	unsigned long *subsection_map;
-	struct page *memmap;
 	int rc = 0;
 
 	subsection_mask_set(map, pfn, nr_pages);
 
-	if (!ms->usage) {
-		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
-		if (!usage)
-			return ERR_PTR(-ENOMEM);
-		ms->usage = usage;
-	}
 	subsection_map = &ms->usage->subsection_map[0];
 
 	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
@@ -820,6 +811,25 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		bitmap_or(subsection_map, map, subsection_map,
 				SUBSECTIONS_PER_SECTION);
 
+	return rc;
+}
+
+static struct page * __meminit section_activate(int nid, unsigned long pfn,
+		unsigned long nr_pages, struct vmem_altmap *altmap)
+{
+	struct mem_section *ms = __pfn_to_section(pfn);
+	struct mem_section_usage *usage = NULL;
+	struct page *memmap;
+	int rc = 0;
+
+	if (!ms->usage) {
+		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
+		if (!usage)
+			return ERR_PTR(-ENOMEM);
+		ms->usage = usage;
+	}
+
+	rc = fill_subsection_map(pfn, nr_pages);
 	if (rc) {
 		if (usage)
 			ms->usage = NULL;
-- 
2.17.2

