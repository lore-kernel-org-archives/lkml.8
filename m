Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001DEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB957204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVUJchCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392194AbgFSQGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393096AbgFSQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdwEEPmGbF+7vaa9v+aN1XHbOlUdwOKUfmYW6uYEoCM=;
        b=XVUJchCF5SL4iK9FYjwn70nwK+ANnKDNE79CElxCw23wZL6BSGhXWHzmibdn+WylihlACY
        jIEn8q7XaEVqyf9KHpekSKbPzuZIBk8maoIOHbI/ldPtvELwco2XDOPRL1Nv4+eLiDBRUl
        goampSa3mgx7u67VP4b14voFCTMuoco=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-T9yWyH6HNRei7rC4nDIVUA-1; Fri, 19 Jun 2020 12:06:02 -0400
X-MC-Unique: T9yWyH6HNRei7rC4nDIVUA-1
Received: by mail-qk1-f199.google.com with SMTP id m29so7439262qkm.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdwEEPmGbF+7vaa9v+aN1XHbOlUdwOKUfmYW6uYEoCM=;
        b=bZSCoW7J8LVlGI6K+zDJ+wj0Vr8uKyd80UVUL6Tw9bZoLZmCJf3z0k5uaZ29aN1Ogc
         Dsmm1IkatR8fypFnk9kYTUMrQo/NLEJoCz70RsSXqWvIzOHfz4wBilTsXMpRCcA/TnbZ
         tQT6m9axZp1yK7Kv23X1wV9ea++9hkgQXxl08ASZcg4bwNIxz2AGdBI7HQ5AgHWDCobD
         TtyVQMxjBoFHEvXHu45Yze13OnmO+CGGmJetKiwWSl4sKwuFEg3KruRGQZuZNWL0NjMQ
         14R2RV5wSayqlPpV7NehRj9fbIVqyTRDfI6EJAnvLpo+YzY7BrtoMOoNAXNyxT16btgb
         t/5w==
X-Gm-Message-State: AOAM531qeAmHzXTb+qcxhEDxYpKtKshsxk+pyIFGa581jOhIHC9kMwVz
        c1r0/puTkXu7D14jl8JjxaqHOHOUL5slFHXpla4xty+EcJ3z/4pko2xU3bEcdt66HL5p/fMx0bK
        gqgzquZTrUjVT/+D+7LsFBHvq
X-Received: by 2002:ac8:fec:: with SMTP id f41mr1437123qtk.212.1592582760968;
        Fri, 19 Jun 2020 09:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8wG2GTQ9R1eiAtzaifkaB+aa3jdUijFfrRdNWsFEhdltAKDggKtTyb2MbmKOZqrM66lR9pA==
X-Received: by 2002:ac8:fec:: with SMTP id f41mr1437088qtk.212.1592582760619;
        Fri, 19 Jun 2020 09:06:00 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 11/26] mm/mips: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:23 -0400
Message-Id: <20200619160538.8641-12-peterx@redhat.com>
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

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux-mips@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/mm/fault.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 31c2afb8f8a5..750a4978a12b 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -96,6 +96,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -152,12 +154,11 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -168,15 +169,6 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-						  regs, address);
-			tsk->maj_flt++;
-		} else {
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-						  regs, address);
-			tsk->min_flt++;
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

