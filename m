Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16612C5518A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15512073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgDWDPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:15:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:65105 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgDWDPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 23:15:35 -0400
IronPort-SDR: g7+6MnpDz1jAi6OLmj+ims+bVJhkiwqaLgyhvhPlLbsGKTkB/JWwGo8cpT6YXv62NqLGvYHTfG
 N/GGJgy/yStw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 20:15:35 -0700
IronPort-SDR: aT9HbTHEvbkCPkbeTpAzsOmK36jErh2gicUvCbEKj/zp5cRYQzWWJx03QqJ+/Z4nzvL0M2UG1d
 w8tSBYRnoQ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="292146112"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.255.231.66])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2020 20:15:33 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH] x86/mm/cpa: Flush direct map alias during cpa
Date:   Wed, 22 Apr 2020 20:13:55 -0700
Message-Id: <20200423031355.23955-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change cpa_flush() to always flush_tlb_all(), as it previously did. As an
optimization, cpa_flush() was changed to optionally only flush the range
in "struct cpa_data *data" if it was small enough. However, this range
does not include any direct map aliases changed in cpa_process_alias().
So small set_memory_() calls that touch that alias don't get the direct
map changes flushed. This situation can happen when the virtual address
taking variants are passed an address in vmalloc or modules space.

The issue was verified by creating a sequence like:
/* Allocate something in vmalloc */
void *ptr = vmalloc();
/* Set vmalloc addr and direct map alias as not present */
set_memory_np((unsigned long)ptr, num_pages);
/* Try to read from direct map alias */
printk("%d\n", *(int*)page_address(vmalloc_to_page(ptr));

Which successfully read from the direct mapped page now set as not
present.

There is usually some flushing that happens before the PTE is set in this
operation, which covers up that the alias doesn't actually get flushed
after it's changed. So to reproduce, set_memory_np() was also tweaked to
touch the address right before it clears its PTE. This loads the old value
in the TLB to simulate a state that could happen in real life for a number
of reasons.

Note this issue does not extend to cases where the set_memory_() calls are
passed a direct map address, or page array, etc, as the primary target. In
those cases the direct map would be flushed.

Fixes: 935f583 ("x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation")
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

Besides the flushing that happens in most cases before the PTE is changed,
the other thing that covers this up is that stale TLB hits around RO->RW
CPA's would be silently fixed by the spurious fault fixer. It looks like
some of the set_memory_uc() calls can operate on vmapped memory addresses
though. So this would miss the flush of the UC attribute on the direct map.

So there isn't any confirmed bug, but it seems like we should be flushing
these, and there possibly is one around cache attributes.

 arch/x86/mm/pat/set_memory.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c4aedd00c1ba..9b6d2854b842 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -331,15 +331,6 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static void __cpa_flush_tlb(void *data)
-{
-	struct cpa_data *cpa = data;
-	unsigned int i;
-
-	for (i = 0; i < cpa->numpages; i++)
-		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
-}
-
 static void cpa_flush(struct cpa_data *data, int cache)
 {
 	struct cpa_data *cpa = data;
@@ -352,10 +343,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 		return;
 	}
 
-	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
-	else
-		flush_tlb_all();
+	flush_tlb_all();
 
 	if (!cache)
 		return;
-- 
2.20.1

