Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34287C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EED520B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwVYOZ9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgFZWbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgFZWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u3Vh1HVYE5zmkqw2sOdn8zxGKpBRt5nL/FWkJRhYB9o=;
        b=GwVYOZ9ENBHSiDyM/aXZzn2NJ4f1VqQKL1igXoMCrA4mS0rSw4JvMsTuLdEa8Z/CUuUH9M
        RPQGC0eNvejCnRw3L8EjZrHYKlT8FXXH8Oe1loTPg0OBZPzWzQppR1xrNPl8iR3Le+qHi6
        kC/1SKh9ge1XP8ymWPSCMzwFv4HvP40=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-INv5xeW5MmCq6GNT-YZmsw-1; Fri, 26 Jun 2020 18:31:40 -0400
X-MC-Unique: INv5xeW5MmCq6GNT-YZmsw-1
Received: by mail-qv1-f70.google.com with SMTP id j18so7390963qvk.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3Vh1HVYE5zmkqw2sOdn8zxGKpBRt5nL/FWkJRhYB9o=;
        b=mh3RTaIu/FkM0HLD1miybS6IBgGXDSxTh4nyPxiNzr1bE4JfpHapTjmzZHbgDQAHLQ
         Av01pPIBHdX5KK/Rf16TepPaciH9x6ye1Db+JmMpkwDo5zb5MMRU+/2Vxj75B69ohQXH
         FeEV/hLE+U7j7DhPdfT3/w+sEJjyqbBx/VWWhg/hVCq/i1jRqc/ruBCvRBwQxiMG78zv
         k8RtmBawYbC+T45w5uDjm387pJSHn4WhQP22dyysbTfVq6tgCg8COEOSEXPyUCl7Q+87
         VYCyzoKceRBvhqxwTeVhrmPK8QRC6EtM6HI87hNCmWKm8NyX8IQv9Jf00unJsFXOkPaD
         t1PQ==
X-Gm-Message-State: AOAM531QenKmWFFRrWASijxwfojk/Q1VQGDb+F/QgD1cGlQPkrrCurPv
        o0j9r6E4u+qMYL3D/KkNJnZKz31+A+da1Y5sOGizcfTdy0Mq7ji8w2S9603pL4p8waX7uOjyb8a
        GbyvIydW2zwBmCgj1sxJl8H6q
X-Received: by 2002:ac8:2fa9:: with SMTP id l38mr5242182qta.40.1593210700166;
        Fri, 26 Jun 2020 15:31:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm0orUUqKrKyKvfnfW8pcdQLEQcj6s00CrnrDVCK/RKvjz45DEVq9UJHC9oLbgbG9R8tJqLw==
X-Received: by 2002:ac8:2fa9:: with SMTP id l38mr5242166qta.40.1593210699937;
        Fri, 26 Jun 2020 15:31:39 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/26] mm/arm64: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:09 -0400
Message-Id: <20200626223130.199227-6-peterx@redhat.com>
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
retry happened.  To do this, we pass pt_regs pointer into __do_page_fault().

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5f6607b951b8..09b206521559 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -398,7 +398,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADACCESS	0x020000
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
-			   unsigned int mm_flags, unsigned long vm_flags)
+				  unsigned int mm_flags, unsigned long vm_flags,
+				  struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
 
@@ -422,7 +423,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, NULL);
+	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
@@ -444,7 +445,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 {
 	const struct fault_info *inf;
 	struct mm_struct *mm = current->mm;
-	vm_fault_t fault, major = 0;
+	vm_fault_t fault;
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 
@@ -510,8 +511,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
-	major |= fault & VM_FAULT_MAJOR;
+	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -532,25 +532,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	 * Handle the "normal" (no error) case first.
 	 */
 	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
-			      VM_FAULT_BADACCESS)))) {
-		/*
-		 * Major/minor page fault accounting is only done
-		 * once. If we go through a retry, it is extremely
-		 * likely that the page will be found in page cache at
-		 * that point.
-		 */
-		if (major) {
-			current->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-				      addr);
-		} else {
-			current->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-				      addr);
-		}
-
+			      VM_FAULT_BADACCESS))))
 		return 0;
-	}
 
 	/*
 	 * If we are in kernel mode at this point, we have no context to
-- 
2.26.2

