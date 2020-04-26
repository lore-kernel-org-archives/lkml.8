Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A819C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC682070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDZGrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDZGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:47:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA7C09B050;
        Sat, 25 Apr 2020 23:47:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSb4n-0008R3-OG; Sun, 26 Apr 2020 08:47:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 629331C0330;
        Sun, 26 Apr 2020 08:47:41 +0200 (CEST)
Date:   Sun, 26 Apr 2020 06:47:40 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind: Prevent false warnings for non-current tasks
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <ec424a2aea1d461eb30cab48a28c6433de2ab784.1587808742.git.jpoimboe@redhat.com>
References: <ec424a2aea1d461eb30cab48a28c6433de2ab784.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158788366096.28353.10709090295221271517.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b08418b54831255a7e3700d6bf7dfc2bdae25cd7
Gitweb:        https://git.kernel.org/tip/b08418b54831255a7e3700d6bf7dfc2bdae25cd7
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Sat, 25 Apr 2020 05:03:06 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Apr 2020 12:22:28 +02:00

x86/unwind: Prevent false warnings for non-current tasks

There's some daring kernel code out there which dumps the stack of
another task without first making sure the task is inactive.  If the
task happens to be running while the unwinder is reading the stack,
unusual unwinder warnings can result.

There's no race-free way for the unwinder to know whether such a warning
is legitimate, so just disable unwinder warnings for all non-current
tasks.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Jones <dsj@fb.com>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/ec424a2aea1d461eb30cab48a28c6433de2ab784.1587808742.git.jpoimboe@redhat.com
---
 arch/x86/kernel/dumpstack_64.c |  3 +-
 arch/x86/kernel/unwind_frame.c |  3 ++-
 arch/x86/kernel/unwind_orc.c   | 40 ++++++++++++++++++---------------
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 87b9789..460ae7f 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -183,7 +183,8 @@ recursion_check:
 	 */
 	if (visit_mask) {
 		if (*visit_mask & (1UL << info->type)) {
-			printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
+			if (task == current)
+				printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
 			goto unknown;
 		}
 		*visit_mask |= 1UL << info->type;
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index a224b5a..5422611 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -344,6 +344,9 @@ bad_address:
 	if (IS_ENABLED(CONFIG_X86_32))
 		goto the_end;
 
+	if (state->task != current)
+		goto the_end;
+
 	if (state->regs) {
 		printk_deferred_once(KERN_WARNING
 			"WARNING: kernel stack regs at %p in %s:%d has bad 'bp' value %p\n",
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 64889da..45166fd 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -8,7 +8,13 @@
 #include <asm/orc_lookup.h>
 
 #define orc_warn(fmt, ...) \
-	printk_deferred_once(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS__)
+	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+
+#define orc_warn_current(args...)					\
+({									\
+	if (state->task == current)					\
+		orc_warn(args);						\
+})
 
 extern int __start_orc_unwind_ip[];
 extern int __stop_orc_unwind_ip[];
@@ -446,8 +452,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_R10:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R10 at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing R10 value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp = state->regs->r10;
@@ -455,8 +461,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_R13:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R13 at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing R13 value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp = state->regs->r13;
@@ -464,8 +470,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_DI:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DI at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing RDI value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp = state->regs->di;
@@ -473,15 +479,15 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_DX:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DX at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing DX value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
 		sp = state->regs->dx;
 		break;
 
 	default:
-		orc_warn("unknown SP base reg %d for ip %pB\n",
+		orc_warn("unknown SP base reg %d at %pB\n",
 			 orc->sp_reg, (void *)state->ip);
 		goto err;
 	}
@@ -509,8 +515,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_TYPE_REGS:
 		if (!deref_stack_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't access registers at %pB\n",
+					 (void *)orig_ip);
 			goto err;
 		}
 
@@ -521,8 +527,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_TYPE_REGS_IRET:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference iret registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't access iret registers at %pB\n",
+					 (void *)orig_ip);
 			goto err;
 		}
 
@@ -532,7 +538,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
 
 	default:
-		orc_warn("unknown .orc_unwind entry type %d for ip %pB\n",
+		orc_warn("unknown .orc_unwind entry type %d at %pB\n",
 			 orc->type, (void *)orig_ip);
 		break;
 	}
@@ -564,8 +570,8 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (state->stack_info.type == prev_type &&
 	    on_stack(&state->stack_info, (void *)state->sp, sizeof(long)) &&
 	    state->sp <= prev_sp) {
-		orc_warn("stack going in the wrong direction? ip=%pB\n",
-			 (void *)orig_ip);
+		orc_warn_current("stack going in the wrong direction? at %pB\n",
+				 (void *)orig_ip);
 		goto err;
 	}
 
