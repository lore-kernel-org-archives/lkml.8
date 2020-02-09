Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2213C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83212080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtdM5CaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBIKsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:48:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37104 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgBIKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581245320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=mdBVxRpLdO0s6+uT+hO6BEgqaFn2MQXMmuMNW77AADU=;
        b=WtdM5CaAdlF0PtGuHbuIb3PWcSIuiHRBMRrmVHx6GUHorKB4WqwDT6opV4Dxd8qDDbysJb
        oAp9aLAz9U3BUnCQ+247i5y8oQb7gjwLfMUL4ehzjHtz8SNuTdaCGCP8cFNQu5EEg5rgzg
        I7mPhgIh3p+aQKNFm8y1Jc+7yCZ+OnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-QKsqChD3ODO-MNUh75hE4A-1; Sun, 09 Feb 2020 05:48:37 -0500
X-MC-Unique: QKsqChD3ODO-MNUh75hE4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D09613E5;
        Sun,  9 Feb 2020 10:48:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A40B610013A7;
        Sun,  9 Feb 2020 10:48:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH 1/7] mm/sparse.c: Introduce new function fill_subsection_map()
Date:   Sun,  9 Feb 2020 18:48:20 +0800
Message-Id: <20200209104826.3385-2-bhe@redhat.com>
In-Reply-To: <20200209104826.3385-1-bhe@redhat.com>
References: <20200209104826.3385-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the codes filling subsection map in section_activate() into
fill_subsection_map(), this makes section_activate() cleaner and
easier to follow.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index c184b69460b7..9ad741ccbeb6 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -788,24 +788,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		depopulate_section_memmap(pfn, nr_pages, altmap);
 }
 
-static struct page * __meminit section_activate(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+/**
+ * fill_subsection_map - fill subsection map of a memory region
+ * @pfn - start pfn of the memory range
+ * @nr_pages - number of pfns to add in the region
+ *
+ * This clears the related subsection map inside one section, and only
+ * intended for hotplug.
+ *
+ * Return:
+ * * 0		- On success.
+ * * -EINVAL	- Invalid memory region.
+ * * -EEXIST	- Subsection map has been set.
+ */
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
@@ -816,6 +820,25 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
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

