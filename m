Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC42C433E5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9524207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImD3ESzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgGGWut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35504 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgGGWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8f5TTLJDyENYlbFehaNnbtlaq4/fY2SMNvjmVOggAGU=;
        b=ImD3ESzVboT0XXGM/ZffdZ/RhP+Ed+wAvDdzDDfoUQW7du/fKrTlivTzeIZsmeXzGKsd8x
        MOjKWz+pCbf3imVKMvYNLKB17EQRIOLWkldznljD29nuxWracuoLfjtUUXGbtZ0ez/bIdw
        hxfaRHAPXlc0PzcaANm3S+TTKD/L1Mk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-CSQwenk7ODKYQCm8Qu8ZvA-1; Tue, 07 Jul 2020 18:50:39 -0400
X-MC-Unique: CSQwenk7ODKYQCm8Qu8ZvA-1
Received: by mail-qt1-f200.google.com with SMTP id u93so31777445qtd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8f5TTLJDyENYlbFehaNnbtlaq4/fY2SMNvjmVOggAGU=;
        b=PumjTmkwLUup3ZZV1qzF7nJZLR4YFJ65/IaBu1byvkWoWLIb4Fs++ikri4ax7gHJtR
         Rxt9BBfzD+2/8vi0ob9/E3NZpDo1gFS8UX7xCDx8rLAeIFxyk0ymXUjqI7rM8wkRSDMn
         3H9SUu1uqQHS1jdh9PXsXyoBeavQrJbVOFAElBpKQn8sh1bEDpPxOSuVc6lwcxcSDoyI
         Y/tYzxlhcaVbbLpmqocYkomSfmUIDWrk0a8SxNxyrJYIKnW+SLwiZDSIOzWQ9B0E/E4b
         XqGOEue0GyIZr7XXRiGnutq0OmPNg2ql59QxpQSRA2PWE2wevGj3mtriMgdHsliopLxY
         Qddw==
X-Gm-Message-State: AOAM530dnK6UAxalcizTWa6wFOqjuuRZNs4YbzcK3dgk7dPxlYofldT/
        RavcHNT9O26zAYzxHhxMF2y3I1O9gmsJ3Fqyhtr3fyQyRseo9nn6rhRkz+F+T1ksg8TfOm9m39F
        FiHyVd4qzFV7Loci+grps85h/
X-Received: by 2002:a05:6214:949:: with SMTP id dn9mr51711864qvb.116.1594162239228;
        Tue, 07 Jul 2020 15:50:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYnZ/sBwn9kw3lX9BrDVhoNgmUHTzKr+RCjgXjVMxWi/R7wstbktVvXocMev9XoXXGqSRu1Q==
X-Received: by 2002:a05:6214:949:: with SMTP id dn9mr51711848qvb.116.1594162238945;
        Tue, 07 Jul 2020 15:50:38 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:38 -0700 (PDT)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v5 09/25] mm/m68k: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:05 -0400
Message-Id: <20200707225021.200906-10-peterx@redhat.com>
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

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-m68k@lists.linux-m68k.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/m68k/mm/fault.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 08b35a318ebe..795f483b1050 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
@@ -84,6 +85,8 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 
@@ -134,7 +137,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
 	if (fault_signal_pending(fault, regs))
@@ -150,16 +153,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
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

