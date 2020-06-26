Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F06820885
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ber2vWJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFZWc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:32:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725833AbgFZWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46zX68cVzugG5lsX8jDq0MfZnX4kHNTYf4hJ1qmG08o=;
        b=ber2vWJY/ULFLKi1BXozq9tdIqtVW2dk+7gIFomK9vxQvmZ5ew6Lsp+Nd6u+9PckOQqW0C
        TsdLqu12tT7zsWnkDphNdgDjnGJjSoQNcwAv8BPaniRkcigYrZqW7Zsl0ZCpvcq7FDnupa
        XkGL3FwTi/yonQ5Uvy6AuIWvDSPQTv8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-RLeGwQ14OGmM9b9h0PhdTQ-1; Fri, 26 Jun 2020 18:31:35 -0400
X-MC-Unique: RLeGwQ14OGmM9b9h0PhdTQ-1
Received: by mail-qk1-f199.google.com with SMTP id x22so7661535qkj.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46zX68cVzugG5lsX8jDq0MfZnX4kHNTYf4hJ1qmG08o=;
        b=CbjDrqm6r2cpBJX2t6N0mvyG9oFko50Wq2bRo9QvCUk5oDG8QlRVc1HIIO+NeQ0VnE
         3WR7Jr8um/7CRAWDCUaB9oyk1tvYNjMkOhSAkrbsich7adcwWIH/ehwGZAYf9kVJC2fP
         hpVX5QcrQXQ/O9mwGIWti/HljuNBDUHKdns9J0QWi9J6xtyQprUjHvKjVASwxKoYMF3H
         +qQmS3ia7tXXPCARBxHpW7Bwzn+MwfW0WhJ8sbB4lSsseTgzNCagKj3fBfIXgrnM0Ype
         od218+haMkR/AItGz0bzpwzje2OOl3UNbyQcuWAopT0ltqmKbTNVN/5oyXm74QQSEr/6
         NZ3w==
X-Gm-Message-State: AOAM532tbfD+MSrdNAENtPlUXCHsPpOhZZTcDuyVl9G3hJ+smTWs51V5
        TzCfR8NdZPW65VPCfWY/lBkOMTkilauGaCfh0MAMtSH4qLVlmqwdODFsDHweRz6Z3DwdpPn9q5t
        SvPrnjdRvxhLa5kQ3sBvP+Te6
X-Received: by 2002:ac8:f6f:: with SMTP id l44mr2968598qtk.4.1593210694239;
        Fri, 26 Jun 2020 15:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGBIAEIhdGjGdtK4u5EAqqYoyGVG3TjRqnu5X22wt8z+X7Z/x3bgLMi5bwNXGSEC9tGQ4LRg==
X-Received: by 2002:ac8:f6f:: with SMTP id l44mr2968555qtk.4.1593210693715;
        Fri, 26 Jun 2020 15:31:33 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
Date:   Fri, 26 Jun 2020 18:31:05 -0400
Message-Id: <20200626223130.199227-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch to move page fault accountings into the general
code in handle_mm_fault().  This includes both the per task flt_maj/flt_min
counters, and the major/minor page fault perf events.  To do this, the pt_regs
pointer is passed into handle_mm_fault().

PERF_COUNT_SW_PAGE_FAULTS should still be kept in per-arch page fault handlers.

So far, all the pt_regs pointer that passed into handle_mm_fault() is NULL,
which means this patch should have no intented functional change.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c         |  2 +-
 arch/arc/mm/fault.c           |  2 +-
 arch/arm/mm/fault.c           |  2 +-
 arch/arm64/mm/fault.c         |  2 +-
 arch/csky/mm/fault.c          |  3 +-
 arch/hexagon/mm/vm_fault.c    |  2 +-
 arch/ia64/mm/fault.c          |  2 +-
 arch/m68k/mm/fault.c          |  2 +-
 arch/microblaze/mm/fault.c    |  2 +-
 arch/mips/mm/fault.c          |  2 +-
 arch/nds32/mm/fault.c         |  2 +-
 arch/nios2/mm/fault.c         |  2 +-
 arch/openrisc/mm/fault.c      |  2 +-
 arch/parisc/mm/fault.c        |  2 +-
 arch/powerpc/mm/copro_fault.c |  2 +-
 arch/powerpc/mm/fault.c       |  2 +-
 arch/riscv/mm/fault.c         |  2 +-
 arch/s390/mm/fault.c          |  2 +-
 arch/sh/mm/fault.c            |  2 +-
 arch/sparc/mm/fault_32.c      |  4 +--
 arch/sparc/mm/fault_64.c      |  2 +-
 arch/um/kernel/trap.c         |  2 +-
 arch/unicore32/mm/fault.c     |  2 +-
 arch/x86/mm/fault.c           |  2 +-
 arch/xtensa/mm/fault.c        |  2 +-
 drivers/iommu/amd_iommu_v2.c  |  2 +-
 drivers/iommu/intel-svm.c     |  2 +-
 include/linux/mm.h            |  7 ++--
 mm/gup.c                      |  4 +--
 mm/hmm.c                      |  3 +-
 mm/ksm.c                      |  3 +-
 mm/memory.c                   | 62 ++++++++++++++++++++++++++++++++++-
 32 files changed, 101 insertions(+), 35 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index c2d7b6d7bac7..82e72f24486e 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -148,7 +148,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	/* If for any reason at all we couldn't handle the fault,
 	   make sure we exit gracefully rather than endlessly redo
 	   the fault.  */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 92b339c7adba..34380139e7a2 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -131,7 +131,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2dd5c41cbb8d..0d6be0f4f27c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -223,7 +223,7 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		goto out;
 	}
 
-	return handle_mm_fault(vma, addr & PAGE_MASK, flags);
+	return handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
 
 check_stack:
 	/* Don't allow expansion below FIRST_USER_ADDRESS */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c9cedc0432d2..5f6607b951b8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -422,7 +422,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags);
+	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, NULL);
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 4e6dc68f3258..b14f97d3cb15 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -150,7 +150,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0);
+	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
+				NULL);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 72334b26317a..f04cd0a6d905 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -89,7 +89,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		break;
 	}
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 30d0c1fca99e..caa93e083c9d 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -139,7 +139,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 * sure we exit gracefully rather than endlessly redo the
 	 * fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 3bfb5c8ac3c7..2db38dfbc00c 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -135,7 +135,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
 	if (fault_signal_pending(fault, regs))
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 3248141f8ed5..9abfa5224386 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -215,7 +215,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index f8d62cd83b36..31c2afb8f8a5 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -152,7 +152,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index f331e533edc2..22527129025c 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -207,7 +207,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, addr, flags);
+	fault = handle_mm_fault(vma, addr, flags, NULL);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index ec9d8a9c426f..88abf297c759 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -131,7 +131,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 8af1cc78c4fb..45aedc572361 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -159,7 +159,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 86e8c848f3d7..c10908ea8803 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -302,7 +302,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	 * fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index beb060b96632..c0478bef1f14 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -64,7 +64,7 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 	}
 
 	ret = 0;
-	*flt = handle_mm_fault(vma, ea, is_write ? FAULT_FLAG_WRITE : 0);
+	*flt = handle_mm_fault(vma, ea, is_write ? FAULT_FLAG_WRITE : 0, NULL);
 	if (unlikely(*flt & VM_FAULT_ERROR)) {
 		if (*flt & VM_FAULT_OOM) {
 			ret = -ENOMEM;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 84af6c8eecf7..992b10c3761c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -563,7 +563,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 #ifdef CONFIG_PPC_MEM_KEYS
 	/*
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index be84e32adc4c..677ee1bb11ac 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -110,7 +110,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, addr, flags);
+	fault = handle_mm_fault(vma, addr, flags, NULL);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index dedc28be27ab..ab6d7eedcfab 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5f23d7907597..a4e670a9c9b3 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -464,7 +464,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index f6e0e601f857..61524d284706 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -235,7 +235,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -411,7 +411,7 @@ static void force_user_fault(unsigned long address, int write)
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;
 	}
-	switch (handle_mm_fault(vma, address, flags)) {
+	switch (handle_mm_fault(vma, address, flags, NULL)) {
 	case VM_FAULT_SIGBUS:
 	case VM_FAULT_OOM:
 		goto do_sigbus;
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index c0c0dd471b6b..6b702a0a8155 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -423,7 +423,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 8f18cf56b3dd..32cc8f59322b 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -75,7 +75,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	do {
 		vm_fault_t fault;
 
-		fault = handle_mm_fault(vma, address, flags);
+		fault = handle_mm_fault(vma, address, flags, NULL);
 
 		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
 			goto out_nosemaphore;
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 3022104aa613..847ff24fcc2a 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -186,7 +186,7 @@ static vm_fault_t __do_pf(struct mm_struct *mm, unsigned long addr,
 	 * If for any reason at all we couldn't handle the fault, make
 	 * sure we exit gracefully rather than endlessly redo the fault.
 	 */
-	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags);
+	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
 	return fault;
 
 check_stack:
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a51df516b87b..3e27ed85af06 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1461,7 +1461,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 	major |= fault & VM_FAULT_MAJOR;
 
 	/* Quick path to respond to signals */
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index e7172bd53ced..722ef3c98d60 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -108,7 +108,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index d6d85debd01b..66042b816943 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -497,7 +497,7 @@ static void do_fault(struct work_struct *work)
 	if (access_error(vma, fault))
 		goto out;
 
-	ret = handle_mm_fault(vma, address, flags);
+	ret = handle_mm_fault(vma, address, flags, NULL);
 out:
 	up_read(&mm->mmap_sem);
 
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 2998418f0a38..c9cb5e5b6c34 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -629,7 +629,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto invalid;
 
 		ret = handle_mm_fault(vma, address,
-				      req->wr_req ? FAULT_FLAG_WRITE : 0);
+				      req->wr_req ? FAULT_FLAG_WRITE : 0, NULL);
 		if (ret & VM_FAULT_ERROR)
 			goto invalid;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3fe7371855c..46bee4044ac1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@ struct file_ra_state;
 struct user_struct;
 struct writeback_control;
 struct bdi_writeback;
+struct pt_regs;
 
 void init_mm_internals(void);
 
@@ -1652,7 +1653,8 @@ int invalidate_inode_page(struct page *page);
 
 #ifdef CONFIG_MMU
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags);
+				  unsigned long address, unsigned int flags,
+				  struct pt_regs *regs);
 extern int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
@@ -1662,7 +1664,8 @@ void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
 #else
 static inline vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags)
+					 unsigned long address, unsigned int flags,
+					 struct pt_regs *regs)
 {
 	/* should never happen if there's no MMU */
 	BUG();
diff --git a/mm/gup.c b/mm/gup.c
index 87a6a59fe667..1a48c639ea49 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -876,7 +876,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
 
-	ret = handle_mm_fault(vma, address, fault_flags);
+	ret = handle_mm_fault(vma, address, fault_flags, NULL);
 	if (ret & VM_FAULT_ERROR) {
 		int err = vm_fault_to_errno(ret, *flags);
 
@@ -1222,7 +1222,7 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	    fatal_signal_pending(current))
 		return -EINTR;
 
-	ret = handle_mm_fault(vma, address, fault_flags);
+	ret = handle_mm_fault(vma, address, fault_flags, NULL);
 	major |= ret & VM_FAULT_MAJOR;
 	if (ret & VM_FAULT_ERROR) {
 		int err = vm_fault_to_errno(ret, 0);
diff --git a/mm/hmm.c b/mm/hmm.c
index 280585833adf..5fca59a1f6e9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -90,7 +90,8 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 	}
 
 	for (; addr < end; addr += PAGE_SIZE)
-		if (handle_mm_fault(vma, addr, fault_flags) & VM_FAULT_ERROR)
+		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
+		    VM_FAULT_ERROR)
 			return -EFAULT;
 	return -EBUSY;
 }
diff --git a/mm/ksm.c b/mm/ksm.c
index 281c00129a2e..2e2b02abcc0f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -480,7 +480,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 			break;
 		if (PageKsm(page))
 			ret = handle_mm_fault(vma, addr,
-					FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE);
+					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+					      NULL);
 		else
 			ret = VM_FAULT_WRITE;
 		put_page(page);
diff --git a/mm/memory.c b/mm/memory.c
index f703fe8c8346..4a9b333b079e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,8 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/perf_event.h>
+#include <linux/ptrace.h>
 
 #include <trace/events/kmem.h>
 
@@ -4345,6 +4347,36 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	return handle_pte_fault(&vmf);
 }
 
+/**
+ * mm_account_fault - Do page fault accountings
+ * @regs: the pt_regs struct pointer.  When set to NULL, will skip accounting
+ * @address: faulted address.
+ * @major: whether this is a major fault.
+ *
+ * This will take care of most of the page fault accountings.  It should only
+ * be called when a page fault is completed.  For example, VM_FAULT_RETRY means
+ * the fault needs to be retried again later, so it should not contribute to
+ * the accounting.
+ *
+ * The accounting will also include the PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]
+ * perf counter updates.  Note: the handling of PERF_COUNT_SW_PAGE_FAULTS
+ * should still be in per-arch page fault handlers at the entry of page fault.
+ */
+static inline void mm_account_fault(struct pt_regs *regs,
+				    unsigned long address, bool major)
+{
+	if (!regs)
+		return;
+
+	if (major) {
+		current->maj_flt++;
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
+	} else {
+		current->min_flt++;
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
+	}
+}
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
@@ -4352,7 +4384,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
  * return value.  See filemap_fault() and __lock_page_or_retry().
  */
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
-		unsigned int flags)
+			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
 
@@ -4393,6 +4425,34 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			mem_cgroup_oom_synchronize(false);
 	}
 
+	if (ret & (VM_FAULT_RETRY | VM_FAULT_ERROR))
+		return ret;
+
+	/*
+	 * Do accounting in the common code, to avoid unnecessary
+	 * architecture differences or duplicated code.
+	 *
+	 * We arbitrarily make the rules be:
+	 *
+	 *  - Unsuccessful faults do not count (e.g. when the address wasn't
+	 *    valid). That includes arch_vma_access_permitted() failing above.
+	 *
+	 *    So this is expressly not a "this many hardware page faults"
+	 *    counter. Use the hw profiling for that.
+	 *
+	 *  - Incomplete faults do not count (e.g. RETRY).  They will only
+	 *    count once completed.
+	 *
+	 *  - The fault counts as a "major" fault when the final successful
+	 *    fault is VM_FAULT_MAJOR, or if it was a retry (which implies that
+	 *    we couldn't handle it immediately previously).
+	 *
+	 *  - If the fault is done for GUP, regs will be NULL and no accounting
+	 *    will be done.
+	 */
+	mm_account_fault(regs, address, (ret & VM_FAULT_MAJOR) ||
+			 (flags & FAULT_FLAG_TRIED));
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
-- 
2.26.2

