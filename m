Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C52C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91780207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfJj+TEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405561AbgFSQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405550AbgFSQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYOPBG0iFD9F9VjgENlAdm0PiHZqNHDJn1sXF2V/+vk=;
        b=WfJj+TEO1ygBEwZSujB+norQqe9WEpjbEJjI1cWX7wbvsk3qkA7jXn9JlbB1z1Mrx/ggyG
        TsO5NDPnOLYzJJcyvJzON59Xe7eDc+0a8quSFJq+yCQEP5R07Rh2qiRN/akHYK1JgVvjiZ
        hd7N1pKUqzhGUFUji62bi0dqo4KmgCA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-VcBl5moCO5CqKC8-vuhoEg-1; Fri, 19 Jun 2020 12:05:58 -0400
X-MC-Unique: VcBl5moCO5CqKC8-vuhoEg-1
Received: by mail-qt1-f198.google.com with SMTP id s30so4383590qts.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYOPBG0iFD9F9VjgENlAdm0PiHZqNHDJn1sXF2V/+vk=;
        b=kjJ4mbsWkBp+r25vDaYfw7Tg0Xl5DZtY92qX5o67v2kuDU0oMnLP5G24eU1H53SJ7e
         LJtkYuxKI02/CldYREYm1wWRMRt+KRzOXrVd3aTYEuoGl1LYmBHPmydwr5vVWLtnIiKL
         pUm8PH8Kt6sJ8U2xBXoeUs0C06DwSmpbjU3mpUetzhYXHtvCsLS1Y1xV0TZuuoPwQq6U
         itwwIsXqjrU1vuS0yljD10HK/YlduRLLaGps4cTYxQp8RDDvsBaIURySybu7FLGIG0e9
         AebY6+zluaDQbfIkja3T9dIdHUwbFd8vl7Jf0hcaVPCuqguf3qKUFOLrNPjLzHRd0Gn5
         iuMg==
X-Gm-Message-State: AOAM531qSlfavCk9aIGiFV2RBWzevMggYwmIyAdXI2id0pboc15E5Nak
        1ZIhHE+tqeIUXq4MTYK4NdCrV6E0ynDccKMIxuBVfeK60p9Eh4Z33dY0E8/ZvyxHvs30bKRYxpZ
        y/vT+vMA9yzDm1HjED4vLlqpK
X-Received: by 2002:aed:29e6:: with SMTP id o93mr4023506qtd.135.1592582757406;
        Fri, 19 Jun 2020 09:05:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxln6wPfL9eSCFZYzdRyC9ZdfjMa92r0xY4V7AGxdmExb5DyEte9R6BPboKGMNjvpqtx9bDA==
X-Received: by 2002:aed:29e6:: with SMTP id o93mr4023464qtd.135.1592582756856;
        Fri, 19 Jun 2020 09:05:56 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 09/26] mm/m68k: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:21 -0400
Message-Id: <20200619160538.8641-10-peterx@redhat.com>
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

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-m68k@lists.linux-m68k.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/m68k/mm/fault.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 2db38dfbc00c..983054d209bc 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
@@ -85,6 +86,8 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -135,7 +138,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
 	if (fault_signal_pending(fault, regs))
@@ -151,16 +154,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
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

