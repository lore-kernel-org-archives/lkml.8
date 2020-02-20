Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E8C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27E720801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+pMHRCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBTHEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:04:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56276 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726342AbgBTHEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582182272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x9la8FY0wFPFkKJ/BbMsC9Q5fV/uDtNl9dyibYDxM6U=;
        b=a+pMHRCf5BAkaVErDCjC/I8BQerJSScIhzCa5VAA+MalPxEKRQNCuHMBk/zB+wzpX+0MZD
        ugJIJcxdf7CEv/+yIvBtxJszc0FcPUr5/Q+KxIjO/Ib6HKJkbFAHGjzFehUekz3lzWYmQ6
        5iGRKJLhsnVsKqHMzscwspz8iIg4eu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Wqfz3nBXMlyro59BFww8DA-1; Thu, 20 Feb 2020 02:04:28 -0500
X-MC-Unique: Wqfz3nBXMlyro59BFww8DA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C647A800D48;
        Thu, 20 Feb 2020 07:04:26 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19BA78C060;
        Thu, 20 Feb 2020 07:04:22 +0000 (UTC)
Date:   Thu, 20 Feb 2020 15:04:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, rppt@linux.ibm.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 6/7] mm/sparse.c: move subsection_map related codes
 together
Message-ID: <20200220070420.GD4937@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-7-bhe@redhat.com>
 <20200220061832.GE32521@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220061832.GE32521@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/20 at 02:18pm, Wei Yang wrote:
> On Thu, Feb 20, 2020 at 12:33:15PM +0800, Baoquan He wrote:
> >No functional change.
> >
> 
> Those functions are introduced in your previous patches.
> 
> Is it possible to define them close to each other at the very beginning?

Thanks for reviewing.

Do you mean to discard this patch and keep it as they are in the patch 4/7?
If yes, it's fine to me to drop it as you suggested. To me, I prefer to put
all subsection map handling codes together.

> 
> >Signed-off-by: Baoquan He <bhe@redhat.com>
> >---
> > mm/sparse.c | 172 +++++++++++++++++++++++++---------------------------
> > 1 file changed, 84 insertions(+), 88 deletions(-)
> >
> >diff --git a/mm/sparse.c b/mm/sparse.c
> >index 14bff0b44e7c..053d6c2e5c1f 100644
> >--- a/mm/sparse.c
> >+++ b/mm/sparse.c
> >@@ -244,10 +244,94 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> > 		nr_pages -= pfns;
> > 	}
> > }
> >+
> >+/**
> >+ * clear_subsection_map - Clear subsection map of one memory region
> >+ *
> >+ * @pfn - start pfn of the memory range
> >+ * @nr_pages - number of pfns to add in the region
> >+ *
> >+ * This is only intended for hotplug, and clear the related subsection
> >+ * map inside one section.
> >+ *
> >+ * Return:
> >+ * * -EINVAL	- Section already deactived.
> >+ * * 0		- Subsection map is emptied.
> >+ * * 1		- Subsection map is not empty.
> >+ */
> >+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >+{
> >+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >+	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> >+	struct mem_section *ms = __pfn_to_section(pfn);
> >+	unsigned long *subsection_map = ms->usage
> >+		? &ms->usage->subsection_map[0] : NULL;
> >+
> >+	subsection_mask_set(map, pfn, nr_pages);
> >+	if (subsection_map)
> >+		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >+
> >+	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> >+				"section already deactivated (%#lx + %ld)\n",
> >+				pfn, nr_pages))
> >+		return -EINVAL;
> >+
> >+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >+
> >+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> >+		return 0;
> >+
> >+	return 1;
> >+}
> >+
> >+/**
> >+ * fill_subsection_map - fill subsection map of a memory region
> >+ * @pfn - start pfn of the memory range
> >+ * @nr_pages - number of pfns to add in the region
> >+ *
> >+ * This fills the related subsection map inside one section, and only
> >+ * intended for hotplug.
> >+ *
> >+ * Return:
> >+ * * 0		- On success.
> >+ * * -EINVAL	- Invalid memory region.
> >+ * * -EEXIST	- Subsection map has been set.
> >+ */
> >+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >+{
> >+	struct mem_section *ms = __pfn_to_section(pfn);
> >+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >+	unsigned long *subsection_map;
> >+	int rc = 0;
> >+
> >+	subsection_mask_set(map, pfn, nr_pages);
> >+
> >+	subsection_map = &ms->usage->subsection_map[0];
> >+
> >+	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> >+		rc = -EINVAL;
> >+	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> >+		rc = -EEXIST;
> >+	else
> >+		bitmap_or(subsection_map, map, subsection_map,
> >+				SUBSECTIONS_PER_SECTION);
> >+
> >+	return rc;
> >+}
> > #else
> > void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> > {
> > }
> >+
> >+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >+{
> >+	return 0;
> >+}
> >+
> >+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >+{
> >+	return 0;
> >+}
> > #endif
> > 
> > /* Record a memory area against a node. */
> >@@ -732,52 +816,6 @@ static void free_map_bootmem(struct page *memmap)
> > }
> > #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> > 
> >-#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >-/**
> >- * clear_subsection_map - Clear subsection map of one memory region
> >- *
> >- * @pfn - start pfn of the memory range
> >- * @nr_pages - number of pfns to add in the region
> >- *
> >- * This is only intended for hotplug, and clear the related subsection
> >- * map inside one section.
> >- *
> >- * Return:
> >- * * -EINVAL	- Section already deactived.
> >- * * 0		- Subsection map is emptied.
> >- * * 1		- Subsection map is not empty.
> >- */
> >-static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >-{
> >-	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >-	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> >-	struct mem_section *ms = __pfn_to_section(pfn);
> >-	unsigned long *subsection_map = ms->usage
> >-		? &ms->usage->subsection_map[0] : NULL;
> >-
> >-	subsection_mask_set(map, pfn, nr_pages);
> >-	if (subsection_map)
> >-		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >-
> >-	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> >-				"section already deactivated (%#lx + %ld)\n",
> >-				pfn, nr_pages))
> >-		return -EINVAL;
> >-
> >-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >-
> >-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> >-		return 0;
> >-
> >-	return 1;
> >-}
> >-#else
> >-static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >-{
> >-	return 0;
> >-}
> >-#endif
> >-
> > /*
> >  * To deactivate a memory region, there are 3 cases to handle across
> >  * two configurations (SPARSEMEM_VMEMMAP={y,n}):
> >@@ -833,48 +871,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > 		ms->section_mem_map = (unsigned long)NULL;
> > }
> > 
> >-#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >-/**
> >- * fill_subsection_map - fill subsection map of a memory region
> >- * @pfn - start pfn of the memory range
> >- * @nr_pages - number of pfns to add in the region
> >- *
> >- * This fills the related subsection map inside one section, and only
> >- * intended for hotplug.
> >- *
> >- * Return:
> >- * * 0		- On success.
> >- * * -EINVAL	- Invalid memory region.
> >- * * -EEXIST	- Subsection map has been set.
> >- */
> >-static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >-{
> >-	struct mem_section *ms = __pfn_to_section(pfn);
> >-	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >-	unsigned long *subsection_map;
> >-	int rc = 0;
> >-
> >-	subsection_mask_set(map, pfn, nr_pages);
> >-
> >-	subsection_map = &ms->usage->subsection_map[0];
> >-
> >-	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> >-		rc = -EINVAL;
> >-	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> >-		rc = -EEXIST;
> >-	else
> >-		bitmap_or(subsection_map, map, subsection_map,
> >-				SUBSECTIONS_PER_SECTION);
> >-
> >-	return rc;
> >-}
> >-#else
> >-static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >-{
> >-	return 0;
> >-}
> >-#endif
> >-
> > static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > 		unsigned long nr_pages, struct vmem_altmap *altmap)
> > {
> >-- 
> >2.17.2
> 
> -- 
> Wei Yang
> Help you, Help me
> 

