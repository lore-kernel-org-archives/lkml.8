Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B31C54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887AF2495E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172815;
	bh=gpPTyRYEHCVUZzxNy70fQ1duYwfPpzkaeocUDOMazW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YiSANmJ/FVJF9W6+pl27df3C+VV+Da8j1znsBLbzH4oDy73+Vhe1qSmQO7HsU32X7
	 hoAjP9zWzAVjUt8t51NVrPGfBWQB5rw8ocPUQo1aWi7VGKTdaFPRQWHuICJM4Nnbdq
	 PKCep3ZTMijJlnVlGa5dGwtts8HjwqwPILXfpuMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgEKExe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgEKExc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3766B24953;
        Mon, 11 May 2020 04:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172812;
        bh=gpPTyRYEHCVUZzxNy70fQ1duYwfPpzkaeocUDOMazW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4of81+qAjATUEZZNxQfMtf6JEGravhTuY0P01z2C4v5sYQYsJF+NVfiSAJkH/5+a
         3y/SFAIjoASSfQPmB4BB3y0MDO9DqAxAiBFLcO7oAoojbZcrGFp2wajOf+p/hC1DzT
         lyrhgkYmH9+4ejSmM+FXVzeQE9jAErJhvRp/H+Lc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH v12 04/18] x86/entry/64: Clean up paranoid exit
Date:   Mon, 11 May 2020 00:52:57 -0400
Message-Id: <20200511045311.4785-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

All that paranoid exit needs to do is to disable IRQs, handle IRQ tracing,
then restore CR3, and restore GS base. Simply do those actions in that
order. Cleaning up the spaghetti code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/x86/entry/entry_64.S | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3063aa9090f9a..0da56e6791b73 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1266,19 +1266,25 @@ SYM_CODE_END(paranoid_entry)
 SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
+
+	/*
+	 * The order of operations is important. IRQ tracing requires
+	 * kernel GS base and CR3. RESTORE_CR3 requires kernel GS base.
+	 *
+	 * NB to anyone to try to optimize this code: this code does
+	 * not execute at all for exceptions from user mode. Those
+	 * exceptions go through error_exit instead.
+	 */
 	TRACE_IRQS_OFF_DEBUG
-	testl	%ebx, %ebx			/* swapgs needed? */
-	jnz	.Lparanoid_exit_no_swapgs
-	TRACE_IRQS_IRETQ
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+
+	/* If EBX is 0, SWAPGS is required */
+	testl	%ebx, %ebx
+	jnz	restore_regs_and_return_to_kernel
+
+	/* We are returning to a context with user GS base */
 	SWAPGS_UNSAFE_STACK
 	jmp	restore_regs_and_return_to_kernel
-.Lparanoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ_DEBUG
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
-	jmp restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
 /*
-- 
2.20.1

