Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5D7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1503320775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUV4XzuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgF3UrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:47:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730024AbgF3UpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D8OdeaID5or5gsgcWoj3vmPJjBIrXv0E7kOuYlamE1o=;
        b=IUV4XzuAa+Di+IOfIipqCZhNxKCivOXjwVDeztpqSuFabQL3alc6Wa43fJNEnzRXO7HN5K
        PViGzJTsEwGgOw94nfADkhJp8+ajQvgR+rcaq6kkfKPNv/fAjo3LtNTQZQI2X9qQ86uuk9
        SaNmg69EbSdTTSGByMFKAiuDlj08WNw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-dZfhhqFPPqeEckBkZSw9hA-1; Tue, 30 Jun 2020 16:45:15 -0400
X-MC-Unique: dZfhhqFPPqeEckBkZSw9hA-1
Received: by mail-qv1-f70.google.com with SMTP id g17so12884937qvw.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D8OdeaID5or5gsgcWoj3vmPJjBIrXv0E7kOuYlamE1o=;
        b=Hg3FPpocs+gk+l8AbAL6l+fLRrDCQSU5GucfsVEM6E9qerXnGr0jET0Wx4j9oyzWtt
         Bf3GWmKexsf37dzQhZj1cH5r2kX1jp6FRBO0Ww68k5vkzWaN7RtNdvvjA4AIeo6z7BUp
         7Y/UGs+KNsJUQQ4ybhrVhoAp/Uk3mrLYKgtAoAuz2TF/xMFVBrFedf6olvurmWgWFg6c
         d72Od4pSpkrtucgFVnxTROP+bq402zWf9MnNJkgH+l28II2M23KFvTPQZKAk/LajlfXg
         hGvAWyzLujVMUP3dWnetOD6ShS3CXSxMnfh+WXmgu8K8uG7wqcmX7uwYxrNKUHnzzHEY
         NCHA==
X-Gm-Message-State: AOAM533CTuvSD9XUSvgBxu1p/lyDjpJ8pPSZ8MwxigzDmhYAlVVKCNAc
        L/W9b67m7VOjbVVovK4omando0Smqwa5b2jJbwL6MhkV43rF5QBisCbew1n1jJVHDXYFG3XIvn5
        TguGEI3LBAlkqfGGLlEoVW7M7
X-Received: by 2002:a0c:aa41:: with SMTP id e1mr7773816qvb.117.1593549914664;
        Tue, 30 Jun 2020 13:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyi+ZiCgpgJNPiRGb/lHwsXU/ArQZuHKcbcZdE9UMPtaTClSVeehVA8eVoAkqIf1DOQolAKg==
X-Received: by 2002:a0c:aa41:: with SMTP id e1mr7773775qvb.117.1593549914158;
        Tue, 30 Jun 2020 13:45:14 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p80sm3991738qke.19.2020.06.30.13.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:13 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 04/26] mm/arm: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:11 -0400
Message-Id: <20200630204511.38663-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.  To do this, we need to pass the pt_regs pointer into
__do_page_fault().

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Russell King <linux@armlinux.org.uk>
CC: Will Deacon <will@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/mm/fault.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 01a8e0f8fef7..efa402025031 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -202,7 +202,8 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 
 static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
-		unsigned int flags, struct task_struct *tsk)
+		unsigned int flags, struct task_struct *tsk,
+		struct pt_regs *regs)
 {
 	struct vm_area_struct *vma;
 	vm_fault_t fault;
@@ -224,7 +225,7 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		goto out;
 	}
 
-	return handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
+	return handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
 
 check_stack:
 	/* Don't allow expansion below FIRST_USER_ADDRESS */
@@ -266,6 +267,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM))
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here.  However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -290,7 +293,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
+	fault = __do_page_fault(mm, addr, fsr, flags, tsk, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
@@ -302,23 +305,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		return 0;
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 	if (!(fault & VM_FAULT_ERROR) && flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-					regs, addr);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-					regs, addr);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 			goto retry;
-- 
2.26.2

