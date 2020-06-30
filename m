Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D96C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44C220772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRBzFcq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgF3Uqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730121AbgF3Up2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u4u5+MpkCsisdwspgoCKpfclb3FqsVFfOPYmJEG8Y9I=;
        b=eRBzFcq+Wfj7hgXwzwpLDlkYu4sX+IPZVkkTQu7JU16qX8GZS4rOWD+wjt3Mmi3uk4EloK
        cwSZJE18BrgKq7G/TnL1OzqQOjPGOW79UxqCNvf32TKo2vXYq77wWGOu3phGCFbQvWHqHp
        dOUnbWIjSUFJlvsBvMmPaS01V7Ydktk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-qhkyoTxOMZmRBwpi_VH4Eg-1; Tue, 30 Jun 2020 16:45:26 -0400
X-MC-Unique: qhkyoTxOMZmRBwpi_VH4Eg-1
Received: by mail-qt1-f198.google.com with SMTP id s30so15263520qts.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4u5+MpkCsisdwspgoCKpfclb3FqsVFfOPYmJEG8Y9I=;
        b=SWnIE7q3WheTg/lYo1ZDJSBawQMdrOqLEp+KtOv5GRIVRT0eQKrEBjUvByeQBBOcD/
         OxZM9UbBMs+7Q3fSo3e6qXBWIHujtq4XoyCndoWXP9I71nL5FFzW1CJJqZv1tBQvM1+D
         nXeMFEIHyN9rMIEIonPVGAcNVwifhEbJznz5bWOAqAQ6CzeuF1IXmbQfaPAuwU/V0SrB
         GanxRSUs8S7wrRe3nAr6y8ZA4wqQlEjt7KSA1gbjsXNDwUA1N4fNTi4sS8P9s13a5eKe
         ooum4EblDhdrW6E3et9Hse5KJ0Raq6FPjZOO5SEqeDiu8/093Z9PqTsgzDPjYnnqMMFj
         WAgw==
X-Gm-Message-State: AOAM532ml5Xv0hB177VcEs/JyVgNMU4kgGSpLC6fOXO312x6IFDO8A/W
        jGQ2PIY3zhP6l47UsUuTJDzxO+42bxTXMT4YMOP9sEzeZ4h0tGQxi2M/d9VcAdXgxx5X5Smbdg/
        Rt+GRp/EF5nF2Tiay2rkdUJ8Q
X-Received: by 2002:a37:a68a:: with SMTP id p132mr11766601qke.184.1593549924932;
        Tue, 30 Jun 2020 13:45:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqVJixsWFF3zg6niA98hdKrVy594U+4EDrNGHhvpcW+xbDBZX1tC15jNdl4/SPSApn/cUTvw==
X-Received: by 2002:a37:a68a:: with SMTP id p132mr11766569qke.184.1593549924642;
        Tue, 30 Jun 2020 13:45:24 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g1sm4326491qkl.86.2020.06.30.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 08/26] mm/ia64: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:22 -0400
Message-Id: <20200630204522.38857-1-peterx@redhat.com>
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

