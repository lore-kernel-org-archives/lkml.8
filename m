Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24770C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0504B204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1NMzOtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394239AbgFSQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32624 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405548AbgFSQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YX1SShq6O2x1DHMP88Y+7d3iXwbELhsA/dlQ5QIA45o=;
        b=f1NMzOtF/qlwGS/xHLzkAhXTvAP2ZpDkCYEWrXULB1qtov6WbsFe1yKMKx6nSzzaHVtUsY
        rTHA96ay4TLdgk6ZcXdQq8d3vbLTDlb/kULRlws14G6/2UK0PeQ/42N0QsqZIeerarl26r
        DHs5e2HLXn7ivYr4DaqeztOJpssDBDQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-JTY0nsQIOY2KjK4C35gKVA-1; Fri, 19 Jun 2020 12:05:56 -0400
X-MC-Unique: JTY0nsQIOY2KjK4C35gKVA-1
Received: by mail-qv1-f71.google.com with SMTP id p18so7039381qvy.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YX1SShq6O2x1DHMP88Y+7d3iXwbELhsA/dlQ5QIA45o=;
        b=nQ6iY4XBudlh3JQWJXK5qFAacqLMDvJJ7OkSaY83Ee7I+JmFEcaFoGidst3qfU8T4r
         nJxbdO+wWDg/tSUjv224iSwaW44WgN8zAu8WxHWJREo1qzzypXUSnYkp+bDM0LsuMgbw
         NVtuiY6xTUYLAmkai8RIXMzsGSaEyY8j7xk1cSA4Ex17TlL1YpuMkRX8kvpA61NMgnKV
         dflpeXyVfCe+CuOPkCUYpZ7uvqx+RzuYsjSpGXDCMo00wDEr7R91RHejzPTNs91NPFRA
         5GmSupr//4tvn48YkFm2f/G2YjfOLU2GZHoXyLaRrkNq+TA4S9xZ27cwg+G7vr90XTXH
         JZ9w==
X-Gm-Message-State: AOAM532AOUnbFJnpHOEOUR2ue9QI6B7ycWBDcTEhXbm+sdRfZmnf3A6D
        X5BsLRJ9sH0Z6zSvhiE7DmgwoNRxws6hBN4X1p4CtBvm5hh0TRGi0QOFxgda8rBUJc5Tkb7jfoj
        OtUe/geZkB2iShqvVm5Arn8/m
X-Received: by 2002:ac8:260b:: with SMTP id u11mr4105558qtu.380.1592582755374;
        Fri, 19 Jun 2020 09:05:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8QwZZxkgEFmPt6AZgLJp9Xz1I4hFPFifumyMXU4bDr2uo3ojnJGbh+6QgvE5DO5po/9pEuw==
X-Received: by 2002:ac8:260b:: with SMTP id u11mr4105527qtu.380.1592582755088;
        Fri, 19 Jun 2020 09:05:55 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 08/26] mm/ia64: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:20 -0400
Message-Id: <20200619160538.8641-9-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/ia64/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index caa93e083c9d..613255e947a8 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/kdebug.h>
 #include <linux/prefetch.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -101,6 +102,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		flags |= FAULT_FLAG_USER;
 	if (mask & VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -139,7 +142,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 * sure we exit gracefully rather than endlessly redo the
 	 * fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -162,10 +165,6 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

