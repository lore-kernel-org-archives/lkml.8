Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A92C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D94220715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgBJAun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:50:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:36888 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgBJAun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 19:50:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 16:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="405427008"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2020 16:50:41 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Baoquan He <bhe@redhat.com>
Subject: [Patch v2] mm/sparsemem: get address to page struct instead of address to pfn
Date:   Mon, 10 Feb 2020 08:50:48 +0800
Message-Id: <20200210005048.10437-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap should be the address to page struct instead of address to pfn.

As mentioned by David, if system memory and devmem sit within a
section, the mismatch address would lead kdump to dump unexpected
memory.

Since sub-section only works for SPARSEMEM_VMEMMAP, pfn_to_page() is
valid to get the page struct address at this point.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: David Hildenbrand <david@redhat.com>
CC: Baoquan He <bhe@redhat.com>

---
v2:
  * adjust comment to mention the mismatch data would affect kdump

---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 586d85662978..4862ec2cfbc0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -887,7 +887,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 
 	/* Align memmap to section boundary in the subsection case */
 	if (section_nr_to_pfn(section_nr) != start_pfn)
-		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
+		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
 	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
 
 	return 0;
-- 
2.17.1

