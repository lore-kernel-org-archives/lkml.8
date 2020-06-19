Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A64C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E8721532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXuQscfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405560AbgFSQGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25794 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405541AbgFSQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SagB2x6xDXMHuNfH0nszNoiVH7/+fXWLgMfhv8WOo7E=;
        b=SXuQscfIp84Jam/3SNag7zZHTrGwnKri/xm+9Yk4bv7VuxQWefJbFQq4NZY2De8nCxOs6R
        1mXbMC6ZG3ckJuBNrVEiNUYsea5P6aOF4kG2MDm8bfcnqAku/gO6u2oh3RECEVxm3CVA9s
        FER3YW8QvV85Uw3gyq4cDyy2Z8+IJp4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-L5VbXHp8OdONKxz-kSAJKw-1; Fri, 19 Jun 2020 12:05:54 -0400
X-MC-Unique: L5VbXHp8OdONKxz-kSAJKw-1
Received: by mail-qt1-f200.google.com with SMTP id s30so4383023qts.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SagB2x6xDXMHuNfH0nszNoiVH7/+fXWLgMfhv8WOo7E=;
        b=WLqx8JJZ4kzzL4eANzlbEtO3idM9E16BaPgo1xbbk1bqrUPkgcQGL/Io4JW/Mw7ws4
         gMGlj4Gmvn783vgcjqFEtBjk5bbhMGnFqRxuhG6Uj6QNmnsqwaA12JAg0Ftkgf1Ciy0l
         7NRCsHc5/yqnG8bfOK0UyeqiBhhdJj3euIFs729KpjB2qNbzJLz/aQ2iTr1z/vIOVhUy
         cqjjx4FceFUadEI8z959m3lCxikMiht+/bvNGhtN66pE/cv9XqUfvTcf0h7760tqtgpw
         bMKnxYdUz6mlcB8f/c4XrZafrsJlMtXHp10HSRGUGWKFsW0N5QHIUFGnvUD3e4igiWEg
         PBYg==
X-Gm-Message-State: AOAM53320tsGzUMLyWgYI7YsNjEXr/6uajy4maGOBD/g4+8q+y0X/lKO
        +aeY5icJLz2vVleTBth4xF3rNcnJ5m4j0UX+z99qh/aSkStWF4Xfe/BkVU/UWI0IbfG353GXXTZ
        vUfY4q/6TXyWpyEO9am+v545C
X-Received: by 2002:a37:9e52:: with SMTP id h79mr3975297qke.467.1592582753531;
        Fri, 19 Jun 2020 09:05:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd2Ml6f1U4IsoXVUG+sGmbZtZswjvwyuO+DQ4aozpetfpM522QVCnolfKkgB3x792Y2yKCcA==
X-Received: by 2002:a37:9e52:: with SMTP id h79mr3975266qke.467.1592582753231;
        Fri, 19 Jun 2020 09:05:53 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH 07/26] mm/hexagon: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:19 -0400
Message-Id: <20200619160538.8641-8-peterx@redhat.com>
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
index f04cd0a6d905..1b1802f30862 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -19,6 +19,7 @@
 #include <linux/signal.h>
 #include <linux/extable.h>
 #include <linux/hardirq.h>
+#include <linux/perf_event.h>
 
 /*
  * Decode of hardware exception sends us to one of several
@@ -54,6 +55,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -89,7 +92,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		break;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -97,10 +100,6 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
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

