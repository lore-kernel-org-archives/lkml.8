Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C9BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05185207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYB5anbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgFOWQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726408AbgFOWQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uy9S6zWlY4QUCbRMwtgEQKAubvhaoWQ6Csg0YCMvJi4=;
        b=bYB5anbFG0qTHiZSjAoa02nRe7wyCwUWfm0244QRLZ+LMITCMvjMkSvtU/e6KOgURl+pY7
        ttuuUM8Jdaaqs2WhtbmtJG12VSU8Y39h9ePNWx+aHI4+9mWQqgH1ooWuSbaUYC0gpVP38J
        2XoIgx2hbTGL0Dw0/x7b7HM2jnw1Qn0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-legKeUzEM3SYQEV925oSrA-1; Mon, 15 Jun 2020 18:16:16 -0400
X-MC-Unique: legKeUzEM3SYQEV925oSrA-1
Received: by mail-qv1-f71.google.com with SMTP id h4so14041507qvr.21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uy9S6zWlY4QUCbRMwtgEQKAubvhaoWQ6Csg0YCMvJi4=;
        b=G9x+WQpJDETmFsR9sigcsw1ZDXqW0HDv8P9P+DBvq4IOQ4/ID8CA1pQLOWZRg9nE+g
         0codwC4x3Gf8jaL2jgJoWXMVVJEQtU8K7trxI+h4wau2FGizQBQvCKVx7jl0SGWyiSqz
         H9DYsLEu6YzGuuQ0m/kQcHI/kjbcgarxAz1uPjnA1lPJcYeyj4eiL/fF+xh2C82GIAZ7
         pEeId0L67W5Aunz+fHBbiJMJSSoc28tan0G+c8Z8s5ZzRRWbafi98sOAVMHMaSk4haO1
         /qwYLHhtLhqV85Agc9W4SSJLvaDaAJDGR7ToeBUeZaOhf3YyPG0/B/AdjVRHeUIoUs14
         DmJQ==
X-Gm-Message-State: AOAM53156kCM6mkIQq8vZ8RqATRRsrXIFJSbBOnMnjYgPMWhnBD7/XGV
        E6bzlLVV7334qeN2S55MGLkCM2ytoNmBVi93M6VI4xwkpp86fc5w4tOAL5MsnYfGMdArVEaHPo/
        JDl2cF5AVC+/pRUpXKu1b6Oqy
X-Received: by 2002:a37:383:: with SMTP id 125mr16915093qkd.487.1592259375282;
        Mon, 15 Jun 2020 15:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx2jdZbikd8ij9fO7Na7EhCsaCx+jNGFIMPDIBNn75KvLdZjW89Wj8DO9pFH/vOL7V0f2F0g==
X-Received: by 2002:a37:383:: with SMTP id 125mr16915044qkd.487.1592259374706;
        Mon, 15 Jun 2020 15:16:14 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 03/25] mm/alpha: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:45 -0400
Message-Id: <20200615221607.7764-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.
Also, the perf events for page faults will be accounted too when the config has
CONFIG_PERF_EVENTS defined.

CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: linux-alpha@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index c2d7b6d7bac7..4f8632ddef25 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -88,7 +88,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	struct mm_struct *mm = current->mm;
 	const struct exception_table_entry *fixup;
 	int si_code = SEGV_MAPERR;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	/* As of EV6, a load into $31/$f31 is a prefetch, and never faults
@@ -149,6 +149,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	   make sure we exit gracefully rather than endlessly redo
 	   the fault.  */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -164,10 +165,6 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -182,6 +179,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 
 	up_read(&mm->mmap_sem);
 
+	mm_fault_accounting(current, regs, address, major);
+
 	return;
 
 	/* Something tried to access memory that isn't in our memory map.
-- 
2.26.2

