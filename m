Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B85C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17F320663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKXh8E2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgF3UqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53824 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730384AbgF3UqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4RAHTSP5z0C7SFvi5Ey3JD7YAbQrWHUIepHjbZsf2aU=;
        b=IKXh8E2esf2kQlw9TJ5+daopxjPI9hZTorbwxrSqy6qHH+rgAel6snaP8Wx+nd9iiqg1Mn
        cRR7enCNp9+Sq6l6WVZSFGZuRBAFegRgZhV1lukpZxF3i1nhufOMhWYlwsiigK5eAgE/Gn
        /vRU6Fo4waRxIgIashyS3fcX4edVBEg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-oDjgHmMANjmvOLHhVB1HCQ-1; Tue, 30 Jun 2020 16:46:06 -0400
X-MC-Unique: oDjgHmMANjmvOLHhVB1HCQ-1
Received: by mail-qt1-f199.google.com with SMTP id h10so1768642qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RAHTSP5z0C7SFvi5Ey3JD7YAbQrWHUIepHjbZsf2aU=;
        b=b38thm4leP6bPrFVBriB1vkUC9/0zuM553DhahIKayHVrOohNXFjbCx39O9ghOxfv7
         J3GER6Mt05T07ajEkld9NK7K81gjlfzUSjkZ1+D9vkrJWmnTvV8CM0ovzX9Kxxo4/wHc
         QtHAWJZp6yVfDMNX/aBJAEBhYY38W7U5okVPuvZerO2zSnvyYYBnkB2X7oD54sRGLaw2
         Ez1B+KEjuZMzmRuzGlfOWTg9mntdgrbuqGxoVb6iTtZZbNqzXGOTic4ma110gZIyf1zQ
         OYxDROWBE81fpj7Zd8EPIfosd5uF4SpbwFTDWIDVV1MUGZSPFBSp6bbvOxNeybC9UjVS
         D4fg==
X-Gm-Message-State: AOAM53265CE2fSgLZmZ4QQSeOWN1CUKgqeIz9UgkGUxYorfCYpt5KZEX
        bIp9hzM6yyBNjXacY0ipSx4ZI+dfmfchpvxFetCoz/WsQDIOM1cNNqRRGGNFNKCjX07IW2mINPJ
        hs/bK7PIbOWwjN5vwL3++iDYX
X-Received: by 2002:a37:5b81:: with SMTP id p123mr21686108qkb.150.1593549961532;
        Tue, 30 Jun 2020 13:46:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZM7dYXcf5y/PjIzLQzsAt1kp+Qf2qriyfk9Ij6NWjLpMdeiq7I8wMzFAUueBBnMbxGIlWpg==
X-Received: by 2002:a37:5b81:: with SMTP id p123mr21686090qkb.150.1593549961276;
        Tue, 30 Jun 2020 13:46:01 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u124sm3833681qkf.83.2020.06.30.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:46:00 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH v4 22/26] mm/unicore32: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:59 -0400
Message-Id: <20200630204559.39539-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/unicore32/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 9b4539d8d669..69bf99bcd8fd 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -16,6 +16,7 @@
 #include <linux/page-flags.h>
 #include <linux/sched/signal.h>
 #include <linux/io.h>
+#include <linux/perf_event.h>
 
 #include <asm/tlbflush.h>
 
@@ -159,7 +160,8 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 }
 
 static vm_fault_t __do_pf(struct mm_struct *mm, unsigned long addr,
-		unsigned int fsr, unsigned int flags, struct task_struct *tsk)
+			  unsigned int fsr, unsigned int flags,
+			  struct task_struct *tsk, struct pt_regs *regs)
 {
 	struct vm_area_struct *vma;
 	vm_fault_t fault;
@@ -185,7 +187,7 @@ static vm_fault_t __do_pf(struct mm_struct *mm, unsigned long addr,
 	 * If for any reason at all we couldn't handle the fault, make
 	 * sure we exit gracefully rather than endlessly redo the fault.
 	 */
-	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
+	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
 	return fault;
 
 check_stack:
@@ -218,6 +220,8 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!(fsr ^ 0x12))
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here.  However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -243,7 +247,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_pf(mm, addr, fsr, flags, tsk);
+	fault = __do_pf(mm, addr, fsr, flags, tsk, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
@@ -253,10 +257,6 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		return 0;
 
 	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
-		if (fault & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 			goto retry;
-- 
2.26.2

