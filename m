Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6570C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B58E20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBTGSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:18:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:63138 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgBTGSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:18:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 22:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,463,1574150400"; 
   d="scan'208";a="436485272"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 19 Feb 2020 22:18:12 -0800
Date:   Thu, 20 Feb 2020 14:18:32 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        mhocko@suse.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 6/7] mm/sparse.c: move subsection_map related codes
 together
Message-ID: <20200220061832.GE32521@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220043316.19668-7-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:33:15PM +0800, Baoquan He wrote:
>No functional change.
>

Those functions are introduced in your previous patches.

Is it possible to define them close to each other at the very beginning?

>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
> mm/sparse.c | 172 +++++++++++++++++++++++++---------------------------
> 1 file changed, 84 insertions(+), 88 deletions(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 14bff0b44e7c..053d6c2e5c1f 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -244,10 +244,94 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> 		nr_pages -= pfns;
> 	}
> }
>+
>+/**
>+ * clear_subsection_map - Clear subsection map of one memory region
>+ *
>+ * @pfn - start pfn of the memory range
>+ * @nr_pages - number of pfns to add in the region
>+ *
>+ * This is only intended for hotplug, and clear the related subsection
>+ * map inside one section.
>+ *
>+ * Return:
>+ * * -EINVAL	- Section already deactived.
>+ * * 0		- Subsection map is emptied.
>+ * * 1		- Subsection map is not empty.
>+ */
>+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>+{
>+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>+	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
>+	struct mem_section *ms = __pfn_to_section(pfn);
>+	unsigned long *subsection_map = ms->usage
>+		? &ms->usage->subsection_map[0] : NULL;
>+
>+	subsection_mask_set(map, pfn, nr_pages);
>+	if (subsection_map)
>+		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
>+
>+	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
>+				"section already deactivated (%#lx + %ld)\n",
>+				pfn, nr_pages))
>+		return -EINVAL;
>+
>+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
>+
>+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>+		return 0;
>+
>+	return 1;
>+}
>+
>+/**
>+ * fill_subsection_map - fill subsection map of a memory region
>+ * @pfn - start pfn of the memory range
>+ * @nr_pages - number of pfns to add in the region
>+ *
>+ * This fills the related subsection map inside one section, and only
>+ * intended for hotplug.
>+ *
>+ * Return:
>+ * * 0		- On success.
>+ * * -EINVAL	- Invalid memory region.
>+ * * -EEXIST	- Subsection map has been set.
>+ */
>+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>+{
>+	struct mem_section *ms = __pfn_to_section(pfn);
>+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>+	unsigned long *subsection_map;
>+	int rc = 0;
>+
>+	subsection_mask_set(map, pfn, nr_pages);
>+
>+	subsection_map = &ms->usage->subsection_map[0];
>+
>+	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
>+		rc = -EINVAL;
>+	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
>+		rc = -EEXIST;
>+	else
>+		bitmap_or(subsection_map, map, subsection_map,
>+				SUBSECTIONS_PER_SECTION);
>+
>+	return rc;
>+}
> #else
> void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> {
> }
>+
>+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>+{
>+	return 0;
>+}
>+
>+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>+{
>+	return 0;
>+}
> #endif
> 
> /* Record a memory area against a node. */
>@@ -732,52 +816,6 @@ static void free_map_bootmem(struct page *memmap)
> }
> #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> 
>-#ifdef CONFIG_SPARSEMEM_VMEMMAP
>-/**
>- * clear_subsection_map - Clear subsection map of one memory region
>- *
>- * @pfn - start pfn of the memory range
>- * @nr_pages - number of pfns to add in the region
>- *
>- * This is only intended for hotplug, and clear the related subsection
>- * map inside one section.
>- *
>- * Return:
>- * * -EINVAL	- Section already deactived.
>- * * 0		- Subsection map is emptied.
>- * * 1		- Subsection map is not empty.
>- */
>-static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>-{
>-	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>-	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
>-	struct mem_section *ms = __pfn_to_section(pfn);
>-	unsigned long *subsection_map = ms->usage
>-		? &ms->usage->subsection_map[0] : NULL;
>-
>-	subsection_mask_set(map, pfn, nr_pages);
>-	if (subsection_map)
>-		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
>-
>-	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
>-				"section already deactivated (%#lx + %ld)\n",
>-				pfn, nr_pages))
>-		return -EINVAL;
>-
>-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
>-
>-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>-		return 0;
>-
>-	return 1;
>-}
>-#else
>-static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>-{
>-	return 0;
>-}
>-#endif
>-
> /*
>  * To deactivate a memory region, there are 3 cases to handle across
>  * two configurations (SPARSEMEM_VMEMMAP={y,n}):
>@@ -833,48 +871,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 		ms->section_mem_map = (unsigned long)NULL;
> }
> 
>-#ifdef CONFIG_SPARSEMEM_VMEMMAP
>-/**
>- * fill_subsection_map - fill subsection map of a memory region
>- * @pfn - start pfn of the memory range
>- * @nr_pages - number of pfns to add in the region
>- *
>- * This fills the related subsection map inside one section, and only
>- * intended for hotplug.
>- *
>- * Return:
>- * * 0		- On success.
>- * * -EINVAL	- Invalid memory region.
>- * * -EEXIST	- Subsection map has been set.
>- */
>-static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>-{
>-	struct mem_section *ms = __pfn_to_section(pfn);
>-	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>-	unsigned long *subsection_map;
>-	int rc = 0;
>-
>-	subsection_mask_set(map, pfn, nr_pages);
>-
>-	subsection_map = &ms->usage->subsection_map[0];
>-
>-	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
>-		rc = -EINVAL;
>-	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
>-		rc = -EEXIST;
>-	else
>-		bitmap_or(subsection_map, map, subsection_map,
>-				SUBSECTIONS_PER_SECTION);
>-
>-	return rc;
>-}
>-#else
>-static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>-{
>-	return 0;
>-}
>-#endif
>-
> static struct page * __meminit section_activate(int nid, unsigned long pfn,
> 		unsigned long nr_pages, struct vmem_altmap *altmap)
> {
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
