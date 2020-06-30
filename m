Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B75C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A9020772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4UrzgNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgF3Upi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730141AbgF3Upa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0oSiaS0i/TrG3B4WZW/K39VImBtqNKePW8X1XXaS114=;
        b=a4UrzgNFdhKHxfA5/hd9q6kGGy+k2JsRe9yuNqtlvJh8XO/r398XrZH79DzlzZ5WjEC8Sf
        i469i2+zJDA6VD703W3lATkOVCUCGyvoeIU0ukPuXlNGFQemaFR56pFC4YtzpEomOyFM2/
        E5FwXy5TxGxeADgMST8piYPBLcviNmE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-1011-t9wOyyQubDE_lxAoQ-1; Tue, 30 Jun 2020 16:45:25 -0400
X-MC-Unique: 1011-t9wOyyQubDE_lxAoQ-1
Received: by mail-qk1-f198.google.com with SMTP id w27so15513843qkw.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oSiaS0i/TrG3B4WZW/K39VImBtqNKePW8X1XXaS114=;
        b=faVG1W3kMcAvw306++/YVamO2dQd2iN4c+lSuaDN233m3n479Kqq6lUXXEHhAoPbiu
         p7x1lfREA/detjFjSJLTDaaiiSCDDdz5TLxT/kXy9qTWm1BtrdxvneDth8/qzyj4NN+t
         NJXGlK9f9lDkuQ0zF44VTn/StkIMnqspifKBR30eAavT19ZhwTdpEZ632girDYlrFIdA
         yRTbm5hzKo+Yl6UWJ3qCWVZpoiP8YUr9UeWIxawv1aR56i9ZsDIQalIIHNqmktthAhIu
         9M5mbt8P/fUtmxO6VFS2+sPXTW6m/ckMHCGnmQwOWmhAyWbHKj4Gyhhy7Ka37uCCNUHs
         qsvg==
X-Gm-Message-State: AOAM532PAXdv5nx4Y5Prt3/avHOgRoo2GFpJ4SLjTNUE4B3676Q1V57l
        wXEKLXLtyaHm2Iab9gKS/aUSHRJoOZmwpUv8j7dZkxsHjtbngWnlNCoEglvNP5TYfs9wquor8Wf
        3Zb2vghm5OYKC8XFyrfr6rmv7
X-Received: by 2002:ae9:ef4f:: with SMTP id d76mr21557572qkg.423.1593549924291;
        Tue, 30 Jun 2020 13:45:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiCIZOd0SFhyDP1RMP34PE1DDliFCmZMFzYzAiXHV+Itj+3kk75rVqggZCe39IF1oIv79/dg==
X-Received: by 2002:ae9:ef4f:: with SMTP id d76mr21557403qkg.423.1593549922268;
        Tue, 30 Jun 2020 13:45:22 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s71sm4176169qke.0.2020.06.30.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH v4 07/26] mm/hexagon: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:19 -0400
Message-Id: <20200630204519.38809-1-peterx@redhat.com>
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

CC: Brian Cain <bcain@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/hexagon/mm/vm_fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index f12f330e7946..ef32c5a84ff3 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -18,6 +18,7 @@
 #include <linux/signal.h>
 #include <linux/extable.h>
 #include <linux/hardirq.h>
+#include <linux/perf_event.h>
 
 /*
  * Decode of hardware exception sends us to one of several
@@ -53,6 +54,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -88,7 +91,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		break;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -96,10 +99,6 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	/* The most common case -- we are done. */
 	if (likely(!(fault & VM_FAULT_ERROR))) {
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 				goto retry;
-- 
2.26.2

