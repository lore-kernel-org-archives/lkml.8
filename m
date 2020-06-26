Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E226DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA3C20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsYpf8GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgFZWgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbgFZWgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593211009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djMzqxEX2KOhdS0mA0I6TixiZlYRFWjkTEipCw3bAqk=;
        b=YsYpf8GDRZFDX1anlw50NPlbtRfZLUioovlq5ClKdAVwyJtmZ4zIsFFMJvquxcsHXQ52Dx
        1TR2ZFLSRl4yd2vqNjkHCKxBOI/ePBfOFzWKVmmfDTCh+8uADXSfHCyyj7BAlBXIfhhASl
        v4eiV1jhpGzZlgu97CWHalC+uJjXT4k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-6vGs15DsNaqUI26RJudhOw-1; Fri, 26 Jun 2020 18:36:41 -0400
X-MC-Unique: 6vGs15DsNaqUI26RJudhOw-1
Received: by mail-qv1-f69.google.com with SMTP id em19so1632474qvb.14
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djMzqxEX2KOhdS0mA0I6TixiZlYRFWjkTEipCw3bAqk=;
        b=tuFHOSmaHRaqE9+aoG8N5GSzVrHne0ddurt6j3MEzl+H1Nbsfwyt/YUMI6Q7AkGyJ5
         xotwqFrhEtnJCwjQB7lpyrgqeQb0KoUBscER5MyJYE6yPok5onRbFBFeNdUWMDdcoaRq
         eynTRuG1k19V3o2grp7+mcj7laDkLlh5HNh87zDlZHaaQlemw7Meczjp7Uttb4EYMZfW
         SnTQgMK6VHIjpwtGEmVdWjxBBcVDyUa4ufisjzuaIks2HJ6QarH1SpPma/nBUB3KOToQ
         cYnNN1BjazvHmCY5X2ELYT2d54Pzf+osakSQLHjegi1m6TsyG+qVXC3mMhx9/bsM0j3b
         oU8w==
X-Gm-Message-State: AOAM530YkDLaEXWVmzkqBHp0FyT5Kjs85NkyBwG3dlpfUtAOiSLJKbKO
        X9mpAA0BA5W7ZPwpdF3E9fkey+60VNIUE5I1dpsgtr6wB8pPRvipD7AscrTrJJxM0Hpb4e1XcFL
        yfy+ZvjHeXDbEFslBxCgAMgew
X-Received: by 2002:a37:4e84:: with SMTP id c126mr5001469qkb.7.1593211000275;
        Fri, 26 Jun 2020 15:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUp1+SFGQDRo0mF95Sau3QQtThG/ZGcjdmMx6Df1C1qf3AIRaxiOeUWjit0m8/ftvHLQqSzg==
X-Received: by 2002:a37:4e84:: with SMTP id c126mr5001450qkb.7.1593211000037;
        Fri, 26 Jun 2020 15:36:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f18sm2019707qtc.28.2020.06.26.15.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 22/26] mm/unicore32: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:37 -0400
Message-Id: <20200626223637.200054-1-peterx@redhat.com>
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

