Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080CEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADFE2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbgEMPWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:22:09 -0400
Received: from 8bytes.org ([81.169.241.247]:42596 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbgEMPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:21:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4C0966BB; Wed, 13 May 2020 17:21:41 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 4/7] x86/mm/64: Implement arch_sync_kernel_mappings()
Date:   Wed, 13 May 2020 17:21:34 +0200
Message-Id: <20200513152137.32426-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513152137.32426-1-joro@8bytes.org>
References: <20200513152137.32426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Implement the function to sync changes in vmalloc and ioremap ranges
to all page-tables.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_64_types.h | 2 ++
 arch/x86/mm/init_64.c                   | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 52e5f5f2240d..8f63efb2a2cc 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -159,4 +159,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
+#define ARCH_PAGE_TABLE_SYNC_MASK	(pgtable_l5_enabled() ?	PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3b289c2f75cd..541af8e5bcd4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -217,6 +217,11 @@ void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
-- 
2.17.1

