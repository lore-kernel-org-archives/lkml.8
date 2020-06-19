Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B4E21532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAEI6ZTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbgFSQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:05:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48567 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391841AbgFSQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX5XNFqam9mdd/6wKfca40oUCGNepMLO5UWfniIypyY=;
        b=cAEI6ZTc57StialzvAGzZwJWqqSQG5H68eXTscLGq7AW3LU5fAXQhaw1cp2zRqpOGrjnCu
        6CFz95P4KvYr3SsMLteBdHST4SjdFVuE1CROTpDoez/ssBlWWeuZIMMpHhekkqIKmyZzk6
        HwCqg8pDs43fUWe8MgvApBs9TYTlKTE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-G9fYqDhbPBSpP29x2t17Eg-1; Fri, 19 Jun 2020 12:05:45 -0400
X-MC-Unique: G9fYqDhbPBSpP29x2t17Eg-1
Received: by mail-qk1-f198.google.com with SMTP id l184so7486030qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QX5XNFqam9mdd/6wKfca40oUCGNepMLO5UWfniIypyY=;
        b=GF/tgMFJ4gJo4jrRcVoO+4fFtC7ElKGCyrmV96tSelaDEZRTaGWsKyfsZ+DLhGT2VX
         eM8ZmuMq/Kif52Tarj4++5WstDm0yJfw5uwV1huc5oG/GPZ1Ek/X3yCdMEyl9DVSiF63
         MKDU351MADqwNE2Uq2MpFcKyiFq7omUMdxFWj55tHjeuQ6jTVZ1Y4eQqyHwbtV2cifb7
         pNKMUFO6lMDQkGShPvM/qpFBbzphoaaYqEgC3lLOWHFN/+OcfesRRgZt0bNuEJ/BRUfc
         UGNrP84sIM/MgcMJRJsGQ+QUO4xti273swroigtTrLim8RWRPNKIW944Yx47s/RTnXnL
         Lg+g==
X-Gm-Message-State: AOAM530MEcWOzdbkHnAMCgWD0n+Exk/Twc4q071T/bb47PDB9yqXHYYy
        wFPHNMidvwUkWJd6BvTw5ReAVVahbWfuQCSBomkWscj/GQx8V6Wt8cNoyiVvRvQWFQ1MQmIhTEE
        mv/6GJKw38MhrQyshi/HRGbmR
X-Received: by 2002:ae9:df84:: with SMTP id t126mr4010331qkf.420.1592582743574;
        Fri, 19 Jun 2020 09:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXJk79qIDPkgg9Bu+gM9Xo3p9+ll31vLKTGG+uA4L1k/Aqbh37gU+sPivXDad1xaGVNQjOFg==
X-Received: by 2002:ae9:df84:: with SMTP id t126mr4010307qkf.420.1592582743346;
        Fri, 19 Jun 2020 09:05:43 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 02/26] mm/alpha: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:14 -0400
Message-Id: <20200619160538.8641-3-peterx@redhat.com>
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

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: linux-alpha@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 82e72f24486e..2e325af081bc 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 extern void die_if_kernel(char *,struct pt_regs *,long, unsigned long *);
 
@@ -116,6 +117,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 #endif
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -148,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	/* If for any reason at all we couldn't handle the fault,
 	   make sure we exit gracefully rather than endlessly redo
 	   the fault.  */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -164,10 +166,6 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
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

