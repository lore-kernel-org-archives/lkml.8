Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F13C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6E920724
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5LdkQic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgBMDLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:11:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40422 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgBMDLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:11:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so4314349oii.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 19:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8yL7iUZLlDcWI/hz8OXwlSrnW+RQAzQUw/NYymBX6Xg=;
        b=g5LdkQicWog5B/IhutWPsbAlMBNOVtHT+iHIggE1NmzAkvGYMo3XVtvDzMbvcclAQx
         HOzLo6ocZ40bWeLZwDMdsITnH6K5hq98fNPzsrucQPhIHZ8gHH9nnTkO2GPuXfoTZHOU
         ATUVfqfevRboK+XDtxQ04FrHy0dhMwY1aV/wsVo2TcOmVKU8phUlMyXavaxtNRSbu1vr
         orMRFwi/oE9JgXLqtRVPDR669S7sICwgwS3lB95DReN4nbBWYG9A44HWsHWEVOdNsxHG
         sODipyUDZgthIOc4Deiama0Rn30E0VJtFz6KJ3hm/Qnx75ZQu9X7RQv8FqQUrd4oyzzo
         XORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8yL7iUZLlDcWI/hz8OXwlSrnW+RQAzQUw/NYymBX6Xg=;
        b=PHwYOgqBiPCfQN6U+7dSYcaHcN6mMRWE/xnR7i/J8wsNTImgxX3oD7/J5lD3/SY2c5
         xjTB35Bifg06hmts9PiOd6HeiyKB0utFj/2ebm2QM+Ru6G1P9fjPunWY0DIA2zh2Pmy9
         HXHMqoQ9i3nOpBsuRF468u6NmHb8DsGuJBO+DQANMDuw+aua4r/Q3CLXqb2KrXPpvRsf
         O2Rzz8oGrVVbdEd5rioAkuxClQOvI0zsHS3d1M5tClogJAyAAMGXDX22kxQhyPLy0+2j
         lCrvFGh26e6oxeXLBLjoTGB41ZHRZeo4Cx5wMMgtcmwoR+RhCwQ5SZ0e9Gu5KlCusybc
         AQ6Q==
X-Gm-Message-State: APjAAAUjm8/ty9ygf2mFchQcrNZVzUE3UgVWm/pkYPR32W/LBhleOytQ
        Hcnqajeo7AtK4dsFzh1SsA==
X-Google-Smtp-Source: APXvYqwlCkCidibdWZXqORr5Z1LDxXrg1K9Z9Te7n583TI937al7BnaO+AEgibCe5jg2r6ePg2hMkQ==
X-Received: by 2002:aca:6542:: with SMTP id j2mr1569376oiw.69.1581563497381;
        Wed, 12 Feb 2020 19:11:37 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id n25sm317517oic.6.2020.02.12.19.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 19:11:36 -0800 (PST)
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:e166:6491:dd75:4196])
        by serve.minyard.net (Postfix) with ESMTPA id 779C9180054;
        Thu, 13 Feb 2020 03:11:36 +0000 (UTC)
From:   minyard@acm.org
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [RFC PATCH 1/2] arm64: Pass registers to all single-step handling routines
Date:   Wed, 12 Feb 2020 21:11:30 -0600
Message-Id: <20200213031131.13255-2-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213031131.13255-1-minyard@acm.org>
References: <20200213031131.13255-1-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Get ready to set the SS bit in the MDSCR register in the kernel restore
handler.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/arm64/include/asm/debug-monitors.h | 4 ++--
 arch/arm64/kernel/debug-monitors.c      | 4 ++--
 arch/arm64/kernel/hw_breakpoint.c       | 6 +++---
 arch/arm64/kernel/kgdb.c                | 6 +++---
 arch/arm64/kernel/probes/kprobes.c      | 4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7619f473155f..73ce974bf754 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -111,8 +111,8 @@ void user_rewind_single_step(struct task_struct *task);
 void user_fastforward_single_step(struct task_struct *task);
 
 void kernel_enable_single_step(struct pt_regs *regs);
-void kernel_disable_single_step(void);
-int kernel_active_single_step(void);
+void kernel_disable_single_step(struct pt_regs *regs);
+int kernel_active_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 48222a4760c2..2a0dfd8b1265 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -414,7 +414,7 @@ void kernel_enable_single_step(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(kernel_enable_single_step);
 
-void kernel_disable_single_step(void)
+void kernel_disable_single_step(struct pt_regs *regs)
 {
 	WARN_ON(!irqs_disabled());
 	mdscr_write(mdscr_read() & ~DBG_MDSCR_SS);
@@ -422,7 +422,7 @@ void kernel_disable_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_disable_single_step);
 
-int kernel_active_single_step(void)
+int kernel_active_single_step(struct pt_regs *regs)
 {
 	WARN_ON(!irqs_disabled());
 	return mdscr_read() & DBG_MDSCR_SS;
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 0b727edf4104..785c9a5060a6 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -682,7 +682,7 @@ static int breakpoint_handler(unsigned long unused, unsigned int esr,
 		if (*kernel_step != ARM_KERNEL_STEP_NONE)
 			return 0;
 
-		if (kernel_active_single_step()) {
+		if (kernel_active_single_step(regs)) {
 			*kernel_step = ARM_KERNEL_STEP_SUSPEND;
 		} else {
 			*kernel_step = ARM_KERNEL_STEP_ACTIVE;
@@ -825,7 +825,7 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 		if (*kernel_step != ARM_KERNEL_STEP_NONE)
 			return 0;
 
-		if (kernel_active_single_step()) {
+		if (kernel_active_single_step(regs)) {
 			*kernel_step = ARM_KERNEL_STEP_SUSPEND;
 		} else {
 			*kernel_step = ARM_KERNEL_STEP_ACTIVE;
@@ -882,7 +882,7 @@ int reinstall_suspended_bps(struct pt_regs *regs)
 			toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 1);
 
 		if (*kernel_step != ARM_KERNEL_STEP_SUSPEND) {
-			kernel_disable_single_step();
+			kernel_disable_single_step(regs);
 			handled_exception = 1;
 		} else {
 			handled_exception = 0;
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 43119922341f..220fe8fd6ace 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -200,8 +200,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		/*
 		 * Received continue command, disable single step
 		 */
-		if (kernel_active_single_step())
-			kernel_disable_single_step();
+		if (kernel_active_single_step(linux_regs))
+			kernel_disable_single_step(linux_regs);
 
 		err = 0;
 		break;
@@ -221,7 +221,7 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		/*
 		 * Enable single step handling
 		 */
-		if (!kernel_active_single_step())
+		if (!kernel_active_single_step(linux_regs))
 			kernel_enable_single_step(linux_regs);
 		err = 0;
 		break;
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d1c95dcf1d78..3082dfc3cd99 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -308,7 +308,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		if (!instruction_pointer(regs))
 			BUG();
 
-		kernel_disable_single_step();
+		kernel_disable_single_step(regs);
 
 		if (kcb->kprobe_status == KPROBE_REENTER)
 			restore_previous_kprobe(kcb);
@@ -415,7 +415,7 @@ kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
 
 	if (retval == DBG_HOOK_HANDLED) {
 		kprobes_restore_local_irqflag(kcb, regs);
-		kernel_disable_single_step();
+		kernel_disable_single_step(regs);
 
 		post_kprobe_handler(kcb, regs);
 	}
-- 
2.17.1

