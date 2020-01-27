Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D5AC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76706214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgA0JuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:50:17 -0500
Received: from foss.arm.com ([217.140.110.172]:41932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgA0JuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:50:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5390731B;
        Mon, 27 Jan 2020 01:50:16 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF42C3F52E;
        Mon, 27 Jan 2020 01:50:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Drop do_el0_ia_bp_hardening() & do_sp_pc_abort() declarations
Date:   Mon, 27 Jan 2020 15:19:35 +0530
Message-Id: <1580118575-1705-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a redundant do_sp_pc_abort() declaration in exceptions.h which can
be removed. Also do_el0_ia_bp_hardening() as been already been dropped with
the commit bfe298745afc ("arm64: entry-common: don't touch daif before
bp-hardening") and hence does not need a declaration any more. This should
not introduce any functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/exception.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index b87c6e276ab1..7a6e81ca23a8 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -33,7 +33,6 @@ static inline u32 disr_to_esr(u64 disr)
 
 asmlinkage void enter_from_user_mode(void);
 void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
-void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 void do_undefinstr(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
@@ -47,7 +46,4 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr);
 void do_cp15instr(unsigned int esr, struct pt_regs *regs);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
-void do_el0_ia_bp_hardening(unsigned long addr,  unsigned int esr,
-			    struct pt_regs *regs);
-
 #endif	/* __ASM_EXCEPTION_H */
-- 
2.20.1

