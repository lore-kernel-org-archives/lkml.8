Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91830C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E13C2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTHnZcLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgGGWui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49135 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729535AbgGGWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8OdeaID5or5gsgcWoj3vmPJjBIrXv0E7kOuYlamE1o=;
        b=iTHnZcLAXbSFJJvtASJ9bLC/f0KBB4I88Enw1PSHF4wVyEB//evWo5EQLCcKhDxHXUvEoY
        +Il7MRLBL1i9/nFDNWnm6tO9+syLN9pbcU2DGKN7jkL6u5eMqrIP60sXFWGN432sZuiv4n
        nl2l4bFeWaYCOVuNI79JXUjKShjCTpc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-niBE3u_7ObG-EVBnj2YPgQ-1; Tue, 07 Jul 2020 18:50:32 -0400
X-MC-Unique: niBE3u_7ObG-EVBnj2YPgQ-1
Received: by mail-qt1-f198.google.com with SMTP id t36so13852461qtc.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8OdeaID5or5gsgcWoj3vmPJjBIrXv0E7kOuYlamE1o=;
        b=QcgzmL0eYWfTr1YPvZru0XfEh2c1GW/0aPwqmynivChkeKatOiTcokGoQGmgseHbJy
         CBsDw9kQ0OEvqkz+AN4+a/G8ptroJF7ltwnPbbggMQcrgvvc9lQPteqQhby2Dnk5zOOe
         nxC4mqaBG1vqM7tk2O2NYoRghKkCXwycdvXLpR5OlUYrkQGY6k8JOQmwQ6sBLNKuPg78
         tpl6hbQWL2c72Lq8GXeif589oMPOZl4sTxjG+8Oltb1LcqIPIndwIcfK6KfcCna3lfX2
         5RMFIf6DS6VKEsTe18xUQgL2xsUAp8guvp+oqWq5VNcEScvUitw93OkolImyCpYxm+gC
         WDhw==
X-Gm-Message-State: AOAM5316s+smhEFwrLDFyuwhuzIR9XTUYxud2Zph0w/ZJkrsRhhXrEnW
        uT01+vnTFHh54+V1FIlj/Mj0IfTz5KVlJz+oShahX4qernmwls5406pgRUSmK4bR639bWKzIIET
        PTUg/r5s84otk3M61ljCjOhrg
X-Received: by 2002:ac8:4419:: with SMTP id j25mr59295048qtn.0.1594162231218;
        Tue, 07 Jul 2020 15:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz8DXKkHPxoOFEcQD6pHkWkgMOJfaMYF0tKBmTSmaZQNpqDRHsJem4bnZngb+YYMsixKQJtw==
X-Received: by 2002:ac8:4419:: with SMTP id j25mr59295024qtn.0.1594162230982;
        Tue, 07 Jul 2020 15:50:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:30 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 04/25] mm/arm: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:00 -0400
Message-Id: <20200707225021.200906-5-peterx@redhat.com>
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

