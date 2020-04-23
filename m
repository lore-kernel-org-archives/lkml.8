Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765AAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A9C20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDWHtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDWHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E76C03C1AB;
        Thu, 23 Apr 2020 00:49:42 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc1-0008JD-8W; Thu, 23 Apr 2020 09:49:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A2FE31C0244;
        Thu, 23 Apr 2020 09:49:32 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:32 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Constify arch_decode_instruction()
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200422103205.61900-4-mingo@kernel.org>
References: <20200422103205.61900-4-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <158762817210.28353.13596091994137162716.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0c98be8118221a8d3de572740f29dd02ed9686a5
Gitweb:        https://git.kernel.org/tip/0c98be8118221a8d3de572740f29dd02ed9686a5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 22 Apr 2020 12:32:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Apr 2020 08:34:18 +02:00

objtool: Constify arch_decode_instruction()

Mostly straightforward constification, except that WARN_FUNC()
needs a writable pointer while we have read-only pointers,
so deflect this to WARN().

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200422103205.61900-4-mingo@kernel.org
---
 tools/objtool/arch.h            | 2 +-
 tools/objtool/arch/x86/decode.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 561c316..445b8fa 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -72,7 +72,7 @@ struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
-int arch_decode_instruction(struct elf *elf, struct section *sec,
+int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index f0d42ad..c45a0b4 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -27,7 +27,7 @@ static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_DI, CFI_R15},
 };
 
-static int is_x86_64(struct elf *elf)
+static int is_x86_64(const struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
 	case EM_X86_64:
@@ -77,7 +77,7 @@ unsigned long arch_jump_destination(struct instruction *insn)
 	return insn->offset + insn->len + insn->immediate;
 }
 
-int arch_decode_instruction(struct elf *elf, struct section *sec,
+int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
@@ -98,7 +98,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	insn_get_length(&insn);
 
 	if (!insn_complete(&insn)) {
-		WARN_FUNC("can't decode instruction", sec, offset);
+		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
 	}
 
