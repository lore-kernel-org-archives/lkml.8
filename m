Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE49DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC906206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgEOOA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbgEOOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:00:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15CAC05BD09;
        Fri, 15 May 2020 07:00:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4181D379; Fri, 15 May 2020 16:00:25 +0200 (CEST)
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
Subject: [PATCH v3 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date:   Fri, 15 May 2020 16:00:16 +0200
Message-Id: <20200515140023.25469-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the updated version of this series with these
changes:

	- Removed sync_current_stack_to_mm() too.

	- Added Acked-by's from Andy Lutomirski

The previous versions can be found here:

	v1: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/

	v2: https://lore.kernel.org/lkml/20200513152137.32426-1-joro@8bytes.org/

The cover-letter of v1 has more details on the motivation
for this patch-set.

Please review.

Regards,

	Joerg

Joerg Roedel (7):
  mm: Add functions to track page directory modifications
  mm/vmalloc: Track which page-table levels were modified
  mm/ioremap: Track which page-table levels were modified
  x86/mm/64: Implement arch_sync_kernel_mappings()
  x86/mm/32: Implement arch_sync_kernel_mappings()
  mm: Remove vmalloc_sync_(un)mappings()
  x86/mm: Remove vmalloc faulting

 arch/x86/include/asm/pgtable-2level_types.h |   2 +
 arch/x86/include/asm/pgtable-3level_types.h |   2 +
 arch/x86/include/asm/pgtable_64_types.h     |   2 +
 arch/x86/include/asm/switch_to.h            |  23 ---
 arch/x86/kernel/setup_percpu.c              |   6 +-
 arch/x86/mm/fault.c                         | 176 +-------------------
 arch/x86/mm/init_64.c                       |   5 +
 arch/x86/mm/pti.c                           |   8 +-
 arch/x86/mm/tlb.c                           |  37 ----
 drivers/acpi/apei/ghes.c                    |   6 -
 include/asm-generic/5level-fixup.h          |   5 +-
 include/asm-generic/pgtable.h               |  23 +++
 include/linux/mm.h                          |  46 +++++
 include/linux/vmalloc.h                     |  18 +-
 kernel/notifier.c                           |   1 -
 kernel/trace/trace.c                        |  12 --
 lib/ioremap.c                               |  46 +++--
 mm/nommu.c                                  |  12 --
 mm/vmalloc.c                                | 109 +++++++-----
 19 files changed, 204 insertions(+), 335 deletions(-)

-- 
2.17.1

