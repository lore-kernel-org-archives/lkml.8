Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0878521532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgIHGfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:35:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:17470 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgIHGff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:35:35 -0400
IronPort-SDR: f2pUWdu8IlQQNG4E833Qzfi5KlPYf+c72EtfaQxYIt3m6Ic76xr/IyWeekRFyA++sn4a0VYqTY
 7gEQ/NlhH1ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="242896564"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="242896564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 23:35:35 -0700
IronPort-SDR: 2tklKCq80yWYYcZRQVGfrPHW3ZIYTzXBpEWakjj88WThKyQckhPXbkSJVRJh9vrhxpzJWWLGvK
 jrKRu/xsKSHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="333369975"
Received: from yhuang-mobile.sh.intel.com ([10.238.4.22])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 23:35:31 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH] x86, fakenuma: Avoid too large emulated node
Date:   Tue,  8 Sep 2020 14:09:12 +0800
Message-Id: <20200908060912.12200-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a testing system with 2 physical NUMA node, 8GB memory, a small
memory hole from 640KB to 1MB, and a large memory hole from 3GB to
4GB.  If "numa=fake=1G" is used in kernel command line, the resulting
fake NUMA nodes are as follows,

    NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
    NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x13fffffff] -> [mem 0x00000000-0x13fffffff]
    Faking node 0 at [mem 0x0000000000000000-0x0000000041ffffff] (1056MB)
    Faking node 1 at [mem 0x0000000140000000-0x000000017fffffff] (1024MB)
    Faking node 2 at [mem 0x0000000042000000-0x0000000081ffffff] (1024MB)
    Faking node 3 at [mem 0x0000000180000000-0x00000001bfffffff] (1024MB)
    Faking node 4 at [mem 0x0000000082000000-0x000000013fffffff] (3040MB)
    Faking node 5 at [mem 0x00000001c0000000-0x00000001ffffffff] (1024MB)
    Faking node 6 at [mem 0x0000000200000000-0x000000023fffffff] (1024MB)

Where, 7 fake NUMA nodes are emulated, the size of fake node 4 is 3040
- 1024 = 2016MB.  This is nearly 2 times of the size of the other fake
nodes (about 1024MB).  This isn't a reasonable splitting.  The better
way is to make the fake node size not too large or small.  So in this
patch, the splitting algorithm is changed to make the fake node size
between 1/2 to 3/2 of the specified node size.  After applying this
patch, the resulting fake NUMA nodes become,

    Faking node 0 at [mem 0x0000000000000000-0x0000000041ffffff] (1056MB)
    Faking node 1 at [mem 0x0000000140000000-0x000000017fffffff] (1024MB)
    Faking node 2 at [mem 0x0000000042000000-0x0000000081ffffff] (1024MB)
    Faking node 3 at [mem 0x0000000180000000-0x00000001bfffffff] (1024MB)
    Faking node 4 at [mem 0x0000000082000000-0x0000000103ffffff] (2080MB)
    Faking node 5 at [mem 0x00000001c0000000-0x00000001ffffffff] (1024MB)
    Faking node 6 at [mem 0x0000000104000000-0x000000013fffffff] (960MB)
    Faking node 7 at [mem 0x0000000200000000-0x000000023fffffff] (1024MB)

The newly added node 6 is a little smaller than the specified node
size (960MB vs. 1024MB).  But the overall results look more
reasonable.

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
 arch/x86/mm/numa_emulation.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 683cd12f4793..231469e1de6a 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -300,9 +300,10 @@ static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
 			/*
 			 * If there won't be enough non-reserved memory for the
 			 * next node, this one must extend to the end of the
-			 * physical node.
+			 * physical node.  The size of the emulated node should
+			 * be between size/2 and size*3/2.
 			 */
-			if ((limit - end - mem_hole_size(end, limit) < size)
+			if ((limit - end - mem_hole_size(end, limit) < size / 2)
 					&& !uniform)
 				end = limit;
 
-- 
2.28.0

