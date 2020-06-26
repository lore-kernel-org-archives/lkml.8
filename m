Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E997AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49092100A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO5/Xl07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgFZWbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52665 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgFZWbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dqCpbomUjM3yzMbNQtQFnUhCIZ/IBDwpBGYZavg7bk=;
        b=FO5/Xl075FwVnMfL/ZyVgVQbcydobsNtDvq9EfeTG+9m0k64AMa8XcT5tGBr6FEdkWmeN+
        0/EEm9MSWIDiMuWq6ggSVD7dwKefYZ5Fi0kpusBFoMlrnqztXbdBnj+4YMvCR1eBgGjzB2
        4h5Qfd9YOl62jEDzE6eRWSWMKqPxLb8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Kg58zWfuPF2TJMBRc2YRoA-1; Fri, 26 Jun 2020 18:31:49 -0400
X-MC-Unique: Kg58zWfuPF2TJMBRc2YRoA-1
Received: by mail-qt1-f198.google.com with SMTP id e6so6557690qtb.19
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dqCpbomUjM3yzMbNQtQFnUhCIZ/IBDwpBGYZavg7bk=;
        b=F0RJhXgEAPdpmfmjWtevx1FjsTi54SaJiDS1vLfizKrYuzp1bMRV2AZCm4zD5xVFnI
         01fCNx+OmljnFGjwuN/qzsBkNs3fDrzYmQ4AgvSBDUxzW4S3wEbq+2wNAVq5Cd/MUyi/
         cED87TR2jNoFD4Zw48vZub/sGb9UKR5MNb2Ve2KfEMa6cWPE8/A5mPMi46wRWjnvkimS
         Bi8HD7WQdbGdT77/jEuSMqr+IvVgH39XMG8H27NkZdjpflQzW4R/Ix42xnFZyl+N89eq
         49XBKhc9+cmDMWOWqp7NsbwZvjdwDSn81b7ZeM7nPq/ePmoz6rgL0+Pf8UCMFtwBCQ/L
         Z7Rw==
X-Gm-Message-State: AOAM533P0co3xofL5QneRoJLcZ8BNEveuUHBPDAIK/AxTAfrMXl3ZK+w
        1YmJk/meXpHrgxy/wlehfRbrCpX93EkC21az1dIGCiiDLajhflyj9qIApJlJK8awH564tuGtXqS
        macc58eRdFsew4tYiclp5vfhX
X-Received: by 2002:ac8:6602:: with SMTP id c2mr5104786qtp.243.1593210708569;
        Fri, 26 Jun 2020 15:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0m9x4oS5jDycK5PNdBHwvU0YSY93jeQ2glDlce223GxZXy6nl10nE9BVmwmIuu4EVeSQu0g==
X-Received: by 2002:ac8:6602:: with SMTP id c2mr5104766qtp.243.1593210708313;
        Fri, 26 Jun 2020 15:31:48 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 10/26] mm/microblaze: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:14 -0400
Message-Id: <20200626223130.199227-11-peterx@redhat.com>
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
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/microblaze/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 9abfa5224386..3d58dbd227cd 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -28,6 +28,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/perf_event.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -122,6 +123,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -215,7 +218,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -231,10 +234,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (unlikely(fault & VM_FAULT_MAJOR))
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

