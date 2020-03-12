Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEEB2074D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf8Pie3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCLMoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:44:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgCLMoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584017069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kcIrXa6UCqDdloVnhXS6o2oKEe07n6dSzxQ4vOV2dfo=;
        b=Hf8Pie3u5LVqQYs5k8tckzerUAiOproTCJG/55UvXk4hAOlCvqlJshc5C52Va9v7nu4r/4
        bqkfR+tnW6PMaNaLZrL1IMCDVC1bNujnUsW1Y0XGja+WoC8jP5kBVdj43A952whldS0ezL
        2yKPfgzBDZjDYEprh+Nb+q4UMJIJ1po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-xdnrvbUnMJqfZS_Dp2AEnA-1; Thu, 12 Mar 2020 08:44:27 -0400
X-MC-Unique: xdnrvbUnMJqfZS_Dp2AEnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 464298010EA;
        Thu, 12 Mar 2020 12:44:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65F3E907F7;
        Thu, 12 Mar 2020 12:44:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richard.weiyang@gmail.com,
        dan.j.williams@intel.com, bhe@redhat.com
Subject: [PATCH v4 1/5] mm/sparse.c: introduce new function fill_subsection_map()
Date:   Thu, 12 Mar 2020 20:44:10 +0800
Message-Id: <20200312124414.439-2-bhe@redhat.com>
In-Reply-To: <20200312124414.439-1-bhe@redhat.com>
References: <20200312124414.439-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code that fills the subsection map from section_activate()
into fill_subsection_map(), this makes section_activate() cleaner and
easier to follow.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/sparse.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index cf28505e82c5..5919bc5b1547 100644
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

