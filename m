Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C490C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E2120658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TT/QIOit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgBTQCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:02:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728620AbgBTQCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AmcICkS4qLRuLvXLi+X8xttLltG7TU1l+7uRTCbIxo=;
        b=TT/QIOitZipDWqINTqrdp4DAtXHRNVT8/9WaahiemxfLpyS04YsnjjJnf3rnhdDi+NCOAy
        jHSbNQCaXBtfOmQjiIJIIodHEece1paF8YIKD/mRt/os6fqqriouyc+cnS6cRGt7sYA/0Y
        ZRm16mmAKEbck8+YZDqooE89adtbmuM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Sm-F4ZUgMkymlXIeO3JzRQ-1; Thu, 20 Feb 2020 11:02:45 -0500
X-MC-Unique: Sm-F4ZUgMkymlXIeO3JzRQ-1
Received: by mail-qv1-f69.google.com with SMTP id z9so2659658qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AmcICkS4qLRuLvXLi+X8xttLltG7TU1l+7uRTCbIxo=;
        b=CtpKCGZpzZh9pjAAlCn0AMnkRgDY0ZOT5Ep6tQDzPHKSgnHM9/2uQ1TFBAgANm+ZTh
         ewPcTL5XNnLP5/xNYRAM5BKFGEN7cgRVgHCuNsp2ji25f+DyaBALZjfC3z5fGejZD/bl
         NykHp2arCOdPjDBStprPMecqPfZLxuWR9zfJXg2xO5IIWQUPcguMbmQpoydJU8+B8Dtb
         zpb+N+xMIU/9EyZolg8hMPlFsUNdghlewoWvM9+2s0VnY9/i+F3+oC0zTg8BA5wExlXI
         UfH8a5wHUzZCVWUFHWFeovMi7DXjlJG9rpwKJx/hHoW+3WipkenBThqwubmr1tEPa67j
         Xiuw==
X-Gm-Message-State: APjAAAUkrvGUAjI5G3z6/aPT+zTK/Igp7B1Ez+LVtJy6lP0ioAMB1Git
        knsxREi8VZ+nMnyTK30vYMZLmKcqL3eBstvpWtIsfZs2FLZ7269D5rB7mTFnjo9t0stVdqdUfAB
        5Oh85Qceq6scqOsGqsjqYCEln
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr28272254qkb.271.1582214561774;
        Thu, 20 Feb 2020 08:02:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqy59oXB5E7UBfzrHFadhkloEalSk+rQ9RMcQOQcFGKGKndhAOp1fJbWwOLNqiBulT5JTmCSUg==
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr28272212qkb.271.1582214561305;
        Thu, 20 Feb 2020 08:02:41 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id d69sm1852468qkg.63.2020.02.20.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:02:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH RESEND v6 11/16] mm: Introduce FAULT_FLAG_DEFAULT
Date:   Thu, 20 Feb 2020 11:02:38 -0500
Message-Id: <20200220160238.9694-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there're tons of arch-specific page fault handlers, most of
them are still sharing the same initial value of the page fault flags.
Say, merely all of the page fault handlers would allow the fault to be
retried, and they also allow the fault to respond to SIGKILL.

Let's define a default value for the fault flags to replace those
initial page fault flags that were copied over.  With this, it'll be
far easier to introduce new fault flag that can be used by all the
architectures instead of touching all the archs.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c      | 2 +-
 arch/arc/mm/fault.c        | 2 +-
 arch/arm/mm/fault.c        | 2 +-
 arch/arm64/mm/fault.c      | 2 +-
 arch/hexagon/mm/vm_fault.c | 2 +-
 arch/ia64/mm/fault.c       | 2 +-
 arch/m68k/mm/fault.c       | 2 +-
 arch/microblaze/mm/fault.c | 2 +-
 arch/mips/mm/fault.c       | 2 +-
 arch/nds32/mm/fault.c      | 2 +-
 arch/nios2/mm/fault.c      | 2 +-
 arch/openrisc/mm/fault.c   | 2 +-
 arch/parisc/mm/fault.c     | 2 +-
 arch/powerpc/mm/fault.c    | 2 +-
 arch/riscv/mm/fault.c      | 2 +-
 arch/s390/mm/fault.c       | 2 +-
 arch/sh/mm/fault.c         | 2 +-
 arch/sparc/mm/fault_32.c   | 2 +-
 arch/sparc/mm/fault_64.c   | 2 +-
 arch/um/kernel/trap.c      | 2 +-
 arch/unicore32/mm/fault.c  | 2 +-
 arch/x86/mm/fault.c        | 2 +-
 arch/xtensa/mm/fault.c     | 2 +-
 include/linux/mm.h         | 7 +++++++
 24 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index aea33b599037..fcfa229cc1e7 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -89,7 +89,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	const struct exception_table_entry *fixup;
 	int si_code = SEGV_MAPERR;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	/* As of EV6, a load into $31/$f31 is a prefetch, and never faults
 	   (or is suppressed by the PALcode).  Support that for older CPUs
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 6eb821a59b49..643fad774071 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -100,7 +100,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	         (regs->ecr_cause == ECR_C_PROTV_INST_FETCH))
 		exec = 1;
 
-	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 	if (write)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 937b81ff8649..18ef0b143ac2 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -241,7 +241,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct mm_struct *mm;
 	int sig, code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6f4b69d712b1..cbb29a43aa7f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -446,7 +446,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	struct mm_struct *mm = current->mm;
 	vm_fault_t fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE | VM_EXEC;
-	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index d19beaf11b4c..d9e15d941bdb 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -41,7 +41,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	int si_code = SEGV_MAPERR;
 	vm_fault_t fault;
 	const struct exception_table_entry *fixup;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	/*
 	 * If we're in an interrupt or have no user context,
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 211b4f439384..b5aa4e80c762 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -65,7 +65,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	struct mm_struct *mm = current->mm;
 	unsigned long mask;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	mask = ((((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
 		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index a455e202691b..182799fd9987 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -71,7 +71,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct * vma;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	pr_debug("do page fault:\nregs->sr=%#x, regs->pc=%#lx, address=%#lx, %ld, %p\n",
 		regs->sr, regs->pc, address, error_code, mm ? mm->pgd : NULL);
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index cdde01dcdfc3..32da02778a63 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -91,7 +91,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	int code = SEGV_MAPERR;
 	int is_write = error_code & ESR_S;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	regs->ear = address;
 	regs->esr = error_code;
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 0ee6fafc57bc..f177da67d940 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -44,7 +44,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	const int field = sizeof(unsigned long) * 2;
 	int si_code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 10);
 
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 0e63f81eff5b..2810a4e5ab27 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -80,7 +80,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	int si_code;
 	vm_fault_t fault;
 	unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	error_code = error_code & (ITYPE_mskINST | ITYPE_mskETYPE);
 	tsk = current;
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 704ace8ca0ee..c38bea4220fb 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -47,7 +47,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	struct mm_struct *mm = tsk->mm;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	cause >>= 2;
 
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 85c7eb0c0186..30d5c51e9d40 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -50,7 +50,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct vm_area_struct *vma;
 	int si_code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index f9be1d1cb43f..8e88e5c5f26a 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -274,7 +274,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	if (!mm)
 		goto no_context;
 
-	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 0868172ce4e3..d7e1f8dc7e4c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -434,7 +434,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 {
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
  	int is_exec = TRAP(regs) == 0x400;
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 1d3869e9ddef..a252d9e38561 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -30,7 +30,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long addr, cause;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 179cf92a56e5..551ac311bd35 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -429,7 +429,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 
 	address = trans_exc_code & __FAIL_ADDR_MASK;
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 	if (access == VM_WRITE || (trans_exc_code & store_indication) == 0x400)
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index eb4048ad0b38..d9c8f2d00a54 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -380,7 +380,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 	mm = tsk->mm;
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 6efbeb227644..a91b0c2d84f8 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -168,7 +168,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	int from_user = !(regs->psr & PSR_PS);
 	int code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	if (text_fault)
 		address = regs->pc;
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index dd1ed6555831..30653418a672 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -271,7 +271,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	int si_code, fault_code;
 	vm_fault_t fault;
 	unsigned long address, mm_rss;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	fault_code = get_thread_fault_code();
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 818553064f04..c59ad37eacda 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -33,7 +33,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	pmd_t *pmd;
 	pte_t *pte;
 	int err = -EFAULT;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	*code_out = SEGV_MAPERR;
 
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 59d0e6ec2cfc..34a90453ca18 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -202,7 +202,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct mm_struct *mm;
 	int sig, code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 	mm = tsk->mm;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6a00bc8d047f..7b6f65333355 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1288,7 +1288,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	vm_fault_t fault, major = 0;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 	mm = tsk->mm;
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 59515905d4ad..7d196dc951e8 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -43,7 +43,7 @@ void do_page_fault(struct pt_regs *regs)
 
 	int is_write, is_exec;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	code = SEGV_MAPERR;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..08ca35d3c341 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -388,6 +388,13 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
 #define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
 
+/*
+ * The default fault flags that should be used by most of the
+ * arch-specific page fault handlers.
+ */
+#define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
+			     FAULT_FLAG_KILLABLE)
+
 #define FAULT_FLAG_TRACE \
 	{ FAULT_FLAG_WRITE,		"WRITE" }, \
 	{ FAULT_FLAG_MKWRITE,		"MKWRITE" }, \
-- 
2.24.1

