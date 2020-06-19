Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC91CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C5821532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gbon2Nge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394257AbgFSQHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:07:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25773 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405534AbgFSQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYNDwtlfjBw7SDjKSzeBn7nLzHhEdZ/Papn4VLBZIoQ=;
        b=Gbon2NgeJHFxisp58KQlO29Oek+1Pj3M50c4T/dg4awaeXrwle+TI0q4BvSQxd+gSTSXTj
        pFOjJREZmFFDp7JZYag1RPKdWkUc8LM+AD/dS0NmDubKnhQPClqXzGy7066Y4YXq4hyKCG
        Wose3JcplJnc5Trk+G7lVvhB1Pw5T3A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-cjcit86PMOOAkAXe43enqg-1; Fri, 19 Jun 2020 12:05:48 -0400
X-MC-Unique: cjcit86PMOOAkAXe43enqg-1
Received: by mail-qk1-f199.google.com with SMTP id o63so1036156qkc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYNDwtlfjBw7SDjKSzeBn7nLzHhEdZ/Papn4VLBZIoQ=;
        b=nLc/sNwUuhuEiKYYBJ3gntBMFuVtPpfPCVV4L2xiJqlMsuhNkzvwwKMLX+pAaOte8/
         nI9mhTFVDUVcKgUI9FkcOhiE6Q1SgYHi5ZoGXOqL0tYMIgZuPqRUkgbZi2z64fDKqd6F
         7Dg76aMN3UlLKJ9Cs8jOvNBXSG+d4StphZ8Gn3zXaTb+rysShnGFjcr0xdCe1Qs/sI6V
         sjhBAWMfl6Km8DkKfxMFu0mf4hMB0svFpDfq7xCweTQBoF/4ddI2/ApGvKCzTEheJyj2
         /uPB6c+C2+86HzXPdvgzDHTszOWo92MT98ulF/a81JEW75BDuBLVw25sLYkGWBKKVVQg
         JJNg==
X-Gm-Message-State: AOAM5336kA+3+kWtm+/KjnPSenk5zYjgQdZItM+oDkPNt8YCHyzdwbvh
        QdP8BNZ1C3JsmaiRoXfNqtXg+aQ3lYoPUJGM1rV4VbuNx8kmV+BtRwZ76NCdG31mE5NLy0koc5j
        LFeSUNgCJDMnlaRfN66J5PSAb
X-Received: by 2002:aed:21c8:: with SMTP id m8mr4187958qtc.224.1592582747571;
        Fri, 19 Jun 2020 09:05:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzQfwrOgEHeZ4fmlf+FrgeIhkxqk3pvz1Rd9/fj39BAorh/CRlZ+KkHZPVWnZcxaKSEJpm8Q==
X-Received: by 2002:aed:21c8:: with SMTP id m8mr4187936qtc.224.1592582747304;
        Fri, 19 Jun 2020 09:05:47 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/26] mm/arm: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:16 -0400
Message-Id: <20200619160538.8641-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
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
index 0d6be0f4f27c..8530befee012 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -201,7 +201,8 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 
 static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
-		unsigned int flags, struct task_struct *tsk)
+		unsigned int flags, struct task_struct *tsk,
+		struct pt_regs *regs)
 {
 	struct vm_area_struct *vma;
 	vm_fault_t fault;
@@ -223,7 +224,7 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		goto out;
 	}
 
-	return handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
+	return handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
 
 check_stack:
 	/* Don't allow expansion below FIRST_USER_ADDRESS */
@@ -265,6 +266,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM))
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here.  However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -289,7 +292,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
+	fault = __do_page_fault(mm, addr, fsr, flags, tsk, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_sem because
@@ -301,23 +304,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
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

