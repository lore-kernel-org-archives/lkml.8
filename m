Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C234C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCBC2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgH1JG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:06:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:26004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbgH1JGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:06:55 -0400
IronPort-SDR: GlsDsNMx4xOaIno4HOAZisms88byJCxpXcMkftYrZjND0qrJMr6ZUQtTSRPQtiNlsUboiHOTm2
 /wXFktquJ81Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154180503"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="154180503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 02:06:54 -0700
IronPort-SDR: KYKLewt87hnvbbAjOQkkY8A5iNbs2fJEoSetOBLplhFxK/STXZXql9eTm0JfOxXAqcfCg1adZH
 a1DpfRsnfGRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="444773272"
Received: from liaoh-mobl1.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.212.20])
  by orsmga004.jf.intel.com with ESMTP; 28 Aug 2020 02:06:50 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH] x86, fakenuma: Fix invalid starting node ID
Date:   Fri, 28 Aug 2020 17:06:37 +0800
Message-Id: <20200828090637.344320-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cc9aec03e58f ("x86/numa_emulation: Introduce uniform split
capability") uses "-1" as the starting node ID, which causes the
strange kernel log as following, when "numa=fake=32G" is added to the
kernel command line.

    Faking node -1 at [mem 0x0000000000000000-0x0000000893ffffff] (35136MB)
    Faking node 0 at [mem 0x0000001840000000-0x000000203fffffff] (32768MB)
    Faking node 1 at [mem 0x0000000894000000-0x000000183fffffff] (64192MB)
    Faking node 2 at [mem 0x0000002040000000-0x000000283fffffff] (32768MB)
    Faking node 3 at [mem 0x0000002840000000-0x000000303fffffff] (32768MB)

And finally kernel BUG as following,

    BUG: Bad page state in process swapper  pfn:00011
    page:(____ptrval____) refcount:0 mapcount:1 mapping:(____ptrval____) index:0x55cd7e44b270 pfn:0x11
    failed to read mapping contents, not a valid kernel address?
    flags: 0x5(locked|uptodate)
    raw: 0000000000000005 000055cd7e44af30 000055cd7e44af50 0000000100000006
    raw: 000055cd7e44b270 000055cd7e44b290 0000000000000000 000055cd7e44b510
    page dumped because: page still charged to cgroup
    page->mem_cgroup:000055cd7e44b510
    Modules linked in:
    CPU: 0 PID: 0 Comm: swapper Not tainted 5.9.0-rc2 #1
    Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
    Call Trace:
     dump_stack+0x57/0x80
     bad_page.cold+0x63/0x94
     __free_pages_ok+0x33f/0x360
     memblock_free_all+0x127/0x195
     mem_init+0x23/0x1f5
     start_kernel+0x219/0x4f5
     secondary_startup_64+0xb6/0xc0

Fixes this bug via using 0 as the starting node ID.  This restores the
original behavior before the commit cc9aec03e58f ("x86/numa_emulation:
Introduce uniform split capability").

Fixes: cc9aec03e58f ("x86/numa_emulation: Introduce uniform split capability")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dave Jiang <dave.jiang@intel.com>
---
 arch/x86/mm/numa_emulation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index c5174b4e318b..683cd12f4793 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -321,7 +321,7 @@ static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
 					      u64 addr, u64 max_addr, u64 size)
 {
 	return split_nodes_size_interleave_uniform(ei, pi, addr, max_addr, size,
-			0, NULL, NUMA_NO_NODE);
+			0, NULL, 0);
 }
 
 static int __init setup_emu2phys_nid(int *dfl_phys_nid)
-- 
2.28.0

