Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7128C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929AB2495F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgEASW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730748AbgEASWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F269C08E859;
        Fri,  1 May 2020 11:22:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIv-0003jY-Od; Fri, 01 May 2020 20:22:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 29E8B1C0822;
        Fri,  1 May 2020 20:22:25 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:25 -0000
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/cpa: Flush direct map alias during cpa
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200424105343.GA20730@hirez.programming.kicks-ass.net>
References: <20200424105343.GA20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158835734513.8414.3180412857061455686.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ab5130186d7476dcee0d4e787d19a521ca552ce9
Gitweb:        https://git.kernel.org/tip/ab5130186d7476dcee0d4e787d19a521ca552ce9
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Wed, 22 Apr 2020 20:13:55 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:30 +02:00

x86/mm/cpa: Flush direct map alias during cpa

As an optimization, cpa_flush() was changed to optionally only flush
the range in @cpa if it was small enough.  However, this range does
not include any direct map aliases changed in cpa_process_alias(). So
small set_memory_() calls that touch that alias don't get the direct
map changes flushed. This situation can happen when the virtual
address taking variants are passed an address in vmalloc or modules
space.

In these cases, force a full TLB flush.

Note this issue does not extend to cases where the set_memory_() calls are
passed a direct map address, or page array, etc, as the primary target. In
those cases the direct map would be flushed.

Fixes: 935f5839827e ("x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation")
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200424105343.GA20730@hirez.programming.kicks-ass.net
---
 arch/x86/mm/pat/set_memory.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 59eca6a..b8c55a2 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -43,7 +43,8 @@ struct cpa_data {
 	unsigned long	pfn;
 	unsigned int	flags;
 	unsigned int	force_split		: 1,
-			force_static_prot	: 1;
+			force_static_prot	: 1,
+			force_flush_all		: 1;
 	struct page	**pages;
 };
 
@@ -355,10 +356,10 @@ static void cpa_flush(struct cpa_data *data, int cache)
 		return;
 	}
 
-	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
-	else
+	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
 		flush_tlb_all();
+	else
+		on_each_cpu(__cpa_flush_tlb, cpa, 1);
 
 	if (!cache)
 		return;
@@ -1598,6 +1599,8 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		cpa->force_flush_all = 1;
+
 		ret = __change_page_attr_set_clr(&alias_cpa, 0);
 		if (ret)
 			return ret;
@@ -1618,6 +1621,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		cpa->force_flush_all = 1;
 		/*
 		 * The high mapping range is imprecise, so ignore the
 		 * return value.
