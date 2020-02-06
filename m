Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B580C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A93621775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBFXRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:17:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:6959 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBFXRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:17:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 15:17:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="232200537"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 15:17:32 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        david@redhat.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/3] mm/sparsemem: adjust memmap only for SPARSEMEM_VMEMMAP
Date:   Fri,  7 Feb 2020 07:16:27 +0800
Message-Id: <20200206231629.14151-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206231629.14151-1-richardw.yang@linux.intel.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only when SPARSEMEM_VMEMMAP is set, memmap returned from
section_activate() points to sub-section page struct. Otherwise, memmap
already points to the whole section page struct.

This means only for SPARSEMEM_VMEMMAP, we need to adjust memmap for
sub-section case.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
---
 mm/sparse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 586d85662978..b5da121bdd6e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -886,7 +886,8 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	section_mark_present(ms);
 
 	/* Align memmap to section boundary in the subsection case */
-	if (section_nr_to_pfn(section_nr) != start_pfn)
+	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
+		section_nr_to_pfn(section_nr) != start_pfn)
 		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
 	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
 
-- 
2.17.1

