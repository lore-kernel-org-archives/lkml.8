Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC4020775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfySwrh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgF3Uqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730187AbgF3Uph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DEmzww7H5zywGqZA9zT7LUnhxIyJ8MI0ZWzVs6Wigj0=;
        b=BfySwrh5XVDpcOFYojQIfsPBGHSG/NvdgfL3K9XthJF3quFTJQOSnUlfPf9okwFLMbk/GW
        /Cc2qYCHnv9z6eA12pnv2HFyVi2qmsBbtiRsRTRdNUnCWQ30yElzrvuMAtoCdYWlWYvdyp
        mMi8zLR7sHGiLQen0UW9bQEYVgO+Kwk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-5Te_6qhmMsizhjK_M0IgcQ-1; Tue, 30 Jun 2020 16:45:33 -0400
X-MC-Unique: 5Te_6qhmMsizhjK_M0IgcQ-1
Received: by mail-qk1-f200.google.com with SMTP id 204so15458914qki.20
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEmzww7H5zywGqZA9zT7LUnhxIyJ8MI0ZWzVs6Wigj0=;
        b=lOrRWwHCX1P61sBeIKUx9n3jPR4Brz3unEQRWaHp7smFxr7j2Yurs9zz7NZowa6FJf
         H/wqEM3ICe9K2/x6rdU1l7CbcmyTtXHiyjOoQ7UROoWhg2L4FhZLxz+dY8nqh8y1KxMY
         xvKZ7HLq2uTEOlnE2lTs/cNtqOGKL3/2ieGRVsIBR6syijGi1n349ezcR7Ht8X4ouqlP
         B7VTVxtPUSITjnzU/LqrduRShnW2F3S7M2JLKrCFBR4LDgeOvRzKcjMpTHL27Obd48mI
         WfZQ/ZpYgPNmifonB305WhvbHpgyUxBY5YNLg0eUGgprDw7F3zoFzWvs7QUUC+KH6xRd
         YSqg==
X-Gm-Message-State: AOAM530YlwV1kaoveoZHq4BzWJV1QoGYX4JZG/sBrok80Hy0D+40QqfB
        54L5ikq//AApFjiwvOjoEElwic5gYfBrSkM6SlCZpAAx6zfNCcB8YrV5NZsFtY3b/GZ2WwsdRQK
        ag+LRQdNIPjWR5ldHJAGJ5P0t
X-Received: by 2002:a0c:f385:: with SMTP id i5mr22470542qvk.4.1593549933145;
        Tue, 30 Jun 2020 13:45:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlcR9sS9E2sPm9khBe36+osfWhMWvjfpILkpvioRaSYPtX3w5/pAVkcwQLHo7Ww9mgcZBAyg==
X-Received: by 2002:a0c:f385:: with SMTP id i5mr22470520qvk.4.1593549932874;
        Tue, 30 Jun 2020 13:45:32 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b186sm3862220qkd.28.2020.06.30.13.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH v4 11/26] mm/mips: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:30 -0400
Message-Id: <20200630204530.39003-1-peterx@redhat.com>
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

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux-mips@vger.kernel.org
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/mm/fault.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index b1db39784db9..7c871b14e74a 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -96,6 +96,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -152,12 +154,11 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -168,15 +169,6 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
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
 
-- 
2.26.2

