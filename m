Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E042075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQDSt0zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgGGWvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729700AbgGGWuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=118ZuGBADe17DIOE5hd4LPbyDCcCNPIhXK0NF+I4+G0=;
        b=CQDSt0zNLQNlhDOz5BLrrLzlkqGz31sv1SFW9Uks5qh5wJh4t7Zcy/mn1x25tDQzOUBlHM
        bXpYEm18C084yYFAzR481FKh69217ph//Crim5RDdMNAFGGXGIVA2EK2eovzFmRGTx/AFC
        CVmIXFmVbRRWi6wIPovGtAFFINeHIi8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-LqD2XiTaNgK3Wz-BI4HFQw-1; Tue, 07 Jul 2020 18:50:53 -0400
X-MC-Unique: LqD2XiTaNgK3Wz-BI4HFQw-1
Received: by mail-qk1-f198.google.com with SMTP id a205so29579422qkc.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=118ZuGBADe17DIOE5hd4LPbyDCcCNPIhXK0NF+I4+G0=;
        b=g9zm9W+5vEYgr5zZXKFn4+SBdLduHB4TDzQc/2IDRM9nJSXHyXCWr674MR1kHpHbPb
         DmCs2pGgJDen4bqRwO/rbchgsdcYdCf8P/6OSVL/GAoKnxmoq7a3j2hj2D/aGW5aCQt6
         F2LtLNlRq7/5G5h7RJyQ6QubPCddDnguNjoL7EmkCHdS+PkapOC4frjg52V/Pi5jibZ4
         EtQDrmOqcRxg0a9dWmUonaskix5bjfenVnTtiiOd90reqz/hiMVVRVX3zw48ksovUOif
         22/ZkYEdMy7aEoxQbEn0UYEaBjreZLXPdLtm84f4l7BUXhvFhxvUceOMwfKDr4eO1OAh
         qFVA==
X-Gm-Message-State: AOAM533hJejhdCbL87ZtieLXstnj8v4selqzsxB1k0zB/OfCn5glILZk
        zK4J9j+lCg+3OVvPasAZljuE8M0cs///7OADs9YrbH6LoEgcm3sWYSfSDBbX7jPkxQbNedWoWnz
        fUIQ3YB5OfPQZ5L81JQ/K5/a0
X-Received: by 2002:a37:b141:: with SMTP id a62mr48028572qkf.201.1594162252351;
        Tue, 07 Jul 2020 15:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK7Y2DUfTKdLNV2DO9bFAUkgaqmVbLuA9xFf6I5zpI0aGjlm1MfWvVmwIY/UB1dT9vqIFjlg==
X-Received: by 2002:a37:b141:: with SMTP id a62mr48028550qkf.201.1594162252137;
        Tue, 07 Jul 2020 15:50:52 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:51 -0700 (PDT)
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Pekka Enberg <penberg@kernel.org>
Subject: [PATCH v5 17/25] mm/riscv: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:13 -0400
Message-Id: <20200707225021.200906-18-peterx@redhat.com>
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

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: linux-riscv@lists.infradead.org
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/riscv/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 30c1124d0fb6..716d64e36f83 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -109,7 +109,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -127,21 +127,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, addr);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, addr);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

