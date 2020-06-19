Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E791FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88902184D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsOh4RrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394420AbgFSQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50262 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394334AbgFSQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nuO+Yb0GY5ATg//nVupU36tJbGPoBpffcxCpoCITILo=;
        b=GsOh4RrV86aGjen+WpxHpKO4zys2nkZ7KVJ7yRB+rdJcojVxhni6Ni8jq2FJh1ExYuMg5a
        jt/l4ahsrWn5S1KnI5KM5QlbcCXghcOlPpCKrRDCYnTECUtKR1ZSZ4OZxHxQbgOdvqcxAS
        WUWPgA8TZVX6irGM+LHcZ/RfQ32Qh4E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-hlUum5PRO4qQh4lBRJKIew-1; Fri, 19 Jun 2020 12:14:03 -0400
X-MC-Unique: hlUum5PRO4qQh4lBRJKIew-1
Received: by mail-qk1-f200.google.com with SMTP id s75so1838998qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuO+Yb0GY5ATg//nVupU36tJbGPoBpffcxCpoCITILo=;
        b=hHr+8FfLtCMTQ3lZZuA1mcJPP6obTEITB9OpXspfuQ1nSgG2HAiXf1LHP2D12PwzKc
         51+BHovJtMGxmMeOTYdZ8a8qbc3fhWhVowetProzN8qAjeOdrDQ696fkdcBBdYjBglAv
         wHh4Qyqks39FZMkviON2jFTC1Oa78rM/pfBth3RMD3pabp2ikYJKbZ0JSt1BOQASmmbh
         RmBn531M8nuW/syLJHgTnFMZqgxF9djtfZMpNimt16G2Hh6aLxHoTSojOubO2k0U/yfM
         fQ2upKbkU/tx0mqBBcrkB6/gDSTyC0B037Thld6+X2H3jV//zcUJ3eiDL9nlRfCj7Aew
         GJfA==
X-Gm-Message-State: AOAM530chjJ42BI1CbTbqBsr//2kIZVmcklPK66Yes/azRbC8145wtzR
        DaMIooe/Oj84PrOEpJPf672mMX+CHTgTBFsSUsM6Bt0afFosj9Il6NIcY7elXLtSz8OqQNGIMMr
        wLa/qSmJTIMrbe5mU/pSHe8Iv
X-Received: by 2002:a37:4a90:: with SMTP id x138mr4285172qka.74.1592583241239;
        Fri, 19 Jun 2020 09:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywyVrKaOWk1ZbIHQBjTISBQH/HyM8FFN6FV+FgYS4h/6d6EkOdlZqisWhzLL/0kWu70yra1g==
X-Received: by 2002:a37:4a90:: with SMTP id x138mr4285122qka.74.1592583240788;
        Fri, 19 Jun 2020 09:14:00 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m26sm7588426qtm.73.2020.06.19.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:14:00 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 24/26] mm/xtensa: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:58 -0400
Message-Id: <20200619161358.9956-1-peterx@redhat.com>
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

Remove the PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN] perf events because it's now
also done in handle_mm_fault().

Move the PERF_COUNT_SW_PAGE_FAULTS event higher before taking mmap_sem for the
fault, then it'll match with the rest of the archs.

CC: Chris Zankel <chris@zankel.net>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: linux-xtensa@linux-xtensa.org
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/xtensa/mm/fault.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 722ef3c98d60..9ef7331e37f8 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -73,6 +73,9 @@ void do_page_fault(struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -108,7 +111,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -123,10 +126,6 @@ void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -140,12 +139,6 @@ void do_page_fault(struct pt_regs *regs)
 	}
 
 	up_read(&mm->mmap_sem);
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-	if (flags & VM_FAULT_MAJOR)
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	else
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-
 	return;
 
 	/* Something tried to access memory that isn't in our memory map..
-- 
2.26.2

