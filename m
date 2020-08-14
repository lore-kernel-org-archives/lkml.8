Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C73C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B3820708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0yRjS8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgHNR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgHNR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:15 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EE3C061386
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:14 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l18so6471301qvq.16
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E0RrGh1M0jqaaDoEOkU8MvQi4g07cx9su4pS9IT1SWw=;
        b=J0yRjS8wAi98SLl40BtGkKwGJXb87bHWptPKQUee0Z7i8RnowmsAsnTsSSGI/mRVKG
         /jBE+O/OM0IlfTDa5WKWGDVszoGwgZAxqhir2+UYOvzVv0T0kxYGs89EIVE3j7zvDcQP
         GPQ1zisFX3ghoL4cEwaGUe+RAIqE8fE978O2GWSaMwrA6JP4uyHCDH6oudvPU+qzrFnK
         s/DztyfYwRhXAGuuuDUHlU5qU/ik0sNsoQCOVLC2aU7SaX6rXyrlmEfq6jLz9760Mo/W
         YzyxoAF7tuNY/jCOHcxGNwqQSk8KoNiASEdIQr3iycLeHaTqYkXL/Uqo8uXoj1mabJku
         9Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E0RrGh1M0jqaaDoEOkU8MvQi4g07cx9su4pS9IT1SWw=;
        b=pOgMdZf0rxAYThQcinx/6bM0wIlz8gfs8hLWdt3g0tDwrlyhvxrXWSjDA5cJtZMHsk
         UL5H5C8k2Vm3a+LykSSh2glOI+AdvGeRyyDjp+zuKU0zf4L2P/Z1CpSQn8iWNvueu1aV
         cLfgVrXSRxm7Kv/Zarf0HHLCPfTzirxArEvUV9GKUPWyZDRZGgmLKglhUhNrz9axJdY/
         EIGwvvD0Zj30KUXMRN0dFtv8a367bfVXGatOVCdRbkeHtTN9OG6uRzeGx/llJ5YdQCuu
         XNRIJxyRyWe5Xzs+K82rSMVvEpwXIvHjWwMd/uzKHvBYUrQntst0hDAeHavEPjQ7oxSj
         ugig==
X-Gm-Message-State: AOAM532SpGHnoX93dUHcCI6hQ3pLYe8BSX0ldHeDWADjIt0AvjPtvNC9
        Z4H2dQh4Lwg0bAv6LjWfpctlgBbnv9CwM4JO
X-Google-Smtp-Source: ABdhPJy3SdR9WMFOSxqndhovcLxyBqUrrg3mnD1AcV1Kt+RAUKx381UmFBB5e6t6uAgctFxBWyRwguDJG3EOOPOZ
X-Received: by 2002:a0c:9a0c:: with SMTP id p12mr3610073qvd.75.1597426093874;
 Fri, 14 Aug 2020 10:28:13 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:03 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <f173aacd755e4644485c551198549ac52d1eb650.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 21/35] arm64: mte: Add in-kernel tag fault handler
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add the implementation of the in-kernel fault handler.

When a tag fault happens on a kernel address:
* a warning is logged,
* the faulting instruction is skipped,
* the execution continues.

When a tag fault happens on a user address:
* the kernel executes do_bad_area() and panics.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 50 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5e832b3387f1..c62c8ba85c0e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -33,6 +33,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/kprobes.h>
+#include <asm/mte.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
@@ -222,6 +223,20 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	return 1;
 }
 
+static bool is_el1_mte_sync_tag_check_fault(unsigned int esr)
+{
+	unsigned int ec = ESR_ELx_EC(esr);
+	unsigned int fsc = esr & ESR_ELx_FSC;
+
+	if (ec != ESR_ELx_EC_DABT_CUR)
+		return false;
+
+	if (fsc == ESR_ELx_FSC_MTE)
+		return true;
+
+	return false;
+}
+
 static bool is_el1_instruction_abort(unsigned int esr)
 {
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_CUR;
@@ -294,6 +309,18 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	do_exit(SIGKILL);
 }
 
+static void report_tag_fault(unsigned long addr, unsigned int esr,
+			     struct pt_regs *regs)
+{
+	bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
+
+	pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
+	pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
+	pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
+			mte_get_ptr_tag(addr),
+			mte_get_mem_tag((void *)addr));
+}
+
 static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
@@ -317,12 +344,16 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 			msg = "execute from non-executable memory";
 		else
 			msg = "read from unreadable memory";
+	} else if (is_el1_mte_sync_tag_check_fault(esr)) {
+		report_tag_fault(addr, esr, regs);
+		msg = "memory tagging extension fault";
 	} else if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
 	} else {
 		msg = "paging request";
 	}
 
+
 	die_kernel_fault(msg, addr, esr, regs);
 }
 
@@ -658,10 +689,27 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 0;
 }
 
+static int do_tag_recovery(unsigned long addr, unsigned int esr,
+			   struct pt_regs *regs)
+{
+	report_tag_fault(addr, esr, regs);
+
+	/* Skip over the faulting instruction and continue: */
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+
+	return 0;
+}
+
+
 static int do_tag_check_fault(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
-	do_bad_area(addr, esr, regs);
+	/* The tag check fault (TCF) is per TTBR */
+	if (is_ttbr0_addr(addr))
+		do_bad_area(addr, esr, regs);
+	else
+		do_tag_recovery(addr, esr, regs);
+
 	return 0;
 }
 
-- 
2.28.0.220.ged08abb693-goog

