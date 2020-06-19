Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A44B21707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNjgDyse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394292AbgFSQM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:12:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390563AbgFSQMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewTqBfexdBAI6q+mW9BG6/0EyFw+GuUSZgL1KkcFzfA=;
        b=PNjgDyseMDvEH8nAck4m8n/qVzfh5awsGzxzCbtyIZ3WQaTH/+3z1rEuBaZvfU6XBEJ+3U
        hKfKfWBPs9+lKKAvJweaZWxqHNejJmqE81MaE1I1F+jazmRDaCb6TjepmEQ7HfEXUdcP3j
        t7kzMP/Ym5WE66EVp+7fCQU0nl/Wb+I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-fOv8sG-RMpaGiKmFUc0ECw-1; Fri, 19 Jun 2020 12:12:50 -0400
X-MC-Unique: fOv8sG-RMpaGiKmFUc0ECw-1
Received: by mail-qt1-f197.google.com with SMTP id y5so7445984qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewTqBfexdBAI6q+mW9BG6/0EyFw+GuUSZgL1KkcFzfA=;
        b=fy2kcd56JVKqk6SCOkPvjHWqYvPRJfvFK9SLYvZ1GAUeWibIxehoHKbmxe+E5iecLK
         li4z3tO3by2M4XKIa87GfNI/E+1xo+JfDvLxuALHeAYoRNBKiHXI256HWfT6WHM5wfF0
         h/Rngq12X+levycc4YnRg//5qt8rAqc6g+wDW0F/hKIr68U8cQWhKVDGP4YQ7QdMSUWe
         UsSPAMa0er2BLwkZteFtq8mpPJR2F1AdSzK2cYVXXYRJPwwisIllkKKvfquIgiCEdXdm
         9xE4g9bv4R2C5+KVP5dY/lCW3kStmS2Q8TaE4wkyC+IXfoPef/KUWL8Fl0ulDXM2z24i
         5cSA==
X-Gm-Message-State: AOAM531UuSHdToC+9lFP6mFfCA6NjhKDsc9sk99cdky/8geH1Ro0fdiF
        9wpKDerLLPfFrKD+1bvJ7rKi+iJLzirNGas/i+ssChfyKDa9tx8ls8A6LqsRxAT/xr/0nQpjI0q
        9cLCn+xbVfMAlbNIs6Lvg2rE5
X-Received: by 2002:a37:e87:: with SMTP id 129mr4114916qko.499.1592583169257;
        Fri, 19 Jun 2020 09:12:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvSVp3DvCUxxCHnzJ36+YGsZtjQWrVVS6joe8rh/iaYG3kK43rnoX9nmcA1Z4z7yyGo8LoFg==
X-Received: by 2002:a37:e87:: with SMTP id 129mr4114895qko.499.1592583169012;
        Fri, 19 Jun 2020 09:12:49 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w204sm6713249qka.41.2020.06.19.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:12:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 13/26] mm/nios2: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:12:46 -0400
Message-Id: <20200619161246.9347-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
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

CC: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nios2/mm/fault.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 88abf297c759..823e7d0a9e97 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/mmu_context.h>
 #include <asm/traps.h>
@@ -83,6 +84,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		if (!user_mode(regs) && !search_exception_tables(regs->ea))
 			goto bad_area_nosemaphore;
@@ -131,7 +134,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -146,16 +149,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 		BUG();
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

