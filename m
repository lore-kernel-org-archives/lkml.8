Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFD3C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 23:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1820820
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 23:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBIXG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:06:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:58109 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgBIXG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 18:06:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 15:06:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="265664145"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2020 15:06:56 -0800
Date:   Mon, 10 Feb 2020 07:07:14 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        richardw.yang@linux.intel.com, david@redhat.com
Subject: Re: [PATCH 2/7] mm/sparse.c: Introduce a new function
 clear_subsection_map()
Message-ID: <20200209230713.GB7326@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209104826.3385-3-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 06:48:21PM +0800, Baoquan He wrote:
>Wrap the codes clearing subsection map of one memory region in
>section_deactivate() into clear_subsection_map().
>

Patch 1 and 2 server the same purpose -- to #ifdef the VMEMMAP.

I suggest to merge these two.

>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
> mm/sparse.c | 44 +++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 37 insertions(+), 7 deletions(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 9ad741ccbeb6..696f6b9f706e 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -726,14 +726,25 @@ static void free_map_bootmem(struct page *memmap)
> }
> #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> 
>-static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>-		struct vmem_altmap *altmap)
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
> {
> 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> 	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> 	struct mem_section *ms = __pfn_to_section(pfn);
>-	bool section_is_early = early_section(ms);
>-	struct page *memmap = NULL;
> 	unsigned long *subsection_map = ms->usage
> 		? &ms->usage->subsection_map[0] : NULL;
> 
>@@ -744,8 +755,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> 				"section already deactivated (%#lx + %ld)\n",
> 				pfn, nr_pages))
>-		return;
>+		return -EINVAL;
>+
>+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> 
>+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>+		return 0;
>+
>+	return 1;
>+}
>+
>+static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>+		struct vmem_altmap *altmap)
>+{
>+	struct mem_section *ms = __pfn_to_section(pfn);
>+	bool section_is_early = early_section(ms);
>+	struct page *memmap = NULL;
>+	int rc;
>+
>+
>+	rc = clear_subsection_map(pfn, nr_pages);
>+	if(IS_ERR_VALUE((unsigned long)rc))
>+		return;
> 	/*
> 	 * There are 3 cases to handle across two configurations
> 	 * (SPARSEMEM_VMEMMAP={y,n}):
>@@ -763,8 +794,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 	 *
> 	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> 	 */
>-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
>-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
>+	if (!rc) {
> 		unsigned long section_nr = pfn_to_section_nr(pfn);
> 
> 		/*
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
