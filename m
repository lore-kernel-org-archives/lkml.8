Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D02C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515B2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBTGQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:16:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:22133 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgBTGQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:16:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 22:16:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,463,1574150400"; 
   d="scan'208";a="436484979"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 19 Feb 2020 22:16:44 -0800
Date:   Thu, 20 Feb 2020 14:17:04 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        mhocko@suse.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 4/7] mm/sparse.c: only use subsection map in VMEMMAP
 case
Message-ID: <20200220061704.GD32521@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220043316.19668-5-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:33:13PM +0800, Baoquan He wrote:
>Currently, subsection map is used when SPARSEMEM is enabled, including
>VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
>supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
>and misleading. Let's adjust code to only allow subsection map being
>used in VMEMMAP case.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> include/linux/mmzone.h |  2 ++
> mm/sparse.c            | 20 ++++++++++++++++++++
> 2 files changed, 22 insertions(+)
>
>diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>index 462f6873905a..fc0de3a9a51e 100644
>--- a/include/linux/mmzone.h
>+++ b/include/linux/mmzone.h
>@@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
> #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
> 
> struct mem_section_usage {
>+#ifdef CONFIG_SPARSEMEM_VMEMMAP
> 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>+#endif
> 	/* See declaration of similar field in struct zone */
> 	unsigned long pageblock_flags[0];
> };
>diff --git a/mm/sparse.c b/mm/sparse.c
>index df857ee9330c..66c497d6a229 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -209,6 +209,7 @@ static inline unsigned long first_present_section_nr(void)
> 	return next_present_section_nr(-1);
> }
> 
>+#ifdef CONFIG_SPARSEMEM_VMEMMAP
> static void subsection_mask_set(unsigned long *map, unsigned long pfn,
> 		unsigned long nr_pages)
> {
>@@ -243,6 +244,11 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> 		nr_pages -= pfns;
> 	}
> }
>+#else
>+void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>+{
>+}
>+#endif
> 
> /* Record a memory area against a node. */
> void __init memory_present(int nid, unsigned long start, unsigned long end)
>@@ -726,6 +732,7 @@ static void free_map_bootmem(struct page *memmap)
> }
> #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> 
>+#ifdef CONFIG_SPARSEMEM_VMEMMAP
> /**
>  * clear_subsection_map - Clear subsection map of one memory region
>  *
>@@ -764,6 +771,12 @@ static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> 
> 	return 1;
> }
>+#else
>+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>+{
>+	return 0;
>+}
>+#endif
> 
> static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 		struct vmem_altmap *altmap)
>@@ -820,6 +833,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 		ms->section_mem_map = (unsigned long)NULL;
> }
> 
>+#ifdef CONFIG_SPARSEMEM_VMEMMAP
> /**
>  * fill_subsection_map - fill subsection map of a memory region
>  * @pfn - start pfn of the memory range
>@@ -854,6 +868,12 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> 
> 	return rc;
> }
>+#else
>+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>+{
>+	return 0;
>+}
>+#endif
> 
> static struct page * __meminit section_activate(int nid, unsigned long pfn,
> 		unsigned long nr_pages, struct vmem_altmap *altmap)
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
