Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFD5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691E9207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkSwJskz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgFOWXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726600AbgFOWXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqMMZBxWd6hyp1UyBnh6ZHWn/4PP621jPkJ/KevHqC4=;
        b=LkSwJskzxhQTpDytVNw3zgB1icmsVUgIwaE9bUYOvz9pPndNDqxWr0AeeKUoOwr1oATXMb
        f8DUnMBIvJ7uHCcIXpDoDFYGZXuFTlonEc3JtK1qgX6uqkZfa3wFLUGEsTq2f49UFL8MOY
        K4Gqm4m44bx03XRZZHevUsfwkFvIagM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-14OBBdaOMpm4a5tNY-JNoQ-1; Mon, 15 Jun 2020 18:23:21 -0400
X-MC-Unique: 14OBBdaOMpm4a5tNY-JNoQ-1
Received: by mail-qk1-f200.google.com with SMTP id q82so733222qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqMMZBxWd6hyp1UyBnh6ZHWn/4PP621jPkJ/KevHqC4=;
        b=Yw/HynYa2K6aTo9QkmFxpDslzemS2/w7OxibXr0j/aOUeiyK5hs+HPd9xto8TovZtN
         O6JGYWPEa5yd/s5q+TjIoSAwO6uVo3aUngiJPcLUTA2Nwxltry6UQdhAoVhmJKJd8+sb
         4145AVjMgmZxczF+YnZfhtUfUNh9K9qEH6r+HJnLl0zsHyNQTUrg2/L3YIzNrseg7pkC
         HM73ZeVjPSt4skcfHcnmw7vP8fitaysHgZ1irMFDlRzSnSJVzwGd3GBE9rlRwgwF8JQ3
         oySUfK1bxODHpWK3jYl/QXVsDnRWoUhoNn7FEwybm/YzcwNnBhkehU5TSEjngMdKoQof
         2UNw==
X-Gm-Message-State: AOAM533TILEK7EHedY957BEsCrri1J2/MuyqEJkK1eU+KsGQXl5BNGnR
        TOYDP9iXEtVpqXz1tSzVMF/ZznRwBgLJ22qK4Zl82tRbzGUiXNXL8Z+ukx7R8CLGPCM8hw2p2q6
        MqOaCzwY4DrgxFAjybpZ9Rrkk
X-Received: by 2002:ac8:7303:: with SMTP id x3mr17706237qto.44.1592259800799;
        Mon, 15 Jun 2020 15:23:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSUb5XIZHW5E1zJcz4VzqFpZD90tEroXjdCFUGU0zNGGOM8YwfFLC116uqeodWPbF2zjxDTA==
X-Received: by 2002:ac8:7303:: with SMTP id x3mr17706219qto.44.1592259800592;
        Mon, 15 Jun 2020 15:23:20 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b24sm12209333qkj.0.2020.06.15.15.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:23:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH 22/25] mm/sparc64: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:23:19 -0400
Message-Id: <20200615222319.8601-1-peterx@redhat.com>
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

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_64.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index c0c0dd471b6b..61be0a0d79c6 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -269,7 +269,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	struct vm_area_struct *vma;
 	unsigned int insn = 0;
 	int si_code, fault_code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned long address, mm_rss;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
@@ -317,8 +317,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	if (faulthandler_disabled() || !mm)
 		goto intr_or_no_mm;
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		if ((regs->tstate & TSTATE_PRIV) &&
 		    !search_exception_tables(regs->tpc)) {
@@ -424,6 +422,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	}
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
@@ -439,15 +438,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
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
 
@@ -461,6 +451,8 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	}
 	up_read(&mm->mmap_sem);
 
+	mm_fault_accounting(current, regs, address, major);
+
 	mm_rss = get_mm_rss(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	mm_rss -= (mm->context.thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
-- 
2.26.2

