Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3460FC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB00206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="aZhCifB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgD2Tdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2Tdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:33:49 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E470C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:49 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y185so2198918vsy.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5HPF6Z0rMyi2bCF2oi0vFekeJ3AwLJE6v7sjXb14H84=;
        b=aZhCifB3Nx6fTFoFfg/F6lIOYeNBPqt3mE9jLhuO2/s4F8aRLZ0pyDLbfb0IkftGhY
         uV6BECU7tw8pXVvUrZ7B2eOgUohtsw9/4wLEfzrDYxV3Qh9bK2ANG5Czs//gNzXleEwt
         gXLc/it3vv4SyMbUi31wvoSKqnR/RB6rh274WYqtinQjePhuaxRdho5dIErQm3b7FYtD
         FsLIm+jvvxgiv116JVi+6ILHP4gp/giPjLg6KUgFqvWA5IFkVmaSnxZNYgYuY8eGMAur
         ynQdYovjNDlXUjz/8VMWDdQd0/kTidgJhaNWxs41R/ahCs4fgzMQV2sHMH7il++MCdiF
         CA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5HPF6Z0rMyi2bCF2oi0vFekeJ3AwLJE6v7sjXb14H84=;
        b=AC+GV9hdEHR2ht3y0cSXSJNuan+pwd6F3iFI83TgsoQ+efGjCCa6gssZvFWerPei2x
         TvXh2F91YOha5mD3RbsTJROWwGx1TBz3NA1QRhlef2gWNwbRapvawHYKITG5exsDrYR5
         1Q0L6+9fp32p1ay5Z9317vpNF3sIVrBwHswhnwhLgyCpoI8OSVoZUnbGMLfsUKyagijn
         7tYkPBQJqHISVsiteLfyq+BC4Hh/P5mAURjozT6aytfmCZaxH/6RNv4XHPM78oQIRNFo
         Fw9+SL+ZfZd8wBbxUaSqtCguKJwo4ZktDCuO8v6JWH+JCNhNjw5HfB2EKgvFWZrvVMwM
         I7mA==
X-Gm-Message-State: AGi0PuaDKo1y7AsRrIMAlsSwCFxNfr9eWmvVIqJzoSL3pr14tGwZEHx/
        1IaRMaehRP/olHawk3lVzAU/zQ==
X-Google-Smtp-Source: APiQypKnVMHy9aKgeY7NmXdHAKJuSnbwtCUFWzAvGpSZi8wUdq0qT6h6figSPGr8oW517AKEv2ZKEw==
X-Received: by 2002:a67:ffcf:: with SMTP id w15mr4870592vsq.213.1588188828318;
        Wed, 29 Apr 2020 12:33:48 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:33:47 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 2/9] Add x86 specifc files for Popcorn
Date:   Wed, 29 Apr 2020 15:32:49 -0400
Message-Id: <fdc78e01527580f635640549f8064871f8178a19.1588127445.git.javier.malave@narfindustries.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <0>
 <cover.1588127445.git.javier.malave@narfindustries.com>
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <cover.1588127445.git.javier.malave@narfindustries.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Popcorn Linux is a Linux kernel-based software stack
that enables applications to execute, with a shared
source base, on distributed hosts.

This Popcorn patch adds x86_64 functionality only. 
Future iterations of Popcorn will support
heterogeneous architectures.
---
 arch/x86/Kconfig               |  3 +++
 arch/x86/include/asm/pgtable.h | 11 +++++++++++
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/mm/fault.c            | 18 ++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1b..4ca75c6c3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -88,6 +88,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_POPCORN	if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
@@ -353,6 +354,8 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
+source "kernel/Kconfig.popcorn"
+
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5e0509b41..7a0171c67 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -210,9 +210,13 @@ static inline u64 protnone_mask(u64 val);
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
+#ifdef CONFIG_POPCORN
+	return (pte_val(pte) & PTE_PFN_MASK) >> PAGE_SHIFT;
+#else
 	phys_addr_t pfn = pte_val(pte);
 	pfn ^= protnone_mask(pfn);
 	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
+#endif
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
@@ -602,7 +606,11 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
+#ifndef CONFIG_POPCORN
 	pteval_t val = pte_val(pte), oldval = val;
+#else
+	pteval_t val = pte_val(pte);
+#endif
 
 	/*
 	 * Chop off the NX bit (if present), and add the NX portion of
@@ -610,8 +618,11 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 */
 	val &= _PAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
+#ifndef CONFIG_POPCORN
 	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
+#endif
 	return __pte(val);
+
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index ce1b5cc36..3fb863285 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_EFI)			+= sysfb_efi.o
 
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
+obj-$(CONFIG_POPCORN)		+= process_server.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_INTEL_UMIP)		+= umip.o
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46df4c6aa..14b9755f9 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -33,6 +33,11 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#include <popcorn/vma_server.h>
+#endif
+
 /*
  * Returns 0 if mmiotrace is disabled, or if the fault is not
  * handled by mmiotrace:
@@ -1416,6 +1421,19 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	vma = find_vma(mm, address);
+#ifdef CONFIG_POPCORN
+	/* vma worker should not fault */
+	BUG_ON(tsk->is_worker);
+
+	if (distributed_remote_process(tsk)) {
+		if (!vma || vma->vm_start > address) {
+			if (vma_server_fetch_vma(tsk, address) == 0) {
+				/* Replace with updated VMA */
+				vma = find_vma(mm, address);
+			}
+		}
+	}
+#endif
 	if (unlikely(!vma)) {
 		bad_area(regs, hw_error_code, address);
 		return;
-- 
2.17.1

