Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0EAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3748120775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN+l5p3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgF3Uqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29029 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730331AbgF3Up7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sstMP5NBLNFJ42p1Ptb1NInEyGUfT5YQOxqtWfaqyuo=;
        b=HN+l5p3cy+BDsLNX0mtxEFX2bzwfsTYSlcFBIumSLcWzprIkeu0aiYBOxdPJYx8sW1Y5b8
        ISKkGSW1NDFt03Fryeezr3RsMaDie9oSZrzAK5cm8zTMctBQIvm7jdhwRoJYa0w87BR8hr
        VYN8ODXirUH6i41tOfOEnxfQvMmLZJE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-C9TADnLMO7uXuXG-4d2q5g-1; Tue, 30 Jun 2020 16:45:56 -0400
X-MC-Unique: C9TADnLMO7uXuXG-4d2q5g-1
Received: by mail-qt1-f199.google.com with SMTP id t32so15320592qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sstMP5NBLNFJ42p1Ptb1NInEyGUfT5YQOxqtWfaqyuo=;
        b=SEBJpggJC0H3Ryw/Lk5SydLA+50fXr/Y14IA/T+gTQLsuLxwYV6nnKu1exJjyLsIkb
         GqBYeq5LWX6ERrz52zQorGSAHgVphcafLeOIoA+DjdAklzDK1zghfrLKUzM1J6qsqNmO
         KIlzciJyr+K8MEcxahWHzI8tL8Wh9odJJkse361WE4m9a8J3QZ1B3kuv8Bayk7/LB6TT
         QA4UQ/xRG9hG2TZFx2btP5kFj9rFxEKtpjbao/QyLUjtMnM+VFZZHd93s4++Ipro43UB
         CLS4IxwnTD0fHUYq+8sNfwvgW+QBCaMxjRdnAR/GE1dOBKW9zTf9hQIWBz/gycyuV5o4
         buxA==
X-Gm-Message-State: AOAM530aT1SjjhBeEWcJWtRZVGtAZGaJ7UexW068fch2ioO0/yyCjYk+
        /obi5YeIsPup6EHiB18SKfSPCbhxWEL5b1CTtL6qYPnaIsWIU6rOIx6XDAQEY1TARfn8lhF/KH2
        oZ0PQw0Axb94sQRs2UehLpfH9
X-Received: by 2002:a37:6801:: with SMTP id d1mr20922044qkc.109.1593549954015;
        Tue, 30 Jun 2020 13:45:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL8+s36Fr/X9eM/aUs84kdpIh/dAND6uY8M4fv2gdc1FLMJbdbBR7ydewQl2OxPf7/WxSloA==
X-Received: by 2002:a37:6801:: with SMTP id d1mr20922017qkc.109.1593549953621;
        Tue, 30 Jun 2020 13:45:53 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g5sm4383436qta.46.2020.06.30.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v4 19/26] mm/sh: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:51 -0400
Message-Id: <20200630204551.39391-1-peterx@redhat.com>
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

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 3c0a11827f7e..482668a2f6d3 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -482,22 +482,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
 			return;
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

