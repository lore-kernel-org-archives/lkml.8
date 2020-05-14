Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE60C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FD2206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgENOct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:32:49 -0400
Received: from foss.arm.com ([217.140.110.172]:37680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgENOcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:32:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC7641045;
        Thu, 14 May 2020 07:32:47 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF6423F71E;
        Thu, 14 May 2020 07:32:46 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/13] arm64: Allow passing fault address to fixup handlers
Date:   Thu, 14 May 2020 14:32:15 +0000
Message-Id: <20200514143227.605-2-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514143227.605-1-oli.swede@arm.com>
References: <20200514143227.605-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Tebbs <sam.tebbs@arm.com>

Extend fixup_exception() to optionally place the faulting address in a
register when returning to a fixup handler. Since A64 instructions must
be 4-byte-aligned, we can mimic the IA-64 implementation and encode a
flag in the lower bits of the offset field to indicate handlers which
expect an address. This will allow us to use more efficient offset
addressing modes in usercopy routines, rather than updating the base
register on every access just for the sake of inferring where a fault
occurred in order to compute the return value upon failure.

The choice of x15 is somewhat arbitrary, but with the consideration that
as the highest-numbered temporary register with no possible 'special'
role in the ABI, it is most likely not used by hand-written assembly
code, and thus a minimally-invasive option for imported routines.

Signed-off-by: Sam Tebbs <sam.tebbs@arm.com>
[ rm: split into separate patch, use UL(), expand commit message ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/include/asm/assembler.h |  9 +++++++++
 arch/arm64/include/asm/extable.h   | 10 +++++++++-
 arch/arm64/mm/extable.c            | 13 +++++++++----
 arch/arm64/mm/fault.c              |  2 +-
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bff325117b4..7017aeb4b29a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -18,6 +18,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/debug-monitors.h>
+#include <asm/extable.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -129,6 +130,14 @@ alternative_endif
 	.popsection
 	.endm
 
+/*
+ * Emit an entry into the exception table.
+ * The fixup handler will receive the faulting address in x15
+ */
+	.macro		_asm_extable_faultaddr, from, to
+	_asm_extable	\from, \to + FIXUP_WITH_ADDR
+	.endm
+
 #define USER(l, x...)				\
 9999:	x;					\
 	_asm_extable	9999b, l
diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 56a4f68b262e..4c4955f2bb44 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -2,6 +2,12 @@
 #ifndef __ASM_EXTABLE_H
 #define __ASM_EXTABLE_H
 
+#include <linux/const.h>
+
+#define FIXUP_WITH_ADDR UL(1)
+
+#ifndef __ASSEMBLY__
+
 /*
  * The exception table consists of pairs of relative offsets: the first
  * is the relative offset to an instruction that is allowed to fault,
@@ -22,5 +28,7 @@ struct exception_table_entry
 
 #define ARCH_HAS_RELATIVE_EXTABLE
 
-extern int fixup_exception(struct pt_regs *regs);
+extern int fixup_exception(struct pt_regs *regs, unsigned long addr);
+
+#endif
 #endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 81e694af5f8c..e6578c2814b5 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -6,13 +6,18 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 
-int fixup_exception(struct pt_regs *regs)
+int fixup_exception(struct pt_regs *regs, unsigned long addr)
 {
 	const struct exception_table_entry *fixup;
 
 	fixup = search_exception_tables(instruction_pointer(regs));
-	if (fixup)
-		regs->pc = (unsigned long)&fixup->fixup + fixup->fixup;
-
+	if (fixup) {
+		unsigned long offset = fixup->fixup;
+		if (offset & FIXUP_WITH_ADDR) {
+			regs->regs[15] = addr;
+			offset &= ~FIXUP_WITH_ADDR;
+		}
+		regs->pc = (unsigned long)&fixup->fixup + offset;
+	}
 	return fixup != NULL;
 }
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c9cedc0432d2..2c648343ab40 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -297,7 +297,7 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	 * Are we prepared to handle this kernel fault?
 	 * We are almost certainly not prepared to handle instruction faults.
 	 */
-	if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
+	if (!is_el1_instruction_abort(esr) && fixup_exception(regs, addr))
 		return;
 
 	if (WARN_RATELIMIT(is_spurious_el1_translation_fault(addr, esr, regs),
-- 
2.17.1

