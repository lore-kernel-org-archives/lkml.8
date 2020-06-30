Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93232C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D79520772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYezAAB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgF3Uw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:52:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgF3Uwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593550372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dSLF2JUETXiqlgMgrNmE+7rrHD1HC1gVnVSET6GUPpA=;
        b=EYezAAB26Wp2eS4NwMOvcI5pmS0lmn73yjuIZYM/7lcACjzPs4CXOj53UdO9k1NNBClUxI
        uh+6qL2/P6qCwZwbAez9OSlp9GKiS5a9z1I5+QEe/wlgM6ISiC0DZDigPTWTJDR2Y6aRwv
        xPI0cWTGZi7RDU40+bXpneUuLy5xiAA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-KPaMk_JGPPq6Qamk0Pii8w-1; Tue, 30 Jun 2020 16:52:50 -0400
X-MC-Unique: KPaMk_JGPPq6Qamk0Pii8w-1
Received: by mail-qk1-f200.google.com with SMTP id o26so15473118qko.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSLF2JUETXiqlgMgrNmE+7rrHD1HC1gVnVSET6GUPpA=;
        b=pwyadfUt8J1Vx04NFmAWPBisPw+ZUOr0FO1g0qpOHyaVRPRtDGo72KMUZ9LVVeERAV
         bW8GkBHAPo/7ZZh3PngVcO7W4Mlv4j+tBWTciMuTWJOMZOfDYAzERbjnslLSjK9B0onB
         0/WtK/oqujip3ieDQP2FMXLANOiuj8ZnguGtaHHFGhlcUGX4Yy8yWQN5JS215ZIn2BZn
         wXBxof/0qM9DPTWmgCss0iO8F8uj91L9WgAytiX2z592xz+pONAQ/rNCR1YCiA+E82aR
         07A03zKb6rYtYj/UFc99ps/Tpxhw9YaHnb8+kQsXSuI5hHHx/MU2Ue1CTWVWrSKmNx3B
         9+BA==
X-Gm-Message-State: AOAM532oifudhh0XLobu8reXeL1kp2k6PkugLBhB+k4ejPHXpfBTseie
        5XZcmTr5my8dk5S9AuPdlTvQsHo6uN7OKqP5A3uA7/z4J8K2lsfOTBDecVaSZMWWtB65m0ShH8h
        y4+8tIJ59OR/+VILsnDy/rIsK
X-Received: by 2002:ac8:18a5:: with SMTP id s34mr22006741qtj.210.1593550369959;
        Tue, 30 Jun 2020 13:52:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvoEV2FUJkvA5qAwTsI4mdiDZPCkCjdD/AwbVYfXw8WHclHjXZP0TyZnfiU/sv0k2kSJZuSg==
X-Received: by 2002:aed:204e:: with SMTP id 72mr22146487qta.313.1593549942977;
        Tue, 30 Jun 2020 13:45:42 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t5sm3840619qkh.46.2020.06.30.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH v4 15/26] mm/parisc: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:40 -0400
Message-Id: <20200630204540.39197-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
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

