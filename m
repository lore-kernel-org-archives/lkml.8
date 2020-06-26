Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F65C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4342088E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXif4RYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgFZWcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:32:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbgFZWbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYNDwtlfjBw7SDjKSzeBn7nLzHhEdZ/Papn4VLBZIoQ=;
        b=EXif4RYxvKQNTLe3gg5/EU/LAccXzI2ZAleGfEKf8nWFuJ7zDU/RCDg2DZvzYsSZqlly31
        Ovc+LRAsk55wBmVTAbAJi5s/9drQFpp851dJyVY/o5Nrmvlko+kZvQ2aUTu6g3GiThm1Nx
        mabTcs7zRGpEICi3DGJgDWaoZwVzD2c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-Y_JiP7BsOLy_kpcul6x5cg-1; Fri, 26 Jun 2020 18:31:39 -0400
X-MC-Unique: Y_JiP7BsOLy_kpcul6x5cg-1
Received: by mail-qk1-f198.google.com with SMTP id p206so1645530qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYNDwtlfjBw7SDjKSzeBn7nLzHhEdZ/Papn4VLBZIoQ=;
        b=BMRjPzkAC8bXfKgaC3EalSzpjBU8WjmKOY+3TCIIH7Fnus/o8HUTrSt2aZKjZs5cHB
         Iyu5IFEMwSGmZf/NVZ5W9dn8fTWg9oGIe7tsUQ0fIP3qRF/8Ql1uDWOgyMEOQiWsElGW
         el7rZ7GjjzODF/XoqnE6JAd5qLILZkAwiDcv5G+7MD+mshdqgK9HPtLDifPjDvwMSkd6
         8kVMjZXdrhvICkda1UlU3A0RjMrAxjXTZ51SS7xA39SnZAFPGrgCfze+75OXDeVhzdXd
         jon1dSi2YD4lpVLrcxGvunZt4q/Z+BqXcSzSocMHBWC+tKX6vPZyI0wjPQC5M62UbWUh
         KitQ==
X-Gm-Message-State: AOAM531C+oQOqlP0k3QolT5V87INKj34XviqZP3K7k1cOLYD+bKhDD65
        53HFem9reXIgFg5pKCPV/Oba7qt4soIsWCelUHdfltzacKnqEYYkoj5+VtLfv0o+0XElikm4uNs
        XOvulbDfq545Wf+1mkppctSID
X-Received: by 2002:ac8:674c:: with SMTP id n12mr1720499qtp.312.1593210698648;
        Fri, 26 Jun 2020 15:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO0yRN7CMv/OFP4YUTmRxOmwQIc3TG0C2j9mstmrYAwNOCl8Vo8qeqsTy1tVWlG77fWkMn/A==
X-Received: by 2002:ac8:674c:: with SMTP id n12mr1720484qtp.312.1593210698435;
        Fri, 26 Jun 2020 15:31:38 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:37 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/26] mm/arm: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:08 -0400
Message-Id: <20200626223130.199227-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
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

