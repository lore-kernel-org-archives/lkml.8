Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ACC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A183F20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqMRzY9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFZWb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbgFZWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5CO9Ioy3aEI+rpepvYK9awRSU/1xBbKoMWw19CoOCA=;
        b=YqMRzY9UmmivSqNJwor9lHlPZtmLoum/hrb1+qoist/75KZ9HWiyTzALtNGy43c42gmlvE
        Uws11V9xL1kryZArO0OsTroIffFJYNMhk/IdbMC/b5vddvjGSHLzZ8YLKiRAcRkDHn4UNB
        7nFouGXzayc6wHfjOmZ0iD8VqOS87Kk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-H5sRQd4kMkymK3afXS9faA-1; Fri, 26 Jun 2020 18:31:51 -0400
X-MC-Unique: H5sRQd4kMkymK3afXS9faA-1
Received: by mail-qk1-f200.google.com with SMTP id k1so4412512qko.14
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5CO9Ioy3aEI+rpepvYK9awRSU/1xBbKoMWw19CoOCA=;
        b=M+wVXtGoBpKYeGdTqi9gZwkatgDqQuwyBxw5cLdFwVL3Y+HyaaAJMe5xwuIjrUq1Vm
         05ZjubWBkntE7EFh+OlHr3H05PrkS45NkLa8SHT8eIPJ5eguZsAxzRTP3Zoba3JTpkz1
         HQqmiYLogcv/vNA91CkuQvdIlTlcN433cA4tT+8MrTlCiYNHaP5Dah4AqPF60HBvG5HH
         T4rqU932hdX3qeuwnOMpJL81juOuMZxmPyUR83NSy3rEZsLoCP34Rd2aqMRFPYcMPO9t
         gcu3abb2tGVzkKstSe/8UYyikVJ79cyVwCEvsSJM5C2pe6ymiPbjCk+5nkJKbUTT7Dy/
         sQ8w==
X-Gm-Message-State: AOAM5328sN5pmXr4LsMs9xt8iF/k718f+GVgky4cNUqcBvK0ukdFWsRw
        l9xDx0KCINH1vDkWXaII53cfmWN0nohCDWqsyCAWt9eeNrK10zTIT8/eIPIrwv2FFfATJF4UvwK
        pr/+qmA0Nbt1UOCuIRzjzMa6L
X-Received: by 2002:ac8:1bad:: with SMTP id z42mr5330181qtj.110.1593210710386;
        Fri, 26 Jun 2020 15:31:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx55mkHv5JA7KsCjLa9A+G8OruKBcVHC68/qR9rih5tmrLSf1Prppo2YVIg8T1r9n5+R3Awzw==
X-Received: by 2002:ac8:1bad:: with SMTP id z42mr5330160qtj.110.1593210710153;
        Fri, 26 Jun 2020 15:31:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 11/26] mm/mips: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:15 -0400
Message-Id: <20200626223130.199227-12-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
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
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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

