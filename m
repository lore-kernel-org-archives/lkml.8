Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5137C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE0A208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmNdnlBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgFZWgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725833AbgFZWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewTqBfexdBAI6q+mW9BG6/0EyFw+GuUSZgL1KkcFzfA=;
        b=OmNdnlBMXruOohTTW3RGqijOVlp1ubuD4cXCi9QbhcSPOrfxCoSS9r+yNgPCjEulZuz8ph
        oOEuZ+Etk48j8Grqamry8ftNHKYxWhOxRG4nxauTOqtUoqJJagJB0OoHHjtwfC1AfjzYMp
        6fIuxkG8GBzAflXuaHUS7djceu+j04M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-X46Ex-dqMmKaxVzW5qGYtw-1; Fri, 26 Jun 2020 18:36:18 -0400
X-MC-Unique: X46Ex-dqMmKaxVzW5qGYtw-1
Received: by mail-qv1-f72.google.com with SMTP id j4so7363386qvt.20
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewTqBfexdBAI6q+mW9BG6/0EyFw+GuUSZgL1KkcFzfA=;
        b=tAq937WyCDuHwkaGEcJ8BfWWwwaPwZCZmCHCznCN+qOOsPtBPccbDVK5iWwC2nyMM6
         7Pvruy4zWBQHkwGdJ7TKRwQoW2saoLe7MxDJCw1jEPFWMfvwdhpKBHeUD0EG463dynX3
         jL3wqlYLR+/f4RvbFhPkU2Xl8QOLpaF/9vJDGhbHELzZD1jhPi5/3TZ9sSxUABbEv8iG
         q3aqk4yysscyP16i+TfU+RF9SMOvw4qPKHjHwmET1bCOUB7KI+SmHXruEsTqa/3xf/0Q
         d0yIGU12R5OntS/RWQZM7idh0Qy0ElhCRU1KEQeIOwXadW+ULlcZ0DXvZzO+UTOudFMp
         WBzw==
X-Gm-Message-State: AOAM5304HrlOJtJAFD26GyEsu5gYPXtgFJ52xelKmEQcJ6ziN0ak+h6k
        Z+HnnpnkcnubUNcbMrvSK2uC6wieXtWNzXFh05V02yyEmp6vgtFjnAwfNIF0EFVV/6fnHam9fSc
        ziCT4gYP8FMnNWtNbo7bUIVeN
X-Received: by 2002:ac8:23cf:: with SMTP id r15mr1638351qtr.376.1593210977233;
        Fri, 26 Jun 2020 15:36:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaSmJeTV2K13FAE2UnfH2As0jiqUsCCqIcWadpHoDShGeuM00aHx1b6eKrm7R2RzZrrjAmwA==
X-Received: by 2002:ac8:23cf:: with SMTP id r15mr1638331qtr.376.1593210976950;
        Fri, 26 Jun 2020 15:36:16 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g41sm11092161qtb.37.2020.06.26.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 13/26] mm/nios2: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:14 -0400
Message-Id: <20200626223614.199620-1-peterx@redhat.com>
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

