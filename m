Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F82C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876AE205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgEMPmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:42:06 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56017 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:42:04 -0400
X-Originating-IP: 84.210.220.251
Received: from [192.168.1.123] (cm-84.210.220.251.getinternet.no [84.210.220.251])
        (Authenticated sender: fredrik@strupe.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 57A3BC0002;
        Wed, 13 May 2020 15:41:59 +0000 (UTC)
From:   Fredrik Strupe <fredrik@strupe.net>
Subject: [RFC PATCH] arm: Don't trap conditional UDF instructions
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>
Message-ID: <b2042f19-9477-272c-0989-d6cab1572cca@strupe.net>
Date:   Wed, 13 May 2020 17:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is more of a question than a patch, but I hope the attached patch makes
the issue a bit clearer.

The arm port of Linux supports hooking/trapping of undefined instructions. Some
parts of the code use this to trap UDF instructions with certain immediates in
order to use them for other purposes, like 'UDF #16' which is equivalent to a
BKPT instruction in A32.

Moreover, most of the undef hooks on UDF instructions assume that UDF is
conditional and mask out the condition prefix during matching. The attached
patch shows the locations where this happens. However, the Arm architecture
reference manual explicitly states that UDF is *not* conditional, making
any instruction encoding with a condition prefix other than 0xe (always
execute) unallocated.

My question is whether trapping invalid UDF instructions is intentional or
rather a bug resulting from an oversight. While the unallocated instructions
are not used for anything else and trapping them in addition to the legal UDF
probably doesn't hurt, it seems to be slightly inconsistent with the ISA
specification.

Sort of related, when looking for these kind of traps I came over the following
code in arch/arm/probes/uprobes/core.c:

    bpinsn = UPROBE_SWBP_ARM_INSN & 0x0fffffff;
    if (insn >= 0xe0000000)
        bpinsn |= 0xe0000000;  /* Unconditional instruction */
    else
        bpinsn |= insn & 0xf0000000;  /* Copy condition from insn */

    auprobe->bpinsn = bpinsn;

Where UPROBE_SWBP_ARM_INSN is equal to the encoding of 'UDF #25'. I might be
mistaken, but it seems like the condition of the UDF instruction is set from
another instruction with the expectation that it will execute conditionally,
which is not the case in practice.

While the above code is not directly related to the code in the patch and
possibly a more clear-cut bug, it might indicate that the conditional UDF
hooks also stem from a slight misunderstanding.

So just to reiterate the question: is trapping UDF instructions with invalid
condition prefixes considered a bug or not?

Thanks,
Fredrik

---
UDF instructions with a conditional prefix other than 0xe (always
execute) are unallocated as opposed to permanently undefined. They
should therefore not be used for instruction hooking/trapping.

Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
---
 arch/arm/kernel/ptrace.c       |  6 +++---
 arch/arm/probes/kprobes/core.c |  2 +-
 arch/arm/probes/kprobes/core.h |  2 +-
 arch/arm/probes/uprobes/core.c | 16 +++++++---------
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index b606cded90cd..a425691a41ad 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -50,7 +50,7 @@
  * reference manual guarantees that the following instruction space
  * will produce an undefined instruction exception on all CPUs:
  *
- *  ARM:   xxxx 0111 1111 xxxx xxxx xxxx 1111 xxxx
+ *  ARM:   1110 0111 1111 xxxx xxxx xxxx 1111 xxxx
  *  Thumb: 1101 1110 xxxx xxxx
  */
 #define BREAKINST_ARM	0xe7f001f0
@@ -211,8 +211,8 @@ static int break_trap(struct pt_regs *regs, unsigned int instr)
 }
 
 static struct undef_hook arm_break_hook = {
-	.instr_mask	= 0x0fffffff,
-	.instr_val	= 0x07f001f0,
+	.instr_mask	= 0xffffffff,
+	.instr_val	= 0xe7f001f0,
 	.cpsr_mask	= PSR_T_BIT,
 	.cpsr_val	= 0,
 	.fn		= break_trap,
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 90b5bc723c83..77b8baa6638f 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -525,7 +525,7 @@ static struct undef_hook kprobes_thumb32_break_hook = {
 #else  /* !CONFIG_THUMB2_KERNEL */
 
 static struct undef_hook kprobes_arm_break_hook = {
-	.instr_mask	= 0x0fffffff,
+	.instr_mask	= 0xffffffff,
 	.instr_val	= KPROBE_ARM_BREAKPOINT_INSTRUCTION,
 	.cpsr_mask	= MODE_MASK,
 	.cpsr_val	= SVC_MODE,
diff --git a/arch/arm/probes/kprobes/core.h b/arch/arm/probes/kprobes/core.h
index c3db468650ce..ee77ae553690 100644
--- a/arch/arm/probes/kprobes/core.h
+++ b/arch/arm/probes/kprobes/core.h
@@ -18,7 +18,7 @@
  * These undefined instructions must be unique and
  * reserved solely for kprobes' use.
  */
-#define KPROBE_ARM_BREAKPOINT_INSTRUCTION	0x07f001f8
+#define KPROBE_ARM_BREAKPOINT_INSTRUCTION	0xe7f001f8
 #define KPROBE_THUMB16_BREAKPOINT_INSTRUCTION	0xde18
 #define KPROBE_THUMB32_BREAKPOINT_INSTRUCTION	0xf7f0a018
 
diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index c4b49b322e8a..f574356284f4 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -22,8 +22,7 @@
 
 bool is_swbp_insn(uprobe_opcode_t *insn)
 {
-	return (__mem_to_opcode_arm(*insn) & 0x0fffffff) ==
-		(UPROBE_SWBP_ARM_INSN & 0x0fffffff);
+	return __mem_to_opcode_arm(*insn) == UPROBE_SWBP_ARM_INSN;
 }
 
 int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
@@ -186,10 +185,9 @@ static int uprobe_trap_handler(struct pt_regs *regs, unsigned int instr)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	instr &= 0x0fffffff;
-	if (instr == (UPROBE_SWBP_ARM_INSN & 0x0fffffff))
+	if (instr == UPROBE_SWBP_ARM_INSN)
 		uprobe_pre_sstep_notifier(regs);
-	else if (instr == (UPROBE_SS_ARM_INSN & 0x0fffffff))
+	else if (instr == UPROBE_SS_ARM_INSN)
 		uprobe_post_sstep_notifier(regs);
 	local_irq_restore(flags);
 
@@ -202,16 +200,16 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 }
 
 static struct undef_hook uprobes_arm_break_hook = {
-	.instr_mask	= 0x0fffffff,
-	.instr_val	= (UPROBE_SWBP_ARM_INSN & 0x0fffffff),
+	.instr_mask	= 0xffffffff,
+	.instr_val	= UPROBE_SWBP_ARM_INSN,
 	.cpsr_mask	= MODE_MASK,
 	.cpsr_val	= USR_MODE,
 	.fn		= uprobe_trap_handler,
 };
 
 static struct undef_hook uprobes_arm_ss_hook = {
-	.instr_mask	= 0x0fffffff,
-	.instr_val	= (UPROBE_SS_ARM_INSN & 0x0fffffff),
+	.instr_mask	= 0xffffffff,
+	.instr_val	= UPROBE_SS_ARM_INSN,
 	.cpsr_mask	= MODE_MASK,
 	.cpsr_val	= USR_MODE,
 	.fn		= uprobe_trap_handler,
-- 
2.20.1

