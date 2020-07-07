Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F184EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB908207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="al6Qh9Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgGGWup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46158 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729612AbgGGWun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4u5+MpkCsisdwspgoCKpfclb3FqsVFfOPYmJEG8Y9I=;
        b=al6Qh9IpXhaZBxBfuUDFGDJBNjhs54vALlEkviPlqhmhGKHoSQqyPTZXP6xv5g82jByhgx
        OgZHeju9GbMfOdJW78WgPvmMBUCP9wTaW/4iowX3QPRUMXBfCwLtNb0Kq+kgKih7F4JyKx
        TPFIfMy0oocp9BNHIHrtFd6polW7V4g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435--_I9TkmrMgyU3pURuFltFg-1; Tue, 07 Jul 2020 18:50:38 -0400
X-MC-Unique: -_I9TkmrMgyU3pURuFltFg-1
Received: by mail-qv1-f69.google.com with SMTP id em19so22359096qvb.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4u5+MpkCsisdwspgoCKpfclb3FqsVFfOPYmJEG8Y9I=;
        b=MCMRVRMj9jIj1qUQpgTOUWlCRnFaT0uqL0h+WG1nAm4RDUyb1iZ1ttLX5PpnFZAnAS
         fRTQmKLsgYBHkcpUp25Y4J9Y9tFugk6ngZ1ZSN1xX9C0jchD549T/lcNKShz8rKXdzL9
         vT9Uth03xmDNwRcL+vwceIeDKkQFOrbP+8tSduZkLfC332R43x7zIW0P3Y65u9gaWW9u
         HF4Rc2zrJYX4cTuD7rdU4ffKDJWj9OuTtvRFdFPrH7WwGt7pn6Vzh9hcrlrgcYG91rU1
         cxwjfFSin1h57MASg2Rge63xBp+PnPIIyXrNZOpufU1ytkrzB0VmiPgFdDdNwpNrRcVM
         iOQQ==
X-Gm-Message-State: AOAM531mY6jtmMoFty0Cnr5W+vDrCgXRJLL032cBZmE0CRb4pa5G9wJK
        dDofOrkGbjHJm765ysXzAO9T1PqF7iNiNiOFgN7kkC1JO0xfA4zhG4tPiTEPgFeTTt7PV0AujkW
        IArlubN7yavwtmQCmC8gOQaEo
X-Received: by 2002:a37:b141:: with SMTP id a62mr48027928qkf.201.1594162237588;
        Tue, 07 Jul 2020 15:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCDX4X568D3uYvvAIuwtoK14UDjY6KFaGDB2k0o/5J1j74ZdyFrKj0t3T0AAWQ2lBwZRcwWw==
X-Received: by 2002:a37:b141:: with SMTP id a62mr48027910qkf.201.1594162237320;
        Tue, 07 Jul 2020 15:50:37 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 08/25] mm/ia64: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:04 -0400
Message-Id: <20200707225021.200906-9-peterx@redhat.com>
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

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/ia64/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index abf2808f9b4b..cd9766d2b6e0 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/kdebug.h>
 #include <linux/prefetch.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/processor.h>
 #include <asm/exception.h>
@@ -105,6 +106,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		flags |= FAULT_FLAG_USER;
 	if (mask & VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 
@@ -143,7 +146,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 * sure we exit gracefully rather than endlessly redo the
 	 * fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -166,10 +169,6 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
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

