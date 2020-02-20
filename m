Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FDC761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5182220801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgBTGOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:14:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:51786 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgBTGOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:14:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 22:14:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,463,1574150400"; 
   d="scan'208";a="436484554"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 19 Feb 2020 22:14:08 -0800
Date:   Thu, 20 Feb 2020 14:14:27 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        mhocko@suse.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 2/7] mm/sparse.c: introduce new function
 fill_subsection_map()
Message-ID: <20200220061427.GB32521@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220043316.19668-3-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:33:11PM +0800, Baoquan He wrote:
>Wrap the codes filling subsection map from section_activate() into
>fill_subsection_map(), this makes section_activate() cleaner and
>easier to follow.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> mm/sparse.c | 45 ++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 34 insertions(+), 11 deletions(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index b8e52c8fed7f..977b47acd38d 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -790,24 +790,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 		ms->section_mem_map = (unsigned long)NULL;
> }
> 
>-static struct page * __meminit section_activate(int nid, unsigned long pfn,
>-		unsigned long nr_pages, struct vmem_altmap *altmap)
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
> {
>-	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> 	struct mem_section *ms = __pfn_to_section(pfn);
>-	struct mem_section_usage *usage = NULL;
>+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> 	unsigned long *subsection_map;
>-	struct page *memmap;
> 	int rc = 0;
> 
> 	subsection_mask_set(map, pfn, nr_pages);
> 
>-	if (!ms->usage) {
>-		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
>-		if (!usage)
>-			return ERR_PTR(-ENOMEM);
>-		ms->usage = usage;
>-	}
> 	subsection_map = &ms->usage->subsection_map[0];
> 
> 	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
>@@ -818,6 +822,25 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> 		bitmap_or(subsection_map, map, subsection_map,
> 				SUBSECTIONS_PER_SECTION);
> 
>+	return rc;
>+}
>+
>+static struct page * __meminit section_activate(int nid, unsigned long pfn,
>+		unsigned long nr_pages, struct vmem_altmap *altmap)
>+{
>+	struct mem_section *ms = __pfn_to_section(pfn);
>+	struct mem_section_usage *usage = NULL;
>+	struct page *memmap;
>+	int rc = 0;
>+
>+	if (!ms->usage) {
>+		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
>+		if (!usage)
>+			return ERR_PTR(-ENOMEM);
>+		ms->usage = usage;
>+	}
>+
>+	rc = fill_subsection_map(pfn, nr_pages);
> 	if (rc) {
> 		if (usage)
> 			ms->usage = NULL;
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
