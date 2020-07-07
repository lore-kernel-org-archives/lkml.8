Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA5FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94132075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky+1hg9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgGGWvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55727 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729155AbgGGWu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2j+0prlu3q0Pnx3SiAUON88ocaozCL3GS+ha/ScH8o=;
        b=Ky+1hg9ptBWCZS3H1F11PwlIoAIzUDLDLNtKpq9SadADBGRKTS5e13KarGSNlIEOMfgunA
        9CTirE90Nk81/cfeivU+lE7qOScqH6NLfqjhAY4lIcBw64+j7HMVsXf1NP7+HVV4pXviZV
        WTQy4txzJxNzHn3HwJ/byQClKMSFSa0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-DlzZKJxkPwWATQhA7sTjUQ-1; Tue, 07 Jul 2020 18:50:48 -0400
X-MC-Unique: DlzZKJxkPwWATQhA7sTjUQ-1
Received: by mail-qt1-f197.google.com with SMTP id r25so31792354qtj.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2j+0prlu3q0Pnx3SiAUON88ocaozCL3GS+ha/ScH8o=;
        b=RKp7kSGNh8L4JPoD2TcW6NwnZI9T8OsDPEL70Ebcr+8XaF3zBkjZAPql06e3mLDs+R
         S0ahNw28uQBXCEy7Eu7N/jCAadZfJie0Vr8eE8VrGMRF3fMVaj+OOOoRFCPsnxzZ0Nyi
         NWLAyZThrQ89q1lsugUIIdTAyY6dNxX2AZCKnlPrb8ZG6JZlEnlTaKKmdkcdKuSTFq3m
         OKyjlc0ZYvg/+PvG0EltaB3lCDW1jLHD8zrZW+MVRfpIyeF4svv1J/LCa6jOqz9/Cj/N
         E+AJHiaoWaATctBGrFIzH59xGyzyKtLgKePUJDjmbIOXWj9iwxqxoktrt17ELi/YmM9v
         +NCQ==
X-Gm-Message-State: AOAM532LC60w9sx5HrwLa+S36kAgPgeoKv2EXyn1tV2dYofy6rSmt+/t
        e+nKkwU6drYBs2zMQAlu858Hct1mX4thiYjv9O7FqX3usjhIANAFJEO852LdlWWDTHgWctugNQg
        Veuob2ltxeOoTIwrk3m0DJ868
X-Received: by 2002:a0c:da04:: with SMTP id x4mr54367805qvj.71.1594162247279;
        Tue, 07 Jul 2020 15:50:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz91h7dze6hXBpExvldsXu0sEfg+FT9NjBcwqSN/tOXe3f7PIXsIg7+TlKvGVkbKH0rXidC5g==
X-Received: by 2002:a0c:da04:: with SMTP id x4mr54367784qvj.71.1594162247063;
        Tue, 07 Jul 2020 15:50:47 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:46 -0700 (PDT)
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
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v5 14/25] mm/openrisc: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:10 -0400
Message-Id: <20200707225021.200906-15-peterx@redhat.com>
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

CC: Jonas Bonn <jonas@southpole.se>
CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
CC: Stafford Horne <shorne@gmail.com>
CC: openrisc@lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/openrisc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 3daa491d1edb..ca97d9baab51 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/extable.h>
 #include <linux/sched/signal.h>
+#include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
 #include <asm/siginfo.h>
@@ -103,6 +104,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (in_interrupt() || !mm)
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -159,7 +162,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -176,10 +179,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
 		/*RGD modeled on Cris */
-		if (fault & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

