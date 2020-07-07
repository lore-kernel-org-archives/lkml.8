Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE132075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpsvY7u/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgGGWvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41545 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729725AbgGGWu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sstMP5NBLNFJ42p1Ptb1NInEyGUfT5YQOxqtWfaqyuo=;
        b=NpsvY7u/q+2YHLjf6ZVoXH4/C5vUnIIkPRvINlyFHy6rUzo6AT3IWrz+Ej+7xnc/6LZBVf
        qgr38d/5keY9NmVnPCGWoGRz11G/qMg+EJ+0uAhnwWTPqWPaPpaFQcmdE5vwPMqvxcT28M
        YyDDRg/CFjuiFIW/tY9HbzELBdFvVNE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-WrKF4Q5nNbSZhUGY_hSsYw-1; Tue, 07 Jul 2020 18:50:56 -0400
X-MC-Unique: WrKF4Q5nNbSZhUGY_hSsYw-1
Received: by mail-qv1-f70.google.com with SMTP id j4so28053839qvt.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sstMP5NBLNFJ42p1Ptb1NInEyGUfT5YQOxqtWfaqyuo=;
        b=izua8GP01oIlwok7eIe3SavVVcpYwlhq3yICQPjYAN111oNOvfdWP1VCN1unmsF9oP
         80CsLEN41eTBCg01mdSJmkyKwm6Lu23PvMMHwAXqdfH57NEUmq75RIva1YfLDTuZyybo
         nmvNNJNxW6eQVvPkoEmTKOAljjvH1BbQ71AZG/+s7MRLe/bmDe2I8G5g88mfiJEG+4wh
         utVcT4/eSfN2qOjKOybWNF2hOfgRRYJYmzOr2x6oIDTKa9sRMReHxqBxy2r31foap7bG
         0fIqsXjlYmbF98rf5yCSc0XtBS8XVW3yIsFemTKIaYNzME/CEfyCdH56T3p2aAppY9R7
         Wviw==
X-Gm-Message-State: AOAM531X0e/CWYOrKYYZd2fuDvUNIQgJeIuH8GFrxycC5j64LfFAUeGc
        EFAVe3SJ3o40h+EpBOlOux+mYPgUIGPL9PV743cJcGEYIorA3R4oLC+DRa5hYwpjetMDdZ6XD34
        L6RZuQrJ6Vl6PmVdVN8Mcf6Eh
X-Received: by 2002:ae9:ea13:: with SMTP id f19mr48305844qkg.331.1594162255793;
        Tue, 07 Jul 2020 15:50:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+fZbbr5VZat1rrRmd+D1Dar1PUsYOv9odYsqMkgw6s9ZuUOa/fKMkRQzzNbqSPEglj8MNYA==
X-Received: by 2002:ae9:ea13:: with SMTP id f19mr48305824qkg.331.1594162255589;
        Tue, 07 Jul 2020 15:50:55 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:54 -0700 (PDT)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v5 19/25] mm/sh: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:15 -0400
Message-Id: <20200707225021.200906-20-peterx@redhat.com>
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

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 3c0a11827f7e..482668a2f6d3 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -482,22 +482,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
 			return;
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

