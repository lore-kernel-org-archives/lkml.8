Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB4CC433E5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADED20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTg7Tj5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgGGWum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729568AbgGGWui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4zIYRHOACURUfy9t13d60Z4Yb5Zt+j+VbtnlH1sD2o=;
        b=BTg7Tj5fsYvk1DAKcyFIK0dRGwIKCyrigCi+dW6L13rnrI5kuwVbqgM9GaqTu9luUJTHOz
        xZ99kZ1IkVZbqBnDJFkx7+coQWkJ2CwLzPN6LRO2FemT1J63fvy/M80XNLS5EOuQxqW0rn
        IwcKegNOj5/7VDTfg8ILJ18hLLXCRGk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-Hz_L5GmQNcKigU_lOVuUwQ-1; Tue, 07 Jul 2020 18:50:36 -0400
X-MC-Unique: Hz_L5GmQNcKigU_lOVuUwQ-1
Received: by mail-qv1-f71.google.com with SMTP id m18so14962132qvt.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4zIYRHOACURUfy9t13d60Z4Yb5Zt+j+VbtnlH1sD2o=;
        b=tSIrxlfCpgnmyP9sHk9/jh9yBog8INcw842Nc2SuRz6ciXFcxSSMzfaP+qVZ60cuA0
         E/xMA8t54ri+ZUU3PNrlMjUYleO2yQ1FjgNfS9nDMALWI89Ck3F4igPBqWjcHUmPiCaM
         TFKZpjRnwaY922QkLeWEqHm6PWvfSNJUslDOlz7KZBLQveUCZsVe8DPM23Vnc8jMVlLD
         1IOp5kQRRgltkD6zfPBvUgyx26rgHmZtH4BF5WXPJCZipLKzFOnQh/dmRs1ADZkDU/+m
         g9p1CQNtt5BdGNKUEDnpHp/AC7P40sz/O0vAl55qlcNdZlyBa/099g8ngWNr7MXyBsd8
         dHTQ==
X-Gm-Message-State: AOAM530Ox644inr2Fvh4R5m4i1MAt8MHj9xgG5MZ21COhz3tEZqlDMlC
        2KLw7LQ3Y1DRmWR3t/1Rgyf6woLujptZVAv90+ldPKu9MPCiyrN5GdOPe/+6Z83cFgEeDJfpx3J
        aUnX6gI3b1dX4hd6YadqE0np7
X-Received: by 2002:a05:620a:121a:: with SMTP id u26mr53672520qkj.398.1594162236049;
        Tue, 07 Jul 2020 15:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzluayj3u4Yocf5HHLjWUxuZvg566IRp972A3KvRd3pkGDQoJgxfIqJJmQTZ0tYxp6Eo8C2mQ==
X-Received: by 2002:a05:620a:121a:: with SMTP id u26mr53672502qkj.398.1594162235782;
        Tue, 07 Jul 2020 15:50:35 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:35 -0700 (PDT)
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
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH v5 07/25] mm/hexagon: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:03 -0400
Message-Id: <20200707225021.200906-8-peterx@redhat.com>
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

CC: Brian Cain <bcain@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
Acked-by: Brian Cain <bcain@codeaurora.org>
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

