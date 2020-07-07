Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C068C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F54620702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGGF7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:59:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgGGF7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:59:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 381CCD6E;
        Mon,  6 Jul 2020 22:59:37 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 806363F68F;
        Mon,  6 Jul 2020 22:59:32 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
Subject: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
Date:   Tue,  7 Jul 2020 13:59:15 +0800
Message-Id: <20200707055917.143653-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707055917.143653-1-justin.he@arm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exports memory_add_physaddr_to_nid() for module driver to use.

memory_add_physaddr_to_nid() is a fallback option to get the nid in case
NUMA_NO_NID is detected.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/mm/numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index aafcee3e3f7e..7eeb31740248 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
 
 /*
  * We hope that we will be hotplugging memory on nodes we already know about,
- * such that acpi_get_node() succeeds and we never fall back to this...
+ * such that acpi_get_node() succeeds. But when SRAT is not present, the node
+ * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
  */
 int memory_add_physaddr_to_nid(u64 addr)
 {
-	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
-- 
2.17.1

