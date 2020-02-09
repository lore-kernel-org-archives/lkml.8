Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73941C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 23:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46309207FF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 23:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBIXjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:39:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:23461 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgBIXjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 18:39:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 15:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="405416746"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2020 15:39:17 -0800
Date:   Mon, 10 Feb 2020 07:39:35 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        richardw.yang@linux.intel.com, david@redhat.com
Subject: Re: [PATCH 4/7] mm/sparse.c: Use __get_free_pages() instead in
 populate_section_memmap()
Message-ID: <20200209233935.GB8705@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209104826.3385-5-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 06:48:23PM +0800, Baoquan He wrote:
>This removes the unnecessary goto, and simplify codes.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Reasonable.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> mm/sparse.c | 16 ++++++----------
> 1 file changed, 6 insertions(+), 10 deletions(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index cf55d272d0a9..36e6565ec67e 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -751,23 +751,19 @@ static void free_map_bootmem(struct page *memmap)
> struct page * __meminit populate_section_memmap(unsigned long pfn,
> 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> {
>-	struct page *page, *ret;
>+	struct page *ret;
> 	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> 
>-	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
>-	if (page)
>-		goto got_map_page;
>+	ret = (void*)__get_free_pages(GFP_KERNEL|__GFP_NOWARN,
>+				get_order(memmap_size));
>+	if (ret)
>+		return ret;
> 
> 	ret = vmalloc(memmap_size);
> 	if (ret)
>-		goto got_map_ptr;
>+		return ret;
> 
> 	return NULL;
>-got_map_page:
>-	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
>-got_map_ptr:
>-
>-	return ret;
> }
> 
> static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
