Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76696C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D189207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KT7XpMtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGPB37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgGPB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:29:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RjzKDjnTgPacZTqkbQ3FDGXw1GgG1R3oxYXg8khQZXA=; b=KT7XpMtHCBpZkzY5qmeBQ/rMiB
        XTnshJ+6tQtKLlb+e0CcqT1AqfF9u44ZDZdJVKY5RbtAHDFIEddXEDLEndRFjhWICtSg13UbeuKOJ
        5OFlLf8JMGc/XPEvieZu3lwAeZZMt7uhWdnik1vc+165gfPTB+d9zpE4lp93zovANP4qIRtReSPOy
        2S+uZHGxdh9QC7IWAYk65ojmJnH+T5LGh0Pn49ASNusLn/GF4NSNxLkDNLE3oi4CsgkbEvOlr5YaS
        wwjfRAf0SvkCGXC6fAMidG3WdmJByM216oqAUJpJow3fLeyBf3l2qWxe9cPLJMlVwwj15JRA8c0zZ
        3yX+hV8A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsig-0000Sy-U4; Thu, 16 Jul 2020 01:29:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mm: drop duplicated words in <linux/pgtable.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Message-ID: <2bb6e13e-44df-4920-52d9-4d3539945f73@infradead.org>
Date:   Wed, 15 Jul 2020 18:29:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled words "used" and "by".

Drop the repeated acronym "TLB" and make several other fixes around it.
(capital letters, spellos)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/pgtable.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20200714.orig/include/linux/pgtable.h
+++ linux-next-20200714/include/linux/pgtable.h
@@ -866,7 +866,7 @@ static inline void ptep_modify_prot_comm
 
 /*
  * No-op macros that just return the current protection value. Defined here
- * because these macros can be used used even if CONFIG_MMU is not defined.
+ * because these macros can be used even if CONFIG_MMU is not defined.
  */
 #ifndef pgprot_encrypted
 #define pgprot_encrypted(prot)	(prot)
@@ -1259,7 +1259,7 @@ static inline int pmd_trans_unstable(pmd
  * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
  * the only case the kernel cares is for NUMA balancing and is only ever set
  * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
- * _PAGE_PROTNONE so by by default, implement the helper as "always no". It
+ * _PAGE_PROTNONE so by default, implement the helper as "always no". It
  * is the responsibility of the caller to distinguish between PROT_NONE
  * protections and NUMA hinting fault protections.
  */
@@ -1343,10 +1343,10 @@ static inline int pmd_free_pte_page(pmd_
 /*
  * ARCHes with special requirements for evicting THP backing TLB entries can
  * implement this. Otherwise also, it can help optimize normal TLB flush in
- * THP regime. stock flush_tlb_range() typically has optimization to nuke the
- * entire TLB TLB if flush span is greater than a threshold, which will
- * likely be true for a single huge page. Thus a single thp flush will
- * invalidate the entire TLB which is not desitable.
+ * THP regime. Stock flush_tlb_range() typically has optimization to nuke the
+ * entire TLB if flush span is greater than a threshold, which will
+ * likely be true for a single huge page. Thus a single THP flush will
+ * invalidate the entire TLB which is not desirable.
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
 #define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)

