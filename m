Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A320AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D74821707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvJOyZw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394418AbgFSQOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38878 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391808AbgFSQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WnWhn2O9ddpmgT5q7yGLFrwE17K5+WMrtUB+3cLWEw=;
        b=OvJOyZw22Z/JljPQtL5/jesCLB5fT9EBpSXbk/Fhna1Vlm2j+qtImovyEj3+ZB+4wy1D4t
        RSXbM941XVJvzrPGw1LPu8aS5XT5Ozx2yACSfidEYUhURbikxDeyPnmDRf2pRWwbNcYHtq
        FqmTwAaNA//+BUJT0RvRQZXU6b+bn3I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-Qvle9EqjO7uTPn2Req6SUg-1; Fri, 19 Jun 2020 12:13:35 -0400
X-MC-Unique: Qvle9EqjO7uTPn2Req6SUg-1
Received: by mail-qk1-f198.google.com with SMTP id u186so1036673qka.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WnWhn2O9ddpmgT5q7yGLFrwE17K5+WMrtUB+3cLWEw=;
        b=NIRQbVpPL1yAiRmRfQt8gSPqVix8dyL9CpXTGTiYDcZLtD6+wjZD0bWPECDD/9/ihz
         onpFUzSq7GWJ4ghBtCPntajIlOx6+tM4la4uo92RvXL4EVOopmBpwyc3taX1ZEsILyjQ
         QDuo6VjVtNyqSe0UxU6iPvC9L3Vsb1UH/9PeBjPM9GhfS/rho8/+e4uvAD07nMbJ+tRi
         Qmz3SiLMKgIOF9ssSS2jBsbnJEK1189NGLBwpkEryPcW8gRq2mppLp02fSLYp/HxF5Um
         4Z2nOIBAuGpTnCBWlgLdrMOO+K6vDz/Cu9RYjmmczdcscFbZFHIXfzvI65yjBrOwX1oR
         KCKw==
X-Gm-Message-State: AOAM5309z94WqUE20w2rOc6J73xYAXCECDM5m21j3d4YERaeCAjEuf92
        7wcL+3Nj7/s50mqq/JgpMmW3zQVaw98q5yWnCjhkevLg00IeYrs4Eb+AymspbHLV9HJcJlCzban
        +Rx2RYSM7CiC16KfAo4zUKtUL
X-Received: by 2002:ae9:ef4d:: with SMTP id d74mr4214783qkg.41.1592583214607;
        Fri, 19 Jun 2020 09:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXGpbO/9nv4BANBmX+guvWqX+FL56EmA0NXR+BJXb0IgqFlArSWQFas9dDfa1ga+CYTZhslw==
X-Received: by 2002:ae9:ef4d:: with SMTP id d74mr4214756qkg.41.1592583214399;
        Fri, 19 Jun 2020 09:13:34 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x11sm6338488qti.60.2020.06.19.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 17/26] mm/riscv: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:31 -0400
Message-Id: <20200619161332.9614-1-peterx@redhat.com>
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

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: linux-riscv@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/riscv/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 677ee1bb11ac..e796ba02b572 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -110,7 +110,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -128,21 +128,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
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

