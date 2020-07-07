Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250EDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D912075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hruPmMsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgGGWvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36081 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729769AbgGGWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJjL1mXsjMkVQ/047kV0rS5FUrA3V1hN/izl2cQ6Ufs=;
        b=hruPmMsSfUHdPK8gOqck+7CatkAssA1v5Jl7SFWcYujiwwww8SE4lzn9DM31CGw5k2lcZg
        DBD4Byo2rc5yTZIuF8nDixST68YPaEZEfyvGAT9Hnkp4xs9oHeFnSCOmsj/itzOGXOER6U
        sT68kXF6B0y7nUUcANxiaii27aSx2vE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-nC-np3dHOQukUPfKSEyDtQ-1; Tue, 07 Jul 2020 18:51:05 -0400
X-MC-Unique: nC-np3dHOQukUPfKSEyDtQ-1
Received: by mail-qk1-f200.google.com with SMTP id q192so19431815qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJjL1mXsjMkVQ/047kV0rS5FUrA3V1hN/izl2cQ6Ufs=;
        b=PGXJm+gVRqJinYtzyjvi1kq4OREfZRMrXEPHo1ed/GdzTn+D5LQ6n15O61YkDfj3Fo
         SGPUsaB38FWSg7GYo65xU6aRPpFnBPFWCV7BlzEv5uE6+OU4R/uQuZOwkD1UaJMAZjyn
         XfWkSj+hzO+w07/LhZBOsHUYUfvnD1BUFS1aloohWh82HS1vz2xBRTV/wJAvS3snbg7H
         YUJ9V4wBFNfeRROIZCabGJcLtvbgcrocqjK8n64t4x23F2lNRpr2esTAOtBfvdqeOqlL
         kicF3kzyLTzPNrLV4EdycCLikPgnI1/Hxl50tt29L1pK7lwQfB8zDQ1+qCqMB08EHlg6
         0J1Q==
X-Gm-Message-State: AOAM533c4V3R/OxSsb2vZcecfNKJpnIsBrJajVKtFzAg3/PfvmoYhejG
        7BzROXsdLIPvyLag6+Uiiet4YeH7EPzNjKoZmJUvcWsqXlpriAJbMiQ9iKxwmumxgDx77NAjO26
        2OEJGlLz6+bmXGF0r5/JhgH5q
X-Received: by 2002:a37:957:: with SMTP id 84mr47902833qkj.392.1594162264308;
        Tue, 07 Jul 2020 15:51:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbMGUDN8sNnAct7snfAr0tVsXTTFuHRnFviDLy5w3hPtrLVevs9DuyV/XuSR75xBh7Bx9u7A==
X-Received: by 2002:a37:957:: with SMTP id 84mr47902815qkj.392.1594162264014;
        Tue, 07 Jul 2020 15:51:04 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:51:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 24/25] mm: Clean up the last pieces of page fault accountings
Date:   Tue,  7 Jul 2020 18:50:20 -0400
Message-Id: <20200707225021.200906-25-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
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
 mm/memory.c                   | 17 ++++++++++-------
 4 files changed, 10 insertions(+), 29 deletions(-)

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
index 80fd1610d43e..71e1d501a1d3 100644
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
index bb7ba127661a..ad5eca9dd1ed 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4404,20 +4404,23 @@ static inline void mm_account_fault(struct pt_regs *regs,
 	 */
 	major = (ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED);
 
+	if (major)
+		current->maj_flt++;
+	else
+		current->min_flt++;
+
 	/*
-	 * If the fault is done for GUP, regs will be NULL, and we will skip
-	 * the fault accounting.
+	 * If the fault is done for GUP, regs will be NULL.  We only do the
+	 * accounting for the per thread fault counters who triggered the
+	 * fault, and we skip the perf event updates.
 	 */
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
-- 
2.26.2

