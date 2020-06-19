Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0296217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2Bt/kk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394361AbgFSQNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:13:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394382AbgFSQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYfbH2Z9PmFD3YC1EEjF5e5lSljD0oX0ZInZG0GJcWM=;
        b=E2Bt/kk3UazV2elMUPc0lQ9Nx8Tu31D6wZGh7wo06a0tRQu5SA4Co1Jc8BdE3VnzsLXwKN
        eh9XMP6JPrdLVM0f4OyNALtbWJVnr3bP+oAkN+7desZwj1HPR2KggtRd5u6dKE/bSfjEdi
        koTC2WC28juHGa3RMzrD2LDBAjyv7eA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-7KGMC1SyPfCldgmxiDznEg-1; Fri, 19 Jun 2020 12:13:21 -0400
X-MC-Unique: 7KGMC1SyPfCldgmxiDznEg-1
Received: by mail-qv1-f70.google.com with SMTP id q5so7062027qvp.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYfbH2Z9PmFD3YC1EEjF5e5lSljD0oX0ZInZG0GJcWM=;
        b=dXnzG7KYeDT1t+ouO5pOUbPOR4pf4IPOweI/Klq5XmQBrXq2i0nA31TPak2xL42fTy
         nJXOfJGMhdlxr9ts8zZl4o/r+ZBgY2zFVGE2KZlrsIDnH5BTcJtXHBfwvP4CbGn98edm
         mx/hZl1fNb1jGx+hPQNl7aH+mrTkM1SRGOVNc+eSNH3IEXaSVrhDO3sOqgzJi3bqNlNy
         V6XULC0FrLdV+6eAId3TRXCkmsc7mXXs+d4rz9T00sDpk4R+uHPT6b//xe1Itl92PpTR
         8iWy2LnsfNh4DgKh4uNU/aIGarhMdQ0FyhHw3cO304Hsk4+D2QGcpFGo5brnJTN1UZy/
         FMXg==
X-Gm-Message-State: AOAM533V5rYl7tZ+bsmqcohEtHj7uE8EvXJ+AXNY3xI2VsnPjn9X6j/l
        Gz2qKB6f76GHbltO/bEvBCv6ow7Hc1DvhBEWpLCEmzsOblvGm/SHI5iwL4PA+DCdkxIQ3BwEaVV
        sRjG70Og/mZJe0zTepN3wxEMK
X-Received: by 2002:a37:5d6:: with SMTP id 205mr4101501qkf.46.1592583200925;
        Fri, 19 Jun 2020 09:13:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+/kXn6XM9J3AHchJ11d9906jc9OEfvlqbxTG9lTxQJaaFL7aW/z0ASmv5F6WdZBp/RES2MA==
X-Received: by 2002:a37:5d6:: with SMTP id 205mr4101475qkf.46.1592583200713;
        Fri, 19 Jun 2020 09:13:20 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id c83sm7040588qkb.75.2020.06.19.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH 15/26] mm/parisc: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:18 -0400
Message-Id: <20200619161318.9492-1-peterx@redhat.com>
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
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
CC: Helge Deller <deller@gmx.de>
CC: linux-parisc@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/parisc/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index c10908ea8803..65661e22678e 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
+#include <linux/perf_event.h>
 
 #include <asm/traps.h>
 
@@ -281,6 +282,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	acc_type = parisc_acctyp(code, regs->iir);
 	if (acc_type & VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma_prev(mm, address, &prev_vma);
@@ -302,7 +304,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	 * fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -323,10 +325,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			/*
 			 * No need to up_read(&mm->mmap_sem) as we would
-- 
2.26.2

