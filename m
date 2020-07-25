Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBC52065F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595677606;
	bh=aIgeJw7FjVTh98J/Xk4LZQhH/4nW/KAvksCjLBGICSA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NK20b4IZ/7w+VZISO3k60Lgxlk+4N7uhRjWTVjr5u3WkimFIHrYINPs9KDzbolhI/
	 7it+kSQHaSV/MU7um3tyVLgGmgbnVuQE0yGwq4hZSlwnlCjkgQLDIkdFrLtx2eY6Nw
	 8cg2Py2tvUdAsu0hBefBRe6fPxFzatI4Rr4/WW58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGYLqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 07:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgGYLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 07:46:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB706C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 04:46:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so12554834eje.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EVbnWxiSdo6tI+OSHkP9KL2Ub8jslTkkkswf8qLkvYE=;
        b=ndeNAYRJN7D7Ejb8uZoTp4gC+9a//CJYnfzy70YWJ8TvoVOIcSqRUkLwtOs8SYTlhX
         1Lru6V25YlmEnKG3Y8GFRnqEOGOs4+POwppYm2hs/mEYsTCYCz7vbO3xQjzmEUfqgHL9
         Q1qGLLYt5oYs9b/YzSog8EWl6U7b6ELdxQChhjMXI+8+L2ttZkWfxP08QPjo88/Yepk/
         lVg9KmuQXPfI1naJt57iKUqogcLR2mQjwShpYpnb+ihH0YBFr/as98jOP5ubz0m8aLEI
         +2Y2YFv5nw46vpXVokguAex5+NsBw2JdtR0gbCDSlhFtz26DmSC7I87BJNl7tEHudVfp
         2q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=EVbnWxiSdo6tI+OSHkP9KL2Ub8jslTkkkswf8qLkvYE=;
        b=LEXeLobWfx8oDdAPuYt+pn5wHMRY5QiIMlSdNIL4IUw8WDYcr/Sj7HoQMygOW6IdP+
         VBZbqrPvr6VV0awgT1gRN8RZoNkRNf7JIySgqu1E3Lubh1onPzfRyI0U3olndv/F+Ckp
         T51nfMbksxskVCxTj4TFC4nsUn1TRwosAATKz2AerlpW72T/+xxEKrjW3GXYx0gc0vKh
         7skeacmMfzDG2mKg5DkVP/CGKX8KUo7+kfl4KlRryPI33GbrPjzZkRa2qfwga6qi/1yj
         DOeGb69/nF7mhkXd3iIqM24rnWtYAM+JBH164/SrWdM7AUlUEYWS/0iPqyvwxsXbzrFc
         F+dg==
X-Gm-Message-State: AOAM53035TXZqvTV3Pdi1nyxTKs1r14r0LyYWxusWsoeN7Tc6+mQwpH2
        meeqdIgWfpz5T6ZfsU9VKvY=
X-Google-Smtp-Source: ABdhPJzfTt7CpECTIIb0XsIODuNNWSvn5+Iq36aHWsVU52XPBH63yt+VKQRGiOpXo+qxTjxTBntptQ==
X-Received: by 2002:a17:906:3c02:: with SMTP id h2mr2156858ejg.437.1595677600532;
        Sat, 25 Jul 2020 04:46:40 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l26sm2720231ejq.39.2020.07.25.04.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 04:46:39 -0700 (PDT)
Date:   Sat, 25 Jul 2020 13:46:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86 fixes
Message-ID: <20200725114637.GA943758@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-25

   # HEAD: d181d2da0141371bbc360eaea78719203e165e1c x86/dumpstack: Dump user space code correctly again

Misc fixes:

 - Fix a section end page alignment assumption that was causing crashes

 - Fix ORC unwinding on freshly forked tasks which haven't executed yet
   and which have empty user task stacks

 - Fix the debug.exception-trace=1 sysctl dumping of user stacks, which
   was broken by recent maccess changes


  out-of-topic modifications in x86-urgent-2020-07-25:
  ------------------------------------------------------
  include/asm-generic/vmlinux.lds.h  # de2b41be8fcc: x86, vmlinux.lds: Page-align

 Thanks,

	Ingo

------------------>
Joerg Roedel (1):
      x86, vmlinux.lds: Page-align end of ..page_aligned sections

Josh Poimboeuf (2):
      x86/unwind/orc: Fix ORC for newly forked tasks
      x86/stacktrace: Fix reliable check for empty user task stacks

Thomas Gleixner (1):
      x86/dumpstack: Dump user space code correctly again


 arch/x86/kernel/dumpstack.c       | 27 +++++++++++++++++----------
 arch/x86/kernel/stacktrace.c      |  5 -----
 arch/x86/kernel/unwind_orc.c      |  8 ++++++--
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 include/asm-generic/vmlinux.lds.h |  5 ++++-
 5 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b037cfa7c0c5..7401cc12c3cc 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -71,6 +71,22 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
+static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
+		     unsigned int nbytes)
+{
+	if (!user_mode(regs))
+		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
+
+	/*
+	 * Make sure userspace isn't trying to trick us into dumping kernel
+	 * memory by pointing the userspace instruction pointer at it.
+	 */
+	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
+		return -EINVAL;
+
+	return copy_from_user_nmi(buf, (void __user *)src, nbytes);
+}
+
 /*
  * There are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
  *
@@ -97,17 +113,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
-	bool bad_ip;
-
-	/*
-	 * Make sure userspace isn't trying to trick us into dumping kernel
-	 * memory by pointing the userspace instruction pointer at it.
-	 */
-	bad_ip = user_mode(regs) &&
-		__chk_range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
 
-	if (bad_ip || copy_from_kernel_nofault(opcodes, (u8 *)prologue,
-					OPCODE_BUFSIZE)) {
+	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
 		printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 6ad43fc44556..2fd698e28e4d 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -58,7 +58,6 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			 * or a page fault), which can make frame pointers
 			 * unreliable.
 			 */
-
 			if (IS_ENABLED(CONFIG_FRAME_POINTER))
 				return -EINVAL;
 		}
@@ -81,10 +80,6 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 	if (unwind_error(&state))
 		return -EINVAL;
 
-	/* Success path for non-user tasks, i.e. kthreads and idle tasks */
-	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))
-		return -EINVAL;
-
 	return 0;
 }
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 7f969b2d240f..ec88bbe08a32 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -440,8 +440,11 @@ bool unwind_next_frame(struct unwind_state *state)
 	/*
 	 * Find the orc_entry associated with the text address.
 	 *
-	 * Decrement call return addresses by one so they work for sibling
-	 * calls and calls to noreturn functions.
+	 * For a call frame (as opposed to a signal frame), state->ip points to
+	 * the instruction after the call.  That instruction's stack layout
+	 * could be different from the call instruction's layout, for example
+	 * if the call was to a noreturn function.  So get the ORC data for the
+	 * call instruction itself.
 	 */
 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
 	if (!orc) {
@@ -662,6 +665,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp;
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
+		state->signal = (void *)state->ip == ret_from_fork;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd8a43d..9a03e5b23135 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -358,6 +358,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
+		. = ALIGN(PAGE_SIZE);
 		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..052e0f05a984 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -341,7 +341,8 @@
 
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
-	*(.data..page_aligned)
+	*(.data..page_aligned)						\
+	. = ALIGN(page_align);
 
 #define READ_MOSTLY_DATA(align)						\
 	. = ALIGN(align);						\
@@ -737,7 +738,9 @@
 	. = ALIGN(bss_align);						\
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
 		BSS_FIRST_SECTIONS					\
+		. = ALIGN(PAGE_SIZE);					\
 		*(.bss..page_aligned)					\
+		. = ALIGN(PAGE_SIZE);					\
 		*(.dynbss)						\
 		*(BSS_MAIN)						\
 		*(COMMON)						\
