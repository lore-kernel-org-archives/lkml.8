Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB5DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6F220773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDnEHpgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgGGWuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31483 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729665AbgGGWus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OgQ3igxRFmWHn0+Y9XrBgGWT5Mzg0+fUW3Zyepd27I=;
        b=MDnEHpgpuw8hB52WzgG83zQ/1KmBGzoC+5h0YToi1gJBCYZluHOgpPyxt7lIjOMX9OxvCh
        o7ZlzdFSAhLJDrDlPCjmd8mgebFyaLW2gA/lSt7P+X0zhcaZhrfkZnIKtzq7n2O/QXNXu0
        YM+fU0vbjCcoHMyK5azu40mCOZtm7xI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-lg54PRNBMPmTN6Tp5FHphg-1; Tue, 07 Jul 2020 18:50:46 -0400
X-MC-Unique: lg54PRNBMPmTN6Tp5FHphg-1
Received: by mail-qk1-f200.google.com with SMTP id q192so19431416qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OgQ3igxRFmWHn0+Y9XrBgGWT5Mzg0+fUW3Zyepd27I=;
        b=WN8/oDbhkgJegiiUTCXxM9zDC79uYJmFLzZ3RjzbE1tpR4sbF5UD/ctUfNg4axXS3D
         YgylaoA+zT0xqFOrW7Mu2QuhOg1G48OBggYwAI9jR/6WbBy1fc/zZfPiDHpssSFu6EMl
         z/ULEdzsseXc+FzXsaxHrca0yr9KVa5gbatXsUthI2MFSk6LEGRn2gN9ZB/sfiQs8E/y
         GCi+kLDBhZpiLed9qYdSvylWsuTfCPM4WpCxoug+N4ojXpow1j0T9Y+w3dDGd4pgMkK4
         fHLnWKP4avhcAjdt7XVfqbU0TSBgNoS+QV9d2wPgluEL+efWGutUPPdVZFC+g60dL70p
         UEMw==
X-Gm-Message-State: AOAM533zN15PuB9TrQFs47dVhcD7U7qKMel/iGby2EBzmAOp6D2Awzvu
        CWAzTU+WdDlp9Pj1uV9kIQmcMXGYveyeG3DbcpGJJZ7ySw+GzVDJRYsIKuBEoXbgMvyttVZ15fm
        HXxCmXqKxZPqw5cq4FxctGiZI
X-Received: by 2002:ad4:5483:: with SMTP id q3mr51466105qvy.99.1594162245537;
        Tue, 07 Jul 2020 15:50:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlFdKalFtzU5Fvl/PrOhZ5qVXzLaWruqJEUEJUgHwOhQFZp7/OQ1u5JWMVDkzqi6qvwk/FLQ==
X-Received: by 2002:ad4:5483:: with SMTP id q3mr51466092qvy.99.1594162245273;
        Tue, 07 Jul 2020 15:50:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v5 13/25] mm/nios2: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:09 -0400
Message-Id: <20200707225021.200906-14-peterx@redhat.com>
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

