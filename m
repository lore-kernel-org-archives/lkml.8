Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D01C433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63132075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBmHeJDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgGGWuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729647AbgGGWur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WN5suCL4vjaI1eJdzhaIBmykla0j2zqu4dhyFqEqPg=;
        b=gBmHeJDcP2rQXAIvxrzw/WcRefKYoj4avjpqytUVov3IlENakF5HLkgz+Fup4ocBAgc/pu
        mL1inroDDU0rreBIPtyPkBP73PJQC132TbijwInYUd6ENmXuxEtiuvcSZun0veOF9jsHpR
        0zJUTmqm9CD75Hz3PrlXYAXnmWpAP1o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-eaO1B_LsMp203hxRwzWRfg-1; Tue, 07 Jul 2020 18:50:44 -0400
X-MC-Unique: eaO1B_LsMp203hxRwzWRfg-1
Received: by mail-qk1-f198.google.com with SMTP id a205so29579279qkc.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WN5suCL4vjaI1eJdzhaIBmykla0j2zqu4dhyFqEqPg=;
        b=Pr2f68Da5Up2q75savsfh4EsYtf5ND86gm4T7y3LRilH84ivLpyUzSMDcGdDEhi/xE
         AVgtSiV9gxK2bLLWY3ugM1PzGbAF+X/FjGwd25mkTaXHsZ+yDXfc43QmUAa+HF+wdHmF
         XaF1Qmv/o3ZkdNuQ36DuaGRs4vs92SHrolTrgFsQlSmliynWdsZqsN7p2kZwG6tZllo1
         BgfAwKYTaBrFaTpyx5ljWLblpzqZ9EwduzqCNvvHwy3K4d1HCKQPXSJmqJQ647dIQOkq
         DSF+o2+85K2O2D24UBCGU2eHv3ljkyXq9FkCoYFtuR1afmAkKu6tLW0hDsdoyYalxB6V
         PiXQ==
X-Gm-Message-State: AOAM533DwRxC0QyJaLE4+E3KJPcUzliY2qz+yRoKzA3xLAmDbUDZ4WJj
        RMinKIEg/A/KrMjWlm6EtLOCrbqYs1zeKZSbcGjFBC94mhMg1RHNYFm/LGF9gw+/lsEg+Uj4aqb
        HBKLtZ6U3izPQT1aj9dzHRwvO
X-Received: by 2002:ad4:5912:: with SMTP id ez18mr44655477qvb.24.1594162243936;
        Tue, 07 Jul 2020 15:50:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCsUVFm5+NKahCqT/VXt5L+qHNyxIcGiPL88zMsimW5b6qIOMZxSStxnN8FyeLMPOOGmbLRQ==
X-Received: by 2002:ad4:5912:: with SMTP id ez18mr44655458qvb.24.1594162243712;
        Tue, 07 Jul 2020 15:50:43 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:43 -0700 (PDT)
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
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH v5 12/25] mm/nds32: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:08 -0400
Message-Id: <20200707225021.200906-13-peterx@redhat.com>
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

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Nick Hu <nickhu@andestech.com>
CC: Greentime Hu <green.hu@gmail.com>
CC: Vincent Chen <deanbo422@gmail.com>
Acked-by: Greentime Hu <green.hu@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nds32/mm/fault.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index d0ecc8fb5b23..f02524eb6d56 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -121,6 +121,8 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	if (unlikely(faulthandler_disabled() || !mm))
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -206,7 +208,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -228,22 +230,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 			goto bad_area;
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the initial
-	 * attempt. If we go through a retry, it is extremely likely that the
-	 * page will be found in page cache at that point.
-	 */
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
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

