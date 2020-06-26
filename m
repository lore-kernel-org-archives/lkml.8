Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D351CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCAC20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIpoKoRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFZWcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:32:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgFZWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YX1SShq6O2x1DHMP88Y+7d3iXwbELhsA/dlQ5QIA45o=;
        b=iIpoKoRiu5enNcg945YMpRlH74Y1/DinQClUsSOKdQkSzcWfS0uAR5mDBFkcuKfs4gEwx6
        D6xCHfXlAAgTAFvLgliOX5HCTNMEF5PWQaKAIAWbXF7ALLXvp8hBuEuIqUT94XY9fxNAFV
        7p1coCoMIoxrQCHmtct5PeGwc72G+2g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-VZPLccc9PPWnjN-QB9RlHw-1; Fri, 26 Jun 2020 18:31:45 -0400
X-MC-Unique: VZPLccc9PPWnjN-QB9RlHw-1
Received: by mail-qk1-f200.google.com with SMTP id 16so7666545qka.15
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YX1SShq6O2x1DHMP88Y+7d3iXwbELhsA/dlQ5QIA45o=;
        b=AGFYdn6BqYQWGt60plEGlaSlMmXevQf41snkeWe6py8j8j3672IQECNS/XRDM7UbM7
         dIbCf2SZlbCqzOsRERRZDeZpM52BRacqgix17mgvd0Zds/ytdQiCNka7l5fGWgGL4LyN
         Tg+vMRJ6SJ9VTzrUSU6uYDN6sL5XHCd3juL1iOeT/vl5KuRoI38VNK59XcmKpM8kGFnG
         /x3woTsaUtib5AU6fbscBpi+O7oyR04DMyc92Qmax8ktWCnUnwvzvHQjMKnecSuhb3PV
         IB1keH/pToD9QeSASbVdTRoOsIFPmb9w3ASm6vVtHefRs+xhA9l73pML5Ei2A6S6wC2s
         66hA==
X-Gm-Message-State: AOAM5334QRDMgHHBSuLxf37rgWyNHMBcf5g1ik5HDVOp8CvYvTG1c4r8
        X2jSVLvk69ND3UX9XKywg94eHOVgTNaDYb6JeGNE8OQNfkdUOUXcZ/1qOmWNA2Goq/9UtczPZoZ
        HgwVqBMi1kjtkccd6+hoDH2rQ
X-Received: by 2002:ac8:4411:: with SMTP id j17mr5108128qtn.77.1593210705221;
        Fri, 26 Jun 2020 15:31:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFkGXTJ4eZV6duyjmcpFzoep5P0kIWnLzx74I0i+0clJz+tNt5G8haLS+ZCSaz1vjw9yPHMA==
X-Received: by 2002:ac8:4411:: with SMTP id j17mr5108110qtn.77.1593210705002;
        Fri, 26 Jun 2020 15:31:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 08/26] mm/ia64: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:12 -0400
Message-Id: <20200626223130.199227-9-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/ia64/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index caa93e083c9d..613255e947a8 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/kdebug.h>
 #include <linux/prefetch.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -101,6 +102,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		flags |= FAULT_FLAG_USER;
 	if (mask & VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -139,7 +142,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 * sure we exit gracefully rather than endlessly redo the
 	 * fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -162,10 +165,6 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

