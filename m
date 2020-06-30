Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4206EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214F520775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z737duBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgF3Upu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22733 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729988AbgF3Upm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OgQ3igxRFmWHn0+Y9XrBgGWT5Mzg0+fUW3Zyepd27I=;
        b=Z737duBZwb8JcyrIuhNQVNJifPpd7ZL9JG2pDVoZMuPhagtqmWxay4aJyYEzijGL9BEbR7
        xCZjBpUTXyo8FIzh9B/1FYwiiMnVbsJVCaybub9ClTvNU6w69OH3Kz42xFnBWMgZvSF6a5
        kMfwX4iBpxR8XK9ixuoMJd0arrkXgkw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-p4JVJj-5OxyonSRoj1PyOA-1; Tue, 30 Jun 2020 16:45:39 -0400
X-MC-Unique: p4JVJj-5OxyonSRoj1PyOA-1
Received: by mail-qv1-f70.google.com with SMTP id e6so5624464qva.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OgQ3igxRFmWHn0+Y9XrBgGWT5Mzg0+fUW3Zyepd27I=;
        b=jR4eqL2o4TLjGnALQDyxcAOcGMDI3lFqrvUwvyO8zD4/Z+Q8FYuJrYspZtydCxkuGS
         wQHK2M9F3pRsep5lLMK0bMDIsyUg2O5XepSLPrcmrhAgOm7UGu7Os8O/Pd2rF8/f4C64
         247/aAxAKb8usZoQVl1b2hLeJM5GrHiyCsrI+uZlbYwHunzLWqS/9WXhPAQ60OTpFvzN
         /NWqbryWKHNiZ/eW5CPMF5Zvwyv3h/h0xeOOfRJcQwoZfm0w3WwN/SBuC2anxptMVLEI
         YHVrBVmGqjMYkqYRWV1Aus42yKaTXuTr4LdMQwZWahgr4vKvW/jVKZscxxcqWG0Cw3hy
         oWOA==
X-Gm-Message-State: AOAM533/Jj+ohLXWrE/wAu1vr33HQktRJcLd1mNTqy5As89hin3t3KPj
        VnGilHYXm5AaDaBHyh+ISaFH4zu+ABbX8yG6cJmOOguE0WV0tH2pL6OYRPS5Y3Q642qpxRmt3oz
        Mnlm1TpD8EUmGb2a4rxE73bR6
X-Received: by 2002:ac8:7512:: with SMTP id u18mr21565598qtq.85.1593549939140;
        Tue, 30 Jun 2020 13:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrq8y45uqCywGIm4yWqg1FVgQgY7p5Y/VuWHOhbRuiBWgzglNEydMONNKVfrJW9amJ/IMJxw==
X-Received: by 2002:ac8:7512:: with SMTP id u18mr21565511qtq.85.1593549937837;
        Tue, 30 Jun 2020 13:45:37 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a15sm3767215qkl.129.2020.06.30.13.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:37 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v4 13/26] mm/nios2: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:35 -0400
Message-Id: <20200630204535.39101-1-peterx@redhat.com>
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

CC: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nios2/mm/fault.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 86beb9a2698e..9476feecf512 100644
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
 	if (!mmap_read_trylock(mm)) {
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

