Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E905C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBCC207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnC7dA+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgFOWQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25965 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726590AbgFOWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LrXet/u9PsVKETw5J5uTZoQrhPoEIyPOMIKIRZZJQVc=;
        b=HnC7dA+163E7kqY+ID8ZIhVNnlkpLUf5+TTlL6WdECniI7Xo0mvs5vid4JJgamwc8vL4cC
        OND3nBUGRqDG1UDZ1a9h+/IUhRDtuWJ/hqZB/VIzjopKrNnmSMXBPDkh1Tv9e/YJ5XZrKk
        4PkwFnZ7QdM8qXDbJPZolY7eKEI9nDA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-Qtt8UKiLOHe1sDwVt1ZTmQ-1; Mon, 15 Jun 2020 18:16:35 -0400
X-MC-Unique: Qtt8UKiLOHe1sDwVt1ZTmQ-1
Received: by mail-qv1-f70.google.com with SMTP id j4so14112510qvt.20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrXet/u9PsVKETw5J5uTZoQrhPoEIyPOMIKIRZZJQVc=;
        b=rOzYrCkB5PyU/jFZaZahhAL2y4i2gekvP6sOzkyT3+jZOnt39l1vgkovmdGfE3YkSM
         IWrZ3botQBIxak2DGe9sNgW39Y8KFOtOkopwbsnffEER+bqRcUZgaG4tpyo2A7aKVCLn
         vIz50JCfANoHSOZ/prw9sNiBlq3OZRF3gV0qbgdybE316sWjeLMjvfZRo1qA022g46Ym
         YgW1P3GN+sQgx2oDBSpBphLUvK2mC1cWGJWEN5lAflSovPzUETWV0ms+cVJxePn7MXPD
         HYmNxA6HK+HWuryuEPlQ+49JX3FkqzMSm1E54klPOJYHjiYhgtOL/wAuJaZOUeUqrmrq
         /F3w==
X-Gm-Message-State: AOAM533bjI3oJlrCHgzlcsfhVazAxeP8gZQDRF4ykgseJebmyYg4VjE9
        GCy/h73/kYO6qkB7mEyu2p+hzQ3475heAxFZoVxv8vUdWzYhIr7d3m7NLaEdfqoQj000u/yjJ1H
        DoTvykCHxa4fyhbjoaYs/VQdy
X-Received: by 2002:a37:bce:: with SMTP id 197mr17965189qkl.370.1592259394368;
        Mon, 15 Jun 2020 15:16:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAB87f0teT+AoUuUDa9EV3hAUkTpzewveG/D3zCXJfCbtNOHTUPLn4ln2DWCvjuYT7AfKeOQ==
X-Received: by 2002:a37:bce:: with SMTP id 197mr17965165qkl.370.1592259394135;
        Mon, 15 Jun 2020 15:16:34 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 14/25] mm/nios2: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:56 -0400
Message-Id: <20200615221607.7764-15-peterx@redhat.com>
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

CC: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nios2/mm/fault.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index ec9d8a9c426f..48617960a07e 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -46,7 +46,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	int code = SEGV_MAPERR;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	cause >>= 2;
@@ -132,6 +132,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -146,16 +147,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
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
 
@@ -170,6 +162,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(current, regs, address, major);
 	return;
 
 /*
-- 
2.26.2

