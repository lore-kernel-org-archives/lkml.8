Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271ACC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F602075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmSSndFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgGGWvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729623AbgGGWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSLF2JUETXiqlgMgrNmE+7rrHD1HC1gVnVSET6GUPpA=;
        b=FmSSndFFeVIbwakdFsnqSQNfL2WpChu4v21uPyp/FS9t9V7hLM/mB+ldn2j/E8z+Qf3V5z
        ph57NzVwdtmXfCPjFLB9xU7zRAj4btrTmlIu9zPDxqSuzLHmxmKP2fA1DrJUSAuSX0Mmbi
        kYiTzVUK4Xrb/w8iNNc/gaMZhKTL44M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-qDgHY4WJOg2uCWqXyYd4oQ-1; Tue, 07 Jul 2020 18:50:49 -0400
X-MC-Unique: qDgHY4WJOg2uCWqXyYd4oQ-1
Received: by mail-qk1-f197.google.com with SMTP id 124so21326258qko.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSLF2JUETXiqlgMgrNmE+7rrHD1HC1gVnVSET6GUPpA=;
        b=WemMXFX3lceHBUCyz3qS2sEvRM0xh1TQ4JEvkVOiUOp1tixgs5XB6WLhAXmEH7soB+
         kV6yCLtfXhAFw1MSgeLDcZ9rgp1rrT43eIJ8Rq+xcuCPJn0ex/znf49KGU/3SPU1DSVs
         bqfadPqmmE2lDL1XNThjLc7sBYCJvDcNEj1GWBDeFIC4PcOhTaG/skxkjTgrpT6rUJst
         qCCmx+YaBeaadfYJSCiKMR/zqlhqCKZO4ClGyNdISGdywGSTSUD1PqBF9i+4mmdLH9SA
         yAFzdO0A675wxGqeBDQqBQB71XRUuHfPBv//xT12qrrA55X3Mo6SYN2w+2kJDaENJWoi
         5baA==
X-Gm-Message-State: AOAM533cbpmytz8Usk6Gpkmitt7yjmoCtcKGqSkxB4lc3MoKInEnhC05
        h5SasnXFXqrkJXuCyC+zb4NPSNG08WI+nZia6sv8vyAb/SSXO7je4oXgez9pqujoJji/cTOtMPF
        z63ZNnrN2IiJ+FAXf9w1rqq5G
X-Received: by 2002:ad4:5307:: with SMTP id y7mr54932492qvr.63.1594162248914;
        Tue, 07 Jul 2020 15:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZZjK6Nn1bIXhPvAgy7jT1o0DD/8o7Kmnv40jvO5ZPTVwAW66E615v62v4cElkkeaFLjMBdA==
X-Received: by 2002:ad4:5307:: with SMTP id y7mr54932474qvr.63.1594162248721;
        Tue, 07 Jul 2020 15:50:48 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:48 -0700 (PDT)
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
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH v5 15/25] mm/parisc: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:11 -0400
Message-Id: <20200707225021.200906-16-peterx@redhat.com>
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
index e32d06928c24..4bfe2da9fbe3 100644
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
 	mmap_read_lock(mm);
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
 			 * No need to mmap_read_unlock(mm) as we would
-- 
2.26.2

