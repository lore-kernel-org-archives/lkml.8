Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CB02053B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTsxTQCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHRDeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRDeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:34:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0FC061389;
        Mon, 17 Aug 2020 20:34:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g7so7431371plq.1;
        Mon, 17 Aug 2020 20:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kXKR3cXpwpt0q9jgFz26UJPnEar0RH5gNFSzQ9D4WUQ=;
        b=JTsxTQCWOkw6T9c3YtWdB1NVIAooJ/0TYLt2HeP3tRrpo9IrPH5fcSJC/W1TF6hUrK
         36Q88tCA5xip+UxdciaZbVfDYgfeyDGUIlbtktjwoxbZTeYrUnbZdG9gFRAnIwKqJwdP
         CmGqb7y9E+ke6lvgFU5x9I3iM9wDvEHVONeLH5m/QC2OyjTuFzQr+1ki+1vWIx4c71RY
         cYA4y4P1JW8KO+6gnUICfuT2g5W25/HCbpSLRvLO85Mdpzi+D1wSk/sEAtEssZ3j+vfB
         n34t1a9YyqYAUV0FR8/FV1KruetVFbpMilo3/y6737GJKAD+w5XJS50Ge4nPNk/NYv2B
         7DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kXKR3cXpwpt0q9jgFz26UJPnEar0RH5gNFSzQ9D4WUQ=;
        b=sEAhKTGCuY40D3OV6p7zdzyfMRWTePiflqwFJoRNnwF9s7j9bIybsukHwM8eNHkbHg
         mbNTXf3XJgGiRFnZBY/N9RBoHfxG/ghatBPLbMU8mdZzzaKONGyH5FBg+PI7TACPyaUQ
         ngSjqEPTuUgYdkcN3KApbcx/fy/gKRnGzcMyLLWekVkhdThR20mTym7jYwV9+gBfP2h+
         5xUp7p1g9cViyTZOKUYQB1m7wmRn+3utwG16RoPJ3cIsOualyqMa//VNEyo+pA9/BJAq
         qCtTLz1MNXIlzpUEt2ETfS0buxCvmECjPg1qdQ97Jr3xeDsajlPIjTNGwG2ccSRKvwhK
         AApw==
X-Gm-Message-State: AOAM531OT8ZHYeUQA97RXqFo5TI7wzBFR9DqKtIp/wBgCn3NNHTAf7++
        DbRTM9IKmsFmp8GtdnTaSgo=
X-Google-Smtp-Source: ABdhPJyW1IrlExwvUFobL+ijBXLtHQla2kejcW1bkPDfbMej7nAW5/8WB8glAdU0v5nRmt+I6vLSLA==
X-Received: by 2002:a17:90b:349:: with SMTP id fh9mr14332259pjb.73.1597721654856;
        Mon, 17 Aug 2020 20:34:14 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id b18sm19823352pgj.12.2020.08.17.20.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 20:34:14 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [RFC PATCH 1/2] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
Date:   Tue, 18 Aug 2020 13:34:04 +1000
Message-Id: <20200818033405.170457-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The de facto (and apparently uncommented) standard for using an mm had,
thanks to this code in sparc if nothing else, been that you must have a
reference on mm_users *and that reference must have been obtained with
mmget()*, i.e., from a thread with a reference to mm_users that had used
the mm.

The introduction of mmget_not_zero() in commit d2005e3f41d4
("userfaultfd: don't pin the user memory in userfaultfd_file_create()")
allowed mm_count holders to aoperate on user mappings asynchronously
from the actual threads using the mm, but they were not to load those
mappings into their TLB (i.e., walking vmas and page tables is okay,
kthread_use_mm() is not).

io_uring 2b188cc1bb857 ("Add io_uring IO interface") added code which
does a kthread_use_mm() from a mmget_not_zero() refcount.

The problem with this is code which previously assumed mm == current->mm
and mm->mm_users == 1 implies the mm will remain single-threaded at
least until this thread creates another mm_users reference, has now
broken.

arch/sparc/kernel/smp_64.c:

    if (atomic_read(&mm->mm_users) == 1) {
        cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
        goto local_flush_and_out;
    }

vs fs/io_uring.c

    if (unlikely(!(ctx->flags & IORING_SETUP_SQPOLL) ||
                 !mmget_not_zero(ctx->sqo_mm)))
        return -EFAULT;
    kthread_use_mm(ctx->sqo_mm);

mmget_not_zero() could come in right after the mm_users == 1 test, then
kthread_use_mm() which sets its CPU in the mm_cpumask. That update could
be lost if cpumask_copy() occurs afterward.

I propose we fix this by allowing mmget_not_zero() to be a first-class
reference, and not have this obscure undocumented and unchecked
restriction.

The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
optimisation could be effectively restored by sending IPIs to mm_cpumask
members and having them remove themselves from mm_cpumask. This is more
tricky so I leave it as an exercise for someone with a sparc64 SMP.
powerpc has a (currently similarly broken) example.

not-yet-Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sparc/kernel/smp_64.c | 58 ++++++--------------------------------
 1 file changed, 9 insertions(+), 49 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e286e2badc8a..41423c6077d0 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1039,38 +1039,9 @@ void smp_fetch_global_pmu(void)
  * are flush_tlb_*() routines, and these run after flush_cache_*()
  * which performs the flushw.
  *
- * The SMP TLB coherency scheme we use works as follows:
- *
- * 1) mm->cpu_vm_mask is a bit mask of which cpus an address
- *    space has (potentially) executed on, this is the heuristic
- *    we use to avoid doing cross calls.
- *
- *    Also, for flushing from kswapd and also for clones, we
- *    use cpu_vm_mask as the list of cpus to make run the TLB.
- *
- * 2) TLB context numbers are shared globally across all processors
- *    in the system, this allows us to play several games to avoid
- *    cross calls.
- *
- *    One invariant is that when a cpu switches to a process, and
- *    that processes tsk->active_mm->cpu_vm_mask does not have the
- *    current cpu's bit set, that tlb context is flushed locally.
- *
- *    If the address space is non-shared (ie. mm->count == 1) we avoid
- *    cross calls when we want to flush the currently running process's
- *    tlb state.  This is done by clearing all cpu bits except the current
- *    processor's in current->mm->cpu_vm_mask and performing the
- *    flush locally only.  This will force any subsequent cpus which run
- *    this task to flush the context from the local tlb if the process
- *    migrates to another cpu (again).
- *
- * 3) For shared address spaces (threads) and swapping we bite the
- *    bullet for most cases and perform the cross call (but only to
- *    the cpus listed in cpu_vm_mask).
- *
- *    The performance gain from "optimizing" away the cross call for threads is
- *    questionable (in theory the big win for threads is the massive sharing of
- *    address space state across processors).
+ * mm->cpu_vm_mask is a bit mask of which cpus an address
+ * space has (potentially) executed on, this is the heuristic
+ * we use to limit cross calls.
  */
 
 /* This currently is only used by the hugetlb arch pre-fault
@@ -1082,16 +1053,10 @@ void smp_flush_tlb_mm(struct mm_struct *mm)
 	u32 ctx = CTX_HWBITS(mm->context);
 	int cpu = get_cpu();
 
-	if (atomic_read(&mm->mm_users) == 1) {
-		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
-		goto local_flush_and_out;
-	}
-
 	smp_cross_call_masked(&xcall_flush_tlb_mm,
 			      ctx, 0, 0,
 			      mm_cpumask(mm));
 
-local_flush_and_out:
 	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
 
 	put_cpu();
@@ -1120,11 +1085,8 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 	info.nr = nr;
 	info.vaddrs = vaddrs;
 
-	if (mm == current->mm && atomic_read(&mm->mm_users) == 1)
-		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
-	else
-		smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
-				       &info, 1);
+	smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
+			       &info, 1);
 
 	__flush_tlb_pending(ctx, nr, vaddrs);
 
@@ -1136,12 +1098,10 @@ void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
 	unsigned long context = CTX_HWBITS(mm->context);
 	int cpu = get_cpu();
 
-	if (mm == current->mm && atomic_read(&mm->mm_users) == 1)
-		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
-	else
-		smp_cross_call_masked(&xcall_flush_tlb_page,
-				      context, vaddr, 0,
-				      mm_cpumask(mm));
+	smp_cross_call_masked(&xcall_flush_tlb_page,
+			      context, vaddr, 0,
+			      mm_cpumask(mm));
+
 	__flush_tlb_page(context, vaddr);
 
 	put_cpu();
-- 
2.23.0

