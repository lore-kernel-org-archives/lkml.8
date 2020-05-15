Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1064C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1152073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563697;
	bh=p66GI+uTo7YFHULVF+gV8GMNJV+n4qtI5rkkXvHNSgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bizfj2QDkovnIG0RHRAIR9wx9PF+qhzloa7YCdlL1cKbqMksgMtPYzz5hrXw7xXkx
	 VI87EALWMPMza8nOP13+zf2o/Dxe5o1mXFD/5qPmLW267BDwvf0EpYA6K2nLl9He7m
	 X6LPfPFWMxz0Rbg6SkLv/Zj4nDAbkagiQglbprRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgEOR2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgEOR2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:28:13 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 664B420756;
        Fri, 15 May 2020 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563693;
        bh=p66GI+uTo7YFHULVF+gV8GMNJV+n4qtI5rkkXvHNSgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzT4gx/SEvgCF35wdoC8o12qutuMXLDyvFTvlIapI95GJch+y536OIiJeafpy7ktV
         PRPft1PnSAwuL2gnIi72NGdVmAEKyRUHbLwyjtFw1nqHf+WMWjtRXfcEwPQMuppVGS
         OgLKeU41E1vqgbhfujljiGor4MjYsDSlaKhIKjFk=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: [PATCH 3/6] arm64: scs: Use 'scs_sp' register alias for x18
Date:   Fri, 15 May 2020 18:27:53 +0100
Message-Id: <20200515172756.27185-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172756.27185-1-will@kernel.org>
References: <20200515172756.27185-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x18 holds the SCS stack pointer value, so introduce a register alias to
make this easier to read in assembly code.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/scs.h |  6 ++++--
 arch/arm64/kernel/entry.S    | 10 +++++-----
 arch/arm64/kernel/head.S     |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index 6b8cf4352fe3..d46efdd2060a 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -7,12 +7,14 @@
 #include <asm/asm-offsets.h>
 
 #ifdef CONFIG_SHADOW_CALL_STACK
+	scs_sp	.req	x18
+
 	.macro scs_load tsk, tmp
-	ldr	x18, [\tsk, #TSK_TI_SCS_SP]
+	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 
 	.macro scs_save tsk, tmp
-	str	x18, [\tsk, #TSK_TI_SCS_SP]
+	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 #else
 	.macro scs_load tsk, tmp
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index cb0516e6f963..741faf0706f1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -394,7 +394,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	.macro	irq_stack_entry
 	mov	x19, sp			// preserve the original sp
 #ifdef CONFIG_SHADOW_CALL_STACK
-	mov	x24, x18		// preserve the original shadow stack
+	mov	x24, scs_sp		// preserve the original shadow stack
 #endif
 
 	/*
@@ -416,7 +416,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 	/* also switch to the irq shadow stack */
-	adr_this_cpu x18, irq_shadow_call_stack, x26
+	adr_this_cpu scs_sp, irq_shadow_call_stack, x26
 #endif
 
 9998:
@@ -430,7 +430,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	.macro	irq_stack_exit
 	mov	sp, x19
 #ifdef CONFIG_SHADOW_CALL_STACK
-	mov	x18, x24
+	mov	scs_sp, x24
 #endif
 	.endm
 
@@ -1071,9 +1071,9 @@ SYM_CODE_START(__sdei_asm_handler)
 #ifdef CONFIG_SHADOW_CALL_STACK
 	/* Use a separate shadow call stack for normal and critical events */
 	cbnz	w4, 3f
-	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_normal, tmp=x6
+	adr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_normal, tmp=x6
 	b	4f
-3:	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_critical, tmp=x6
+3:	adr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_critical, tmp=x6
 4:
 #endif
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2b01c19c5483..1293baddfd20 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -426,7 +426,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	mov	x29, sp
 
 #ifdef CONFIG_SHADOW_CALL_STACK
-	adr_l	x18, init_shadow_call_stack	// Set shadow call stack
+	adr_l	scs_sp, init_shadow_call_stack	// Set shadow call stack
 #endif
 
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
-- 
2.26.2.761.g0e0b3e54be-goog

