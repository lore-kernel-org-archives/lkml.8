Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550E5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4342168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FD8m5Tgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394436AbgFSQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43237 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394409AbgFSQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djMzqxEX2KOhdS0mA0I6TixiZlYRFWjkTEipCw3bAqk=;
        b=FD8m5Tgw2ml9LIDH4YDfv1p/uZrt15qPXwJ1WBvhi6KL0HFAHSWPQPwjniHnBZuF2uLsKL
        vXpNBB8Jm0j4i2xJcORvxgpVY2BxNlc34tpFRjP1QgLB3Ye/74YTuMhKSggcgkdWz8ZwjA
        qtrEifV/GV0i00aDD9nQSWtUUw+UOpg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-myY3j4gRMHqX6oVuc-UZAg-1; Fri, 19 Jun 2020 12:13:55 -0400
X-MC-Unique: myY3j4gRMHqX6oVuc-UZAg-1
Received: by mail-qt1-f198.google.com with SMTP id x6so7495851qts.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djMzqxEX2KOhdS0mA0I6TixiZlYRFWjkTEipCw3bAqk=;
        b=blaAucGqCbf3OBCUIr8dfFiHQ3JuQj9GJlt8Txr0EPlRu1Z5DFXPBeFMH4n5C+cr1b
         WLhhcAEui1sX5uUOS0I5yeP0H8c68vu+8zKj2Vmv0YqrrCVGMMWye9LXi9RJ/Z+tJRWU
         5LQsnyCigpQlnyYcucBNq0EE8GZqOmXTOEvf1cqiBWXVT30QTGGVbmtwXpAOSnbidC2K
         pTk4q9lmy6nRgwwjIA2I7sS/52QVClpylCaKZOjXhpWaL9Bt/XEquiRTSSulBwl3ZaXI
         4eKdWuUfvgq4z1bPyhiiqxGnyH3qg9o6dR3v4BrvYTGIV8SVB3cakS1AZambKZmvoOr0
         da+g==
X-Gm-Message-State: AOAM532bq/61S6ld2RyMUO2mDUafbmYkd2JpV5N9Gl5QEjP78IuxjilS
        JgQVmmMSnxTzZPOxaHHrdZWXYzsETy2VrwGNk6z1dVO5snWdznejGMSTwRfEE5NpRPLz9gI6QCU
        E/28gyjvrLwrQ220Rukr5Vjfp
X-Received: by 2002:a05:620a:538:: with SMTP id h24mr3790627qkh.13.1592583234297;
        Fri, 19 Jun 2020 09:13:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoIDne3D6Lyc/+ePjNzlFOb4ZPCNYmFPc0mxtEwDaPmhR5/H3npMIraUQuPAc8rRqyj8GbKA==
X-Received: by 2002:a05:620a:538:: with SMTP id h24mr3790569qkh.13.1592583233626;
        Fri, 19 Jun 2020 09:13:53 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id z46sm6066253qtb.57.2020.06.19.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 22/26] mm/unicore32: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:51 -0400
Message-Id: <20200619161351.9859-1-peterx@redhat.com>
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

CC: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/unicore32/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 847ff24fcc2a..b272a389d977 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -16,6 +16,7 @@
 #include <linux/page-flags.h>
 #include <linux/sched/signal.h>
 #include <linux/io.h>
+#include <linux/perf_event.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -160,7 +161,8 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 }
 
 static vm_fault_t __do_pf(struct mm_struct *mm, unsigned long addr,
-		unsigned int fsr, unsigned int flags, struct task_struct *tsk)
+			  unsigned int fsr, unsigned int flags,
+			  struct task_struct *tsk, struct pt_regs *regs)
 {
 	struct vm_area_struct *vma;
 	vm_fault_t fault;
@@ -186,7 +188,7 @@ static vm_fault_t __do_pf(struct mm_struct *mm, unsigned long addr,
 	 * If for any reason at all we couldn't handle the fault, make
 	 * sure we exit gracefully rather than endlessly redo the fault.
 	 */
-	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, NULL);
+	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
 	return fault;
 
 check_stack:
@@ -219,6 +221,8 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!(fsr ^ 0x12))
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here.  However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -244,7 +248,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_pf(mm, addr, fsr, flags, tsk);
+	fault = __do_pf(mm, addr, fsr, flags, tsk, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_sem because
@@ -254,10 +258,6 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
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

