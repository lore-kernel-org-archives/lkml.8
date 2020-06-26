Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82593C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5918B20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGr7Bb6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgFZWbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725922AbgFZWbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrEBS+6D6tr7sKM8RKvuVARuC8ujPdG5Fi1hrXsWHAc=;
        b=gGr7Bb6EhP+eouj/EJ/s4QC7w4qUyDuHlj8GXXvXW8QGQsh05FiGvrvXDSjy+F++eVF/9x
        hYCIpnga9IVexE51dDVOk+j3hTv1GDAA20TT38UygHJ8T4YgkXSsFu1Jug1saSQTduU7di
        Qx2Ax9WSralUt1XiWIJW/QEw7dcaDSo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-a8PbfZYmOjac9K6jMvLBdg-1; Fri, 26 Jun 2020 18:31:37 -0400
X-MC-Unique: a8PbfZYmOjac9K6jMvLBdg-1
Received: by mail-qk1-f199.google.com with SMTP id u186so7696102qka.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrEBS+6D6tr7sKM8RKvuVARuC8ujPdG5Fi1hrXsWHAc=;
        b=Ji5L8+s9jDokxulnXfdlpCwWEyZEiSgnqtNe+MEyrFGew17SBTypGioffcd7Lagzsb
         ZWLEHsBFWwbWEtd9ejfdEFAnb4MugrfZ7vN26MtHyTAEv63LYspXR8JAbvNW8SgjkgDT
         NQiGKTEEUwMhNICG0fwPtrdcxFTsZCP0B+NhGBxaTxBEu8mTVp5w3KM6e2SqqORZnOwl
         oGdyspm/GkkelvVf/jPxi1WGN0wGVMwaRD0wT2yZ+at7WycZevrGCoA1OTfDE/Ey+o/t
         XGjLpQt7Ix3w7yih+wo1lnJqcJjAQ2j11nTdOIxSJQVRKQQn2ebi9jGg059ldeN1nGMP
         u9+Q==
X-Gm-Message-State: AOAM532O7tR+NiYBghLo3SbDfCuckr1lqQ8wJQ3kYZPwiCGJiOUbc9xk
        q9SseW9ebhsiUYtrj6yfowlU8pHoOkF+2Dw/WMwuQ7gM8g5KkNE5BxSeAAWKiRZfZV10HEdkrtZ
        BJHYK2gLv6eTIOilQSOS/SQZs
X-Received: by 2002:ac8:3438:: with SMTP id u53mr5257909qtb.102.1593210697045;
        Fri, 26 Jun 2020 15:31:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyypwZl81DCOa9IcPJnHElr7C3d8MHgy+sT0obHjubCfmpU7Euqfw3mBtLPdpkmWRiHkTsPYg==
X-Received: by 2002:ac8:3438:: with SMTP id u53mr5257884qtb.102.1593210696782;
        Fri, 26 Jun 2020 15:31:36 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 03/26] mm/arc: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:07 -0400
Message-Id: <20200626223130.199227-4-peterx@redhat.com>
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

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Vineet Gupta <vgupta@synopsys.com>
CC: linux-snps-arc@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 34380139e7a2..68e6849cf086 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -106,6 +106,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	if (write)
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -131,7 +132,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -156,22 +157,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 * Major/minor page fault accounting
 	 * (in case of retry we only land here once)
 	 */
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
-	if (likely(!(fault & VM_FAULT_ERROR))) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
-
+	if (likely(!(fault & VM_FAULT_ERROR)))
 		/* Normal return path: fault Handled Gracefully */
 		return;
-	}
 
 	if (!user_mode(regs))
 		goto no_context;
-- 
2.26.2

