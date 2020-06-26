Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589672089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPoM7McE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgFZWhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:37:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45401 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbgFZWhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593211023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nuO+Yb0GY5ATg//nVupU36tJbGPoBpffcxCpoCITILo=;
        b=bPoM7McEQpMTY6FVS0xL+piD+3D0+DIddu4SVUu+HJy3Md5wQ5TqOoHioKh+/BCw9IvoIa
        q3SPJPBjSynxOJykHW1GZ/inQv3B5L5ocDnDQ6T/dUQFUA7Aaf8RSyRE2GUB1XJcK+fLb5
        7OKIg8iYOC+Qi6GcVORwyVa2EGmvRFw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-tvj2LRsuMTqVzpJBGATcBg-1; Fri, 26 Jun 2020 18:36:45 -0400
X-MC-Unique: tvj2LRsuMTqVzpJBGATcBg-1
Received: by mail-qk1-f197.google.com with SMTP id k1so4421882qko.14
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuO+Yb0GY5ATg//nVupU36tJbGPoBpffcxCpoCITILo=;
        b=QJ3JFoi179yUnckHV2z196wNb53hpk2O/Ax5oYlb9nTl3WRyeQ3r6n9uH9QqEcY7RR
         WcFPbIZrmiR6cLDsUSjY9XybKKIv3z8b8UsLof8EHTjzMVWBHmMOxLcZKTEDfgCx1B8t
         yxnjMjo9ioodTqI+U7V7fKrQJ6Qv8921Ur4Rfpj6ozD4h+rkl0VPXuMY1cjsQkQnmSvC
         az8zi9JeAeo5NvsEPTJaIVLvwGKHE6KfIBlhSYXSPXjBoNZU4PsPj/t/AZcAsObu/iwE
         biBGOHFGcLI+zlrCtfyH0RkJTdgzsMAxDD9AUGALUkQZgoERTksALCKSxwxFXYU7iL8+
         6f3w==
X-Gm-Message-State: AOAM532Uv5Tu5xq25MxT3K8VCnDJvX+dDmNSNDOCgvqIqkvyzIAE4ArO
        iq/fovTe5ONlzx1uxjrFsaBcnIdUHUVjeQZDssdOHwI6a1PQ7+BSD+SJdL86kju4gaitMLcr+aE
        vFEqqZJYMz4IDBrQ4X1Xf8qA4
X-Received: by 2002:a37:7902:: with SMTP id u2mr5018361qkc.53.1593211005445;
        Fri, 26 Jun 2020 15:36:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4rHIJ+fZotKVVngfN/0wEgFoPpGcYIDEVRwjbxqvl3WnyNUGWXCN5el2iLD4ILApdcoxlJQ==
X-Received: by 2002:a37:7902:: with SMTP id u2mr5018340qkc.53.1593211005229;
        Fri, 26 Jun 2020 15:36:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v2sm9347394qtq.8.2020.06.26.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 24/26] mm/xtensa: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:43 -0400
Message-Id: <20200626223643.200151-1-peterx@redhat.com>
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
index 722ef3c98d60..9ef7331e37f8 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -73,6 +73,9 @@ void do_page_fault(struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	down_read(&mm->mmap_sem);
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
 
 	up_read(&mm->mmap_sem);
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

