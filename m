Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A80C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D6520775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqjPn3NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgF3Uqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730098AbgF3Up1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fUO3NS9psrO0Jdd2xoJCjexzJ/aoni+i2MbifOTNg00=;
        b=gqjPn3NG1cCGyUO4yse98HpBshSRuPiVdft7mdXS3RtJU5Uy2ODg4lzuk3DSnpcUOxN6Ty
        gYhwcTdts9VaZAzPdiT9vFjb7wMx/l3a/jTA86Z7ifLHXmqLoTKZYrJ6HjRGzhZavO0UWl
        bV+jS8jcfJzrHyteoxAb0hxCVFM4Wsg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28--DFZ1Y8uOxuzD-t2f2RTNQ-1; Tue, 30 Jun 2020 16:45:18 -0400
X-MC-Unique: -DFZ1Y8uOxuzD-t2f2RTNQ-1
Received: by mail-qv1-f70.google.com with SMTP id y36so14595487qvf.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUO3NS9psrO0Jdd2xoJCjexzJ/aoni+i2MbifOTNg00=;
        b=MPMW4hnx3DG408KSYxcHuWtcSXGGwkJNasxCxklddCoXJeOKpcfhGVzWhfOIpjypPq
         QrT3stVXnXpRD3ENks6Vmx+ad3s+B8A/OXZCnWMsKUuQ6+yfupgaJsFOZJzT+5SrPDmH
         DacPXBWGO71sbglzZyMg1qrHzHzvvJUaQq6iMjp+XJAmSweOTumXO33Ph+uf1RMX9DDd
         wW+VBFDjsthk2WtJgdvHpO2zZhq86dg5tNySs9MjsDtOJPesb8F8CufCSMKsO7dagiP2
         WShfwfs6JAPX3tA54Fdtsd+SZeSbHNliTG+vdYLEALaUvk7OxbJTEpIAANGt4Cu4PBv2
         PavQ==
X-Gm-Message-State: AOAM531vE/PR5ymN2NnK3KyKm2bTiR3SqDsp+/PWm+eVgFdrByEVTqHf
        I/C38NBmw5VJnSZciucQ6d9WbTlLGiJEFl6VOJzzje8f7BoNsrmJnWJu8hVxw5mZfKfSaIakGYF
        qFcS+1QwxCOJbS8uOrKR9lPiw
X-Received: by 2002:ac8:27c9:: with SMTP id x9mr2655039qtx.172.1593549917114;
        Tue, 30 Jun 2020 13:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM45GnPoMoskFnro4SYt1oRyRPA5o85g+uNQHWZT+8Z2bvlk/KPFB1VULzepW16SEXqoxiIw==
X-Received: by 2002:ac8:27c9:: with SMTP id x9mr2655012qtx.172.1593549916828;
        Tue, 30 Jun 2020 13:45:16 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m7sm3926577qti.6.2020.06.30.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 05/26] mm/arm64: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:14 -0400
Message-Id: <20200630204514.38711-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
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
index be29f4076fe3..f07333e86c2f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -404,7 +404,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADACCESS	0x020000
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
-			   unsigned int mm_flags, unsigned long vm_flags)
+				  unsigned int mm_flags, unsigned long vm_flags,
+				  struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
 
@@ -428,7 +429,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, NULL);
+	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
@@ -450,7 +451,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 {
 	const struct fault_info *inf;
 	struct mm_struct *mm = current->mm;
-	vm_fault_t fault, major = 0;
+	vm_fault_t fault;
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 
@@ -516,8 +517,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
-	major |= fault & VM_FAULT_MAJOR;
+	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -538,25 +538,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
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

