Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9102077D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIobXq2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgF3Uq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730393AbgF3UqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/aAL+YqVyNIr1/+0GkFqbZ5SrplCx8CkqqCzwc93fOY=;
        b=NIobXq2YYrRMEOYEWaFcRL8Q+I8oE4+BwTycRHIOemF7xmx9ZfEHVMdmKm5WyoSoAU4E3H
        UCSpa/CeLKpkLCzkVSR70k2w8MNHZP5Ad6P2I5RvUhdy1vZuj1krF4KPafGwJFwAPIJ5B4
        +9v2J/JbNOw7IDtdjxLd9lRVAUDMnlM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-IKiMUkfnN8OThPY1jllsTQ-1; Tue, 30 Jun 2020 16:46:07 -0400
X-MC-Unique: IKiMUkfnN8OThPY1jllsTQ-1
Received: by mail-qv1-f70.google.com with SMTP id j18so14680901qvk.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/aAL+YqVyNIr1/+0GkFqbZ5SrplCx8CkqqCzwc93fOY=;
        b=jH9+BnfSVTPBXWSJLKJaqaUrcSrDxoqudMCvjN4+a+oqOjlUud8ehtTwA4I9kU/lCI
         fuXo5d/iQxRpfmamRmX1OBIRNQFfPVXgq7RQLtzuXHONusU5vYRtf+YioxTE4t8zlcuz
         tnoLM67xYz00Prk4a1eozd5XSPvIa0lvXlqNsIQPL+QyMQ6ErqK7k31MV+9MNRZSOL93
         ZbfhTUNzrpNAuue+CH2OpnfYSJ+SyEyNr0Ozf6VxKC0FSqpzuiuDhpCpF1EYnd/G+ji/
         HzUqIIifUbYfcCRZ7AE8Jk60CjBXLBBJSo67PKnQSx00Pj8SPot1ohND1iG/whP4ttys
         eNnQ==
X-Gm-Message-State: AOAM533yC2BrmTWY/sdQFMcIXS0wstTUUFHOk3Jok3FJxkFh+PEANroT
        /FDWDYWo6bgqlyLzGTYaonAO1euyYLZYLRaas/DWbODgYpvdA2qbkMp9GhtPijjH6M+TTyrrhgl
        3pjtuQrgI1arpZD1PGon3RMlr
X-Received: by 2002:ac8:3777:: with SMTP id p52mr22305341qtb.31.1593549967241;
        Tue, 30 Jun 2020 13:46:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA5Qn2mPg7zu4RqzhVdNMOn9tGWBHigOGJIoAnItfVkgeeGrQilw31yhmo4PQ8Uq4TNeoO9g==
X-Received: by 2002:ac8:3777:: with SMTP id p52mr22305300qtb.31.1593549966760;
        Tue, 30 Jun 2020 13:46:06 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id q29sm1563919qtc.10.2020.06.30.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:46:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v4 24/26] mm/xtensa: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:46:04 -0400
Message-Id: <20200630204604.39640-1-peterx@redhat.com>
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

Remove the PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN] perf events because it's now
also done in handle_mm_fault().

Move the PERF_COUNT_SW_PAGE_FAULTS event higher before taking mmap_sem for the
fault, then it'll match with the rest of the archs.

CC: Chris Zankel <chris@zankel.net>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: linux-xtensa@linux-xtensa.org
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/xtensa/mm/fault.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 6942de45f078..a05b53a22810 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -73,6 +73,9 @@ void do_page_fault(struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -108,7 +111,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -123,10 +126,6 @@ void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -140,12 +139,6 @@ void do_page_fault(struct pt_regs *regs)
 	}
 
 	mmap_read_unlock(mm);
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-	if (flags & VM_FAULT_MAJOR)
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	else
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-
 	return;
 
 	/* Something tried to access memory that isn't in our memory map..
-- 
2.26.2

