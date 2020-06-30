Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D918A20775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYKwMw2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgF3UqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730416AbgF3UqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KP+2GjJCGxAUudaqzPCZQK6QSLk+7TO8m2VQsgXKpzI=;
        b=OYKwMw2v4ABxnZSk1kh9tmMDdRrer0EfHILEo+k7+9oRef4wdBnjJgPWvaS4iQU8kxA1K+
        g7EVG8OnhVi1ufQehTIguut66yzxKkyv8eaZvWX4FmQM+0dEzUzZyQgwlhM+OnEZFZV6za
        l5grYcBStFcFbvmIt9kh423VsL+IlgQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-AU63hCNbOUCSAdZyKeCthw-1; Tue, 30 Jun 2020 16:46:13 -0400
X-MC-Unique: AU63hCNbOUCSAdZyKeCthw-1
Received: by mail-qk1-f198.google.com with SMTP id z1so5383009qkz.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KP+2GjJCGxAUudaqzPCZQK6QSLk+7TO8m2VQsgXKpzI=;
        b=U1HC/u62o1SaP4w0YqJ+1qKLHSmUh41XDQLKxtytx+uli2WyfqhMovmszuxAyuuRGn
         VeCAltNHrOpY+Ga5iwMdFvL0qqjiwiDDE6GmHk0arVt/UR+I3jmXoSieZ4RQRgzoZmN6
         6Ib4IGsoH+r7Cm5JlTC8vrZYqPERQOPw4nU8Cuk9UAafkg8ZRdoQdvobQKH6Um6O7x5J
         u3H6uzZOlkIWraSSAHyu2ac19oxho+0n7muhG8cdtmKTFjwMKUCXAHZO0b/4RXLqjJRh
         WAbrJoZDCYRCnzzqlLQldGAbRvLATF19mBkFaJ7fVSeevXdAIK+V23vqie7WVTvr7v6n
         2EaQ==
X-Gm-Message-State: AOAM5311Jjh/54UyXr+Y5ppTrVPRcLURSQYmHVk6TRV+2nozM/Y92rE7
        TuUq5qafu6j+I+ekZGZO6pjHTb3YBMUoveME2xTyggMtYmtpyxJvnUGTkZswRfZQh8VuNDd8C94
        0MMI6ma4vwLOPd19MqU7UjvBr
X-Received: by 2002:a05:620a:20db:: with SMTP id f27mr19920691qka.345.1593549971477;
        Tue, 30 Jun 2020 13:46:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuOgaCMTcOSfNWgVpDMRuvJOVPg/PDTEHtuDHHfX8jyFjFfbUpFyUfQhuNzejHJ4xckU7Yog==
X-Received: by 2002:a05:620a:20db:: with SMTP id f27mr19920545qka.345.1593549969136;
        Tue, 30 Jun 2020 13:46:09 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d13sm3830829qkj.27.2020.06.30.13.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:46:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 25/26] mm: Clean up the last pieces of page fault accountings
Date:   Tue, 30 Jun 2020 16:46:07 -0400
Message-Id: <20200630204607.39688-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here're the last pieces of page fault accounting that were still done outside
handle_mm_fault() where we still have regs==NULL when calling handle_mm_fault():

arch/powerpc/mm/copro_fault.c:   copro_handle_mm_fault
arch/sparc/mm/fault_32.c:        force_user_fault
arch/um/kernel/trap.c:           handle_page_fault
mm/gup.c:                        faultin_page
                                 fixup_user_fault
mm/hmm.c:                        hmm_vma_fault
mm/ksm.c:                        break_ksm

Some of them has the issue of duplicated accounting for page fault retries.
Some of them didn't do the accounting at all.

This patch cleans all these up by letting handle_mm_fault() to do per-task page
fault accounting even if regs==NULL (though we'll still skip the perf event
accountings).  With that, we can safely remove all the outliers now.

There's another functional change in that now we account the page faults to the
caller of gup, rather than the task_struct that passed into the gup code.  More
information of this can be found at [1].

After this patch, below things should never be touched again outside
handle_mm_fault():

  - task_struct.[maj|min]_flt
  - PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]

[1] https://lore.kernel.org/lkml/CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/copro_fault.c |  5 -----
 arch/um/kernel/trap.c         |  4 ----
 mm/gup.c                      | 13 -------------
 mm/memory.c                   | 19 ++++++++++++-------
 4 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 2d0276abe0a6..8acd00178956 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -76,11 +76,6 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 		BUG();
 	}
 
-	if (*flt & VM_FAULT_MAJOR)
-		current->maj_flt++;
-	else
-		current->min_flt++;
-
 out_unlock:
 	mmap_read_unlock(mm);
 	return ret;
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 8d9870d76da1..ad12f78bda7e 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -88,10 +88,6 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			BUG();
 		}
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 
diff --git a/mm/gup.c b/mm/gup.c
index 53ad15629014..89b18c407ad2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -893,13 +893,6 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		BUG();
 	}
 
-	if (tsk) {
-		if (ret & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
-	}
-
 	if (ret & VM_FAULT_RETRY) {
 		if (locked && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
 			*locked = 0;
@@ -1255,12 +1248,6 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 		goto retry;
 	}
 
-	if (tsk) {
-		if (major)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fixup_user_fault);
diff --git a/mm/memory.c b/mm/memory.c
index e594d5cdcaa0..00d96ae9464c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4365,6 +4365,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 /**
  * mm_account_fault - Do page fault accountings
  * @regs: the pt_regs struct pointer.  When set to NULL, will skip accounting
+ *        of perf event counters, but we'll still do the per-task accounting to
+ *        the task who triggered this page fault.
  * @address: faulted address.
  * @major: whether this is a major fault.
  *
@@ -4380,16 +4382,18 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 static inline void mm_account_fault(struct pt_regs *regs,
 				    unsigned long address, bool major)
 {
+	if (major)
+		current->maj_flt++;
+	else
+		current->min_flt++;
+
 	if (!regs)
 		return;
 
-	if (major) {
-		current->maj_flt++;
+	if (major)
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	} else {
-		current->min_flt++;
+	else
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
 }
 
 /*
@@ -4462,8 +4466,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	 *    fault is VM_FAULT_MAJOR, or if it was a retry (which implies that
 	 *    we couldn't handle it immediately previously).
 	 *
-	 *  - If the fault is done for GUP, regs will be NULL and no accounting
-	 *    will be done.
+	 *  - If the fault is done for GUP, regs will be NULL and we only do
+	 *    the accounting for the per thread fault counters who triggered
+	 *    the fault, and we skip the perf event updates.
 	 */
 	mm_account_fault(regs, address, (ret & VM_FAULT_MAJOR) ||
 			 (flags & FAULT_FLAG_TRIED));
-- 
2.26.2

