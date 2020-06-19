Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF628C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9F3204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvzVKHLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbgFSQGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404709AbgFSQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u3Vh1HVYE5zmkqw2sOdn8zxGKpBRt5nL/FWkJRhYB9o=;
        b=FvzVKHLz6BjTDZb95dNo3qF6+MTrSDs7qTdIl8HBEsfsgCPJtFExsUrOJ8TlyB3j7nBkPp
        IEdtLt3S5+M8Ou7UqnJr0Rp5RafwwBs4z7FJyFYn2l57s42x3xf5nW+cl9PCaAKaXa3thW
        UOmuQgOTcctt2lP+HCKOEufKvK+wYXw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-qT1VKv2CMk-fcwZTAQZ-gw-1; Fri, 19 Jun 2020 12:05:50 -0400
X-MC-Unique: qT1VKv2CMk-fcwZTAQZ-gw-1
Received: by mail-qk1-f200.google.com with SMTP id 16so7451206qka.15
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3Vh1HVYE5zmkqw2sOdn8zxGKpBRt5nL/FWkJRhYB9o=;
        b=gvZ+xPm3BP2aHhTkRBnXAUSB94J0k0EgKSnKtrzYhgWiLWpSgP/hodvk+FATnXHhkb
         AxchLl2RSDFADww4fm2JzdvSoVJ/bIsm+a+bzyeyXgGSwmlRRVNLvgDoqCOcQzb5CiAr
         Bj5T18oHlIcRxqYtc6wZVuyOU503h4ow02XYnCSkAhNP1jFoQZBRC6gK3atiNYGvGp85
         Y38OLa3/ZrHKyTTAGhP2hBnSrnMh1Hqm+Mi5KRj+P/GINfH6skZ4gTxb4sMT829T3ZKw
         jr2Qy/Y7tnkJOhUCBdtYRO6r3kgrKWy3FYmrmTF+SCHyqxLYhDRyBwwOZ4ZyKYISYnUq
         AOiA==
X-Gm-Message-State: AOAM533RTmNJfKmZHJ9cObN+BpshD+HcXNoPvVt0OLQ2KX7PgKGOf9om
        g1vhJh6mqZYrNaVaXx+7rzy3k69TUjzDsLM+u+WXJVvV/OR0f++cHIwd+uTPjRLyY6VXrLZiIxU
        qxTQ3mX7CxztO6/K5TMtafe3U
X-Received: by 2002:ae9:e841:: with SMTP id a62mr4262431qkg.497.1592582749588;
        Fri, 19 Jun 2020 09:05:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySpRUMhXyNfEl10XktKVgqTs3uRy85zxUDqvWPGZZNqeyiCaJtUfJ8ugLHtIHHC9pHiVb8gQ==
X-Received: by 2002:ae9:e841:: with SMTP id a62mr4262393qkg.497.1592582749242;
        Fri, 19 Jun 2020 09:05:49 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/26] mm/arm64: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:17 -0400
Message-Id: <20200619160538.8641-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.  To do this, we pass pt_regs pointer into __do_page_fault().

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5f6607b951b8..09b206521559 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -398,7 +398,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADACCESS	0x020000
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
-			   unsigned int mm_flags, unsigned long vm_flags)
+				  unsigned int mm_flags, unsigned long vm_flags,
+				  struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
 
@@ -422,7 +423,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, NULL);
+	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
@@ -444,7 +445,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 {
 	const struct fault_info *inf;
 	struct mm_struct *mm = current->mm;
-	vm_fault_t fault, major = 0;
+	vm_fault_t fault;
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 
@@ -510,8 +511,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
-	major |= fault & VM_FAULT_MAJOR;
+	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -532,25 +532,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	 * Handle the "normal" (no error) case first.
 	 */
 	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
-			      VM_FAULT_BADACCESS)))) {
-		/*
-		 * Major/minor page fault accounting is only done
-		 * once. If we go through a retry, it is extremely
-		 * likely that the page will be found in page cache at
-		 * that point.
-		 */
-		if (major) {
-			current->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-				      addr);
-		} else {
-			current->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-				      addr);
-		}
-
+			      VM_FAULT_BADACCESS))))
 		return 0;
-	}
 
 	/*
 	 * If we are in kernel mode at this point, we have no context to
-- 
2.26.2

