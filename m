Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA2320849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgESUCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgEST6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79BC08C5C2;
        Tue, 19 May 2020 12:58:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nj-0008Hl-Cr; Tue, 19 May 2020 21:58:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9097E1C047E;
        Tue, 19 May 2020 21:58:27 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:27 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/int3: Ensure that poke_int3_handler() is not traced
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135313.410702173@linutronix.de>
References: <20200505135313.410702173@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830750.17951.7543501617936016455.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     819f5f8cfbcf3c143ef2ca7a674cec3702ab3807
Gitweb:        https://git.kernel.org/tip/819f5f8cfbcf3c143ef2ca7a674cec3702ab3807
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Jan 2020 15:53:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:04 +02:00

x86/int3: Ensure that poke_int3_handler() is not traced

In order to ensure poke_int3_handler() is completely self contained -- this
is called while modifying other text, imagine the fun of hitting another
INT3 -- ensure that everything it uses is not traced.

The primary means here is to force inlining; bsearch() is notrace because
all of lib/ is.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135313.410702173@linutronix.de


---
 arch/x86/include/asm/ptrace.h        |  2 +-
 arch/x86/include/asm/text-patching.h | 11 +++++++----
 arch/x86/kernel/alternative.c        | 13 ++++++-------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6d6475f..ebedeab 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -123,7 +123,7 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
  * On x86_64, vm86 mode is mercifully nonexistent, and we don't need
  * the extra check.
  */
-static inline int user_mode(struct pt_regs *regs)
+static __always_inline int user_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_32
 	return ((regs->cs & SEGMENT_RPL_MASK) | (regs->flags & X86_VM_MASK)) >= USER_RPL;
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 67315fa..6593b42 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -64,7 +64,7 @@ extern void text_poke_finish(void);
 
 #define DISP32_SIZE		4
 
-static inline int text_opcode_size(u8 opcode)
+static __always_inline int text_opcode_size(u8 opcode)
 {
 	int size = 0;
 
@@ -118,12 +118,14 @@ extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
 
 #ifndef CONFIG_UML_X86
-static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
+static __always_inline
+void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 {
 	regs->ip = ip;
 }
 
-static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
+static __always_inline
+void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
 	 * The int3 handler in entry_64.S adds a gap between the
@@ -138,7 +140,8 @@ static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 	*(unsigned long *)regs->sp = val;
 }
 
-static inline void int3_emulate_call(struct pt_regs *regs, unsigned long func)
+static __always_inline
+void int3_emulate_call(struct pt_regs *regs, unsigned long func)
 {
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7867dfb..1f4cb2c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -957,7 +957,8 @@ struct bp_patching_desc {
 
 static struct bp_patching_desc *bp_desc;
 
-static inline struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
+static __always_inline
+struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 {
 	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
 
@@ -967,18 +968,18 @@ static inline struct bp_patching_desc *try_get_desc(struct bp_patching_desc **de
 	return desc;
 }
 
-static inline void put_desc(struct bp_patching_desc *desc)
+static __always_inline void put_desc(struct bp_patching_desc *desc)
 {
 	smp_mb__before_atomic();
 	atomic_dec(&desc->refs);
 }
 
-static inline void *text_poke_addr(struct text_poke_loc *tp)
+static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
 {
 	return _stext + tp->rel_addr;
 }
 
-static int notrace patch_cmp(const void *key, const void *elt)
+static int noinstr patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
@@ -988,9 +989,8 @@ static int notrace patch_cmp(const void *key, const void *elt)
 		return 1;
 	return 0;
 }
-NOKPROBE_SYMBOL(patch_cmp);
 
-int notrace poke_int3_handler(struct pt_regs *regs)
+int noinstr poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
@@ -1064,7 +1064,6 @@ out_put:
 	put_desc(desc);
 	return ret;
 }
-NOKPROBE_SYMBOL(poke_int3_handler);
 
 #define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
 static struct text_poke_loc tp_vec[TP_VEC_MAX];
