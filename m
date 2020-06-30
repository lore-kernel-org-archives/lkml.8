Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D579C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665A220702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZECID6Vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgF3Uwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:52:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47373 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726268AbgF3Uwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593550370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZuPZYk0Ns+MCrJXk2nN23I5YsKRR2oHib+g0ZYAxJ90=;
        b=ZECID6VoxlCL7Qy7W/xFloMHsRzLsiO9T9FvkdLyPcrKoWvCTM6A2KEr5T2ScS6thUkk8n
        p7mOfQ2ZevBYlT+UqVzzMLJysC6EIwNNqKZSJGZJYvRDALoFHG0uX3GwAWsGO5HW+VeLQx
        1jOqorkjJMCcDbYvXkGtx4SBHGqaYsE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-AfF42e-JNS-LfOnRu7eEIg-1; Tue, 30 Jun 2020 16:52:47 -0400
X-MC-Unique: AfF42e-JNS-LfOnRu7eEIg-1
Received: by mail-pg1-f198.google.com with SMTP id o15so16079161pgn.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuPZYk0Ns+MCrJXk2nN23I5YsKRR2oHib+g0ZYAxJ90=;
        b=jxzd90bPE2MdY1/EXBR2usogNWGTGH6SBotcaJcilBNJ4rAtA5ntZcWhLNioShHCbp
         6ruKsyucu6BK2/LOBEjhdihGXmTyDxW5xdoe7iOvB9fzZEjgRwm68EHYo9hCzgRFilXe
         6ref60TgUUv9frDqn0SsK1DFrxbYgX0TtJwyy1ydVwgnukRaOyO1swbEwpViy0bZqBq7
         C9O6WwmQy5+s2m/V8Jh4nmaHeQ4n1tFiH238zqaduEl6J6y7E/877jfqcnN9edAE06mZ
         63+iLrsdAiV+I62MROiazapOmvRiNLC/ZG7P5UBfRwAMsSGCMqlKTyjLqxgwA/rOyIUa
         nwkA==
X-Gm-Message-State: AOAM532zO9GeMWqLE/2IS7gExyyW98Cr3nQOANBIm/MieSJIrHSHRt9n
        wQXa9LLBXOLjdqhV4ZclwM79pNZ0aIiGz3TZB+SHeZZQjo77UBLm1X8WcCrg7QNQdoZzJNBN5KI
        J4w9i508AmutNOrE/DWV/72rO
X-Received: by 2002:a05:6214:1586:: with SMTP id m6mr20808923qvw.171.1593549956468;
        Tue, 30 Jun 2020 13:45:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNcVTxS1nLn72PqQ6RmcgCA2jlQ+iPsG1/Q8+SmC7pwUxqSCsBS9tibh2g1OtZBBb74J0RnA==
X-Received: by 2002:a05:6214:1586:: with SMTP id m6mr20808902qvw.171.1593549956202;
        Tue, 30 Jun 2020 13:45:56 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v184sm3850652qki.12.2020.06.30.13.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:55 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH v4 20/26] mm/sparc32: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:53 -0400
Message-Id: <20200630204553.39442-1-peterx@redhat.com>
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

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_32.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 06af03db4417..8071bfd72349 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -234,7 +234,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -250,15 +250,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			current->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, address);
-		} else {
-			current->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

