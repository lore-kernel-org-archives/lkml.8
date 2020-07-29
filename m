Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC29C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9406F21D95
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgG2Dfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:35:45 -0400
Received: from foss.arm.com ([217.140.110.172]:44634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Dfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:35:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1581D31B;
        Tue, 28 Jul 2020 20:35:44 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9ACF53F66E;
        Tue, 28 Jul 2020 20:35:36 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [RFC PATCH 4/6] mm/page_alloc: adjust the start,end in dax pmem kmem case
Date:   Wed, 29 Jul 2020 11:34:22 +0800
Message-Id: <20200729033424.2629-5-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 cases when doing online pages:
 - normal RAM, should be aligned with memory block size
 - persistent memory with ZONE_DEVICE
 - persistent memory used as normal RAM (kmem) with ZONE_NORMAL, this patch
   tries to adjust the start_pfn/end_pfn after finding the corresponding
   resource range.

Without this patch, the check of __init_single_page when doing online memory
will be failed because those pages haven't been mapped in mmu(not present
from mmu's point of view).

Signed-off-by: Jia He <justin.he@arm.com>
---
 mm/page_alloc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce294..13216ab3623f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5971,6 +5971,20 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (start_pfn == altmap->base_pfn)
 			start_pfn += altmap->reserve;
 		end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+	} else {
+		struct resource res;
+		int ret;
+
+		/* adjust the start,end in dax pmem kmem case */
+		ret = find_next_iomem_res(start_pfn << PAGE_SHIFT,
+			(end_pfn << PAGE_SHIFT) - 1,
+			IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+			IORES_DESC_PERSISTENT_MEMORY,
+			false, &res);
+		if (!ret) {
+			start_pfn = PFN_UP(res.start);
+			end_pfn = PFN_DOWN(res.end + 1);
+		}
 	}
 #endif
 
-- 
2.17.1

