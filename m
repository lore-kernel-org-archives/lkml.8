Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC55C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974CF20772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxCii+aK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgF3UpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730015AbgF3UpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s/tHcdcbc7ASES1NC7DB9h+EmhaDl2CvL1xA0Fn1tkQ=;
        b=TxCii+aKKBFYoxdO4pu8QsNTzwGxb6JbyzyiSAgSHgIkJxbvK24ewMvtOPkYRTPoW2iWCq
        sW0dQHIJZZKVFLa04ETuOtSHeazzfBFR1LH22JEH8BlIFSh8SmoRlKPQRDqXPi736JlKMo
        c0uJTX1wPqt0Zb00JwORYQ+S/OHqn6A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Tz1zjr6xPg-y50wJmwNC_g-1; Tue, 30 Jun 2020 16:45:10 -0400
X-MC-Unique: Tz1zjr6xPg-y50wJmwNC_g-1
Received: by mail-qt1-f198.google.com with SMTP id c22so15313536qtp.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/tHcdcbc7ASES1NC7DB9h+EmhaDl2CvL1xA0Fn1tkQ=;
        b=X3OpI59FVRFbK/HDS5BQLxXugve31hNYTxzkVdg2GZ6UWDDSrRASVo6eB9sUMbc6yv
         lngZ3Vq92Lk7Qz7SP+USnck4Ccba1PobQdN8p8N3+8lNVkH1VBNf9QOwsosOP9zNKdS/
         T/Pw3v4TqzR9qNV9LuaVaTXAHZKcAodyZPJXT2kD4L20/wsGM3adhLRrhqxcKkRo9W61
         G3MhApsRwQa7q1D73Man4uJICJX25eJRJ9YVqR/3+k+9SshAFpeZg+vulmipdtScN8SH
         NygqFxVjCO2UNHADw/1cefFSe/yT4hSS2SE7D6avbetlhaiZKX05lMyBl8lDATNX2fVm
         pmGg==
X-Gm-Message-State: AOAM530D47cekTUXT/WEasaR361QRddj44Ve84mwDGYotc+NrEaBsc7Q
        8BbxI//Dts1S8nKSYP2ar/3AkpGKgUzX9lhopVAOJcCjkWLc5IHHd1D+liNW/uL0m1Cb396KVrP
        M4xgRSbCBKwQ3WjUSf2Rb7k8a
X-Received: by 2002:a37:ec7:: with SMTP id 190mr21417743qko.49.1593549906919;
        Tue, 30 Jun 2020 13:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHVmdxlpZRa7wrNNf8cVbqE4zwRTMK1+aEsQni+x4zkf/MOnttaP/o/L9HKDCy6mQRoDtl8g==
X-Received: by 2002:a37:ec7:: with SMTP id 190mr21417687qko.49.1593549906263;
        Tue, 30 Jun 2020 13:45:06 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 16sm3950681qkv.48.2020.06.30.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 01/26] mm: Do page fault accounting in handle_mm_fault
Date:   Tue, 30 Jun 2020 16:45:04 -0400
Message-Id: <20200630204504.38516-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
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
 drivers/iommu/amd/iommu_v2.c  |  2 +-
 drivers/iommu/intel/svm.c     |  3 +-
 include/linux/mm.h            |  7 ++--
 mm/gup.c                      |  4 +--
 mm/hmm.c                      |  3 +-
 mm/ksm.c                      |  3 +-
 mm/memory.c                   | 62 ++++++++++++++++++++++++++++++++++-
 32 files changed, 102 insertions(+), 35 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index c2303a8c2b9f..1983e43a5e2f 100644
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
index 72f5405a7ec5..1b178dc147fd 100644
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
index c6550eddfce1..01a8e0f8fef7 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -224,7 +224,7 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		goto out;
 	}
 
-	return handle_mm_fault(vma, addr & PAGE_MASK, flags);
+	return handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
 
 check_stack:
 	/* Don't allow expansion below FIRST_USER_ADDRESS */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8afb238ff335..be29f4076fe3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -428,7 +428,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags);
+	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, NULL);
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 0b9cbf2cf6a9..7137e2e8dc57 100644
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
index cd3808f96b93..f12f330e7946 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -88,7 +88,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		break;
 	}
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 3a4dec334cc5..abf2808f9b4b 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -143,7 +143,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 * sure we exit gracefully rather than endlessly redo the
 	 * fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index a94a814ad6ad..738fff2a16f4 100644
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
index a2bfe587b491..1a3d4c4ca28b 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -214,7 +214,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 01b168a90434..b1db39784db9 100644
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
index 8fb73f6401a0..d0ecc8fb5b23 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -206,7 +206,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, addr, flags);
+	fault = handle_mm_fault(vma, addr, flags, NULL);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 4112ef0e247e..86beb9a2698e 100644
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
index d2224ccca294..3daa491d1edb 100644
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
index 66ac0719bd49..e32d06928c24 100644
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
index b83abbead4a2..2d0276abe0a6 100644
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
index 641fc5f3d7dd..25dee001d8e1 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -607,7 +607,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	major |= fault & VM_FAULT_MAJOR;
 
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index ae7b7fe24658..50a952a68433 100644
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
index d53c2e2ea1fd..fc14df0b4d6e 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -478,7 +478,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index fbe1f2fe9a8c..3c0a11827f7e 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -482,7 +482,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index cfef656eda0f..06af03db4417 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -234,7 +234,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -410,7 +410,7 @@ static void force_user_fault(unsigned long address, int write)
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;
 	}
-	switch (handle_mm_fault(vma, address, flags)) {
+	switch (handle_mm_fault(vma, address, flags, NULL)) {
 	case VM_FAULT_SIGBUS:
 	case VM_FAULT_OOM:
 		goto do_sigbus;
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index a3806614e4dc..9ebee14ee893 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -422,7 +422,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 
 	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 2b3afa354a90..8d9870d76da1 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -71,7 +71,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	do {
 		vm_fault_t fault;
 
-		fault = handle_mm_fault(vma, address, flags);
+		fault = handle_mm_fault(vma, address, flags, NULL);
 
 		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
 			goto out_nosemaphore;
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 7654bddde133..9b4539d8d669 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -185,7 +185,7 @@ static vm_fault_t __do_pf(struct mm_struct *mm, unsigned long addr,
 	 * If for any reason at all we couldn't handle the fault, make
 	 * sure we exit gracefully rather than endlessly redo the fault.
 	 */
-	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags);
+	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
 	return fault;
 
 check_stack:
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1ead568c0101..fe3ca00eb121 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1292,7 +1292,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags);
+	fault = handle_mm_fault(vma, address, flags, NULL);
 	major |= fault & VM_FAULT_MAJOR;
 
 	/* Quick path to respond to signals */
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index c4decc73fd86..6942de45f078 100644
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
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index e4b025c5637c..c259108ab6dd 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -495,7 +495,7 @@ static void do_fault(struct work_struct *work)
 	if (access_error(vma, fault))
 		goto out;
 
-	ret = handle_mm_fault(vma, address, flags);
+	ret = handle_mm_fault(vma, address, flags, NULL);
 out:
 	mmap_read_unlock(mm);
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6c87c807a0ab..5ae59a6ad681 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -872,7 +872,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto invalid;
 
 		ret = handle_mm_fault(vma, address,
-				      req->wr_req ? FAULT_FLAG_WRITE : 0);
+				      req->wr_req ? FAULT_FLAG_WRITE : 0,
+				      NULL);
 		if (ret & VM_FAULT_ERROR)
 			goto invalid;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6a0c302dc76..ebc173dddad5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,6 +38,7 @@ struct file_ra_state;
 struct user_struct;
 struct writeback_control;
 struct bdi_writeback;
+struct pt_regs;
 
 void init_mm_internals(void);
 
@@ -1651,7 +1652,8 @@ int invalidate_inode_page(struct page *page);
 
 #ifdef CONFIG_MMU
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags);
+				  unsigned long address, unsigned int flags,
+				  struct pt_regs *regs);
 extern int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
@@ -1661,7 +1663,8 @@ void unmap_mapping_range(struct address_space *mapping,
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
index f6124e38c965..53ad15629014 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -884,7 +884,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
 
-	ret = handle_mm_fault(vma, address, fault_flags);
+	ret = handle_mm_fault(vma, address, fault_flags, NULL);
 	if (ret & VM_FAULT_ERROR) {
 		int err = vm_fault_to_errno(ret, *flags);
 
@@ -1238,7 +1238,7 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	    fatal_signal_pending(current))
 		return -EINTR;
 
-	ret = handle_mm_fault(vma, address, fault_flags);
+	ret = handle_mm_fault(vma, address, fault_flags, NULL);
 	major |= ret & VM_FAULT_MAJOR;
 	if (ret & VM_FAULT_ERROR) {
 		int err = vm_fault_to_errno(ret, 0);
diff --git a/mm/hmm.c b/mm/hmm.c
index e9a545751108..0be32b8a47be 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -75,7 +75,8 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 	}
 
 	for (; addr < end; addr += PAGE_SIZE)
-		if (handle_mm_fault(vma, addr, fault_flags) & VM_FAULT_ERROR)
+		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
+		    VM_FAULT_ERROR)
 			return -EFAULT;
 	return -EBUSY;
 }
diff --git a/mm/ksm.c b/mm/ksm.c
index 5fb176d497ea..90a625b02a1d 100644
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
index 17a3df0f3994..e594d5cdcaa0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,8 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/perf_event.h>
+#include <linux/ptrace.h>
 
 #include <trace/events/kmem.h>
 
@@ -4360,6 +4362,36 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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
@@ -4367,7 +4399,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
  * return value.  See filemap_fault() and __lock_page_or_retry().
  */
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
-		unsigned int flags)
+			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
 
@@ -4408,6 +4440,34 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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

