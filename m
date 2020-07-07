Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EAD2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxomDuAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgGGWuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44296 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729564AbgGGWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EjHuThpSN4MTMc6/ZiQrvbTE5N9rIyqvyo4j3Ae/jMQ=;
        b=BxomDuAauFS2MfFWidajHnpOWnAobkcXwVqHTlIVQrEyhPHs4qGXY9P4AICozkj6OCCF8U
        ZomkZknm+/jjJo/s0fDFCg1uReZAR5pmxw75kOdYxcIZBmLmogR0ekIuqqnKpWrYn6pLqC
        ZnnWDZx1Wxv0kpERuzWByB1FUT83fIU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-PDVeZE5QOgaU0eSzfWteng-1; Tue, 07 Jul 2020 18:50:33 -0400
X-MC-Unique: PDVeZE5QOgaU0eSzfWteng-1
Received: by mail-qk1-f197.google.com with SMTP id 204so29653049qki.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjHuThpSN4MTMc6/ZiQrvbTE5N9rIyqvyo4j3Ae/jMQ=;
        b=aD4vtfa4bUYGIk60772R5XvBg/9fGq9stahknHaXSkBJFWJk0KQjEtI6+KU5bxQpaa
         XAfRz/Rjqf/bRZeWI8o+L4NechCEb4WDdvTE/yPycB5Wc8fjyKbxCS4/JgHG7hDfDphf
         Rcuqb078tiusYLwkMLtbtWrWCkptCvLo9cxFDQuO/XP1iKMLrDYbKyo74anAdcV6+w/E
         mH6/l00zuVKY5yhR9pdrIzYgnnNW7TRflTk5jUzLJm3xCfrQLHpu7bOY951NUZ8z7Yt6
         6C+bLyjdHibKGeXeiVQGShCA5EAdtuzjGu6yyiA81vu+oYjky8xkwpmdfKzlPFz7SIWM
         eRoQ==
X-Gm-Message-State: AOAM5328zYRrZAasIkinXBDknHgLcTcKBPwDiwceRwtZPp672+a/4veG
        PGYyY7UYM7+Azqe8cfcdVNvxfMEYfMzZhA3US/zx429g1SBtASBgeZ9Chjjg9mFGG+9EV284L0M
        TJMtpU6ssIIDzGtUF47zkRi6i
X-Received: by 2002:ac8:4d5d:: with SMTP id x29mr57898338qtv.358.1594162232807;
        Tue, 07 Jul 2020 15:50:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKs84wiAnpkRkYMFU65uBv9KDGiwUMHAvWd757+lDwcSvLqmU3BsGAsJ394Lj65TO/7Bc44g==
X-Received: by 2002:ac8:4d5d:: with SMTP id x29mr57898318qtv.358.1594162232589;
        Tue, 07 Jul 2020 15:50:32 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 05/25] mm/arm64: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:01 -0400
Message-Id: <20200707225021.200906-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
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
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f885940035ce..a3bd189602df 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -404,7 +404,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADACCESS	0x020000
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
-			   unsigned int mm_flags, unsigned long vm_flags)
+				  unsigned int mm_flags, unsigned long vm_flags,
+				  struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
 
@@ -428,7 +429,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, NULL);
+	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
@@ -450,7 +451,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 {
 	const struct fault_info *inf;
 	struct mm_struct *mm = current->mm;
-	vm_fault_t fault, major = 0;
+	vm_fault_t fault;
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 
@@ -516,8 +517,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
-	major |= fault & VM_FAULT_MAJOR;
+	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -538,25 +538,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
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

