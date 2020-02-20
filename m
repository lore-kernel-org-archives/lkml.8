Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B07C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B500C24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQgktwEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgBTPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:54:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbgBTPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Mh676x2V7WPJQ5Q4bhcBk2eD6SPRqYMWz8sogXT9zQ=;
        b=BQgktwErep55VucG8r2WQXzGKVyIxgYjBmbS+56ZSLpUNiyNdCxUop+4HAGngxhnxE1Bl8
        N4opRTjVW0kvshGYdoC2PMAbCnwoF3FX+nYoGbhskVaO+QAEMpP9f8am3Nu4HlxKbW+rsg
        2nafNGCPJ9877F9wjVyo+z7yfNY7x9M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-K4AKLpokMDyYmFa-TVt6oA-1; Thu, 20 Feb 2020 10:54:05 -0500
X-MC-Unique: K4AKLpokMDyYmFa-TVt6oA-1
Received: by mail-qt1-f199.google.com with SMTP id l25so2887551qtu.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Mh676x2V7WPJQ5Q4bhcBk2eD6SPRqYMWz8sogXT9zQ=;
        b=fXf0yjoimA+WMNbDzyBb8wMU4REzRILue3IMoRxOyGQ5XIW7qM8NDPUrtGDRa0bhch
         G1UfrOTA0fIFFp0iUwasmg3M8uOH1DwrNZCjqsWrhTWhYwkaIAmKvbYBuFs8XhULY3U8
         HKE+nw2qtEihv+1AUVMttzmvno+hQcA0vMfc19v7Alr2yzZzyY31GiZzCfVo5+Kmsz/C
         9E9CzZ2Gnlvky85FKkdxbxEpQYPnzwN8YLJbQN3YpiwT3tMy9dUPZAzd9wMnmS0b5sCY
         owCRZpaRRkSbmBpFGcQ85W7YFSt4Q7DNEeBL767GnVlydfOXtePKSesX9USlajfA+1ir
         I24Q==
X-Gm-Message-State: APjAAAUePbmYjZR7hKgpPtHhgDtJzkpktx27l0eIfCoHcUSgFgLA2q2F
        Vm7mmWfzUgaJ2LryuLLsHKBTGbnz475W6PxacHcLFHFmpgSNR8FFiXp9y/YZwPPZowL+uPsN0Mk
        lYL9t9FM8aeXoe+78cHHs+Zs6
X-Received: by 2002:a05:620a:b83:: with SMTP id k3mr27384588qkh.425.1582214043050;
        Thu, 20 Feb 2020 07:54:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqybYr6bDEV4C6TnC93gLoCkT2H6jjY6IqDEpzHnghyV6Cs0aJKz8PK7g9Obwf00UEl5GpSMkA==
X-Received: by 2002:a05:620a:b83:: with SMTP id k3mr27384539qkh.425.1582214042581;
        Thu, 20 Feb 2020 07:54:02 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id h20sm1807430qkk.64.2020.02.20.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:54:01 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: [PATCH RESEND v6 03/16] mm: Introduce fault_signal_pending()
Date:   Thu, 20 Feb 2020 10:53:40 -0500
Message-Id: <20200220155353.8676-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: <20200220155353.8676-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most architectures, we've got a quick path to detect fatal signal
after a handle_mm_fault().  Introduce a helper for that quick path.

It cleans the current codes a bit so we don't need to duplicate the
same check across archs.  More importantly, this will be an unified
place that we handle the signal immediately right after an interrupted
page fault, so it'll be much easier for us if we want to change the
behavior of handling signals later on for all the archs.

Note that currently only part of the archs are using this new helper,
because some archs have their own way to handle signals.  In the
follow up patches, we'll try to apply this helper to all the rest of
archs.

Another note is that the "regs" parameter in the new helper is not
used yet.  It'll be used very soon.  Now we kept it in this patch only
to avoid touching all the archs again in the follow up patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c        |  2 +-
 arch/arm/mm/fault.c          |  2 +-
 arch/hexagon/mm/vm_fault.c   |  2 +-
 arch/ia64/mm/fault.c         |  2 +-
 arch/m68k/mm/fault.c         |  2 +-
 arch/microblaze/mm/fault.c   |  2 +-
 arch/mips/mm/fault.c         |  2 +-
 arch/nds32/mm/fault.c        |  2 +-
 arch/nios2/mm/fault.c        |  2 +-
 arch/openrisc/mm/fault.c     |  2 +-
 arch/parisc/mm/fault.c       |  2 +-
 arch/riscv/mm/fault.c        |  2 +-
 arch/s390/mm/fault.c         |  3 +--
 arch/sparc/mm/fault_32.c     |  2 +-
 arch/sparc/mm/fault_64.c     |  2 +-
 arch/unicore32/mm/fault.c    |  2 +-
 arch/xtensa/mm/fault.c       |  2 +-
 include/linux/sched/signal.h | 13 +++++++++++++
 18 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 741e61ef9d3f..aea33b599037 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	   the fault.  */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bd0f4821f7e1..937b81ff8649 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -295,7 +295,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			goto no_context;
 		return 0;
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index b3bc71680ae4..d19beaf11b4c 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -91,7 +91,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	/* The most common case -- we are done. */
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index c2f299fe9e04..211b4f439384 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -141,7 +141,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index e9b1d7585b43..a455e202691b 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -138,7 +138,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	fault = handle_mm_fault(vma, address, flags);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return 0;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index e6a810b0c7ad..cdde01dcdfc3 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -217,7 +217,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 1e8d00793784..0ee6fafc57bc 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -154,7 +154,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(regs))
 		return;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 906dfb25353c..0e63f81eff5b 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -214,7 +214,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			goto no_context;
 		return;
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 6a2e716b959f..704ace8ca0ee 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -133,7 +133,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 5d4d3a9691d0..85c7eb0c0186 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -161,7 +161,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index adbd5e2144a3..f9be1d1cb43f 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -304,7 +304,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index cf7248e07f43..1d3869e9ddef 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -117,7 +117,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 7b0bb475c166..179cf92a56e5 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -480,8 +480,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
-	/* No reason to continue if interrupted by SIGKILL. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
 			goto out_up;
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 89976c9b936c..6efbeb227644 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -237,7 +237,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 8b7ddbd14b65..dd1ed6555831 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -425,7 +425,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 76342de9cf8c..59d0e6ec2cfc 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -250,7 +250,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return 0;
 
 	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index bee30a77cd70..59515905d4ad 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -110,7 +110,7 @@ void do_page_fault(struct pt_regs *regs)
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 88050259c466..4c87ffce64d1 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -369,6 +369,19 @@ static inline int signal_pending_state(long state, struct task_struct *p)
 	return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
 }
 
+/*
+ * This should only be used in fault handlers to decide whether we
+ * should stop the current fault routine to handle the signals
+ * instead, especially with the case where we've got interrupted with
+ * a VM_FAULT_RETRY.
+ */
+static inline bool fault_signal_pending(unsigned int fault_flags,
+					struct pt_regs *regs)
+{
+	return unlikely((fault_flags & VM_FAULT_RETRY) &&
+			fatal_signal_pending(current));
+}
+
 /*
  * Reevaluate whether the task has signals pending delivery.
  * Wake the task if so.
-- 
2.24.1

