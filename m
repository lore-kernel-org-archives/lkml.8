Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14375C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5A420772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z95/X8R7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgF3Upl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39153 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729988AbgF3Upf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntPp8bHOPIXhq64ZYjMBP9tKw1Ahb/2+VdQMPS01kXM=;
        b=Z95/X8R7FiYmTKkxOSDMzkuVm7JRSsUobbr5JYl9KcFpd6wbPvR0YobRb7hX2kbKPATAKT
        VgCcGUmT8g3CQSF/RcoERSHWz+X+54md7BUiBgzevfRmQ9MMX50GrG2H0kOgLWsCcjoUR+
        dSMefKxUMB7g9aeVQoLaXfsgXR+vOIs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-kGwfTurrNnafJiWNzc0ZaA-1; Tue, 30 Jun 2020 16:45:31 -0400
X-MC-Unique: kGwfTurrNnafJiWNzc0ZaA-1
Received: by mail-qt1-f198.google.com with SMTP id z26so15288570qto.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntPp8bHOPIXhq64ZYjMBP9tKw1Ahb/2+VdQMPS01kXM=;
        b=l14u0GR7vne53QjXaxPmSKCEwBs9BK6stZz2CSnR+XlO6mNxY3NvFw3+UjWEb6cORZ
         gymOcBcBgX8RQe4II3Zi+SOFdrzWpiDW19WiVUTTVQzhme12KpmWC43O07zc8ax3gBfj
         WkaxwupSAug78MbmxNgTHS2kkvpeEFb9BGthKkWycroCGavDStA7aAhAeb88EQ0jyeiL
         LKkWdmKCBOoEwYoJNu9F/p4XauxzTfaqHsCD4tpPmb//tqNw0ENLO6v7UvOv2cMXVKbP
         NWD8sieg7YB/CPUIPWvXOf3Kl+JgjH0ng57KCkkY1dp/pg7cgbyEdwxklzUvk2KT+G6B
         J61A==
X-Gm-Message-State: AOAM532sIrr0JbVaKG+AEtk5pSEWuXTmnN+kGLxTCZz+3ISa4XgzixJ/
        D7Frb5HW+XFysuvZ6aVYUIFGZ/5m1qAA+B4pOXTPAymVFlJWQ9YnXNQiB24CPAQMLy7h8yJOfDq
        P/e2BiYQu766cf1AzsPIj5+Lg
X-Received: by 2002:a37:de19:: with SMTP id h25mr18441910qkj.354.1593549930600;
        Tue, 30 Jun 2020 13:45:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwUQDPyUuSg/1KIgpJ4dyImwv9wjGn6EtkG5kne0m0m1PAimwPyxdFpEe1G1QOHO4oZVoDAg==
X-Received: by 2002:a37:de19:: with SMTP id h25mr18441858qkj.354.1593549929950;
        Tue, 30 Jun 2020 13:45:29 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r7sm3769108qtm.66.2020.06.30.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>
Subject: [PATCH v4 10/26] mm/microblaze: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:27 -0400
Message-Id: <20200630204527.38955-1-peterx@redhat.com>
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

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/microblaze/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 1a3d4c4ca28b..b3fed2cecf84 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -28,6 +28,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/perf_event.h>
 
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -121,6 +122,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -214,7 +217,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -230,10 +233,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (unlikely(fault & VM_FAULT_MAJOR))
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

