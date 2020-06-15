Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFE820739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuJdK3yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgFOWQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36048 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbgFOWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8RD1B8wb1dTFuTqvcr6ZWbigMuslfX1X9yF8acF4FQ=;
        b=QuJdK3yBcMMA4wn0+wAflpc9+yP4D8qw1sN9W4Gou0bsZ/8VhrWisTIQdjs3K1NBojqE/S
        IocruoJoxbDyCZeqZ4mQYDIjePxiw60Sb94XAYu5G5ofjz55Jl3c/UXwhijPNeom1Rjjaj
        s4pUMHQZPK1BW4511D7JrICSsUaBzMg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-bWj3bF0wNLCaQLvrI6BuWw-1; Mon, 15 Jun 2020 18:16:31 -0400
X-MC-Unique: bWj3bF0wNLCaQLvrI6BuWw-1
Received: by mail-qt1-f200.google.com with SMTP id y5so15212963qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8RD1B8wb1dTFuTqvcr6ZWbigMuslfX1X9yF8acF4FQ=;
        b=eU+MpCQBqRmqqUx1cXUkP73Gj2jXSiPWJcYN52fvmlO3t6b0JaDy78gQiK/etXN4ms
         ESkLK04td86iGCjgPVQfhsYOff09NWYTk/6KMhyze+izn4OqcoUtCKJpDaAfvzjr8puY
         qCf1d+4sHO3003duaawJlKgxVxCVApQReXIn0d1ddCGrZPjBnBnrSPcsixvUCvzWHcR0
         R9WV88tdJ3FDDTfJ1jWMZSlULfFhJToexuWA36yVNlcSI36VIGponI3Mxjxxz9pkqD/F
         w22R2o03u5ZlYArQ9zoWmq0ymCbEpJITrqN59cVj1+SXUY7+TEQ+O29Fj9MfotIAuWUP
         4kcA==
X-Gm-Message-State: AOAM533VNqHDwUxyzzn8qHMfn7A8H0n/yb9APAmH5RauikIC/wU/SyR/
        Mk/vsMm7iZbZ+MDc3EYg0CE0Vt7yIhwSQlpqvAawk+E+cxS0JkgzuQRsSanM/bCt2JATx1bJw+/
        7JQ7DWzNX51GyXdZ13xPh19Vd
X-Received: by 2002:a37:ac14:: with SMTP id e20mr17758582qkm.20.1592259390904;
        Mon, 15 Jun 2020 15:16:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk1+i3mjIQwPhD2lbehxtygSZfiJxv5Zm8yfvOnzyKWTHYGgv5WurQfy7csXRutMmX+Ql/qw==
X-Received: by 2002:a37:ac14:: with SMTP id e20mr17758556qkm.20.1592259390643;
        Mon, 15 Jun 2020 15:16:30 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:30 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 12/25] mm/mips: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:54 -0400
Message-Id: <20200615221607.7764-13-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.
Since at it, move the accouting out of mmap_sem because not needed.

CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux-mips@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/mm/fault.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index f8d62cd83b36..0b937fb12614 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -43,7 +43,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	struct mm_struct *mm = tsk->mm;
 	const int field = sizeof(unsigned long) * 2;
 	int si_code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 10);
@@ -153,11 +153,11 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -168,15 +168,6 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-						  regs, address);
-			tsk->maj_flt++;
-		} else {
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-						  regs, address);
-			tsk->min_flt++;
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -191,6 +182,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(tsk, regs, address, major);
 	return;
 
 /*
-- 
2.26.2

