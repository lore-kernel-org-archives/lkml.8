Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BB7C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB7620772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHeAmYkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgF3Up2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44806 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729669AbgF3UpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6LDTI5CbN1iafPepx0N8aCOkAEGCgmTd74bKKgxee6w=;
        b=CHeAmYkvdhPFXSGU7WZlBrAhoypk7tXCOepRT0CVrDPLsYUFPr88LKxhSVeD20cI8OfHQf
        ZyS3eO2GTCBl3bv0v7RjrLXMHd5/PuKJ1UhVq9w+EXlnHWjzcRsfmGqJcRLYtcA9hZhMVN
        dwmioW1S2AdKe4Lpa7T79WWWEu5/XAA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-iTOSt3wjOaG1Jjs1895ETQ-1; Tue, 30 Jun 2020 16:45:14 -0400
X-MC-Unique: iTOSt3wjOaG1Jjs1895ETQ-1
Received: by mail-qt1-f198.google.com with SMTP id u48so15277690qth.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6LDTI5CbN1iafPepx0N8aCOkAEGCgmTd74bKKgxee6w=;
        b=s2qy034D3W9xK3/868vQqpX4RqbbfyuREx3qUV4+SbxkpFnkswoonkhBxJaWUFf7mV
         ibIIZXToYiVv7JZHrZX5igK/dXuQ0rPcfPCF6VvcakMNnxzlZCYMtfh4QwqEM2s1Jrgn
         5d8kUE3a8we+BhJGWBlzwRQKebqpLVTV7P1rqdZVxth7dz5AGM8S45MXywMKfy2jAVsh
         O6hAdsOu82SdqKzZnLdq4CF+PNJQoyGVu50jkqJRLHDz4Ik5ovMGZqIR7MNIOomp5wND
         bdRtxvDWXul8Pa+duYTNCpJCfhMrmvJFoewDH2B2wL2Gz2HgUKGYzC/IEQmHbyxSrGeN
         h+TA==
X-Gm-Message-State: AOAM533i/XLdyKIk70iblGH/Qkp6a5ImEiLTM80AmlRZsqlZe1+RJIGQ
        B/27HjbNBRpZJUayjxzJeRuzl+xV4cGVSMYC3E+Dg43wIy/soWeb/VQ+Z7Vl5kSgFtWE7jikwue
        vicK6Tsn4XofsSMBhCQFp0MDT
X-Received: by 2002:a05:620a:1035:: with SMTP id a21mr20501595qkk.321.1593549913127;
        Tue, 30 Jun 2020 13:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+kaBc9/kmTr6BNHfQkL+ErMO1IOKMu40pdoPLe9ogbLzCBmnzOfYZlcKb4wfLKTS9uQhctA==
X-Received: by 2002:a05:620a:1035:: with SMTP id a21mr20501496qkk.321.1593549911595;
        Tue, 30 Jun 2020 13:45:11 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x26sm3658652qtr.4.2020.06.30.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:11 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v4 03/26] mm/arc: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:09 -0400
Message-Id: <20200630204509.38615-1-peterx@redhat.com>
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

CC: Vineet Gupta <vgupta@synopsys.com>
CC: linux-snps-arc@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 1b178dc147fd..5601dec319b5 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -106,6 +106,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	if (write)
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 
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

