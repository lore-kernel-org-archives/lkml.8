Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B236C2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7mt3LFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgGGWvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729064AbgGGWvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WDfseXJG+YEknLKo7gGTNIu+jjXQaKHoiJwElOOM90=;
        b=U7mt3LFME/Aa9wDoo8IpZDYpVVnW4Wj10loMHWqedukurXmnzeXbu7ePlghrWUGdl13HYQ
        T6Y0P4xyQpmNUrct+zl3N5DfwSXFWNBBwr7d3ujndb2ybd0fJSeo4ZjIR04WYGVTrprrQQ
        Qsnp3+gEOjYUCSwafcSUlDgxL3mPzDo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-u5A-4ugkN_i-8by_mHAQHw-1; Tue, 07 Jul 2020 18:51:03 -0400
X-MC-Unique: u5A-4ugkN_i-8by_mHAQHw-1
Received: by mail-qt1-f200.google.com with SMTP id z26so13360391qto.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WDfseXJG+YEknLKo7gGTNIu+jjXQaKHoiJwElOOM90=;
        b=ojndvRY9SJC/G6pmq8Yks3xxj2XXN8csOk5Ju4mMTXbsmLJv44EDsmiRSZVwlqJBgV
         SjHYbvMxQ6OMjvMzRBMngZkcQPNU0Z6dKybmqg6Z38Wr95GtLWgzW4EZbJ93xHd6K9dc
         Q2vRlE35pu8FexcD+LOgM8lwP4E2biHqLYwPlYK2DjEk2qkOGZJQLATMuZ8JaqsdkRpd
         HfB4vice+7tgP/BD+6SVagbLfDwXa9Utp3b0fIY0VT66kMjEe7E1Mi6GAGu+vmLBbkyM
         yP68vkXYoefM46HK7gQ+mKukpT6ImQjXc3aW7gsPajZcjGeuKPZgw7fpVihVGagjsKZi
         sGhA==
X-Gm-Message-State: AOAM530IumnX04m/S2zcyShM3xoxQONFDL/JdZc2+4PJc1shWQIRmptH
        pmJ/lMoc18v6SONODaUHEVj8m5MU0UC9tF0Hnw9OlzlwlqhdvL4rc/SkMUQi7D60/KXdRA3U7Ct
        R3YBSx8NK0LuhazQRIseZoAoJ
X-Received: by 2002:ac8:1972:: with SMTP id g47mr57090706qtk.180.1594162262625;
        Tue, 07 Jul 2020 15:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGFS+kyEs2De/yDG4/t5VdS5tufXXCkrB6G/JQRILDl9qFzVJ4Jz7OgpD+7mvusv7YHy15LQ==
X-Received: by 2002:ac8:1972:: with SMTP id g47mr57090687qtk.180.1594162262390;
        Tue, 07 Jul 2020 15:51:02 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:51:01 -0700 (PDT)
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v5 23/25] mm/xtensa: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:19 -0400
Message-Id: <20200707225021.200906-24-peterx@redhat.com>
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
index e72c8c1359a6..7666408ce12a 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -72,6 +72,9 @@ void do_page_fault(struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -107,7 +110,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -122,10 +125,6 @@ void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -139,12 +138,6 @@ void do_page_fault(struct pt_regs *regs)
 	}
 
 	mmap_read_unlock(mm);
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

