Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C464520738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAfqq3Nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgGGWwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:52:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24026 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728509AbgGGWud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7D381D/H14FHe4T4c1JYQQxnwU06uKAee3rsUSJokIU=;
        b=gAfqq3Nz8yIyW5m7vPEhpv8FTomlORwYJHy+AjyGizV8HiNiRAVJ01P4neBkFp+no3dB7l
        /zgUYyrdhgq9PnpWZac+hLrUFnpKHjmCR8CRTGbZ5i5ROiiksOCdJqDds9AAaqbE+fD4H6
        xlCjqNTMblrveO0KQtKpNLVX5brG++c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-8vUCRgUnMH-2xk0AyuSWTw-1; Tue, 07 Jul 2020 18:50:30 -0400
X-MC-Unique: 8vUCRgUnMH-2xk0AyuSWTw-1
Received: by mail-qk1-f199.google.com with SMTP id k1so26404773qko.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7D381D/H14FHe4T4c1JYQQxnwU06uKAee3rsUSJokIU=;
        b=QWB67fsmSsuWvwSWUyqV1WV4KR5tiT0FYgqrCuTOz51y8TDubIXLI6rWObkMQBdknz
         qbIYGuPAIBxk7D2jxCi8H4my7cMfrRC2xwC3tyvS1pGQQrowNgIahoKJdtiL+hmkvS2l
         Dij+S1oZm8wFezsvciQqfroTi/XHOcWOeHS+E6VUIHOgve6LmKnzHGN1x1/75Mur9aK5
         k2EE7wQoU5UtV77q+6qBrnRT1VvZlr5Wc3xqr+goW2/taS5WarJ2sluBR+fC0p2Hrzgf
         Q7NBC2WmiwQnjKGrGkjCMNvEvx94Wtj+jsNa8w+h222zK/bpvetp3Eh/Iihszx1zfahe
         wa2g==
X-Gm-Message-State: AOAM533tC0ZxO3MI4q3lSWGZ0SN9NbRfAUMJD/ZJd+Z2ussTwDrtIWt6
        qUnSJdt9gcyxjt+0rOOnTj+MgDsG45aZzXHMxYWMVartZ9mm1a0TwjZZYP3aR+3nN+TBxrjnDj8
        dvJYl/pUlG0TnHgnbtBe0F1Ft
X-Received: by 2002:a37:957:: with SMTP id 84mr47901154qkj.392.1594162229536;
        Tue, 07 Jul 2020 15:50:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Qe2aOe1IpWrTkBCeJI7Q41I9z0vTh86xMOYiLo7vcyohVA6pGslr3yB/GvOVaXZ0OVm2lw==
X-Received: by 2002:a37:957:: with SMTP id 84mr47901134qkj.392.1594162229298;
        Tue, 07 Jul 2020 15:50:29 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:28 -0700 (PDT)
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
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v5 03/25] mm/arc: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:49:59 -0400
Message-Id: <20200707225021.200906-4-peterx@redhat.com>
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
retry happened.

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Vineet Gupta <vgupta@synopsys.com>
CC: linux-snps-arc@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 587dea524e6b..f5657cb68e4f 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -105,6 +105,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	if (write)
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 
@@ -130,7 +131,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -155,22 +156,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 * Major/minor page fault accounting
 	 * (in case of retry we only land here once)
 	 */
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
-	if (likely(!(fault & VM_FAULT_ERROR))) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
-
+	if (likely(!(fault & VM_FAULT_ERROR)))
 		/* Normal return path: fault Handled Gracefully */
 		return;
-	}
 
 	if (!user_mode(regs))
 		goto no_context;
-- 
2.26.2

