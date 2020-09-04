Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E731C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678A7206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xBBL6TE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/Fav/eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIDG7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDG7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:59:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA8C061244;
        Thu,  3 Sep 2020 23:59:18 -0700 (PDT)
Date:   Fri, 04 Sep 2020 06:59:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599202756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQfHpPgYmXHjke7UnAkKo5tbCxBXGR0oKw4pe7S8E2E=;
        b=4xBBL6TEQyyNhoeIOUipHkUT56W1iONCba4TR1iZXiypSdQmS+7TpBLgaUL+p6PoNORQGa
        shmXtM9j/9EyJjDao/suykQixEmFv4LcmB5Z2DXw08SiMViuFTww1P++lDtDg0F3+vN2pB
        VEV5vz8o0M+3tY3vPvFQbVNsfK9W4PsoFUfos2goWbWBNh4q+ulnyyPI3jw2OXw5WQwhAX
        pa1i1B3lBEvKPv2GDOQ/9mDffjykSPCjLqihpq/wMRIfFSX9STSxd4NQIcUwWfKL34wgTr
        YzmgFTx/DzWAebQhUofcPJkS97QsKSQozKjU/NTz1EHn/KaapQD0jlDRpHqhwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599202756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQfHpPgYmXHjke7UnAkKo5tbCxBXGR0oKw4pe7S8E2E=;
        b=u/Fav/eZDrqjcyWksy7MiKH0RCm8fXkz/hy3kXNKXc2OJin3rWbofePMa+k95lBM1YDeVV
        AZ7g0N9aO7BGtMDQ==
From:   "tip-bot2 for Huang Ying" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86, fakenuma: Fix invalid starting node ID
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200904061047.612950-1-ying.huang@intel.com>
References: <20200904061047.612950-1-ying.huang@intel.com>
MIME-Version: 1.0
Message-ID: <159920275466.20229.58684697289932367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ccae0f36d500aef727f98acd8d0601e6b262a513
Gitweb:        https://git.kernel.org/tip/ccae0f36d500aef727f98acd8d0601e6b262a513
Author:        Huang Ying <ying.huang@intel.com>
AuthorDate:    Fri, 04 Sep 2020 14:10:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 04 Sep 2020 08:56:13 +02:00

x86, fakenuma: Fix invalid starting node ID

Commit:

  cc9aec03e58f ("x86/numa_emulation: Introduce uniform split capability")

uses "-1" as the starting node ID, which causes the strange kernel log as
follows, when "numa=fake=32G" is added to the kernel command line:

    Faking node -1 at [mem 0x0000000000000000-0x0000000893ffffff] (35136MB)
    Faking node 0 at [mem 0x0000001840000000-0x000000203fffffff] (32768MB)
    Faking node 1 at [mem 0x0000000894000000-0x000000183fffffff] (64192MB)
    Faking node 2 at [mem 0x0000002040000000-0x000000283fffffff] (32768MB)
    Faking node 3 at [mem 0x0000002840000000-0x000000303fffffff] (32768MB)

And finally the kernel crashes:

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

Fix this bug via using 0 as the starting node ID.  This restores the
original behavior before cc9aec03e58f.

[ mingo: Massaged the changelog. ]

Fixes: cc9aec03e58f ("x86/numa_emulation: Introduce uniform split capability")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200904061047.612950-1-ying.huang@intel.com
---
 arch/x86/mm/numa_emulation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index c5174b4..683cd12 100644
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
