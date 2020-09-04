Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E77C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50052206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgIDGK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:10:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:54234 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgIDGK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:10:58 -0400
IronPort-SDR: 3aAFKejwiiKBFV6wTuMLb4AcqP87yTum+cPPeET6xJlqoCnXmkveqA02CMPBdJcpIxyNpzSdcq
 C3fIf5UPEVlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137750994"
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="137750994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 23:10:58 -0700
IronPort-SDR: hWkpxkd8JZl/EXkkDEZ49Tteg9MZaZngq6o6VuqGMRt8sDT/jYHm4g7c1CFok6+t0Y+x3peost
 VG1MRxyBDcBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="284319611"
Received: from linjian1-mobl.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.214.206])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2020 23:10:54 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH RESEND] x86, fakenuma: Fix invalid starting node ID
Date:   Fri,  4 Sep 2020 14:10:47 +0800
Message-Id: <20200904061047.612950-1-ying.huang@intel.com>
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

