Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D84520C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9iIihoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgFZWg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52830 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgFZWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593211010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcV8UWlWsC1eML+Y6HmJxR2Cl1DnigkEWgcHrN025RQ=;
        b=U9iIihoVkshY9R6dE31ZkxT2L67pNE17ShfYeF8OZGxt3mylbw2pgYsn1YZRYnMB5d+wGu
        jNhpe7TbHNol3RFgRtkM1ePOCpVUoTxldKLvC+MQ4YMs1ZOkXdSR9IbcEvA9IYmOCOpXgR
        qPXFxf1FhJFWhTjs891Vl4sjiQM24KI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-66QR32MmPhSBzyaOwMtB7g-1; Fri, 26 Jun 2020 18:36:49 -0400
X-MC-Unique: 66QR32MmPhSBzyaOwMtB7g-1
Received: by mail-qk1-f200.google.com with SMTP id g12so7633815qko.19
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcV8UWlWsC1eML+Y6HmJxR2Cl1DnigkEWgcHrN025RQ=;
        b=iAgeyF1wtVG87kr7slgKu9bTOXOoQiKKL9J59fmr67yE1YEq3HWcGQeNYjXB71zHb7
         ed2TK76fIO8cuWFEaCKippCE3bvKe2bkCHSaF3JU3pq0R4WRvKtVNAnbYpGxpITZO4Pb
         gKWOjZQcpj2rgCgq8c4yFm5+PDTbO4JbJGS/8vXegBlfye5f9VeGSDFLyjvr93adt53c
         Main/YAh9Tyq73aMFGXFVzhIoFWb/qT/E7mTZJI1B6a/haGS9c2slc6RXlM/uxl3N0cz
         HSPxhVGjDr7WxgNeMqKcdLkE7T21RAxWpbSmkNowhcdrvHhl5peLboYtpthxZ8J47kui
         Ytcg==
X-Gm-Message-State: AOAM532Tb5tbbq2o+D1OICbKT3B5um0rkDiB3E9l7qz5UHA8xRdfKjxx
        Rk50Li3imKZb6yvvRa4uAK03WxouJkpp5EUm/NGDUdmkue0k+BZiwAtxf+IVjuIU1EBhaaS9pVL
        cTVx+jhdfhDl36cptCyPJsEU7
X-Received: by 2002:ac8:7587:: with SMTP id s7mr5192324qtq.304.1593211007865;
        Fri, 26 Jun 2020 15:36:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3dZZkXEut2YSkcj9Z923IX4G8sGFHFjPc5JlN6ewxXiJbeYgWJTu7LB7Nc6uW9BidINIy7w==
X-Received: by 2002:ac8:7587:: with SMTP id s7mr5192304qtq.304.1593211007603;
        Fri, 26 Jun 2020 15:36:47 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r76sm8832654qka.30.2020.06.26.15.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 25/26] mm: Clean up the last pieces of page fault accountings
Date:   Fri, 26 Jun 2020 18:36:45 -0400
Message-Id: <20200626223645.200199-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here're the last pieces of page fault accounting that were still done outside
handle_mm_fault() where we still have regs==NULL when calling handle_mm_fault():

arch/powerpc/mm/copro_fault.c:   copro_handle_mm_fault
arch/sparc/mm/fault_32.c:        force_user_fault
arch/um/kernel/trap.c:           handle_page_fault
mm/gup.c:                        faultin_page
                                 fixup_user_fault
mm/hmm.c:                        hmm_vma_fault
mm/ksm.c:                        break_ksm

Some of them has the issue of duplicated accounting for page fault retries.
Some of them didn't do the accounting at all.

This patch cleans all these up by letting handle_mm_fault() to do per-task page
fault accounting even if regs==NULL (though we'll still skip the perf event
accountings).  With that, we can safely remove all the outliers now.

There's another functional change in that now we account the page faults to the
caller of gup, rather than the task_struct that passed into the gup code.  More
information of this can be found at [1].

After this patch, below things should never be touched again outside
handle_mm_fault():

  - task_struct.[maj|min]_flt
  - PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]

[1] https://lore.kernel.org/lkml/CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/copro_fault.c |  5 -----
 arch/um/kernel/trap.c         |  4 ----
 mm/gup.c                      | 13 -------------
 mm/memory.c                   | 19 ++++++++++++-------
 4 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index c0478bef1f14..2e59be1a9359 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -76,11 +76,6 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 		BUG();
 	}
 
-	if (*flt & VM_FAULT_MAJOR)
-		current->maj_flt++;
-	else
-		current->min_flt++;
-
 out_unlock:
 	up_read(&mm->mmap_sem);
 	return ret;
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 32cc8f59322b..c881831de357 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -92,10 +92,6 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			BUG();
 		}
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 
diff --git a/mm/gup.c b/mm/gup.c
index 1a48c639ea49..17b4d0c45a6b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -885,13 +885,6 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		BUG();
 	}
 
-	if (tsk) {
-		if (ret & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
-	}
-
 	if (ret & VM_FAULT_RETRY) {
 		if (locked && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
 			*locked = 0;
@@ -1239,12 +1232,6 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 		goto retry;
 	}
 
-	if (tsk) {
-		if (major)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fixup_user_fault);
diff --git a/mm/memory.c b/mm/memory.c
index 4a9b333b079e..0b3c747cd2b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4350,6 +4350,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 /**
  * mm_account_fault - Do page fault accountings
  * @regs: the pt_regs struct pointer.  When set to NULL, will skip accounting
+ *        of perf event counters, but we'll still do the per-task accounting to
+ *        the task who triggered this page fault.
  * @address: faulted address.
  * @major: whether this is a major fault.
  *
@@ -4365,16 +4367,18 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 static inline void mm_account_fault(struct pt_regs *regs,
 				    unsigned long address, bool major)
 {
+	if (major)
+		current->maj_flt++;
+	else
+		current->min_flt++;
+
 	if (!regs)
 		return;
 
-	if (major) {
-		current->maj_flt++;
+	if (major)
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	} else {
-		current->min_flt++;
+	else
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
 }
 
 /*
@@ -4447,8 +4451,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	 *    fault is VM_FAULT_MAJOR, or if it was a retry (which implies that
 	 *    we couldn't handle it immediately previously).
 	 *
-	 *  - If the fault is done for GUP, regs will be NULL and no accounting
-	 *    will be done.
+	 *  - If the fault is done for GUP, regs will be NULL and we only do
+	 *    the accounting for the per thread fault counters who triggered
+	 *    the fault, and we skip the perf event updates.
 	 */
 	mm_account_fault(regs, address, (ret & VM_FAULT_MAJOR) ||
 			 (flags & FAULT_FLAG_TRIED));
-- 
2.26.2

