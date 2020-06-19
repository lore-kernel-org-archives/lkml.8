Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B05C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0CF204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WL3KVim2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394236AbgFSQGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393039AbgFSQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dqCpbomUjM3yzMbNQtQFnUhCIZ/IBDwpBGYZavg7bk=;
        b=WL3KVim27v/cmQOa6uDBgrPgkSguxH6whuOrJwWc6zE1n6eQh24BBHbv2HY5JmFkSUA3ua
        tuuHrzXwkXMoLJZr2AK/hzCPjeUQq71nVGk5jeHsmboyqo/NO5Xl9KWSw8gfD5ODdzuFZ+
        d3z66W//qw1yaSQryI8qjuwKJAu3xaE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-qmRsEhuaNz-58Zo0TdPGsg-1; Fri, 19 Jun 2020 12:06:00 -0400
X-MC-Unique: qmRsEhuaNz-58Zo0TdPGsg-1
Received: by mail-qv1-f71.google.com with SMTP id x16so7033019qvp.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dqCpbomUjM3yzMbNQtQFnUhCIZ/IBDwpBGYZavg7bk=;
        b=nGWw1dXbe2SieHrS5Pd/8EQ+2WF293P16irYhshrFnbqtXpMrCQTq14JZoqZwHx8sJ
         mwm/Kmt62AmF+57RHaWclWMHo6H7M1C2S7wUKHYrM2A62lYm+1NaIWE6saFn4FPr3lO9
         O103o626itREa2fw0XVpyDk1vOsTE7Js/LD9Ny1fq7C1EbZR+/0CojBaz3BWwLU1kc63
         p6LjQ1r869yZZQ1KOizAq1bOR5DsUYQEZRvfVVBQYUaekF81dcwR0hRopXjFhZ9nv11u
         Vfj+sctuM0+/PPgpoNXr2Mf6jl1BzPsORGXq1wWpy4YiUmq4jc5BkhqhjW0Kb+KAvILE
         1hWg==
X-Gm-Message-State: AOAM5305yEwcMEBNurqfhzGffPZvuJbEdF9IysOkL+t792YAoHp2dWHh
        E3Jn4owx2Oeh+H1tVAO4MRAZ9jasWOH2LLoOBwi1AH1Iks59mV4Vn+2X9K/ooikisTst1fLpuRQ
        4mAG4Rq8HkrdG2YytH6RzKadK
X-Received: by 2002:a05:620a:10ad:: with SMTP id h13mr4366748qkk.373.1592582759372;
        Fri, 19 Jun 2020 09:05:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3/0AzPGmc/mgScudox87Z+KKyBmz3uCW7RXHY47m0M7+4IoVxehRGqL+MdgH5iyR2bGppkA==
X-Received: by 2002:a05:620a:10ad:: with SMTP id h13mr4366702qkk.373.1592582758840;
        Fri, 19 Jun 2020 09:05:58 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:57 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 10/26] mm/microblaze: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:22 -0400
Message-Id: <20200619160538.8641-11-peterx@redhat.com>
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

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/microblaze/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 9abfa5224386..3d58dbd227cd 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -28,6 +28,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/perf_event.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -122,6 +123,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -215,7 +218,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -231,10 +234,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
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

